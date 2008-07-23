Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0422DDE98
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 18:37:14 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6N8al0T099490
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 08:36:47 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6N8al2E3633346
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6N8alSw021864
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
From: ehrhardt@linux.vnet.ibm.com
To: kvm-ppc@vger.kernel.org, embedded-hypervisor@power.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 3/6] kvmppc: add hypercall infrastructure - guest part
Date: Wed, 23 Jul 2008 10:36:44 +0200
Message-Id: <1216802207-32675-4-git-send-email-ehrhardt@linux.vnet.ibm.com>
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

This adds the guest portion of the hypercall infrastructure, basically an
illegal instruction with a defined layout.
See http://kvm.qumranet.com/kvmwiki/PowerPC_Hypercall_ABI for more detail
on the hypercall ABI for powerpc.

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 kvm_para.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

[diff]
diff --git a/include/asm-powerpc/kvm_para.h b/include/asm-powerpc/kvm_para.h
--- a/include/asm-powerpc/kvm_para.h
+++ b/include/asm-powerpc/kvm_para.h
@@ -25,6 +25,8 @@
 #ifdef __KERNEL__
 
 #include <linux/of.h>
+
+#define KVM_HYPERCALL_BIN 0x03ffffff
 
 static struct kvmppc_para_features {
 	char *dtcell;
@@ -63,6 +65,20 @@
 
 void kvm_guest_init(void);
 
+static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
+{
+	register unsigned long hcall asm ("r0") = nr;
+	register unsigned long arg1 asm ("r3") = p1;
+	register long ret asm ("r11");
+
+	asm volatile(".long %1"
+			: "=r"(ret)
+			: "i"(KVM_HYPERCALL_BIN), "r"(hcall), "r"(arg1)
+			: "r4", "r5", "r6", "r7", "r8",
+			  "r9", "r10", "r12", "cc");
+	return ret;
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* __POWERPC_KVM_PARA_H__ */
