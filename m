Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 763D8140216
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:02 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:28:01 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A5FFB2BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:58 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516pgm21037278
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:51 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451Rv4V011578
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 14/22] powerpc/eeh: Emulate RTAS call ibm,
 get-config-addr-info2
Date: Mon,  5 May 2014 11:28:03 +1000
Message-Id: <1399253291-3975-15-git-send-email-gwshan@linux.vnet.ibm.com>
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

The RTAS call "ibm,get-config-addr-info2" is being used by guest
to retrieve the corresponding PE number for the specified PCI device.
The patch implements the backend to support the emulation of the
RTAS call.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-rtas.c | 59 +++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-rtas.c b/arch/powerpc/platforms/powernv/eeh-rtas.c
index 031ee8c..4a9c2c7 100644
--- a/arch/powerpc/platforms/powernv/eeh-rtas.c
+++ b/arch/powerpc/platforms/powernv/eeh-rtas.c
@@ -334,6 +334,62 @@ out:
 	return ret;
 }
 
+static int kvmppc_eeh_get_addr2(struct kvm_vcpu *vcpu,
+				struct rtas_args *args)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct eeh_vfio_pci_addr addr;
+	int opcode;
+	int ret = 0;
+
+	/* Sanity check on parameter */
+	if (args->nargs != 4 || args->nret != 2) {
+		pr_warn("%s: Non-matched arguments (%d, %d) - (4, 2)\n",
+			__func__, args->nargs, args->nret);
+		ret = -3;
+		goto out;
+	}
+
+	/* Check on the operation code */
+	opcode = args->args[3];
+	if (opcode != 0 && opcode != 1) {
+		pr_warn("%s: opcode %d out of range (0, 1)\n",
+			__func__, opcode);
+		ret = -3;
+		goto out;
+	}
+
+	/* Figure out address */
+	if (kvmppc_eeh_format_addr(vcpu, args, &addr, true, &edev, &pe)) {
+		ret = -3;
+		goto out;
+	}
+
+	/* Insure that the EEH stuff has been initialized */
+	hose = pe->phb;
+	phb = hose->private_data;
+	if (!(phb->flags & PNV_PHB_FLAG_EEH)) {
+		pr_warn("%s: EEH disabled on PHB#%d\n",
+			__func__, hose->global_number);
+		ret = -3;
+		goto out;
+	}
+
+	/*
+	 * Fill result according to opcode. We don't differentiate
+	 * PCI bus and device sensitive PE here.
+	 */
+	if (opcode == 0)
+		args->rets[1] = pe->gaddr.pe_addr;
+	else
+		args->rets[1] = 1;
+out:
+	return ret;
+}
+
 /**
  * kvmppc_eeh_rtas - Backend for EEH RTAS emulation
  * @vcpu: KVM virtual CPU
@@ -359,6 +415,9 @@ void kvmppc_eeh_rtas(struct kvm_vcpu *vcpu, struct rtas_args *args, int op)
 	case eeh_rtas_read_slot_reset_state2:
 		ret = kvmppc_eeh_get_state2(vcpu, args);
 		break;
+	case eeh_rtas_get_config_addr_info2:
+		ret = kvmppc_eeh_get_addr2(vcpu, args);
+		break;
 	default:
 		pr_warn("%s: Unsupported EEH RTAS service#%d\n",
 			__func__, op);
-- 
1.8.3.2
