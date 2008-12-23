Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id DEA93DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 00:11:47 +1100 (EST)
Received: by ewy13 with SMTP id 13so3220531ewy.9
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 05:11:45 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: paulus@samba.org,
	benh@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH RESEND] powerpc: make udbg 16550 boot console configurable for
	EMBEDDED
Date: Tue, 23 Dec 2008 14:11:34 +0100
Message-Id: <1230037894-26837-1-git-send-email-jacmet@sunsite.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The udbg console is currently always enabled for platforms selecting
the PPC_UDBG_16550 symbol (needed to create platform devices for
8250 SoC UARTs from DT).

Now, the udbg console is nice for debugging as it works so early, but
it also has a number of disadvantages:

- It doesn't respect console= and still outputs console messages even
  if console isn't ttySx (E.G. if CONFIG_SILENT_CONSOLE is enabled in
  U-Boot which sets 'console='
- It's slow (boot is ~0.3s slower on my mpc8347 platform compared to
  using the 8250 driver right away)
- It slightly bloats the kernel (pretty insignificant, around 1K)

As that isn't always desirable, add a PPC_UDBG_16550_CONSOLE kconfig
symbol to let the user disable it (only visible if CONFIG_EMBEDDED).

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/kernel/Makefile        |    3 ++-
 arch/powerpc/kernel/legacy_serial.c |    4 ++++
 arch/powerpc/platforms/Kconfig      |    7 +++++++
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 92673b4..4651c0b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -80,7 +80,8 @@ obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
-obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
+obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o
+obj-$(CONFIG_PPC_UDBG_16550_CONSOLE)	+= udbg_16550.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
 pci64-$(CONFIG_PPC64)		+= pci_dn.o isa-bridge.o
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 9ddfaef..c0e9866 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -279,6 +279,7 @@ static int __init add_legacy_pci_port(struct device_node *np,
 }
 #endif
 
+#ifdef CONFIG_PPC_UDBG_16550_CONSOLE
 static void __init setup_legacy_serial_console(int console)
 {
 	struct legacy_serial_info *info =
@@ -295,6 +296,9 @@ static void __init setup_legacy_serial_console(int console)
 	DBG("default console speed = %d\n", info->speed);
 	udbg_init_uart(addr, info->speed, info->clock);
 }
+#else
+#define setup_legacy_serial_console(console)	do { } while (0)
+#endif
 
 /*
  * This is called very early, as part of setup_system() or eventually
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 47e956c..bc3ce47 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -312,4 +312,11 @@ config MPC8xxx_GPIO
 	  Say Y here if you're going to use hardware that connects to the
 	  MPC831x/834x/837x/8572/8610 GPIOs.
 
+config PPC_UDBG_16550_CONSOLE
+	bool "Boot console on 16550 UDBG" if EMBEDDED
+	depends on PPC_UDBG_16550
+	default y
+	help
+	  Say Y here to use the UDBG infrastructure for early boot messages.
+
 endmenu
-- 
1.5.6.5
