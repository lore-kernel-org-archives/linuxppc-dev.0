Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FFE91A05E2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 18:15:44 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH v2 3/6] powerpc: Add threads_per_subcore
Date: Fri, 23 May 2014 18:15:27 +1000
Message-Id: <1400832930-17050-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1400832930-17050-1-git-send-email-mikey@neuling.org>
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

On POWER8 we have a new concept of a subcore. This is what happens when
you take a regular core and split it. A subcore is a grouping of two or
four SMT threads, as well as a handfull of SPRs which allows the subcore
to appear as if it were a core from the point of view of a guest.

Unlike threads_per_core which is fixed at boot, threads_per_subcore can
change while the system is running. Most code will not want to use
threads_per_subcore.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputhreads.h | 7 +++++++
 arch/powerpc/kernel/setup-common.c    | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index ac3eedb..2bf8e93 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -18,10 +18,12 @@
 
 #ifdef CONFIG_SMP
 extern int threads_per_core;
+extern int threads_per_subcore;
 extern int threads_shift;
 extern cpumask_t threads_core_mask;
 #else
 #define threads_per_core	1
+#define threads_per_subcore	1
 #define threads_shift		0
 #define threads_core_mask	(CPU_MASK_CPU0)
 #endif
@@ -74,6 +76,11 @@ static inline int cpu_thread_in_core(int cpu)
 	return cpu & (threads_per_core - 1);
 }
 
+static inline int cpu_thread_in_subcore(int cpu)
+{
+	return cpu & (threads_per_subcore - 1);
+}
+
 static inline int cpu_first_thread_sibling(int cpu)
 {
 	return cpu & ~(threads_per_core - 1);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 3cf25c8..aa0f5ed 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -390,9 +390,10 @@ void __init check_for_initrd(void)
 
 #ifdef CONFIG_SMP
 
-int threads_per_core, threads_shift;
+int threads_per_core, threads_per_subcore, threads_shift;
 cpumask_t threads_core_mask;
 EXPORT_SYMBOL_GPL(threads_per_core);
+EXPORT_SYMBOL_GPL(threads_per_subcore);
 EXPORT_SYMBOL_GPL(threads_shift);
 EXPORT_SYMBOL_GPL(threads_core_mask);
 
@@ -401,6 +402,7 @@ static void __init cpu_init_thread_core_maps(int tpc)
 	int i;
 
 	threads_per_core = tpc;
+	threads_per_subcore = tpc;
 	cpumask_clear(&threads_core_mask);
 
 	/* This implementation only supports power of 2 number of threads
-- 
1.9.1
