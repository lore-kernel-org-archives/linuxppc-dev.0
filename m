Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 132BEDE539
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 20:37:45 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m7JAaj2k122886
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 10:36:45 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7JAajD53657824
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:36:45 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7JAai59010562
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:36:44 +0200
From: ehrhardt@linux.vnet.ibm.com
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest optimization
Date: Tue, 19 Aug 2008 12:36:44 +0200
Message-Id: <1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
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

Dependent on the already existing CONFIG_KVM_GUEST config option this patch
changes wrteei to wrtee allowing the hypervisor to rewrite those to nontrapping
instructions. Maybe we should split the kvm guest otpimizations in two parts
one for the overhead free optimizations and on for the rest that might add
some complexity for non virtualized execution (like this one).

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
---

[diffstat]
 hw_irq.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

[diff]
diff --git a/include/asm-powerpc/hw_irq.h b/include/asm-powerpc/hw_irq.h
--- a/include/asm-powerpc/hw_irq.h
+++ b/include/asm-powerpc/hw_irq.h
@@ -72,7 +72,11 @@
 static inline void local_irq_disable(void)
 {
 #ifdef CONFIG_BOOKE
+#ifdef CONFIG_KVM_GUEST
+	__asm__ __volatile__("wrtee %0": : "r"(0) :"memory");
+#else
 	__asm__ __volatile__("wrteei 0": : :"memory");
+#endif
 #else
 	unsigned long msr;
 	__asm__ __volatile__("": : :"memory");
@@ -84,7 +88,11 @@
 static inline void local_irq_enable(void)
 {
 #ifdef CONFIG_BOOKE
+#ifdef CONFIG_KVM_GUEST
+	__asm__ __volatile__("wrtee %0": : "r"(MSR_EE) :"memory");
+#else
 	__asm__ __volatile__("wrteei 1": : :"memory");
+#endif
 #else
 	unsigned long msr;
 	__asm__ __volatile__("": : :"memory");
@@ -99,7 +107,11 @@
 	msr = mfmsr();
 	*flags = msr;
 #ifdef CONFIG_BOOKE
+#ifdef CONFIG_KVM_GUEST
+	__asm__ __volatile__("wrtee %0": : "r"(0) :"memory");
+#else
 	__asm__ __volatile__("wrteei 0": : :"memory");
+#endif
 #else
 	SET_MSR_EE(msr & ~MSR_EE);
 #endif
