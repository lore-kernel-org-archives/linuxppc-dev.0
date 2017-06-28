Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyMCG3wT2zDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 22:13:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 2/2] powerpc: use spin loop primitives in some functions
Date: Wed, 28 Jun 2017 22:13:42 +1000
Message-Id: <1498652022-10417-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1498652022-10417-1-git-send-email-mpe@ellerman.id.au>
References: <1498652022-10417-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Use the different spin loop primitives in some simple powerpc
spin loops, including those which will spin as a common case.

This will help to test the spin loop primitives before more
conversions are done.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/delay.h | 15 +++++++++++----
 arch/powerpc/kernel/smp.c        |  3 +--
 arch/powerpc/kernel/time.c       |  6 ++++--
 arch/powerpc/mm/hash_native_64.c |  4 +++-
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/asm/delay.h
index 52e4d54da2a9..b028788bd55d 100644
--- a/arch/powerpc/include/asm/delay.h
+++ b/arch/powerpc/include/asm/delay.h
@@ -58,11 +58,18 @@ extern void udelay(unsigned long usecs);
 	typeof(condition) __ret;                                               \
 	unsigned long __loops = tb_ticks_per_usec * timeout;                   \
 	unsigned long __start = get_tbl();                                     \
-	while (!(__ret = (condition)) && (tb_ticks_since(__start) <= __loops)) \
-		if (delay)                                                     \
+                                                                               \
+	if (delay) {                                                           \
+		while (!(__ret = (condition)) &&                               \
+				(tb_ticks_since(__start) <= __loops))          \
 			udelay(delay);                                         \
-		else                                                           \
-			cpu_relax();                                           \
+	} else {                                                               \
+		spin_begin();                                                  \
+		while (!(__ret = (condition)) &&                               \
+				(tb_ticks_since(__start) <= __loops))          \
+			spin_cpu_relax();                                      \
+		spin_end();                                                    \
+	}                                                                      \
 	if (!__ret)                                                            \
 		__ret = (condition);                                           \
 	__ret;		                                                       \
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 418019728efa..67d89b4e777c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -767,8 +767,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 		smp_ops->give_timebase();
 
 	/* Wait until cpu puts itself in the online & active maps */
-	while (!cpu_online(cpu))
-		cpu_relax();
+	spin_until_cond(cpu_online(cpu));
 
 	return 0;
 }
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 0cc0dad905d5..e75844d76992 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -442,6 +442,7 @@ void __delay(unsigned long loops)
 	unsigned long start;
 	int diff;
 
+	spin_begin();
 	if (__USE_RTC()) {
 		start = get_rtcl();
 		do {
@@ -449,13 +450,14 @@ void __delay(unsigned long loops)
 			diff = get_rtcl() - start;
 			if (diff < 0)
 				diff += 1000000000;
+			spin_cpu_relax();
 		} while (diff < loops);
 	} else {
 		start = get_tbl();
 		while (get_tbl() - start < loops)
-			HMT_low();
-		HMT_medium();
+			spin_cpu_relax();
 	}
+	spin_end();
 }
 EXPORT_SYMBOL(__delay);
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index bdaac28193f7..ad0ba1da1b79 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -184,8 +184,10 @@ static inline void native_lock_hpte(struct hash_pte *hptep)
 	while (1) {
 		if (!test_and_set_bit_lock(HPTE_LOCK_BIT, word))
 			break;
+		spin_begin();
 		while(test_bit(HPTE_LOCK_BIT, word))
-			cpu_relax();
+			spin_cpu_relax();
+		spin_end();
 	}
 }
 
-- 
2.7.4
