Date: Sat, 14 Jun 2003 11:38:01 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] 2.4.21 fixes
Message-ID: <Pine.GSO.4.21.0306141056270.14234-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

Here are some fixes for 2.4.21 (current linuxppc_2_4):

  - arch/ppc/kernel/checks.c: Kill warning about undeclared printf() by
    including <stdio.h> _after_ all other includes (including it first doesn't
    work)

  - arch/ppc/kernel/open_pic.c: Kill warning about unused openpic_reset(). An
    alternative is to add an #ifdef, but since it's never used before its
    definition, just removing the forward declaration looks better to me

  - arch/ppc/kernel/ppc_ksyms.c, arch/ppc/kernel/setup.c: Define and export
    screen_info unconditionally, so vga16fb can be built as a module. An
    alternative is to make the definition dependent on CONFIG_FB_VGA16 ||
    CONFIG_FB_VGA16_MODULE, and the export on CONFIG_FB_VGA16_MODULE, but this
    is ugly.

    Another reason is that screen_info is referenced in
    arch/ppc/platforms/prep_setup.c on the following (complex) condition:

    #if defined(CONFIG_PREP_RESIDUAL) && \
        (defined(CONFIG_FB_VGA16) || defined(CONFIG_FB_VGA_16_MODULE) || \
	         defined(CONFIG_FB_VESA))

    which causes a link failure with the current code, too. The alternative
    #ifdef solution would clutter this even more...

  - include/asm-ppc/posix_types.h: Kill warning about incorrect printf()-style
    format in the ext2 code by making __kernel_ino_t unsigned long, like on
    most other architectures.

--- linuxppc_2_4/arch/ppc/kernel/checks.c.orig	Fri Jun 13 18:06:31 2003
+++ linuxppc_2_4/arch/ppc/kernel/checks.c	Fri Jun 13 21:56:25 2003
@@ -16,6 +16,8 @@
 #include <asm/system.h>
 #include <asm/io.h>

+#include <stdio.h>
+
 /*
  * Do various before compile checks of data structures
  * -- Cort
--- linuxppc_2_4/arch/ppc/kernel/open_pic.c.orig	Fri Jun 13 18:06:57 2003
+++ linuxppc_2_4/arch/ppc/kernel/open_pic.c	Sat Jun 14 10:30:41 2003
@@ -69,7 +69,6 @@
  * These functions are not used but the code is kept here
  * for completeness and future reference.
  */
-static void openpic_reset(void);
 #ifdef notused
 static void openpic_enable_8259_pass_through(void);
 static u_int openpic_get_priority(void);
--- linuxppc_2_4/arch/ppc/kernel/ppc_ksyms.c.orig	Fri Jun 13 18:06:11 2003
+++ linuxppc_2_4/arch/ppc/kernel/ppc_ksyms.c	Sat Jun 14 10:49:01 2003
@@ -292,9 +292,7 @@

 EXPORT_SYMBOL(abs);

-#ifdef CONFIG_VGA_CONSOLE
 EXPORT_SYMBOL(screen_info);
-#endif

 EXPORT_SYMBOL(__delay);
 EXPORT_SYMBOL(__sti);
--- linuxppc_2_4/arch/ppc/kernel/setup.c.orig	Fri Jun 13 18:05:54 2003
+++ linuxppc_2_4/arch/ppc/kernel/setup.c	Sat Jun 14 10:48:46 2003
@@ -89,7 +89,6 @@
 int icache_bsize;
 int ucache_bsize;

-#ifdef CONFIG_VGA_CONSOLE
 struct screen_info screen_info = {
 	0, 25,			/* orig-x, orig-y */
 	0,			/* unused */
@@ -101,7 +100,6 @@
 	1,			/* orig-video-isVGA */
 	16			/* orig-video-points */
 };
-#endif /* CONFIG_VGA_CONSOLE */

 void machine_restart(char *cmd)
 {
--- linuxppc_2_4/include/asm-ppc/posix_types.h.orig	Fri Jun 13 18:05:45 2003
+++ linuxppc_2_4/include/asm-ppc/posix_types.h	Fri Jun 13 21:55:00 2003
@@ -8,7 +8,7 @@
  */

 typedef unsigned int	__kernel_dev_t;
-typedef unsigned int	__kernel_ino_t;
+typedef unsigned long	__kernel_ino_t;
 typedef unsigned int	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
 typedef long		__kernel_off_t;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
