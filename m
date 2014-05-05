Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 208E9140294
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:00 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:59 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8FAD12CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:57 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516fCt66125910
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451Ruk8001122
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 12/22] powerpc/eeh: Emulate RTAS call ibm,set-slot-reset
Date: Mon,  5 May 2014 11:28:01 +1000
Message-Id: <1399253291-3975-13-git-send-email-gwshan@linux.vnet.ibm.com>
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

The RTAS call "ibm,set-slot-reset" is being used to reset one
particular PE, either foundamental or hot reset. The patche intends
to implement the backend to emulate the RTAS call.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-rtas.c | 92 +++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-rtas.c b/arch/powerpc/platforms/powernv/eeh-rtas.c
index 1a037fd..3e38d13 100644
--- a/arch/powerpc/platforms/powernv/eeh-rtas.c
+++ b/arch/powerpc/platforms/powernv/eeh-rtas.c
@@ -171,6 +171,95 @@ out:
 	return ret;
 }
 
+static int kvmppc_eeh_set_reset(struct kvm_vcpu *vcpu,
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
+	if (args->nargs != 4 || args->nret != 1) {
+		pr_warn("%s: Non-matched arguments (%d, %d) - (4, 1)\n",
+			__func__, args->nargs, args->nret);
+		ret = -3;
+		goto out;
+	}
+
+	/* Sanity check on opcode */
+	opcode = args->args[3];
+	if (opcode != EEH_RESET_DEACTIVATE &&
+	    opcode != EEH_RESET_HOT &&
+	    opcode != EEH_RESET_FUNDAMENTAL) {
+		pr_warn("%s: Unsupported opcode %d\n",
+			__func__, opcode);
+		ret = -3;
+		goto out;
+	}
+
+	/* Figure out the address. We always have PE address */
+	if (kvmppc_eeh_format_addr(vcpu, args, &addr, false, &edev, &pe)) {
+		ret = -3;
+		goto out;
+	}
+
+	/* Insure that the EEH stuff has been initialized */
+	hose = pe->phb;
+	phb = hose->private_data;
+	if (!(phb->flags & PNV_PHB_FLAG_EEH)) {
+		pr_warn("%s: EEH disable on PHB#%d\n",
+			__func__, hose->global_number);
+		ret = -7;
+		goto out;
+	}
+
+	/* Call into the IODA dependent backend to do the reset */
+	if (!phb->eeh_ops ||
+	    !phb->eeh_ops->set_option ||
+	    !phb->eeh_ops->reset) {
+		pr_warn("%s: Unsupported request\n", __func__);
+		ret = -7;
+	} else {
+		/*
+		 * The frozen PE might be caused by the mechanism called
+		 * PAPR error injection, which is supposed to be one-shot
+		 * without "sticky" bit as being stated by the spec. But
+		 * the reality isn't that, at least on P7IOC. So we have
+		 * to clear that to avoid recrusive error, which fail the
+		 * recovery.
+		 */
+		if (opcode == EEH_RESET_DEACTIVATE)
+			opal_pci_reset(phb->opal_id,
+				       OPAL_PHB_ERROR,
+				       OPAL_ASSERT_RESET);
+
+		if (phb->eeh_ops->reset(pe, opcode)) {
+			pr_warn("%s: Failure from backend\n",
+				__func__);
+			ret = -1;
+			goto out;
+		}
+
+		/*
+		 * The PE is still in frozen state and we need clear that.
+		 * It's good to clear frozen state after deassert to avoid
+		 * messy IO access during reset, which might cause recrusive
+		 * frozen PE.
+		 */
+		if (opcode == EEH_RESET_DEACTIVATE) {
+			phb->eeh_ops->set_option(pe, EEH_OPT_THAW_MMIO);
+			phb->eeh_ops->set_option(pe, EEH_OPT_THAW_DMA);
+		}
+	}
+
+out:
+	return ret;
+}
+
 /**
  * kvmppc_eeh_rtas - Backend for EEH RTAS emulation
  * @vcpu: KVM virtual CPU
@@ -190,6 +279,9 @@ void kvmppc_eeh_rtas(struct kvm_vcpu *vcpu, struct rtas_args *args, int op)
 	case eeh_rtas_set_option:
 		ret = kvmppc_eeh_set_option(vcpu, args);
 		break;
+	case eeh_rtas_set_slot_reset:
+		ret = kvmppc_eeh_set_reset(vcpu, args);
+		break;
 	default:
 		pr_warn("%s: Unsupported EEH RTAS service#%d\n",
 			__func__, op);
-- 
1.8.3.2
