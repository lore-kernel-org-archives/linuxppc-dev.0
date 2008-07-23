Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6A3BDDE1C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 18:38:14 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6N8alRW479642
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 08:36:47 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6N8al0H3891304
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6N8allB021871
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
From: ehrhardt@linux.vnet.ibm.com
To: kvm-ppc@vger.kernel.org, embedded-hypervisor@power.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 4/6] kvmppc: magic page hypercall - host part
Date: Wed, 23 Jul 2008 10:36:45 +0200
Message-Id: <1216802207-32675-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
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

This adds the host part of the magic page registration. This is a memory
area of the guest granted to the host.
The patch just introduces the infrastruture to receive the guest paddr.
This is work in progress and it is intended to later on use this memory
as storage area a guest can read unprivileged (using binary rewriting to
change privileges instructions).

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 arch/powerpc/kvm/emulate.c     |    5 +++++
 arch/powerpc/kvm/powerpc.c     |   18 +++++++++++++++++-
 include/asm-powerpc/kvm_para.h |    2 ++
 include/linux/kvm.h            |    6 ++++++
 4 files changed, 30 insertions(+), 1 deletion(-)

[diff]
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -208,6 +208,11 @@
 	int ret = 0;
 
 	switch (vcpu->arch.gpr[0]) {
+	case KVM_HCALL_RESERVE_MAGICPAGE:
+		/* FIXME TODO implement the real fuctionality using that */
+		printk(KERN_ERR"%s - receive magicpage address 0x%x\n",
+			__func__, vcpu->arch.gpr[3]);
+		break;
 	default:
 		printk(KERN_ERR"unknown hypercall %d\n", vcpu->arch.gpr[0]);
 		kvmppc_dump_vcpu(vcpu);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -148,6 +148,9 @@
 	case KVM_CAP_COALESCED_MMIO:
 		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
 		break;
+	case KVM_CAP_PPCPV_MAGICPAGE:
+		r = 1;
+		break;
 	default:
 		r = 0;
 		break;
@@ -159,7 +162,20 @@
 long kvm_arch_dev_ioctl(struct file *filp,
                         unsigned int ioctl, unsigned long arg)
 {
-	return -EINVAL;
+	long r = -EINVAL;
+
+	switch (ioctl) {
+	case KVM_GET_PPCPV_MAGICPAGE_SIZE:
+		r = -EINVAL;
+		if (arg)
+			goto out;
+		r = 1024;
+		break;
+	default:
+		r = -EINVAL;
+	}
+out:
+	return r;
 }
 
 int kvm_arch_set_memory_region(struct kvm *kvm,
diff --git a/include/asm-powerpc/kvm_para.h b/include/asm-powerpc/kvm_para.h
--- a/include/asm-powerpc/kvm_para.h
+++ b/include/asm-powerpc/kvm_para.h
@@ -24,6 +24,8 @@
 
 #define KVM_HYPERCALL_BIN 0x03ffffff
 
+#define KVM_HCALL_RESERVE_MAGICPAGE	0
+
 static inline int kvm_para_available(void)
 {
 	return 0;
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -365,6 +365,11 @@
 #define KVM_TRACE_PAUSE           _IO(KVMIO,  0x07)
 #define KVM_TRACE_DISABLE         _IO(KVMIO,  0x08)
 /*
+ * ioctls for powerpc paravirtualization extensions
+ */
+#define KVM_GET_PPCPV_MAGICPAGE_SIZE       _IO(KVMIO,   0x09)
+
+/*
  * Extension capability list.
  */
 #define KVM_CAP_IRQCHIP	  0
@@ -382,6 +387,7 @@
 #define KVM_CAP_PV_MMU 13
 #define KVM_CAP_MP_STATE 14
 #define KVM_CAP_COALESCED_MMIO 15
+#define KVM_CAP_PPCPV_MAGICPAGE 16
 
 /*
  * ioctls for VM fds
