Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0137.outbound.protection.outlook.com [207.46.100.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35C5F1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 11:40:03 +1100 (AEDT)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <kda@linux-powerpc.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/6] powerpc/mm: any thread in one core can be the first to
 setup TLB1
Date: Thu, 24 Dec 2015 08:39:57 +0800
Message-ID: <1450917597-29171-1-git-send-email-chenhui.zhao@freescale.com>
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
Changes for v4:
* added CONFIG_BOOKE

 arch/powerpc/include/asm/cputhreads.h | 8 ++++++++
 arch/powerpc/mm/tlb_nohash.c          | 4 +---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index ba42e46..ea96231 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -94,6 +94,14 @@ static inline int cpu_last_thread_sibling(int cpu)
 	return cpu | (threads_per_core - 1);
 }
 
+static inline u32 get_tensr(void)
+{
+#ifdef	CONFIG_BOOKE
+	if (cpu_has_feature(CPU_FTR_SMT))
+		return mfspr(SPRN_TENSR);
+#endif
+	return 1;
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
