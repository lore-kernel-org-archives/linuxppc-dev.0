Return-Path: <galak@freescale.com>
Date: Thu, 22 Sep 2005 10:13:31 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0509221012590.30414@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix building of power3 config on ppc32  
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The spinlock_types.h merge renamed the structure for raw_spinlock_t to
match ppc64.  In doing so some of the spinlock macros/functions needed to
be updated to match.  Apparently, this seems to only be caught when
building power3.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit faf6551d6434845fb16e28c203b2dc66d91ebd1f
tree 7f14282bd0eea36376ea64ee2ab7a61aaadd1ea0
parent 613d5aafb93030cbf69943dd47c3b37bdfd5a398
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 22 Sep 2005 10:12:03 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 22 Sep 2005 10:12:03 -0500

 include/asm-ppc/spinlock.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-ppc/spinlock.h b/include/asm-ppc/spinlock.h
--- a/include/asm-ppc/spinlock.h
+++ b/include/asm-ppc/spinlock.h
@@ -9,7 +9,7 @@
  * (the type definitions are in asm/raw_spinlock_types.h)
  */
 
-#define __raw_spin_is_locked(x)		((x)->lock != 0)
+#define __raw_spin_is_locked(x)		((x)->slock != 0)
 #define __raw_spin_unlock_wait(lock) \
 	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
@@ -31,17 +31,17 @@ static inline void __raw_spin_lock(raw_s
 	bne-	2b\n\
 	isync"
 	: "=&r"(tmp)
-	: "r"(&lock->lock), "r"(1)
+	: "r"(&lock->slock), "r"(1)
 	: "cr0", "memory");
 }
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__("eieio	# __raw_spin_unlock": : :"memory");
-	lock->lock = 0;
+	lock->slock = 0;
 }
 
-#define __raw_spin_trylock(l) (!test_and_set_bit(0,&(l)->lock))
+#define __raw_spin_trylock(l) (!test_and_set_bit(0,(volatile unsigned long *)(&(l)->slock)))
 
 /*
  * Read-write spinlocks, allowing multiple readers
