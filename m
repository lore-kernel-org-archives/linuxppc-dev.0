Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3727F140176
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:28:00 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 5 May 2014 11:27:59 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 003FA357804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 11:27:57 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4516o7k459208
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:06:50 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s451RudA011753
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 11:27:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 11/22] powerpc/eeh: Emulate RTAS call ibm,set-eeh-option
Date: Mon,  5 May 2014 11:28:00 +1000
Message-Id: <1399253291-3975-12-git-send-email-gwshan@linux.vnet.ibm.com>
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

The RTAS call "ibm,set-eeh-option" is being used to enable/disable
EEH functionality on the specified PE, or enable MMIO/DMA for the
frozen PE. The patch emulates the RTAS call.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-rtas.c | 83 +++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/eeh-rtas.c b/arch/powerpc/platforms/powernv/eeh-rtas.c
index f04b820..1a037fd 100644
--- a/arch/powerpc/platforms/powernv/eeh-rtas.c
+++ b/arch/powerpc/platforms/powernv/eeh-rtas.c
@@ -91,6 +91,86 @@ static int kvmppc_eeh_format_addr(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int kvmppc_eeh_set_option(struct kvm_vcpu *vcpu,
+				 struct rtas_args *args)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct eeh_dev *edev;
+	struct eeh_pe *pe;
+	struct eeh_vfio_pci_addr addr;
+	int opcode;
+	bool is_legacy = false;
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
+	/* Check on opcode */
+	opcode = args->args[3];
+	if (opcode < EEH_OPT_DISABLE || opcode > EEH_OPT_THAW_DMA) {
+		pr_warn("%s: opcode %d out of range (%d, %d)\n",
+			__func__, opcode, EEH_OPT_DISABLE, EEH_OPT_THAW_DMA);
+		ret = -3;
+		goto out;
+	}
+
+	if (opcode == EEH_OPT_ENABLE)
+		is_legacy = true;
+
+	/* Figure out the address */
+	if (kvmppc_eeh_format_addr(vcpu, args, &addr, is_legacy, &edev, &pe)) {
+		ret = -7;
+		goto out;
+	}
+
+	/* Insure that the EEH stuff has been initialized */
+	hose = pe->phb;
+	phb = hose->private_data;
+	if (!(phb->flags & PNV_PHB_FLAG_EEH)) {
+		pr_warn("%s: EEH disabled on PHB#%d\n",
+			__func__, hose->global_number);
+		ret = -7;
+		goto out;
+	}
+
+	/*
+	 * The EEH functionality has been enabled on all PEs
+	 * by default. So just return success. The same situation
+	 * would be applied while we disable EEH functionality.
+	 * However, the guest isn't expected to disable that
+	 * at all.
+	 */
+	if (opcode == EEH_OPT_DISABLE ||
+		opcode == EEH_OPT_ENABLE) {
+		ret = 0;
+		goto out;
+	}
+
+	/*
+	 * Call into the IODA dependent backend in order
+	 * to enable DMA or MMIO for the indicated PE.
+	 */
+	if (phb->eeh_ops && phb->eeh_ops->set_option) {
+		if (phb->eeh_ops->set_option(pe, opcode)) {
+			pr_warn("%s: Failure from backend\n",
+				__func__);
+			ret = -1;
+		}
+	} else {
+		pr_warn("%s: Unsupported request\n",
+			__func__);
+		ret = -7;
+	}
+out:
+	return ret;
+}
+
 /**
  * kvmppc_eeh_rtas - Backend for EEH RTAS emulation
  * @vcpu: KVM virtual CPU
@@ -107,6 +187,9 @@ void kvmppc_eeh_rtas(struct kvm_vcpu *vcpu, struct rtas_args *args, int op)
 
 	/* Parse the requested service */
 	switch (op) {
+	case eeh_rtas_set_option:
+		ret = kvmppc_eeh_set_option(vcpu, args);
+		break;
 	default:
 		pr_warn("%s: Unsupported EEH RTAS service#%d\n",
 			__func__, op);
-- 
1.8.3.2
