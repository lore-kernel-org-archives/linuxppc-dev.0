Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A03BCDE312
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 07:20:36 +1000 (EST)
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] powerpc: enable kexec support on mpc8544ds
Date: Wed,  1 Oct 2008 23:20:23 +0200
Message-Id: <1222896024-22172-3-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/Kconfig                     |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 587da5e..c2c6a20 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -304,7 +304,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on (PPC_PRPMC2800 || PPC_MULTIPLATFORM) && EXPERIMENTAL
+	depends on (PPC_PRPMC2800 || PPC_MULTIPLATFORM || MPC85xx_DS) && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 3d5f21b..d50d383 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -30,6 +30,7 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/i8259.h>
+#include <linux/kexec.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -227,6 +228,11 @@ define_machine(mpc8544_ds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+#ifdef CONFIG_KEXEC
+	.machine_kexec          = default_machine_kexec,
+	.machine_kexec_prepare  = booke_machine_kexec_prepare,
+	.machine_crash_shutdown = default_machine_crash_shutdown,
+#endif
 };
 
 define_machine(mpc8572_ds) {
-- 
1.5.6.5
