Date: Fri, 8 Aug 2003 02:15:23 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: paulus@samba.org
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] 2.6 timebase synchronization
Message-ID: <20030808001523.GA9274@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Here is a patch that provides improved generic SMP timebase
synchronization for 2.6.

The calibration error is typically 0 ticks (at least on my machine).
Without this patch, the difference is about 2 * 10^6 ticks...

/Samuel


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.998   -> 1.999
#	arch/ppc/kernel/Makefile	1.51    -> 1.52
#	arch/ppc/kernel/smp.c	1.35    -> 1.36
#	               (new)	        -> 1.1     arch/ppc/kernel/smp-tbsync.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/08	samuel@ibrium.se	1.999
# SMP timebase synchronization
# --------------------------------------------
#
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	Fri Aug  8 01:51:49 2003
+++ b/arch/ppc/kernel/Makefile	Fri Aug  8 01:51:49 2003
@@ -25,7 +25,7 @@
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_PCI)		+= pci-dma.o
 obj-$(CONFIG_KGDB)		+= ppc-stub.o
-obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
 obj-$(CONFIG_TAU)		+= temp.o

 ifdef CONFIG_MATH_EMULATION
diff -Nru a/arch/ppc/kernel/smp-tbsync.c b/arch/ppc/kernel/smp-tbsync.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/kernel/smp-tbsync.c	Fri Aug  8 01:51:49 2003
@@ -0,0 +1,187 @@
+/*
+ * Smp timebase synchronization for ppc.
+ *
+ * Copyright (C) 2003 Samuel Rydh (samuel@ibrium.se)
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/unistd.h>
+#include <linux/init.h>
+#include <asm/atomic.h>
+#include <asm/smp.h>
+#include <asm/time.h>
+
+#define NUM_ITER		300
+
+enum {
+	kExit=0, kSetAndTest, kTest
+};
+
+/* keep things aligned in order to avoid cache ping-pong */
+struct tbsync_vars {
+	/* CPU0 write */
+	volatile int		tbu;
+	volatile int		tbl;
+	volatile int		mark;
+	volatile int		handshake;
+	volatile int		cmd;
+	int			filler1[3+8];
+
+	/* CPU0 and CPU1 write */
+	atomic_t		contest;
+};
+
+static volatile int		tbsync_ack;
+static volatile int		running;
+
+static struct tbsync_vars	*tbsync;
+
+
+#define I_SYNC()		asm volatile("sync; isync");
+#define CONTEST_CACHE_FLUSH()	asm volatile("dcbf 0,%0 ; sync ; isync" : : \
+						"r" (&tbsync->contest) );
+
+
+static int __devinit
+enter_contest( int mark, int add )
+{
+	while( (int)(get_tbl() - mark) < 0 )
+		;
+	return atomic_add_return( add, &tbsync->contest );
+}
+
+void __devinit
+smp_generic_take_timebase( void )
+{
+	int cmd, tbl;
+
+	while( !running )
+		;
+	for( ;; ) {
+		tbsync_ack = 1;
+		while( !tbsync->handshake )
+			;
+
+		I_SYNC();
+
+		cmd = tbsync->cmd;
+		tbl = tbsync->tbl;
+		tbsync_ack = 0;
+		if( cmd == kExit )
+			return;
+
+		while( tbsync->handshake )
+			;
+		if( cmd == kSetAndTest ) {
+			asm volatile ("isync");
+			asm volatile ("mttbl %0" :: "r" (tbl) );
+			asm volatile ("mttbu %0" :: "r" (tbsync->tbu) );
+		}
+		(void) enter_contest( tbsync->mark, 2 );
+
+		CONTEST_CACHE_FLUSH();
+	}
+}
+
+static int __devinit
+start_contest( int cmd, int offset, int num )
+{
+	int i, tbu, tbl, mark, result, score=0;
+
+	tbsync->cmd = cmd;
+
+	for( i=-3; i<num; ) {
+		atomic_set( &tbsync->contest, 0 );
+		CONTEST_CACHE_FLUSH();
+
+		tbl = get_tbl() + 2000;
+		tbsync->tbu = tbu = get_tbu();
+		tbsync->tbl = tbl + offset;
+		tbsync->mark = mark = tbl + 500;
+
+		I_SYNC();
+
+		tbsync->handshake = 1;
+		while( tbsync_ack )
+			;
+
+		while( (int)(get_tbl() - tbl) <= 0 )
+			;
+		tbsync->handshake = 0;
+		result = enter_contest( mark, -1 );
+
+		while( !tbsync_ack )
+			;
+
+		if( tbsync->tbu != get_tbu() || ((tbsync->tbl ^ get_tbl()) & 0x80000000) )
+			continue;
+
+		if( i++ > 0 )
+			score += result;
+	}
+	return score;
+}
+
+void __devinit
+smp_generic_give_timebase( void )
+{
+	int i, offset, score, min=0, max=5000, next_offset=1000;
+	int best=10000, best_offset;
+
+	printk("Synchronizing timebase\n");
+
+	/* if this fails then this kernel won't work anyway... */
+	tbsync = kmalloc( sizeof(*tbsync), GFP_KERNEL );
+	memset( tbsync, 0, sizeof(*tbsync) );
+	I_SYNC();
+	running = 1;
+	while( !tbsync_ack )
+		;
+
+	/* binary search for optimal offset */
+	do {
+		offset = next_offset;
+		score = start_contest( kSetAndTest, offset, NUM_ITER );
+
+		printk("score %d, offset %d [%d..%d]\n", score, offset, min, max );
+
+		if( score > 0 )
+			max = offset;
+		else {
+			min = offset;
+			score = -score;
+		}
+		if( score < best ) {
+			best_offset = offset;
+			best = score;
+		}
+		next_offset = (min + max)/2;
+	} while( offset != next_offset );
+
+	/* guard against inaccurate mttb */
+	for( i=0; i<10; i++ ) {
+		if( (score=start_contest(kTest, best_offset, NUM_ITER)) < 0 )
+			score = -score;
+		if( score <= best || score < 20 )
+			break;
+		start_contest( kSetAndTest, best_offset, NUM_ITER/10 );
+	}
+	printk("Final timbase offset: %d (%d/%d)\n", best_offset, score, NUM_ITER );
+
+	/* exiting */
+	tbsync->cmd = kExit;
+	I_SYNC();
+	tbsync->handshake = 1;
+	while( tbsync_ack )
+		;
+	tbsync->handshake = 0;
+	kfree( tbsync );
+	tbsync = NULL;
+
+	/* all done */
+	smp_tb_synchronized = 1;
+}
diff -Nru a/arch/ppc/kernel/smp.c b/arch/ppc/kernel/smp.c
--- a/arch/ppc/kernel/smp.c	Fri Aug  8 01:51:49 2003
+++ b/arch/ppc/kernel/smp.c	Fri Aug  8 01:51:49 2003
@@ -58,10 +58,6 @@
 /* all cpu mappings are 1-1 -- Cort */
 volatile unsigned long cpu_callin_map[NR_CPUS];

-#define TB_SYNC_PASSES 4
-volatile unsigned long __initdata tb_sync_flag = 0;
-volatile unsigned long __initdata tb_offset = 0;
-
 int start_secondary(void *);
 extern int cpu_idle(void *unused);
 void smp_call_function_interrupt(void);
@@ -288,41 +284,6 @@
 		atomic_inc(&call_data->finished);
 }

-/* FIXME: Do this properly for all archs --RR */
-static spinlock_t timebase_lock = SPIN_LOCK_UNLOCKED;
-static unsigned int timebase_upper = 0, timebase_lower = 0;
-
-void __devinit
-smp_generic_give_timebase(void)
-{
-	spin_lock(&timebase_lock);
-	do {
-		timebase_upper = get_tbu();
-		timebase_lower = get_tbl();
-	} while (timebase_upper != get_tbu());
-	spin_unlock(&timebase_lock);
-
-	while (timebase_upper || timebase_lower)
-		rmb();
-}
-
-void __devinit
-smp_generic_take_timebase(void)
-{
-	int done = 0;
-
-	while (!done) {
-		spin_lock(&timebase_lock);
-		if (timebase_upper || timebase_lower) {
-			set_tb(timebase_upper, timebase_lower);
-			timebase_upper = 0;
-			timebase_lower = 0;
-			done = 1;
-		}
-		spin_unlock(&timebase_lock);
-	}
-}
-
 static void __devinit smp_store_cpu_info(int id)
 {
         struct cpuinfo_PPC *c = &cpu_data[id];
@@ -423,7 +384,7 @@

 	/* wake up cpu */
 	smp_ops->kick_cpu(cpu);
-
+
 	/*
 	 * wait to see if the cpu made a callin (is actually up).
 	 * use this value that I found through experimentation.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
