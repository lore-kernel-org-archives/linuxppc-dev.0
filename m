Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7C253DE2F7
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:23:19 +1000 (EST)
Date: Fri, 3 Oct 2008 20:23:17 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: make Freescale QE support a selectable
	Kconfig option
Message-ID: <20081003162317.GA31740@oksana.dev.rtsoft.ru>
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
	<20081003070416.GA460@oksana.dev.rtsoft.ru>
	<E50C84D1-E250-4827-B260-A5005CABE959@kernel.crashing.org>
	<20081003084849.GA18271@oksana.dev.rtsoft.ru>
	<20081003090804.GA29029@oksana.dev.rtsoft.ru>
	<48E63DB6.8030102@freescale.com>
	<20081003160545.GA29927@oksana.dev.rtsoft.ru>
	<48E643A5.9060403@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48E643A5.9060403@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Otherwise user-selectable options appears at the top level.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Fri, Oct 03, 2008 at 11:09:09AM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > Yup. David said that platform GPIO controllers should not go into the
> > drivers/gpio/, their place is in the arch/.
> 
> Then when I do "make menuconfig", why doesn't that option appear under "Platform
> support"?

Because the whole arch/powerpc/sysdev/qe_lib/Kconfig includes into
the top level Kconfig.

> This is what I see now:
> 
> [*] Networking support  --->
>     Device Drivers  --->
>     File systems  --->
> [*] QE GPIO support
>     Library routines  --->
>     Kernel hacking  --->

Damn, this is bad indeed (I don't use the menuconfig, never saw this).

I think arch/powerpc/sysdev/qe_lib/Kconfig inclusion should be fixed.

How about this patch? Or we can move QUICC_ENGINE into the
qe_lib/Kconfig and include it in the platform/Kconfig... either
way would work.

Thanks for noticing.

 arch/powerpc/Kconfig               |    2 --
 arch/powerpc/platforms/Kconfig     |   36 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/Kconfig |   35 -----------------------------------
 3 files changed, 36 insertions(+), 37 deletions(-)
 delete mode 100644 arch/powerpc/sysdev/qe_lib/Kconfig

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 587da5e..dd976b6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -829,8 +829,6 @@ source "fs/Kconfig"
 
 # XXX source "arch/ppc/8260_io/Kconfig"
 
-source "arch/powerpc/sysdev/qe_lib/Kconfig"
-
 source "lib/Kconfig"
 
 source "arch/powerpc/Kconfig.debug"
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 4c900ef..da6da51 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -248,6 +248,42 @@ config QUICC_ENGINE
 	  Selecting this option means that you wish to build a kernel
 	  for a machine with a QE coprocessor.
 
+if QUICC_ENGINE
+
+config UCC_SLOW
+	bool
+	default y if SERIAL_QE
+	help
+	  This option provides qe_lib support to UCC slow
+	  protocols: UART, BISYNC, QMC
+
+config UCC_FAST
+	bool
+	default y if UCC_GETH
+	help
+	  This option provides qe_lib support to UCC fast
+	  protocols: HDLC, Ethernet, ATM, transparent
+
+config UCC
+	bool
+	default y if UCC_FAST || UCC_SLOW
+
+config QE_USB
+	bool
+	help
+	  QE USB Host Controller support
+
+config QE_GPIO
+	bool "QE GPIO support"
+	depends on QUICC_ENGINE
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here if you're going to use hardware that connects to the
+	  QE GPIOs.
+
+endif
+
 config CPM2
 	bool "Enable support for the CPM2 (Communications Processor Module)"
 	depends on MPC85xx || 8260
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
deleted file mode 100644
index 1ce5464..0000000
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ /dev/null
@@ -1,35 +0,0 @@
-#
-# QE Communication options
-#
-
-config UCC_SLOW
-	bool
-	default y if SERIAL_QE
-	help
-	  This option provides qe_lib support to UCC slow
-	  protocols: UART, BISYNC, QMC
-
-config UCC_FAST
-	bool
-	default y if UCC_GETH
-	help
-	  This option provides qe_lib support to UCC fast
-	  protocols: HDLC, Ethernet, ATM, transparent
-
-config UCC
-	bool
-	default y if UCC_FAST || UCC_SLOW
-
-config QE_USB
-	bool
-	help
-	  QE USB Host Controller support
-
-config QE_GPIO
-	bool "QE GPIO support"
-	depends on QUICC_ENGINE
-	select GENERIC_GPIO
-	select ARCH_REQUIRE_GPIOLIB
-	help
-	  Say Y here if you're going to use hardware that connects to the
-	  QE GPIOs.
-- 
1.5.6.3
