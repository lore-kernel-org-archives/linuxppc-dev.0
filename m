Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7FACA68639
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 07:32:11 +1000 (EST)
Date: Sat, 22 Oct 2005 23:32:06 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Message-ID: <20051022213206.GB6097@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] pmu_register_sleep_notifier needs ADB_PMU
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


a simple patch for a pegsos user:
https://bugzilla.novell.com/show_bug.cgi?id=119606

arch/ppc/platforms/built-in.o(.init.text+0x10a4): In function `core99_wake_up':
: undefined reference to `pmu_register_sleep_notifier'
make[1]: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/ppc/platforms/pmac_sleep.S |    2 +-
 arch/ppc/platforms/pmac_time.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.14-rc5/arch/ppc/platforms/pmac_sleep.S
===================================================================
--- linux-2.6.14-rc5.orig/arch/ppc/platforms/pmac_sleep.S
+++ linux-2.6.14-rc5/arch/ppc/platforms/pmac_sleep.S
@@ -46,7 +46,7 @@
 	.section .text
 	.align	5
 
-#if defined(CONFIG_PM) || defined(CONFIG_CPU_FREQ_PMAC)
+#if (defined(CONFIG_PM) || defined(CONFIG_CPU_FREQ_PMAC)) && defined(CONFIG_ADB_PMU)
 
 /* This gets called by via-pmu.c late during the sleep process.
  * The PMU was already send the sleep command and will shut us down
Index: linux-2.6.14-rc5/arch/ppc/platforms/pmac_time.c
===================================================================
--- linux-2.6.14-rc5.orig/arch/ppc/platforms/pmac_time.c
+++ linux-2.6.14-rc5/arch/ppc/platforms/pmac_time.c
@@ -206,7 +206,7 @@ via_calibrate_decr(void)
 	return 1;
 }
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && defined(CONFIG_ADB_PMU)
 /*
  * Reset the time after a sleep.
  */
@@ -251,7 +251,7 @@ pmac_calibrate_decr(void)
 	struct device_node *cpu;
 	unsigned int freq, *fp;
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && defined(CONFIG_ADB_PMU)
 	pmu_register_sleep_notifier(&time_sleep_notifier);
 #endif /* CONFIG_PM */
 
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
