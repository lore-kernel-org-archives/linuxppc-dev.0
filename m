Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1031F1A028E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:24 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/19] powerpc: Create mtmsrd_isync()
Date: Wed, 28 Oct 2015 11:50:55 +1100
Message-Id: <1445993467-667-7-git-send-email-anton@samba.org>
In-Reply-To: <1445993467-667-1-git-send-email-anton@samba.org>
References: <1445993467-667-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mtmsrd_isync() will do an mtmsrd followed by an isync on older
processors. On newer processors we avoid the isync via a feature fixup.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/reg.h |  8 ++++++++
 arch/powerpc/kernel/process.c  | 30 ++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a908ada..987dac0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1193,12 +1193,20 @@
 #define __mtmsrd(v, l)	asm volatile("mtmsrd %0," __stringify(l) \
 				     : : "r" (v) : "memory")
 #define mtmsr(v)	__mtmsrd((v), 0)
+#define __MTMSR		"mtmsrd"
 #else
 #define mtmsr(v)	asm volatile("mtmsr %0" : \
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
+#define __MTMSR		"mtmsr"
 #endif
 
+static inline void mtmsr_isync(unsigned long val)
+{
+	asm volatile(__MTMSR " %0; " ASM_FTR_IFCLR("isync", "nop", %1) : :
+			"r" (val), "i" (CPU_FTR_ARCH_206) : "memory");
+}
+
 #define mfspr(rn)	({unsigned long rval; \
 			asm volatile("mfspr %0," __stringify(rn) \
 				: "=r" (rval)); rval;})
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ef64219..5bf8ec2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -130,7 +130,10 @@ void enable_kernel_fp(void)
 		check_if_tm_restore_required(current);
 		giveup_fpu(current);
 	} else {
-		giveup_fpu(NULL);	/* just enables FP for kernel */
+		u64 oldmsr = mfmsr();
+
+		if (!(oldmsr & MSR_FP))
+			mtmsr_isync(oldmsr | MSR_FP);
 	}
 }
 EXPORT_SYMBOL(enable_kernel_fp);
@@ -144,7 +147,10 @@ void enable_kernel_altivec(void)
 		check_if_tm_restore_required(current);
 		giveup_altivec(current);
 	} else {
-		giveup_altivec_notask();
+		u64 oldmsr = mfmsr();
+
+		if (!(oldmsr & MSR_VEC))
+			mtmsr_isync(oldmsr | MSR_VEC);
 	}
 }
 EXPORT_SYMBOL(enable_kernel_altivec);
@@ -173,10 +179,14 @@ void enable_kernel_vsx(void)
 {
 	WARN_ON(preemptible());
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX))
+	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX)) {
 		giveup_vsx(current);
-	else
-		giveup_vsx(NULL);	/* just enable vsx for kernel - force */
+	} else {
+		u64 oldmsr = mfmsr();
+
+		if (!(oldmsr & MSR_VSX))
+			mtmsr_isync(oldmsr | MSR_VSX);
+	}
 }
 EXPORT_SYMBOL(enable_kernel_vsx);
 
@@ -209,10 +219,14 @@ void enable_kernel_spe(void)
 {
 	WARN_ON(preemptible());
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_SPE))
+	if (current->thread.regs && (current->thread.regs->msr & MSR_SPE)) {
 		giveup_spe(current);
-	else
-		giveup_spe(NULL);	/* just enable SPE for kernel - force */
+	} else {
+		u64 oldmsr = mfmsr();
+
+		if (!(oldmsr & MSR_SPE))
+			mtmsr_isync(oldmsr | MSR_SPE);
+	}
 }
 EXPORT_SYMBOL(enable_kernel_spe);
 
-- 
2.5.0
