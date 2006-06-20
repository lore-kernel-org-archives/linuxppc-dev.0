Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20D2F67A64
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 21:41:58 +1000 (EST)
Received: from [131.234.76.225] (helo=dhcp-76-225.uni-paderborn.de)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.62) (envelope-from <johannes@sipsolutions.net>)
	id 1Ft15m-0005FT-63
	for linuxppc-dev@ozlabs.org; Wed, 21 Jun 2006 12:41:54 +0100
Subject: [RFC] cpu hotplug in powermac g5
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 21 Jun 2006 01:22:49 +0200
Message-Id: <1150845770.16662.7.camel@johannes>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patch seems to make cpu hotplugging mostly work on my quad
powermac G5. The first part (platforms/powermac/smp.c) actually plugs in
the right functions after which it already works, but the CPUs get
warmer when offline than when online and idle.

The modification in powerpc/kernel/smp.c makes the generic cpu die
routine also do more power saving just like the idle loop. I have no
idea if it is correct.

There do seem to be some bugs with this, once a while I get a soft
lockup detected but I can't figure out why/when it happened. Other than
that, I can online/offline CPUs at will with this patch.

--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/smp.c	2006-06-20 23:23:17.731573780 +0200
+++ linux-2.6-git/arch/powerpc/platforms/powermac/smp.c	2006-06-21 00:20:47.189942635 +0200
@@ -905,8 +905,15 @@ struct smp_ops_t core99_smp_ops = {
 	.setup_cpu	= smp_core99_setup_cpu,
 	.give_timebase	= smp_core99_give_timebase,
 	.take_timebase	= smp_core99_take_timebase,
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
+#if defined(CONFIG_HOTPLUG_CPU)
+# if defined(CONFIG_PPC32)
 	.cpu_disable	= smp_core99_cpu_disable,
 	.cpu_die	= smp_core99_cpu_die,
+# endif
+# if defined(CONFIG_PPC64)
+	.cpu_disable	= generic_cpu_disable,
+	.cpu_die	= generic_cpu_die,
+	.cpu_enable	= generic_cpu_enable,
+# endif
 #endif
 };
--- linux-2.6-git.orig/arch/powerpc/kernel/smp.c	2006-06-21 01:15:42.183256221 +0200
+++ linux-2.6-git/arch/powerpc/kernel/smp.c	2006-06-21 01:15:44.879231957 +0200
@@ -441,8 +441,16 @@ void generic_mach_cpu_die(void)
 	printk(KERN_DEBUG "CPU%d offline\n", cpu);
 	__get_cpu_var(cpu_state) = CPU_DEAD;
 	smp_wmb();
-	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
-		cpu_relax();
+	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE) {
+		if (ppc_md.power_save) {
+			/* need we do more? what about TIF_POLLING_NRFLAG? */
+			ppc_md.power_save();
+		} else {
+			HMT_low();
+			HMT_very_low();
+		}
+		HMT_medium(); /* should be after loop? */
+	}
 
 #ifdef CONFIG_PPC64
 	flush_tlb_pending();
