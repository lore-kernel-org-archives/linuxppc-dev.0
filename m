Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id A7DCFDDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 10:51:33 +1000 (EST)
Date: Tue, 22 May 2007 19:51:25 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] remove spinlock from struct cpu_purr_data
Message-ID: <20070523005125.GE29914@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cpu_purr_data is a per-cpu array used to account for stolen time on
partitioned systems.  It used to be the case that cpus accessed each
others' cpu_purr_data, so each entry was protected by a spinlock.

However, the code was reworked ("Simplify stolen time calculation")
with the result that each cpu accesses its own cpu_purr_data and not
those of other cpus.  This means we can get rid of the spinlock as
long as we're careful to disable interrupts when accessing
cpu_purr_data in process context.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/kernel/time.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 2c8564d..0a8a820 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -222,19 +222,28 @@ struct cpu_purr_data {
 	int	initialized;			/* thread is running */
 	u64	tb;			/* last TB value read */
 	u64	purr;			/* last PURR value read */
-	spinlock_t lock;
 };
 
+/*
+ * Each entry in the cpu_purr_data array is manipulated only by its
+ * "owner" cpu -- usually in the timer interrupt but also occasionally
+ * in process context for cpu online.  As long as cpus do not touch
+ * each others' cpu_purr_data, disabling local interrupts is
+ * sufficient to serialize accesses.
+ */
 static DEFINE_PER_CPU(struct cpu_purr_data, cpu_purr_data);
 
 static void snapshot_tb_and_purr(void *data)
 {
+	unsigned long flags;
 	struct cpu_purr_data *p = &__get_cpu_var(cpu_purr_data);
 
+	local_irq_save(flags);
 	p->tb = mftb();
 	p->purr = mfspr(SPRN_PURR);
 	wmb();
 	p->initialized = 1;
+	local_irq_restore(flags);
 }
 
 /*
@@ -242,15 +251,14 @@ static void snapshot_tb_and_purr(void *data)
  */
 void snapshot_timebases(void)
 {
-	int cpu;
-
 	if (!cpu_has_feature(CPU_FTR_PURR))
 		return;
-	for_each_possible_cpu(cpu)
-		spin_lock_init(&per_cpu(cpu_purr_data, cpu).lock);
 	on_each_cpu(snapshot_tb_and_purr, NULL, 0, 1);
 }
 
+/*
+ * Must be called with interrupts disabled.
+ */
 void calculate_steal_time(void)
 {
 	u64 tb, purr;
@@ -262,7 +270,6 @@ void calculate_steal_time(void)
 	pme = &per_cpu(cpu_purr_data, smp_processor_id());
 	if (!pme->initialized)
 		return;		/* this can happen in early boot */
-	spin_lock(&pme->lock);
 	tb = mftb();
 	purr = mfspr(SPRN_PURR);
 	stolen = (tb - pme->tb) - (purr - pme->purr);
@@ -270,7 +277,6 @@ void calculate_steal_time(void)
 		account_steal_time(current, stolen);
 	pme->tb = tb;
 	pme->purr = purr;
-	spin_unlock(&pme->lock);
 }
 
 /*
@@ -284,12 +290,12 @@ static void snapshot_purr(void)
 
 	if (!cpu_has_feature(CPU_FTR_PURR))
 		return;
+	local_irq_save(flags);
 	pme = &per_cpu(cpu_purr_data, smp_processor_id());
-	spin_lock_irqsave(&pme->lock, flags);
 	pme->tb = mftb();
 	pme->purr = mfspr(SPRN_PURR);
 	pme->initialized = 1;
-	spin_unlock_irqrestore(&pme->lock, flags);
+	local_irq_restore(flags);
 }
 
 #endif /* CONFIG_PPC_SPLPAR */
-- 
1.5.2
