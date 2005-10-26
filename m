Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 3D378685C0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Oct 2005 15:27:32 +1000 (EST)
Date: Wed, 26 Oct 2005 00:27:28 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510260025590.22489@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix warnings due to use of seq_file
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Having a prototype that uses seq_file without always including
seq_file.h generates a lot of warnings.  This happened when asm/irq.h
was merged.

Moving the prototypes into the file the actualy needs it resolves
the warnings.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit 42f89bb5e263cd295937b2af57a8e6338560e73f
tree 89c699d57f424973e8b10d85056d9526902bc2c5
parent c77ae9103af0c3f77a298a7edd626da0675eddc5
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 26 Oct 2005 00:25:31 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 26 Oct 2005 00:25:31 -0500

 arch/ppc/platforms/85xx/mpc8540_ads.c        |    2 ++
 arch/ppc/platforms/85xx/mpc8560_ads.c        |    1 +
 arch/ppc/platforms/85xx/mpc85xx_ads_common.h |    1 -
 arch/ppc/platforms/85xx/stx_gp3.c            |    1 +
 arch/ppc/platforms/85xx/stx_gp3.h            |    1 -
 5 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
@@ -52,6 +52,8 @@
 
 #include <syslib/ppc85xx_setup.h>
 
+extern int mpc85xx_ads_show_cpuinfo(struct seq_file *m);
+
 /* ************************************************************************
  *
  * Setup the architecture
diff --git a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -55,6 +55,7 @@
 #include <syslib/ppc85xx_common.h>
 #include <syslib/ppc85xx_setup.h>
 
+extern int mpc85xx_ads_show_cpuinfo(struct seq_file *m);
 
 /* ************************************************************************
  *
diff --git a/arch/ppc/platforms/85xx/mpc85xx_ads_common.h b/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
--- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
+++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.h
@@ -25,7 +25,6 @@
 #define BCSR_ADDR		((uint)0xf8000000)
 #define BCSR_SIZE		((uint)(32 * 1024))
 
-extern int mpc85xx_ads_show_cpuinfo(struct seq_file *m);
 extern void mpc85xx_ads_init_IRQ(void) __init;
 extern void mpc85xx_ads_map_io(void) __init;
 
diff --git a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
--- a/arch/ppc/platforms/85xx/stx_gp3.c
+++ b/arch/ppc/platforms/85xx/stx_gp3.c
@@ -58,6 +58,7 @@
 #include <syslib/cpm2_pic.h>
 #include <syslib/ppc85xx_common.h>
 
+extern int mpc85xx_show_cpuinfo(struct seq_file *m);
 
 unsigned char __res[sizeof(bd_t)];
 
diff --git a/arch/ppc/platforms/85xx/stx_gp3.h b/arch/ppc/platforms/85xx/stx_gp3.h
--- a/arch/ppc/platforms/85xx/stx_gp3.h
+++ b/arch/ppc/platforms/85xx/stx_gp3.h
@@ -42,7 +42,6 @@ extern void mpc85xx_setup_hose(void) __i
 extern void mpc85xx_restart(char *cmd);
 extern void mpc85xx_power_off(void);
 extern void mpc85xx_halt(void);
-extern int mpc85xx_show_cpuinfo(struct seq_file *m);
 extern void mpc85xx_init_IRQ(void) __init;
 extern unsigned long mpc85xx_find_end_of_memory(void) __init;
 extern void mpc85xx_calibrate_decr(void) __init;
