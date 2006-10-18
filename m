Return-Path: <ben.collins@ubuntu.com>
Received: from swissweb.swissdisk.com (www.swissdisk.com [216.66.254.197])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B012B67B61
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 03:50:25 +1000 (EST)
Received: from [72.169.114.90] (helo=critter.internal)
	by swissweb.swissdisk.com with esmtp (Exim 4.50) id 1GaDfP-0000Tu-HY
	for linuxppc-dev@ozlabs.org; Wed, 18 Oct 2006 08:49:18 -0700
Received: from collinsap1.internal.net ([192.168.1.1]
	helo=mail.phunnypharm.org) by critter.internal with smtp (Exim 4.62)
	(envelope-from <ben.collins@ubuntu.com>) id 1GaEt8-0003NU-DR
	for linuxppc-dev@ozlabs.org; Wed, 18 Oct 2006 13:07:31 -0400
Subject: [PATCHES] Ubuntu trivial powerpc patches
From: Ben Collins <ben.collins@ubuntu.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 18 Oct 2006 13:07:30 -0400
Message-Id: <1161191250.5663.14.camel@gullible>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a couple of small patches I've got in the Ubuntu kernel tree for
powerpc. They can be synced from:

git.kernel.org:/pub/scm/linux/kernel/git/bcollins/ubuntu-2.6#ubuntu-powerpc

The patch for prom init printf's disabling is just to make the boot a
little cleaner.

Ben Collins:
      [powerpc] Allow disabling of prom init messages.
      [powerpc] Make pSeries_init_panel message configurable.

 arch/powerpc/Kconfig                   |    5 +++++
 arch/powerpc/Kconfig.debug             |    9 +++++++++
 arch/powerpc/kernel/prom_init.c        |    5 ++++-
 arch/powerpc/platforms/pseries/setup.c |    2 +-
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8b69104..58b9ed9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -371,6 +371,11 @@ config PPC_PSERIES
 	select PPC_UDBG_16550
 	default y
 
+config PPC_PSERIES_PANEL_MSG
+	depends on PPC_PSERIES
+	string "Message for pSeries progress panel"
+	default "Linux ppc64"
+
 config PPC_ISERIES
 	bool "IBM Legacy iSeries"
 	depends on PPC_MULTIPLATFORM && PPC64
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 5ad149b..0f7a26c 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -121,6 +121,15 @@ config BOOTX_TEXT
 	  Say Y here to see progress messages from the boot firmware in text
 	  mode. Requires either BootX or Open Firmware.
 
+config EARLY_PROM_PRINT
+	bool "Support early messages from the kernel via the prom console"
+	depends PPC_OF
+	default y
+	help
+	  Say Y here to see early messages from the kernel through the
+	  prom console. These are usually only related to the prom init
+	  and detection code.
+
 config SERIAL_TEXT_DEBUG
 	bool "Support for early boot texts over serial port"
 	depends on 4xx || LOPEC || MV64X60 || PPLUS || PRPMC800 || \
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index b917616..e95cd81 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -297,7 +297,7 @@ static void __init prom_print(const char
 	}
 }
 
-
+#ifdef CONFIG_EARLY_PROM_PRINT
 static void __init prom_print_hex(unsigned long val)
 {
 	int i, nibbles = sizeof(val)*2;
@@ -356,6 +356,9 @@ #endif
 		}
 	}
 }
+#else
+#define prom_printf(fmt, ...)	do {} while(0)
+#endif
 
 
 static unsigned int __init prom_claim(unsigned long virt, unsigned long size,
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 89a8119..c9fc362 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -340,7 +340,7 @@ static void __init pSeries_setup_arch(vo
 static int __init pSeries_init_panel(void)
 {
 	/* Manually leave the kernel version on the panel. */
-	ppc_md.progress("Linux ppc64\n", 0);
+	ppc_md.progress(CONFIG_PPC_PSERIES_PANEL_MSG "\n", 0);
 	ppc_md.progress(init_utsname()->version, 0);
 
 	return 0;
