Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16900.16651.359433.310079@cargo.ozlabs.ibm.com>
Date: Sat, 5 Feb 2005 14:44:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linuxppc-dev@lists.linuxppc.org, trini@kernel.crashing.org,
	torvalds@osdl.org
Subject: [PATCH] Fix PPC rwlock code on SMP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, the kernel won't compile for SMP ppc32 if preempt is
enabled.  This patch adds suitable read_can_lock and write_can_lock
definitions.

This patch also adds a real _raw_read_trylock (inline and out-of-line
versions), changes the rwlock->lock field to a signed int, which is
what it really was all along, and cleans up the out-of-line rwlock
code in arch/ppc/lib/locks.c.  It removes the debug fields from the
rwlock struct because we were never using them, even with
CONFIG_DEBUG_SPINLOCK set.

I have compile and boot tested this with the four combinations of
CONFIG_DEBUG_SPINLOCKS on and off, and CONFIG_PREEMPT on and off.
Please put this patch into 2.6.11 so that 2.6.11 will work for
ppc32 with CONFIG_SMP and CONFIG_PREEMPT.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/lib/locks.c nanango/arch/ppc/lib/locks.c
--- linux-2.5/arch/ppc/lib/locks.c	2004-06-04 15:14:12.000000000 +1000
+++ nanango/arch/ppc/lib/locks.c	2005-02-05 14:02:33.427658848 +1100
@@ -91,44 +91,57 @@
 }
 EXPORT_SYMBOL(_raw_spin_unlock);
 
-
 /*
- * Just like x86, implement read-write locks as a 32-bit counter
- * with the high bit (sign) being the "write" bit.
- * -- Cort
+ * For rwlocks, zero is unlocked, -1 is write-locked,
+ * positive is read-locked.
  */
+static __inline__ int __read_trylock(rwlock_t *rw)
+{
+	signed int tmp;
+
+	__asm__ __volatile__(
+"2:	lwarx	%0,0,%1		# __read_trylock\n\
+	addic.	%0,%0,1\n\
+	ble-	1f\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1\n\
+	bne-	2b\n\
+	isync\n\
+1:"
+	: "=&r"(tmp)
+	: "r"(&rw->lock)
+	: "cr0", "memory");
+
+	return tmp;
+}
+
+int _raw_read_trylock(rwlock_t *rw)
+{
+	return __read_trylock(rw) > 0;
+}
+EXPORT_SYMBOL(_raw_read_trylock);
+
 void _raw_read_lock(rwlock_t *rw)
 {
-	unsigned long stuck = INIT_STUCK;
-	int cpu = smp_processor_id();
+	unsigned int stuck;
 
-again:
-	/* get our read lock in there */
-	atomic_inc((atomic_t *) &(rw)->lock);
-	if ( (signed long)((rw)->lock) < 0) /* someone has a write lock */
-	{
-		/* turn off our read lock */
-		atomic_dec((atomic_t *) &(rw)->lock);
-		/* wait for the write lock to go away */
-		while ((signed long)((rw)->lock) < 0)
-		{
-			if(!--stuck)
-			{
-				printk("_read_lock(%p) CPU#%d\n", rw, cpu);
+	while (__read_trylock(rw) <= 0) {
+		stuck = INIT_STUCK;
+		while (!read_can_lock(rw)) {
+			if (--stuck == 0) {
+				printk("_read_lock(%p) CPU#%d lock %d\n",
+				       rw, _smp_processor_id(), rw->lock);
 				stuck = INIT_STUCK;
 			}
 		}
-		/* try to get the read lock again */
-		goto again;
 	}
-	wmb();
 }
 EXPORT_SYMBOL(_raw_read_lock);
 
 void _raw_read_unlock(rwlock_t *rw)
 {
 	if ( rw->lock == 0 )
-		printk("_read_unlock(): %s/%d (nip %08lX) lock %lx\n",
+		printk("_read_unlock(): %s/%d (nip %08lX) lock %d\n",
 		       current->comm,current->pid,current->thread.regs->nip,
 		      rw->lock);
 	wmb();
@@ -138,40 +151,17 @@
 
 void _raw_write_lock(rwlock_t *rw)
 {
-	unsigned long stuck = INIT_STUCK;
-	int cpu = smp_processor_id();
+	unsigned int stuck;
 
-again:
-	if ( test_and_set_bit(31,&(rw)->lock) ) /* someone has a write lock */
-	{
-		while ( (rw)->lock & (1<<31) ) /* wait for write lock */
-		{
-			if(!--stuck)
-			{
-				printk("write_lock(%p) CPU#%d lock %lx)\n",
-				       rw, cpu,rw->lock);
+	while (cmpxchg(&rw->lock, 0, -1) != 0) {
+		stuck = INIT_STUCK;
+		while (!write_can_lock(rw)) {
+			if (--stuck == 0) {
+				printk("write_lock(%p) CPU#%d lock %d)\n",
+				       rw, _smp_processor_id(), rw->lock);
 				stuck = INIT_STUCK;
 			}
-			barrier();
 		}
-		goto again;
-	}
-
-	if ( (rw)->lock & ~(1<<31)) /* someone has a read lock */
-	{
-		/* clear our write lock and wait for reads to go away */
-		clear_bit(31,&(rw)->lock);
-		while ( (rw)->lock & ~(1<<31) )
-		{
-			if(!--stuck)
-			{
-				printk("write_lock(%p) 2 CPU#%d lock %lx)\n",
-				       rw, cpu,rw->lock);
-				stuck = INIT_STUCK;
-			}
-			barrier();
-		}
-		goto again;
 	}
 	wmb();
 }
@@ -179,14 +169,8 @@
 
 int _raw_write_trylock(rwlock_t *rw)
 {
-	if (test_and_set_bit(31, &(rw)->lock)) /* someone has a write lock */
-		return 0;
-
-	if ((rw)->lock & ~(1<<31)) {	/* someone has a read lock */
-		/* clear our write lock and wait for reads to go away */
-		clear_bit(31,&(rw)->lock);
+	if (cmpxchg(&rw->lock, 0, -1) != 0)
 		return 0;
-	}
 	wmb();
 	return 1;
 }
@@ -194,12 +178,12 @@
 
 void _raw_write_unlock(rwlock_t *rw)
 {
-	if ( !(rw->lock & (1<<31)) )
-		printk("_write_lock(): %s/%d (nip %08lX) lock %lx\n",
+	if (rw->lock >= 0)
+		printk("_write_lock(): %s/%d (nip %08lX) lock %d\n",
 		      current->comm,current->pid,current->thread.regs->nip,
 		      rw->lock);
 	wmb();
-	clear_bit(31,&(rw)->lock);
+	rw->lock = 0;
 }
 EXPORT_SYMBOL(_raw_write_unlock);
 
diff -urN linux-2.5/include/asm-ppc/spinlock.h nanango/include/asm-ppc/spinlock.h
--- linux-2.5/include/asm-ppc/spinlock.h	2005-01-21 08:40:04.000000000 +1100
+++ nanango/include/asm-ppc/spinlock.h	2005-02-05 13:57:51.351671856 +1100
@@ -82,29 +82,43 @@
  * read-locks.
  */
 typedef struct {
-	volatile unsigned long lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	volatile unsigned long owner_pc;
-#endif
+	volatile signed int lock;
 #ifdef CONFIG_PREEMPT
 	unsigned int break_lock;
 #endif
 } rwlock_t;
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_DEBUG_INIT     , 0
-#else
-#define RWLOCK_DEBUG_INIT     /* */
-#endif
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 RWLOCK_DEBUG_INIT }
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
 #define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
 
+#define read_can_lock(rw)	((rw)->lock >= 0)
+#define write_can_lock(rw)	(!(rw)->lock)
+
 #ifndef CONFIG_DEBUG_SPINLOCK
 
+static __inline__ int _raw_read_trylock(rwlock_t *rw)
+{
+	signed int tmp;
+
+	__asm__ __volatile__(
+"2:	lwarx	%0,0,%1		# read_trylock\n\
+	addic.	%0,%0,1\n\
+	ble-	1f\n"
+	PPC405_ERR77(0,%1)
+"	stwcx.	%0,0,%1\n\
+	bne-	2b\n\
+	isync\n\
+1:"
+	: "=&r"(tmp)
+	: "r"(&rw->lock)
+	: "cr0", "memory");
+
+	return tmp > 0;
+}
+
 static __inline__ void _raw_read_lock(rwlock_t *rw)
 {
-	unsigned int tmp;
+	signed int tmp;
 
 	__asm__ __volatile__(
 	"b	2f		# read_lock\n\
@@ -125,7 +139,7 @@
 
 static __inline__ void _raw_read_unlock(rwlock_t *rw)
 {
-	unsigned int tmp;
+	signed int tmp;
 
 	__asm__ __volatile__(
 	"eieio			# read_unlock\n\
@@ -141,7 +155,7 @@
 
 static __inline__ int _raw_write_trylock(rwlock_t *rw)
 {
-	unsigned int tmp;
+	signed int tmp;
 
 	__asm__ __volatile__(
 "2:	lwarx	%0,0,%1		# write_trylock\n\
@@ -161,7 +175,7 @@
 
 static __inline__ void _raw_write_lock(rwlock_t *rw)
 {
-	unsigned int tmp;
+	signed int tmp;
 
 	__asm__ __volatile__(
 	"b	2f		# write_lock\n\
@@ -192,11 +206,10 @@
 extern void _raw_read_unlock(rwlock_t *rw);
 extern void _raw_write_lock(rwlock_t *rw);
 extern void _raw_write_unlock(rwlock_t *rw);
+extern int _raw_read_trylock(rwlock_t *rw);
 extern int _raw_write_trylock(rwlock_t *rw);
 
 #endif
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
-
 #endif /* __ASM_SPINLOCK_H */
 #endif /* __KERNEL__ */
