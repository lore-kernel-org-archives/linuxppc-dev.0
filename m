Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1D332DDE2E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 14:40:59 +1100 (EST)
Date: Fri, 23 Feb 2007 14:40:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] tidy spinlock.h a bit
Message-Id: <20070223144057.27e1e819.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


_raw_{spin,read,write}relax() are not used anywhere, so remove them.

The calls to __spin_yield() and __rw_yield() will only be compiled in
if CONFIG_PPC_SPLPAR or CONFIG_PPC_ISERIES is defined, so we don't need
alternate definitions for them (just declarations).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/spinlock.h |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/spinlock.h b/include/asm-powerpc/spinlock.h
index cc4cfce..e247503 100644
--- a/include/asm-powerpc/spinlock.h
+++ b/include/asm-powerpc/spinlock.h
@@ -95,13 +95,11 @@ static int __inline__ __raw_spin_trylock(raw_spinlock_t *lock)
 #if defined(CONFIG_PPC_SPLPAR) || defined(CONFIG_PPC_ISERIES)
 /* We only yield to the hypervisor if we are in shared processor mode */
 #define SHARED_PROCESSOR (get_lppaca()->shared_proc)
-extern void __spin_yield(raw_spinlock_t *lock);
-extern void __rw_yield(raw_rwlock_t *lock);
 #else /* SPLPAR || ISERIES */
-#define __spin_yield(x)	barrier()
-#define __rw_yield(x)	barrier()
 #define SHARED_PROCESSOR	0
 #endif
+extern void __spin_yield(raw_spinlock_t *lock);
+extern void __rw_yield(raw_rwlock_t *lock);
 
 static void __inline__ __raw_spin_lock(raw_spinlock_t *lock)
 {
@@ -285,9 +283,5 @@ static __inline__ void __raw_write_unlock(raw_rwlock_t *rw)
 	rw->lock = 0;
 }
 
-#define _raw_spin_relax(lock)	__spin_yield(lock)
-#define _raw_read_relax(lock)	__rw_yield(lock)
-#define _raw_write_relax(lock)	__rw_yield(lock)
-
 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */
-- 
1.4.4.4
