Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 56977140296
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:01 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:28:00 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id ACF55357804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:58 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516gms9306468
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:42 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RwrE011593
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 15/22] powerpc/eeh: Emulate RTAS call ibm,slot-error-detail
Date: Mon,  5 May 2014 11:28:04 +1000
Message-Id: <1399253291-3975-16-git-send-email-gwshan@linux.vnet.ibm.com>
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

The RTAS call "ibm,slot-error-detail" is being used to retrieve the
error log (either permanent or temporary) from the underlying firmware.
The patch implements the backend to emulate the RTAS call.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-rtas.c | 75 +++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-rtas.c b/arch/powerpc/platforms/powernv/eeh-rtas.c
index 4a9c2c7..8934564 100644
--- a/arch/powerpc/platforms/powernv/eeh-rtas.c
+++ b/arch/powerpc/platforms/powernv/eeh-rtas.c
@@ -390,6 +390,78 @@ out:
 	return ret;
 }
 
+static int kvmppc_eeh_get_error(struct kvm_vcpu *vcpu,
+				struct rtas_args *args)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct eeh_vfio_pci_addr addr;
+	char *log;
+	int guest_log;
+	int len, severity;
+	int ret = 0;
+
+	/* Sanity check on parameter */
+	if (args->nargs != 8 || args->nret != 1) {
+		pr_warn("%s: Non-matched arguments (%d, %d) - (8, 1)\n",
+			__func__, args->nargs, args->nret);
+		ret = 1;
+		goto out;
+	} else if (args->args[7] != 1 && args->args[7] != 2) {
+		pr_warn("%s: Invalid Log type\n", __func__);
+		ret = 1;
+		goto out;
+	}
+
+	/* Figure out the address */
+	if (kvmppc_eeh_format_addr(vcpu, args, &addr, false, &edev, &pe)) {
+		ret = 1;
+		goto out;
+	}
+
+	/* Make sure that the EEH stuff has been initialized */
+	hose = pe->phb;
+	phb = hose->private_data;
+	if (!(phb->flags & PNV_PHB_FLAG_EEH)) {
+		pr_warn("%s: EEH disabled on PHB#%d\n",
+			__func__, hose->global_number);
+		ret = 1;
+		goto out;
+	}
+
+	/*
+	 * Retrieve error log from PE. We don't have cached error
+	 * log for one specific PE yet, which need to be figured
+	 * out later.
+	 */
+	if (phb->eeh_ops && phb->eeh_ops->get_log) {
+		guest_log = args->args[5];
+		len = args->args[6];
+		severity = args->args[7];
+		log = kzalloc(len, GFP_KERNEL);
+		if (!log) {
+			pr_err("%s: Out of memory!\n", __func__);
+			ret = 1;
+			goto out;
+		}
+
+		phb->eeh_ops->get_log(pe, severity, log, len);
+		if (kvm_write_guest(vcpu->kvm, guest_log, log, len)) {
+			pr_warn("%s: Fail pushing log to guest\n",
+				__func__);
+			ret = 1;
+		}
+
+		kfree(log);
+	} else {
+		ret = 1;
+	}
+out:
+	return ret;
+}
+
 /**
  * kvmppc_eeh_rtas - Backend for EEH RTAS emulation
  * @vcpu: KVM virtual CPU
@@ -418,6 +490,9 @@ void kvmppc_eeh_rtas(struct kvm_vcpu *vcpu, struct rtas_args *args, int op)
 	case eeh_rtas_get_config_addr_info2:
 		ret = kvmppc_eeh_get_addr2(vcpu, args);
 		break;
+	case eeh_rtas_slot_error_detail:
+		ret = kvmppc_eeh_get_error(vcpu, args);
+		break;
 	default:
 		pr_warn("%s: Unsupported EEH RTAS service#%d\n",
 			__func__, op);
-- 
1.8.3.2
