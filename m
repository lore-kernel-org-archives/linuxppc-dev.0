From: Allen Curtis <acurtis@onz.com>
Reply-To: acurtis@onz.com
To: dan@embeddededge.com
Subject: 8260/8xx Embedded Boot patch
Date: Tue, 27 Aug 2002 17:06:51 -0700
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_FN1JZ79VGRG1BPEXO97A"
Message-Id: <200208271706.51677.acurtis@onz.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--------------Boundary-00=_FN1JZ79VGRG1BPEXO97A
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Fix/cleanup to embedded boot
--
All things come to those who wait. Some of us just have to wait a little
longer...
--------------Boundary-00=_FN1JZ79VGRG1BPEXO97A
Content-Type: text/x-diff;
  charset="us-ascii";
  name="embedded.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="embedded.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1114.1.1 -> 1.1114.1.2
#	  arch/ppc/config.in	1.150   -> 1.151
#	arch/ppc/boot/simple/head.S	1.3     -> 1.4
#	arch/ppc/boot/simple/embed_config.c	1.13    -> 1.14
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/26	acurtis@ws01.onz.com	1.1114.1.2
# CONFIG_EMBEDDEDBOOT and CONFIG_PPC_ALL cleanup
# --------------------------------------------
#
diff -Nru a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
--- a/arch/ppc/boot/simple/embed_config.c	Tue Aug 27 16:29:02 2002
+++ b/arch/ppc/boot/simple/embed_config.c	Tue Aug 27 16:29:02 2002
@@ -27,7 +27,7 @@

 /* For those boards that don't provide one.
 */
-#if !defined(CONFIG_MBX)
+#ifndef(CONFIG_EMBEDDEDBOOT)
 static	bd_t	bdinfo;
 #endif

@@ -444,6 +444,10 @@
 	bd_t	*bd;

 	bd = *bdp;
+
+#if !defined(CONFIG_EMBEDDEDBOOT)
+	bd = &bdinfo;
+	*bdp = bd;
 #if 0
 	/* This is actually provided by my boot rom.  I have it
 	 * here for those people that may load the kernel with
@@ -469,6 +473,17 @@
 	for (i=0; i<6; i++) {
 		bd->bi_enetaddr[i] = *cp++;
 	}
+#else
+	/* The boot rom passes these to us in MHz.  Linux now expects
+	 * them to be in Hz.
+	 */
+	bd->bi_intfreq *= 1000000;
+	bd->bi_busfreq *= 1000000;
+	bd->bi_cpmfreq *= 1000000;
+	bd->bi_brgfreq *= 1000000;
+
+	clk_8260(bd);
+#endif
 }
 #endif /* EST8260 */

diff -Nru a/arch/ppc/boot/simple/head.S b/arch/ppc/boot/simple/head.S
--- a/arch/ppc/boot/simple/head.S	Tue Aug 27 16:29:02 2002
+++ b/arch/ppc/boot/simple/head.S	Tue Aug 27 16:29:02 2002
@@ -59,7 +59,7 @@
 	isync
 #endif

-#if defined(CONFIG_MBX) || defined(CONFIG_RPX6)
+#ifdef CONFIG_EMBEDDEDBOOT
 	mr	r29,r3	/* On the MBX860, r3 is the board info pointer.
 			 * On the RPXSUPER, r3 points to the
 			 * NVRAM configuration keys.
@@ -103,7 +103,7 @@
 	mr	r3, r29
 #endif

-#if defined(CONFIG_MBX) || defined(CONFIG_RPX6)
+#ifdef CONFIG_EMBEDDEDBOOT
 	mr	r4,r29	/* put the board info pointer where the relocate
 			 * routine will find it
 			 */
diff -Nru a/arch/ppc/config.in b/arch/ppc/config.in
--- a/arch/ppc/config.in	Tue Aug 27 16:29:02 2002
+++ b/arch/ppc/config.in	Tue Aug 27 16:29:02 2002
@@ -62,12 +62,18 @@

 if [ "$CONFIG_8260" = "y" ]; then
   define_bool CONFIG_SERIAL_CONSOLE y
+  define_bool CONFIG_PPC_ALL    n
+
   choice 'Machine Type'	\
 	"EST8260	CONFIG_EST8260	\
 	 SBS8260	CONFIG_SBS8260	\
 	 RPXSUPER	CONFIG_RPX6	\
  	 TQM8260	CONFIG_TQM8260	\
 	 Willow		CONFIG_WILLOW"	Willow
+
+	if [ "$CONFIG_EST8260" = "y" -o "$CONFIG_RPX6" = "y" ]; then
+	  define_bool CONFIG_EMBEDDEDBOOT y
+	fi
 fi

 if [ "$CONFIG_40x" = "y" ]; then
@@ -131,6 +137,17 @@
 	 MBX		CONFIG_MBX		\
 	 WinCept	CONFIG_WINCEPT"		RPX-Lite

+  if [ "$CONFIG_MBX"     = "y" -o \
+       "$CONFIG_RPXLITE" = "y" -o \
+       "$CONFIG_IVMS8"   = "y" -o \
+       "$CONFIG_SM850"   = "y" -o \
+       "$CONFIG_TQM823L" = "y" -o \
+       "$CONFIG_TQM850L" = "y" -o \
+       "$CONFIG_TQM860L" = "y" -o \
+       "$CONFIG_BSEIP"   = "y" ]; then
+    define_bool CONFIG_EMBEDDEDBOOT y
+  fi
+
   if [ "$CONFIG_TQM823L" = "y" -o \
        "$CONFIG_TQM850L" = "y" -o \
        "$CONFIG_FPS850L" = "y" -o \
@@ -343,10 +360,6 @@
     fi
   fi
   dep_bool 'OCP Device proc fs support (experimental)' CONFIG_OCP_PROC $CONFIG_IBM_OCP
-fi
-
-if [ "$CONFIG_8xx" = "y" -o "$CONFIG_8260" = "y" ]; then
-    define_bool CONFIG_EMBEDDEDBOOT y
 fi
 endmenu

diff -Nru a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
--- a/arch/ppc/boot/simple/embed_config.c	Tue Aug 27 16:29:27 2002
+++ b/arch/ppc/boot/simple/embed_config.c	Tue Aug 27 16:29:27 2002
@@ -27,7 +27,7 @@

 /* For those boards that don't provide one.
 */
-#ifndef(CONFIG_EMBEDDEDBOOT)
+#ifndef CONFIG_EMBEDDEDBOOT
 static	bd_t	bdinfo;
 #endif

@@ -402,7 +402,7 @@
 clk_8260(bd_t *bd)
 {
 	uint	scmr, vco_out, clkin;
-	uint	plldf, pllmf, busdf, brgdf, cpmdf;
+	uint	plldf, pllmf, busdf, cpmdf;
 	volatile immap_t	*ip;

 	ip = (immap_t *)IMAP_ADDR;

--------------Boundary-00=_FN1JZ79VGRG1BPEXO97A--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
