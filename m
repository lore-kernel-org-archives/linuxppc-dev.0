Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C5AF7B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 08:43:01 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10DF9DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 08:43:00 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] spinlock: __raw_spin_is_locked() should return true for UP
Date: Tue, 18 Aug 2009 17:42:23 -0500
Message-Id: <1250635343-32546-1-git-send-email-galak@kernel.crashing.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	linuxppc-dev@ozlabs.org, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For some reason __raw_spin_is_locked() has been returning false for the
uni-processor, non-CONFIG_DEBUG_SPINLOCK.  The UP + CONFIG_DEBUG_SPINLOCK
handles this correctly.

Found this by enabling CONFIG_DEBUG_VM on PPC and hitting always hitting
a BUG_ON that was testing to make sure the pte_lock was held.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Linus, a fix for 2.6.31

 include/linux/spinlock_up.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/spinlock_up.h b/include/linux/spinlock_up.h
index d4841ed..2b372e0 100644
--- a/include/linux/spinlock_up.h
+++ b/include/linux/spinlock_up.h
@@ -57,7 +57,7 @@ static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 #define __raw_write_unlock(lock)	do { (void)(lock); } while (0)
 
 #else /* DEBUG_SPINLOCK */
-#define __raw_spin_is_locked(lock)	((void)(lock), 0)
+#define __raw_spin_is_locked(lock)	((void)(lock), 1)
 /* for sched.c and kernel_lock.c: */
 # define __raw_spin_lock(lock)		do { (void)(lock); } while (0)
 # define __raw_spin_lock_flags(lock, flags)	do { (void)(lock); } while (0)
-- 
1.6.0.6
