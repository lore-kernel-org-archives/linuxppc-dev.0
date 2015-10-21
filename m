Return-Path: <paulus@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48A231A02CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 16:04:29 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B7677140549
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:04:28 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulus@au1.ibm.com>;
 Wed, 21 Oct 2015 15:04:27 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 841563578057
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:04:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9L54Gmj57933940
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:04:25 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9L53qgd006532
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:03:52 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t9L53pcB005978
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:03:52 +1100
Date: Wed, 21 Oct 2015 16:03:14 +1100
From: Paul Mackerras <paulus@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] Revert "Use the POWER8 Micro Partition Prefetch Engine
 in KVM HV on POWER8"
Message-ID: <20151021050314.GA17764@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 9678cdaae93932473f696fdea5debf3eee1e1260 because
the original commit had multiple, partly self-cancelling bugs, that
could cause occasional memory corruption.  In fact the logmpp instruction
was using register r0 as the source of the buffer address and operation
code, and depending on what was in r0, it would either do nothing or
corrupt the 64k page pointed to by r0.  The logmpp instruction encoding
and the operation code definitions could be corrected, but then there is
the problem that there is no clearly defined way to know when the
hardware has finished writing to the buffer.  The original commit
attempted to work around this by aborting the write-out before starting
the prefetch, but this is ineffective in the case where the virtual
core is now executing on a different physical core from the one where
the write-out was initiated.

These problems plus advice from the hardware designers not to use the
function (since the measured performance improvement from using the
feature was actually mostly negative), mean that reverting the code is
the best option.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/cache.h      |  7 -----
 arch/powerpc/include/asm/kvm_host.h   |  2 --
 arch/powerpc/include/asm/ppc-opcode.h | 17 -----------
 arch/powerpc/include/asm/reg.h        |  1 -
 arch/powerpc/kvm/book3s_hv.c          | 55 +----------------------------------
 5 files changed, 1 insertion(+), 81 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 0dc42c5..5f8229e 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -3,7 +3,6 @@
 
 #ifdef __KERNEL__
 
-#include <asm/reg.h>
 
 /* bytes per L1 cache line */
 #if defined(CONFIG_8xx) || defined(CONFIG_403GCX)
@@ -40,12 +39,6 @@ struct ppc64_caches {
 };
 
 extern struct ppc64_caches ppc64_caches;
-
-static inline void logmpp(u64 x)
-{
-	asm volatile(PPC_LOGMPP(R1) : : "r" (x));
-}
-
 #endif /* __powerpc64__ && ! __ASSEMBLY__ */
 
 #if defined(__ASSEMBLY__)
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 827a38d..887c259 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -297,8 +297,6 @@ struct kvmppc_vcore {
 	u32 arch_compat;
 	ulong pcr;
 	ulong dpdes;		/* doorbell state (POWER8) */
-	void *mpp_buffer; /* Micro Partition Prefetch buffer */
-	bool mpp_buffer_is_valid;
 	ulong conferring_threads;
 };
 
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 790f5d1..7ab04fc 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -141,7 +141,6 @@
 #define PPC_INST_ISEL			0x7c00001e
 #define PPC_INST_ISEL_MASK		0xfc00003e
 #define PPC_INST_LDARX			0x7c0000a8
-#define PPC_INST_LOGMPP			0x7c0007e4
 #define PPC_INST_LSWI			0x7c0004aa
 #define PPC_INST_LSWX			0x7c00042a
 #define PPC_INST_LWARX			0x7c000028
@@ -285,20 +284,6 @@
 #define __PPC_EH(eh)	0
 #endif
 
-/* POWER8 Micro Partition Prefetch (MPP) parameters */
-/* Address mask is common for LOGMPP instruction and MPPR SPR */
-#define PPC_MPPE_ADDRESS_MASK 0xffffffffc000ULL
-
-/* Bits 60 and 61 of MPP SPR should be set to one of the following */
-/* Aborting the fetch is indeed setting 00 in the table size bits */
-#define PPC_MPPR_FETCH_ABORT (0x0ULL << 60)
-#define PPC_MPPR_FETCH_WHOLE_TABLE (0x2ULL << 60)
-
-/* Bits 54 and 55 of register for LOGMPP instruction should be set to: */
-#define PPC_LOGMPP_LOG_L2 (0x02ULL << 54)
-#define PPC_LOGMPP_LOG_L2L3 (0x01ULL << 54)
-#define PPC_LOGMPP_LOG_ABORT (0x03ULL << 54)
-
 /* Deal with instructions that older assemblers aren't aware of */
 #define	PPC_DCBAL(a, b)		stringify_in_c(.long PPC_INST_DCBAL | \
 					__PPC_RA(a) | __PPC_RB(b))
@@ -307,8 +292,6 @@
 #define PPC_LDARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LDARX | \
 					___PPC_RT(t) | ___PPC_RA(a) | \
 					___PPC_RB(b) | __PPC_EH(eh))
-#define PPC_LOGMPP(b)		stringify_in_c(.long PPC_INST_LOGMPP | \
-					__PPC_RB(b))
 #define PPC_LWARX(t, a, b, eh)	stringify_in_c(.long PPC_INST_LWARX | \
 					___PPC_RT(t) | ___PPC_RA(a) | \
 					___PPC_RB(b) | __PPC_EH(eh))
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index aa1cc5f0..a908ada 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -226,7 +226,6 @@
 #define   CTRL_TE	0x00c00000	/* thread enable */
 #define   CTRL_RUNLATCH	0x1
 #define SPRN_DAWR	0xB4
-#define SPRN_MPPR	0xB8	/* Micro Partition Prefetch Register */
 #define SPRN_RPR	0xBA	/* Relative Priority Register */
 #define SPRN_CIABR	0xBB
 #define   CIABR_PRIV		0x3
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2280497..9c26c5a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -36,7 +36,6 @@
 
 #include <asm/reg.h>
 #include <asm/cputable.h>
-#include <asm/cache.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
@@ -75,12 +74,6 @@
 
 static DECLARE_BITMAP(default_enabled_hcalls, MAX_HCALL_OPCODE/4 + 1);
 
-#if defined(CONFIG_PPC_64K_PAGES)
-#define MPP_BUFFER_ORDER	0
-#elif defined(CONFIG_PPC_4K_PAGES)
-#define MPP_BUFFER_ORDER	3
-#endif
-
 static int dynamic_mt_modes = 6;
 module_param(dynamic_mt_modes, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(dynamic_mt_modes, "Set of allowed dynamic micro-threading modes: 0 (= none), 2, 4, or 6 (= 2 or 4)");
@@ -1455,13 +1448,6 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 	vcore->kvm = kvm;
 	INIT_LIST_HEAD(&vcore->preempt_list);
 
-	vcore->mpp_buffer_is_valid = false;
-
-	if (cpu_has_feature(CPU_FTR_ARCH_207S))
-		vcore->mpp_buffer = (void *)__get_free_pages(
-			GFP_KERNEL|__GFP_ZERO,
-			MPP_BUFFER_ORDER);
-
 	return vcore;
 }
 
@@ -1894,33 +1880,6 @@ static int on_primary_thread(void)
 	return 1;
 }
 
-static void kvmppc_start_saving_l2_cache(struct kvmppc_vcore *vc)
-{
-	phys_addr_t phy_addr, mpp_addr;
-
-	phy_addr = (phys_addr_t)virt_to_phys(vc->mpp_buffer);
-	mpp_addr = phy_addr & PPC_MPPE_ADDRESS_MASK;
-
-	mtspr(SPRN_MPPR, mpp_addr | PPC_MPPR_FETCH_ABORT);
-	logmpp(mpp_addr | PPC_LOGMPP_LOG_L2);
-
-	vc->mpp_buffer_is_valid = true;
-}
-
-static void kvmppc_start_restoring_l2_cache(const struct kvmppc_vcore *vc)
-{
-	phys_addr_t phy_addr, mpp_addr;
-
-	phy_addr = virt_to_phys(vc->mpp_buffer);
-	mpp_addr = phy_addr & PPC_MPPE_ADDRESS_MASK;
-
-	/* We must abort any in-progress save operations to ensure
-	 * the table is valid so that prefetch engine knows when to
-	 * stop prefetching. */
-	logmpp(mpp_addr | PPC_LOGMPP_LOG_ABORT);
-	mtspr(SPRN_MPPR, mpp_addr | PPC_MPPR_FETCH_WHOLE_TABLE);
-}
-
 /*
  * A list of virtual cores for each physical CPU.
  * These are vcores that could run but their runner VCPU tasks are
@@ -2471,14 +2430,8 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 
 	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
 
-	if (vc->mpp_buffer_is_valid)
-		kvmppc_start_restoring_l2_cache(vc);
-
 	__kvmppc_vcore_entry();
 
-	if (vc->mpp_buffer)
-		kvmppc_start_saving_l2_cache(vc);
-
 	srcu_read_unlock(&vc->kvm->srcu, srcu_idx);
 
 	spin_lock(&vc->lock);
@@ -3073,14 +3026,8 @@ static void kvmppc_free_vcores(struct kvm *kvm)
 {
 	long int i;
 
-	for (i = 0; i < KVM_MAX_VCORES; ++i) {
-		if (kvm->arch.vcores[i] && kvm->arch.vcores[i]->mpp_buffer) {
-			struct kvmppc_vcore *vc = kvm->arch.vcores[i];
-			free_pages((unsigned long)vc->mpp_buffer,
-				   MPP_BUFFER_ORDER);
-		}
+	for (i = 0; i < KVM_MAX_VCORES; ++i)
 		kfree(kvm->arch.vcores[i]);
-	}
 	kvm->arch.online_vcores = 0;
 }
 
-- 
2.1.4
