Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 58FA31401F1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:02 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:28:01 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 177333578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:59 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516hmE53412036
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RwBl013849
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 16/22] powerpc/eeh: Emulate RTAS call ibm,configure-pe
Date: Mon,  5 May 2014 11:28:05 +1000
Message-Id: <1399253291-3975-17-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399253291-3975-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RTAS call "ibm,configure-pe" is being used to restore everything
after PE reset. The patch implements the backend to emulate the
RTAS call. In that, we restores BARs for the affected PCI device in
host side because the guest might not have full access to the config
space.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-rtas.c | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-rtas.c b/arch/powerpc/platforms/powernv/eeh-rtas.c
index 8934564..a663cd8 100644
--- a/arch/powerpc/platforms/powernv/eeh-rtas.c
+++ b/arch/powerpc/platforms/powernv/eeh-rtas.c
@@ -462,6 +462,52 @@ out:
 	return ret;
 }
 
+static int kvmppc_eeh_configure_pe(struct kvm_vcpu *vcpu,
+				   struct rtas_args *args)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct eeh_vfio_pci_addr addr;
+	int ret = 0;
+
+	/* Sanity check on parameter */
+	if (args->nargs != 3 || args->nret != 1) {
+		pr_warn("%s: Non-matched arguments (%d, %d) - (3, 1)\n",
+			__func__, args->nargs, args->nret);
+		ret = -3;
+		goto out;
+	}
+
+	/* Figure out the address */
+	if (kvmppc_eeh_format_addr(vcpu, args, &addr, false, &edev, &pe)) {
+		ret = -3;
+		goto out;
+	}
+
+	/* Make sure that the EEH stuff has been initialized */
+	hose = pe->phb;
+	phb = hose->private_data;
+	if (!(phb->flags & PNV_PHB_FLAG_EEH)) {
+		pr_warn("%s: EEH disabled on PHB#%x\n",
+			__func__, hose->global_number);
+		ret = -3;
+		goto out;
+	}
+
+	/*
+	 * The access to PCI config space on VFIO device has some
+	 * limitations. Part of PCI config space, including BAR
+	 * registers are not readable and writable. So the guest
+	 * should have stale values for those registers and we have
+	 * to restore them in host side.
+	 */
+	eeh_pe_restore_bars(pe);
+out:
+	return ret;
+}
+
 /**
  * kvmppc_eeh_rtas - Backend for EEH RTAS emulation
  * @vcpu: KVM virtual CPU
@@ -493,6 +539,9 @@ void kvmppc_eeh_rtas(struct kvm_vcpu *vcpu, struct rtas_args *args, int op)
 	case eeh_rtas_slot_error_detail:
 		ret = kvmppc_eeh_get_error(vcpu, args);
 		break;
+	case eeh_rtas_configure_pe:
+		ret = kvmppc_eeh_configure_pe(vcpu, args);
+		break;
 	default:
 		pr_warn("%s: Unsupported EEH RTAS service#%d\n",
 			__func__, op);
-- 
1.8.3.2
