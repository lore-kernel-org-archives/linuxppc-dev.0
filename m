Return-Path: <olof@lixom.net>
Date: Tue, 21 Aug 2007 17:06:31 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@ozlabs.org
Subject: [PATCH] powerpc: Fix race in the pasemi timebase calibration
Message-ID: <20070821220631.GA4304@lixom.net>
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

Make sure the new timebase value is available by the time take_timebase
completes. Otherwise take_timebase might race with give_timebase,
causing severe badness when the value later is modified (think looong
hang trying to catch up with a very large number of lost ticks).

This has shown up lately, possibly because of other code paths in the
startup of secondary cpus being slimmed down enough that the race happened
more often.

Signed-off-by: Olof Johansson <olof@lixom.net>


---

Paul,

This started showing up in the 2.6.22 timeframe, and noone else seems
to have hit it yet, so there's no urge to get it into 2.6.23. Please
queue it for .24 though.


Thanks,

-Olof

Index: mainline/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- mainline.orig/arch/powerpc/platforms/pasemi/setup.c
+++ mainline/arch/powerpc/platforms/pasemi/setup.c
@@ -50,6 +50,7 @@ static void pas_restart(char *cmd)
 
 #ifdef CONFIG_SMP
 static DEFINE_SPINLOCK(timebase_lock);
+static unsigned long timebase_avail;
 
 static void __devinit pas_give_timebase(void)
 {
@@ -61,6 +62,7 @@ static void __devinit pas_give_timebase(
 	mtspr(SPRN_TBCTL, TBCTL_UPDATE_LOWER | (tb & 0xffffffff));
 	mtspr(SPRN_TBCTL, TBCTL_UPDATE_UPPER | (tb >> 32));
 	mtspr(SPRN_TBCTL, TBCTL_RESTART);
+	timebase_avail = 1;
 	spin_unlock(&timebase_lock);
 	pr_debug("pas_give_timebase: cpu %d gave tb %lx\n",
 		 smp_processor_id(), tb);
@@ -68,6 +70,8 @@ static void __devinit pas_give_timebase(
 
 static void __devinit pas_take_timebase(void)
 {
+	while (!timebase_avail)
+		smp_rmb();
 	pr_debug("pas_take_timebase: cpu %d has tb %lx\n",
 		 smp_processor_id(), mftb());
 }
