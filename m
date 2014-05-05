Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4E3BF140295
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:01 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:28:00 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C04053578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s451Rg1R1966342
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RvZl013814
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:57 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 13/22] powerpc/eeh: Emulate RTAS call ibm,
 read-slot-reset-state2
Date: Mon,  5 May 2014 11:28:02 +1000
Message-Id: <1399253291-3975-14-git-send-email-gwshan@linux.vnet.ibm.com>
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

The RTAS call "ibm,read-slot-reset-state2" is being used to retrieve
the various states of the specified PE, e.g. reset state, frozen DMA,
frozen MMIO etc. The patch implements the backend to emulate the
RTAS call.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-rtas.c | 77 +++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-rtas.c b/arch/powerpc/platforms/powernv/eeh-rtas.c
index 3e38d13..031ee8c 100644
--- a/arch/powerpc/platforms/powernv/eeh-rtas.c
+++ b/arch/powerpc/platforms/powernv/eeh-rtas.c
@@ -260,6 +260,80 @@ out:
 	return ret;
 }
 
+static int kvmppc_eeh_get_state2(struct kvm_vcpu *vcpu,
+				 struct rtas_args *args)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct eeh_vfio_pci_addr addr;
+	int result, ret = 0;
+
+	/* Sanity check on parameter */
+	if (args->nargs != 3 || (args->nret != 4 && args->nret != 5)) {
+		pr_warn("%s: Non-matched argument (%d, %d) - (3, 4/5)\n",
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
+		pr_warn("%s: EEH disabled on PHB#%d\n",
+			__func__, hose->global_number);
+		ret = -3;
+		args->rets[2] = 0;
+		goto out;
+	}
+
+	/*
+	 * Mark EEH supported on the PCI device. Otherwise,
+	 * the PE state is meaningless to the guest
+	 */
+	args->rets[2] = 1;
+
+	/* Call to the IOC dependent function */
+	if (phb->eeh_ops && phb->eeh_ops->get_state) {
+		result = phb->eeh_ops->get_state(pe);
+
+		if (!(result & EEH_STATE_RESET_ACTIVE) &&
+		    (result & EEH_STATE_DMA_ENABLED) &&
+		    (result & EEH_STATE_MMIO_ENABLED))
+			args->rets[1] = 0;
+		else if (result & EEH_STATE_RESET_ACTIVE)
+			args->rets[1] = 1;
+		else if (!(result & EEH_STATE_RESET_ACTIVE) &&
+			 !(result & EEH_STATE_DMA_ENABLED) &&
+			 !(result & EEH_STATE_MMIO_ENABLED))
+			args->rets[1] = 2;
+		else if (!(result & EEH_STATE_RESET_ACTIVE) &&
+			(result & EEH_STATE_DMA_ENABLED) &&
+			!(result & EEH_STATE_MMIO_ENABLED))
+			args->rets[1] = 4;
+		else {
+			args->rets[1] = 5;
+			args->rets[3] = 1000;
+		}
+
+		ret = 0;
+	} else {
+		pr_warn("%s: Unsupported request\n",
+			__func__);
+		ret = -3;
+	}
+out:
+	return ret;
+}
+
 /**
  * kvmppc_eeh_rtas - Backend for EEH RTAS emulation
  * @vcpu: KVM virtual CPU
@@ -282,6 +356,9 @@ void kvmppc_eeh_rtas(struct kvm_vcpu *vcpu, struct rtas_args *args, int op)
 	case eeh_rtas_set_slot_reset:
 		ret = kvmppc_eeh_set_reset(vcpu, args);
 		break;
+	case eeh_rtas_read_slot_reset_state2:
+		ret = kvmppc_eeh_get_state2(vcpu, args);
+		break;
 	default:
 		pr_warn("%s: Unsupported EEH RTAS service#%d\n",
 			__func__, op);
-- 
1.8.3.2
