Message-ID: <391F3FDA.6723D3F9@mindless.com>
Date: Mon, 15 May 2000 02:08:02 +0200
From: Bernd Kischnick <kisch@mindless.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@linuxcare.com>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "linux-kernel@vger.rutgers.edu" <linux-kernel@vger.rutgers.edu>
Subject: PATCH: PowerMac specific
Content-Type: multipart/mixed;
 boundary="------------5AB4BE8A6D637244D4DFB137"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------5AB4BE8A6D637244D4DFB137
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all,

the attached patches are necessary to get the kernel 2.3.99-pre8
compiled for PowerMacs, when some configuration options are different
than others seem to have them (CONFIG_ADBMOUSE, CONFIG_ADB_PMU, CONFIG_KGDB).

Also we've got some renamed defines in ide-pmac.c (Mediabay-specific).

And some undeclared symbols in include/asm-ppc/string.h.

Regards,
- Bernd
--------------5AB4BE8A6D637244D4DFB137
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="522A6368";
 name="pmac.patch"
Content-Description: Unknown Document
Content-Disposition: inline;
 filename="pmac.patch"
Content-Transfer-Encoding: 7bit

diff -ru linux/drivers/macintosh/mac_keyb.c my/linux/drivers/macintosh/mac_keyb.c
--- linux/drivers/macintosh/mac_keyb.c	Sun Feb 13 19:47:01 2000
+++ my/linux/drivers/macintosh/mac_keyb.c	Sun May 14 00:39:59 2000
@@ -585,8 +585,10 @@
 }
 #endif /* CONFIG_ADBMOUSE */

+#ifdef CONFIG_ADB_PMU
 /* XXX Needs to get rid of this, see comments in pmu.c */
 extern int backlight_level;
+#endif

 static void
 buttons_input(unsigned char *data, int nb, struct pt_regs *regs, int autopoll)
@@ -627,7 +629,7 @@
 		/* brightness decrease */
 		case 0xa:
 			/* down event */
-#ifdef CONFIG_PPC
+#if defined(CONFIG_PPC) && defined (CONFIG_ADB_PMU)
 			if ( data[1] == (data[1]&0xf) ) {
 				if (backlight_level > 2)
 					pmu_set_brightness(backlight_level-2);
@@ -639,7 +641,7 @@
 		/* brightness increase */
 		case 0x9:
 			/* down event */
-#ifdef CONFIG_PPC
+#if defined(CONFIG_PPC) && defined(CONFIG_ADB_PMU)
 			if ( data[1] == (data[1]&0xf) ) {
 				if (backlight_level < 0x1e)
 					pmu_set_brightness(backlight_level+2);
@@ -1053,5 +1055,5 @@
 	    0x07);

  	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
- }
+}
diff -ru linux/arch/ppc/kernel/ppc_ksyms.c my/linux/arch/ppc/kernel/ppc_ksyms.c
--- linux/arch/ppc/kernel/ppc_ksyms.c	Sun May 14 12:06:52 2000
+++ my/linux/arch/ppc/kernel/ppc_ksyms.c	Sun May 14 12:13:00 2000
@@ -271,6 +271,7 @@
 #endif
 EXPORT_SYMBOL(down_read_failed);

+#ifdef CONFIG_KGDB
 extern void (*debugger)(struct pt_regs *regs);
 extern int (*debugger_bpt)(struct pt_regs *regs);
 extern int (*debugger_sstep)(struct pt_regs *regs);
@@ -284,3 +285,4 @@
 EXPORT_SYMBOL(debugger_iabr_match);
 EXPORT_SYMBOL(debugger_dabr_match);
 EXPORT_SYMBOL(debugger_fault_handler);
+#endif
diff -ru linux/drivers/ide/ide-pmac.c my/linux/drivers/ide/ide-pmac.c
--- linux/drivers/ide/ide-pmac.c	Thu Mar 23 02:18:44 2000
+++ my/linux/drivers/ide/ide-pmac.c	Sun May 14 00:06:27 2000
@@ -402,11 +402,11 @@
 				feature_clear(np, FEATURE_IDE0_reset);
 				break;
 			    case 1:
-				feature_set(np, FEATURE_Mediabay_IDE_reset);
+				feature_set(np, FEATURE_IDE1_reset);
 				mdelay(10);
- 				feature_set(np, FEATURE_Mediabay_IDE_enable);
+ 				feature_set(np, FEATURE_IDE1_enable);
 				mdelay(10);
-				feature_clear(np, FEATURE_Mediabay_IDE_reset);
+				feature_clear(np, FEATURE_IDE1_reset);
 				break;
 			    case 2:
 			    	/* This one exists only for KL, I don't know about any
diff -ru linux/include/asm-ppc/string.h my/linux/include/asm-ppc/string.h
--- linux/include/asm-ppc/string.h	Sun Nov 28 00:42:33 1999
+++ my/linux/include/asm-ppc/string.h	Sat May 13 22:17:01 2000
@@ -1,17 +1,29 @@
 #ifndef _PPC_STRING_H_
 #define _PPC_STRING_H_

+#define __HAVE_ARCH_BCOPY
+
 #define __HAVE_ARCH_STRCPY
+extern char * strcpy(char *,const char *);
 #define __HAVE_ARCH_STRNCPY
-#define __HAVE_ARCH_STRLEN
-#define __HAVE_ARCH_STRCMP
+extern char * strncpy(char *,const char *, __kernel_size_t);
 #define __HAVE_ARCH_STRCAT
+extern char * strcat(char *, const char *);
+#define __HAVE_ARCH_STRCMP
+extern int strcmp(const char *,const char *);
+#define __HAVE_ARCH_STRLEN
+extern __kernel_size_t strlen(const char *);
+
 #define __HAVE_ARCH_MEMSET
-#define __HAVE_ARCH_BCOPY
+extern void * memset(void *,int,__kernel_size_t);
 #define __HAVE_ARCH_MEMCPY
+extern void * memcpy(void *,const void *,__kernel_size_t);
 #define __HAVE_ARCH_MEMMOVE
+extern void * memmove(void *,const void *,__kernel_size_t);
 #define __HAVE_ARCH_MEMCMP
+extern int memcmp(const void *,const void *,__kernel_size_t);
 #define __HAVE_ARCH_MEMCHR
+extern void * memchr(const void *,int,__kernel_size_t);

 extern int strcasecmp(const char *, const char *);
 extern int strncasecmp(const char *, const char *, int);

--------------5AB4BE8A6D637244D4DFB137--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
