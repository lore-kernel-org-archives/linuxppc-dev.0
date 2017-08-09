Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS9rL6S2vzDr2y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 22:41:54 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y192so5810956pgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 05:41:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/6] powerpc/watchdog: Improve watchdog lock primitive
Date: Wed,  9 Aug 2017 22:41:22 +1000
Message-Id: <20170809124126.28907-3-npiggin@gmail.com>
In-Reply-To: <20170809124126.28907-1-npiggin@gmail.com>
References: <20170809124126.28907-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Hard-disable interrupts before taking the lock, which prevents
  soft-NMI re-entrancy and therefore can prevent deadlocks.
- Use raw_ variants of local_irq_disable to avoid irq debugging.
- When the lock is contended, spin at low SMT priority, using
  loads only, and with interrupts enabled (where possible).

Some stalls have been noticed at high loads that go away with improved
locking. There should not be so much locking contention in the first
place (which is addressed in a subsequent patch), but locking should
still be improved.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/watchdog.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 4b9a567c9975..3a26c3401acc 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -71,15 +71,20 @@ static inline void wd_smp_lock(unsigned long *flags)
 	 * This may be called from low level interrupt handlers at some
 	 * point in future.
 	 */
-	local_irq_save(*flags);
-	while (unlikely(test_and_set_bit_lock(0, &__wd_smp_lock)))
-		cpu_relax();
+	raw_local_irq_save(*flags);
+	hard_irq_disable(); /* Make it soft-NMI safe */
+	while (unlikely(test_and_set_bit_lock(0, &__wd_smp_lock))) {
+		raw_local_irq_restore(*flags);
+		spin_until_cond(!test_bit(0, &__wd_smp_lock));
+		raw_local_irq_save(*flags);
+		hard_irq_disable();
+	}
 }
 
 static inline void wd_smp_unlock(unsigned long *flags)
 {
 	clear_bit_unlock(0, &__wd_smp_lock);
-	local_irq_restore(*flags);
+	raw_local_irq_restore(*flags);
 }
 
 static void wd_lockup_ipi(struct pt_regs *regs)
-- 
2.13.3
