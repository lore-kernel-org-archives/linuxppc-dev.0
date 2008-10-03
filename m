Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 84C87DDF6D
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 05:40:38 +1000 (EST)
Date: Fri, 3 Oct 2008 23:40:36 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/QE: move QE_GPIO Kconfig symbol into the
	platforms/Kconfig
Message-ID: <20081003194036.GA9323@oksana.dev.rtsoft.ru>
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
	<20081003070416.GA460@oksana.dev.rtsoft.ru>
	<E50C84D1-E250-4827-B260-A5005CABE959@kernel.crashing.org>
	<20081003084849.GA18271@oksana.dev.rtsoft.ru>
	<20081003090804.GA29029@oksana.dev.rtsoft.ru>
	<48E63DB6.8030102@freescale.com>
	<20081003160545.GA29927@oksana.dev.rtsoft.ru>
	<48E643A5.9060403@freescale.com>
	<20081003162317.GA31740@oksana.dev.rtsoft.ru>
	<B88B23CE-9EBD-4C4B-9978-0E9C3C3AB738@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <B88B23CE-9EBD-4C4B-9978-0E9C3C3AB738@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Specifying user-selectable option in the qe_lib/Kconfig was a bad idea
because the qe_lib/Kconfig is included into the top level Kconfig, and
thus the QE_GPIO option appears at the top level menu.

This patch effectively moves the QE_GPIO option under the platform menu
instead.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Fri, Oct 03, 2008 at 12:48:31PM -0500, Kumar Gala wrote:
[...]
> I want to leave the "hidden" options in qe_lib/Kconfig.. just move the  
> user selectable one (QE_GPIO) in to platforms/Kconfig

Here it is.

 arch/powerpc/platforms/Kconfig     |    9 +++++++++
 arch/powerpc/sysdev/qe_lib/Kconfig |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 8871185..71845d7 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -249,6 +249,15 @@ config QUICC_ENGINE
 	  Selecting this option means that you wish to build a kernel
 	  for a machine with a QE coprocessor.
 
+config QE_GPIO
+	bool "QE GPIO support"
+	depends on QUICC_ENGINE
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here if you're going to use hardware that connects to the
+	  QE GPIOs.
+
 config CPM2
 	bool "Enable support for the CPM2 (Communications Processor Module)"
 	depends on MPC85xx || 8260
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index 1ce5464..76ffbc4 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -24,12 +24,3 @@ config QE_USB
 	bool
 	help
 	  QE USB Host Controller support
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
