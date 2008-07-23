Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 343EBDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 18:38:14 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6N8aln7420134
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 08:36:47 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6N8alSQ2760732
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6N8alpr021859
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
From: ehrhardt@linux.vnet.ibm.com
To: kvm-ppc@vger.kernel.org, embedded-hypervisor@power.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 2/6] kvmppc: add hypercall infrastructure - host part
Date: Wed, 23 Jul 2008 10:36:43 +0200
Message-Id: <1216802207-32675-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

This adds the host portion of the hypercall infrastructure which receives
the guest calls - no specific hcall function is implemented in this patch.

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 arch/powerpc/kvm/emulate.c     |   27 +++++++++++++++++++++++++++
 include/asm-powerpc/kvm_para.h |    2 ++
 2 files changed, 29 insertions(+)

[diff]
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -203,6 +203,24 @@
 	kvmppc_set_msr(vcpu, vcpu->arch.srr1);
 }
 
+static int kvmppc_do_hypercall(struct kvm_vcpu *vcpu)
+{
+	int ret = 0;
+
+	switch (vcpu->arch.gpr[0]) {
+	default:
+		printk(KERN_ERR"unknown hypercall %d\n", vcpu->arch.gpr[0]);
+		kvmppc_dump_vcpu(vcpu);
+		ret = -ENOSYS;
+	}
+
+	vcpu->arch.gpr[11] = ret;
+	vcpu->arch.pc += 4; /* Advance past hypercall instruction. */
+
+	return ret;
+}
+
+
 /* XXX to do:
  * lhax
  * lhaux
@@ -232,6 +250,15 @@
 	int advance = 1;
 
 	switch (get_op(inst)) {
+	case 0:
+		if (inst == KVM_HYPERCALL_BIN) {
+			kvmppc_do_hypercall(vcpu);
+			advance = 0; /* kvmppc_do_hypercall handles the PC. */
+		} else {
+			printk(KERN_ERR"unknown op %d\n", get_op(inst));
+			emulated = EMULATE_FAIL;
+		}
+		break;
 	case 3:                                                 /* trap */
 		printk("trap!\n");
 		kvmppc_queue_exception(vcpu, BOOKE_INTERRUPT_PROGRAM);
diff --git a/include/asm-powerpc/kvm_para.h b/include/asm-powerpc/kvm_para.h
--- a/include/asm-powerpc/kvm_para.h
+++ b/include/asm-powerpc/kvm_para.h
@@ -22,6 +22,8 @@
 
 #ifdef __KERNEL__
 
+#define KVM_HYPERCALL_BIN 0x03ffffff
+
 static inline int kvm_para_available(void)
 {
 	return 0;
