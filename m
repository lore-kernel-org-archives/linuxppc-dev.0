Return-Path: <galak@gate.crashing.org>
Date: Tue, 20 Dec 2005 16:37:07 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0512201636350.26351-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] powerpc: added a udbg_progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added a common udbg_progress for use by ppc_md.progress()

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 7b69a37a4e811e72e82896ab38e6ae04542455f5
tree 923809875e727ab5d0dd0579e45da9201dd86653
parent adb69b3e888de037f4e58cc505443e624d498596
author Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 16:40:09 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 16:40:09 -0600

 arch/powerpc/kernel/udbg.c              |    6 ++++++
 arch/powerpc/platforms/powermac/setup.c |    8 +-------
 include/asm-powerpc/udbg.h              |    1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 9567d94..558c1ce 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -90,6 +90,12 @@ void udbg_printf(const char *fmt, ...)
 	va_end(args);
 }
 
+void __init udbg_progress(char *s, unsigned short hex)
+{
+	udbg_puts(s);
+	udbg_puts("\n");
+}
+
 /*
  * Early boot console based on udbg
  */
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 1daa5a0..e5a5bdb 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -639,12 +639,6 @@ static void __init pmac_init_early(void)
 #endif
 }
 
-static void __init pmac_progress(char *s, unsigned short hex)
-{
-	udbg_puts(s);
-	udbg_puts("\n");
-}
-
 /*
  * pmac has no legacy IO, anything calling this function has to
  * fail or bad things will happen
@@ -763,7 +757,7 @@ struct machdep_calls __initdata pmac_md 
 	.calibrate_decr		= pmac_calibrate_decr,
 	.feature_call		= pmac_do_feature_call,
 	.check_legacy_ioport	= pmac_check_legacy_ioport,
-	.progress		= pmac_progress,
+	.progress		= udbg_progress,
 #ifdef CONFIG_PPC64
 	.pci_probe_mode		= pmac_pci_probe_mode,
 	.idle_loop		= native_idle,
diff --git a/include/asm-powerpc/udbg.h b/include/asm-powerpc/udbg.h
index 58cdc88..a3390b0 100644
--- a/include/asm-powerpc/udbg.h
+++ b/include/asm-powerpc/udbg.h
@@ -23,6 +23,7 @@ extern int udbg_read(char *buf, int bufl
 
 extern void register_early_udbg_console(void);
 extern void udbg_printf(const char *fmt, ...);
+extern void udbg_progress(char *s, unsigned short hex);
 
 extern void udbg_init_uart(void __iomem *comport, unsigned int speed,
 			   unsigned int clock);
