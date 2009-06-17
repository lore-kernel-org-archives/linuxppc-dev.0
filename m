Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 05C15B7178
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 12:43:29 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 17 Jun 2009 12:42:51 +1000
Subject: [PATCH 3/3] powerpc/pasemi: Use raw spinlock in SMP TB sync
Message-Id: <20090617024328.EAA7DDDDA1@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

spin_lock() can hang if called while the timebase is frozen,
so use a raw lock instead, also disable interrupts while
at it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/pasemi/setup.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- linux-work.orig/arch/powerpc/platforms/pasemi/setup.c	2009-06-17 12:13:33.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pasemi/setup.c	2009-06-17 12:15:01.000000000 +1000
@@ -71,20 +71,25 @@ static void pas_restart(char *cmd)
 }
 
 #ifdef CONFIG_SMP
-static DEFINE_SPINLOCK(timebase_lock);
+static raw_spinlock_t timebase_lock;
 static unsigned long timebase;
 
 static void __devinit pas_give_timebase(void)
 {
-	spin_lock(&timebase_lock);
+	unsigned long flags;
+
+	local_irq_save(flags);
+	hard_irq_disable();
+	__raw_spin_lock(&timebase_lock);
 	mtspr(SPRN_TBCTL, TBCTL_FREEZE);
 	isync();
 	timebase = get_tb();
-	spin_unlock(&timebase_lock);
+	__raw_spin_unlock(&timebase_lock);
 
 	while (timebase)
 		barrier();
 	mtspr(SPRN_TBCTL, TBCTL_RESTART);
+	local_irq_restore(flags);
 }
 
 static void __devinit pas_take_timebase(void)
@@ -92,10 +97,10 @@ static void __devinit pas_take_timebase(
 	while (!timebase)
 		smp_rmb();
 
-	spin_lock(&timebase_lock);
+	__raw_spin_lock(&timebase_lock);
 	set_tb(timebase >> 32, timebase & 0xffffffff);
 	timebase = 0;
-	spin_unlock(&timebase_lock);
+	__raw_spin_unlock(&timebase_lock);
 }
 
 struct smp_ops_t pas_smp_ops = {
