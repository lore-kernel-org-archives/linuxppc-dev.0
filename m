Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0141.outbound.protection.outlook.com [207.46.100.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4BB41A00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 20:28:03 +1100 (AEDT)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <scottwood@freescale.com>
Subject: [PATCH v3 1/6] powerpc/mm: any thread in one core can be the first to
 setup TLB1
Date: Fri, 20 Nov 2015 17:13:57 +0800
Message-ID: <1448010842-22345-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On e6500, in the case of cpu hotplug, either thread in one core
may be the first thread initilzing the TLB1. The subsequent threads
must not setup it again.

The code is derived from the comment of Scott Wood.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/powerpc/include/asm/cputhreads.h | 7 +++++++
 arch/powerpc/mm/tlb_nohash.c          | 4 +---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index ba42e46..b56cece 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -94,6 +94,13 @@ static inline int cpu_last_thread_sibling(int cpu)
 	return cpu | (threads_per_core - 1);
 }
 
+static inline u32 get_tensr(void)
+{
+	if (cpu_has_feature(CPU_FTR_SMT))
+		return mfspr(SPRN_TENSR);
+	else
+		return 1;
+}
 
 
 #endif /* _ASM_POWERPC_CPUTHREADS_H */
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index bb04e4d..f466848 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -640,9 +640,7 @@ static void early_init_this_mmu(void)
 		 * transient mapping would cause problems.
 		 */
 #ifdef CONFIG_SMP
-		if (cpu != boot_cpuid &&
-		    (cpu != cpu_first_thread_sibling(cpu) ||
-		     cpu == cpu_first_thread_sibling(boot_cpuid)))
+		if (hweight32(get_tensr()) > 1)
 			map = false;
 #endif
 
-- 
1.9.1
