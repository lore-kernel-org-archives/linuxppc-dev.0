Return-Path: <danielwa@cisco.com>
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 300501A0036
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 02:59:27 +1100 (AEDT)
From: Daniel Walker <danielwa@cisco.com>
To: xe-kernel@external.cisco.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Walker <dwalker@fifo99.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH-RFC 3/7] powerpc: convert to generic builtin command line
Date: Tue,  6 Oct 2015 08:47:10 -0700
Message-Id: <1444146434-12776-3-git-send-email-danielwa@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This updates the powerpc code to use the CONFIG_GENERIC_CMDLINE
option.

Cc: xe-kernel@external.cisco.com
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/powerpc/Kconfig            | 23 +----------------------
 arch/powerpc/kernel/prom.c      |  4 ++++
 arch/powerpc/kernel/prom_init.c |  8 ++++----
 3 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9a7057e..26252dc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -160,6 +160,7 @@ config PPC
 	select EDAC_ATOMIC_SCRUB
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select HAVE_ARCH_SECCOMP_FILTER
+	select GENERIC_CMDLINE
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
@@ -640,28 +641,6 @@ config PPC_DENORMALISATION
 	  Add support for handling denormalisation of single precision
 	  values.  Useful for bare metal only.  If unsure say Y here.
 
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-
-config CMDLINE
-	string "Initial kernel command string"
-	depends on CMDLINE_BOOL
-	default "console=ttyS0,9600 console=tty0 root=/dev/sda2"
-	help
-	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel. For these platforms, you can supply
-	  some command-line options at build time by entering them here.  In
-	  most cases you will need to specify the root device here.
-
-config CMDLINE_FORCE
-	bool "Always use the default kernel command string"
-	depends on CMDLINE_BOOL
-	help
-	  Always use the default kernel command string, even if the boot
-	  loader passes other arguments to the kernel.
-	  This is useful if you cannot or don't want to change the
-	  command-line options your boot loader passes to the kernel.
-
 config EXTRA_TARGETS
 	string "Additional default image types"
 	help
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index bef76c5..3281d5a 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -34,6 +34,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/cmdline.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -670,6 +671,9 @@ void __init early_init_devtree(void *params)
 	 */
 	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
 
+	/* append and prepend any arguments built into the kernel. */
+	cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
+
 	/* Scan memory nodes and rebuild MEMBLOCKs */
 	of_scan_flat_dt(early_init_dt_scan_root, NULL);
 	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 15099c4..2dd2608 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/bitops.h>
+#include <linux/cmdline.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/page.h>
@@ -595,11 +596,10 @@ static void __init early_cmdline_parse(void)
 	p = prom_cmd_line;
 	if ((long)prom.chosen > 0)
 		l = prom_getprop(prom.chosen, "bootargs", p, COMMAND_LINE_SIZE-1);
-#ifdef CONFIG_CMDLINE
+
 	if (l <= 0 || p[0] == '\0') /* dbl check */
-		strlcpy(prom_cmd_line,
-			CONFIG_CMDLINE, sizeof(prom_cmd_line));
-#endif /* CONFIG_CMDLINE */
+		cmdline_add_builtin(prom_cmd_line, NULL, sizeof(prom_cmd_line));
+
 	prom_printf("command line: %s\n", prom_cmd_line);
 
 #ifdef CONFIG_PPC64
-- 
2.1.4
