Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EAD4767BEB
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 23:08:35 +1000 (EST)
Date: Tue, 17 Oct 2006 23:08:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] simplify stolen time calculation
Message-Id: <20061017230835.ea9876ae.sfr@canb.auug.org.au>
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

In calculating stolen time, we were trying to actually account for time
spent in the hypervisor.  We don't really have enough information to do
that accurately, so don't try.  Instead, we now calculate stolen time as
time that the current cpu thread is not actually dispatching instructions.
On chips without a PURR, we cannot do this, so stolen time will always
be zero.  On chips with a PURR, this is merely the difference between
the elapsed PURR values and the elapsed TB values.

This gives us much more sane vaules from tools such as mpstat, even if
they are still a bit strange e.g. 2 busy threads on one cpu will both
appear to have 50% user time and 50% stolen time while 1 busy thread on
a cpu will look like 100% user on one of them and 100% idle on the other.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/time.c |   63 +++++++++++---------------------------------
 1 files changed, 16 insertions(+), 47 deletions(-)


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index a124499..73e73dd 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -221,11 +221,8 @@ #ifdef CONFIG_PPC_SPLPAR
  */
 struct cpu_purr_data {
 	int	initialized;			/* thread is running */
-	u64	tb0;			/* timebase at origin time */
-	u64	purr0;			/* PURR at origin time */
 	u64	tb;			/* last TB value read */
 	u64	purr;			/* last PURR value read */
-	u64	stolen;			/* stolen time so far */
 	spinlock_t lock;
 };
 
@@ -235,10 +232,8 @@ static void snapshot_tb_and_purr(void *d
 {
 	struct cpu_purr_data *p = &__get_cpu_var(cpu_purr_data);
 
-	p->tb0 = mftb();
-	p->purr0 = mfspr(SPRN_PURR);
-	p->tb = p->tb0;
-	p->purr = 0;
+	p->tb = mftb();
+	p->purr = mfspr(SPRN_PURR);
 	wmb();
 	p->initialized = 1;
 }
@@ -259,37 +254,24 @@ void snapshot_timebases(void)
 
 void calculate_steal_time(void)
 {
-	u64 tb, purr, t0;
+	u64 tb, purr;
 	s64 stolen;
-	struct cpu_purr_data *p0, *pme, *phim;
-	int cpu;
+	struct cpu_purr_data *pme;
 
 	if (!cpu_has_feature(CPU_FTR_PURR))
 		return;
-	cpu = smp_processor_id();
-	pme = &per_cpu(cpu_purr_data, cpu);
+	pme = &per_cpu(cpu_purr_data, smp_processor_id());
 	if (!pme->initialized)
 		return;		/* this can happen in early boot */
-	p0 = &per_cpu(cpu_purr_data, cpu & ~1);
-	phim = &per_cpu(cpu_purr_data, cpu ^ 1);
-	spin_lock(&p0->lock);
+	spin_lock(&pme->lock);
 	tb = mftb();
-	purr = mfspr(SPRN_PURR) - pme->purr0;
-	if (!phim->initialized || !cpu_online(cpu ^ 1)) {
-		stolen = (tb - pme->tb) - (purr - pme->purr);
-	} else {
-		t0 = pme->tb0;
-		if (phim->tb0 < t0)
-			t0 = phim->tb0;
-		stolen = phim->tb - t0 - phim->purr - purr - p0->stolen;
-	}
-	if (stolen > 0) {
+	purr = mfspr(SPRN_PURR);
+	stolen = (tb - pme->tb) - (purr - pme->purr);
+	if (stolen > 0)
 		account_steal_time(current, stolen);
-		p0->stolen += stolen;
-	}
 	pme->tb = tb;
 	pme->purr = purr;
-	spin_unlock(&p0->lock);
+	spin_unlock(&pme->lock);
 }
 
 /*
@@ -298,30 +280,17 @@ void calculate_steal_time(void)
  */
 static void snapshot_purr(void)
 {
-	int cpu;
-	u64 purr;
-	struct cpu_purr_data *p0, *pme, *phim;
+	struct cpu_purr_data *pme;
 	unsigned long flags;
 
 	if (!cpu_has_feature(CPU_FTR_PURR))
 		return;
-	cpu = smp_processor_id();
-	pme = &per_cpu(cpu_purr_data, cpu);
-	p0 = &per_cpu(cpu_purr_data, cpu & ~1);
-	phim = &per_cpu(cpu_purr_data, cpu ^ 1);
-	spin_lock_irqsave(&p0->lock, flags);
-	pme->tb = pme->tb0 = mftb();
-	purr = mfspr(SPRN_PURR);
-	if (!phim->initialized) {
-		pme->purr = 0;
-		pme->purr0 = purr;
-	} else {
-		/* set p->purr and p->purr0 for no change in p0->stolen */
-		pme->purr = phim->tb - phim->tb0 - phim->purr - p0->stolen;
-		pme->purr0 = purr - pme->purr;
-	}
+	pme = &per_cpu(cpu_purr_data, smp_processor_id());
+	spin_lock_irqsave(&pme->lock, flags);
+	pme->tb = mftb();
+	pme->purr = mfspr(SPRN_PURR);
 	pme->initialized = 1;
-	spin_unlock_irqrestore(&p0->lock, flags);
+	spin_unlock_irqrestore(&pme->lock, flags);
 }
 
 #endif /* CONFIG_PPC_SPLPAR */
-- 
1.4.2.3
