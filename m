Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CE332DDE99
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 13:21:58 +1000 (EST)
Date: Tue, 21 Aug 2007 21:26:43 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Rework SMP timebase handoff for pasemi
Message-ID: <20070822022643.GA9050@lixom.net>
References: <20070821220631.GA4304@lixom.net>
	<18123.37125.712301.914626@cargo.ozlabs.ibm.com>
	<20070822021212.GA8060@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070822021212.GA8060@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rework timebase handoff to play nice with configurations with more than
2 cores, as well as with CPU hotplug.

Previous scheme just pushed out the current timebase from the giving
core to all cores without caring if they wanted it or not, nor checking
if they'd taken it. The taking side didn't make sure the giving side
had provided a value yet either. In other words, it was completely broken.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: mainline/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- mainline.orig/arch/powerpc/platforms/pasemi/setup.c
+++ mainline/arch/powerpc/platforms/pasemi/setup.c
@@ -50,26 +50,30 @@ static void pas_restart(char *cmd)
 
 #ifdef CONFIG_SMP
 static DEFINE_SPINLOCK(timebase_lock);
+static unsigned long timebase;
 
 static void __devinit pas_give_timebase(void)
 {
-	unsigned long tb;
-
 	spin_lock(&timebase_lock);
 	mtspr(SPRN_TBCTL, TBCTL_FREEZE);
-	tb = mftb();
-	mtspr(SPRN_TBCTL, TBCTL_UPDATE_LOWER | (tb & 0xffffffff));
-	mtspr(SPRN_TBCTL, TBCTL_UPDATE_UPPER | (tb >> 32));
-	mtspr(SPRN_TBCTL, TBCTL_RESTART);
+	isync();
+	timebase = get_tb();
 	spin_unlock(&timebase_lock);
-	pr_debug("pas_give_timebase: cpu %d gave tb %lx\n",
-		 smp_processor_id(), tb);
+
+	while (timebase)
+		barrier();
+	mtspr(SPRN_TBCTL, TBCTL_RESTART);
 }
 
 static void __devinit pas_take_timebase(void)
 {
-	pr_debug("pas_take_timebase: cpu %d has tb %lx\n",
-		 smp_processor_id(), mftb());
+	while (!timebase)
+		smp_rmb();
+
+	spin_lock(&timebase_lock);
+	set_tb(timebase >> 32, timebase & 0xffffffff);
+	timebase = 0;
+	spin_unlock(&timebase_lock);
 }
 
 struct smp_ops_t pas_smp_ops = {
