Message-Id: <200004062057.WAA00323@piglet.grunz.lu>
Date: Thu, 6 Apr 2000 22:57:41 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: up-to-date patch for PMac nvram in 2.3.99
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-955054661=:322"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-955054661=:322
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi list,

Following the nvram discussion a month ago, here is an updated working
patch to re-enable nvram functionality in Paul's rsync 2.3.99 tree.

IMHO I think nvram is an important functionality, and I think this
patch or something to the same effect needs to go into 2.4.0.

So, can all of you check this patch, try it out, and report any trouble
or objections?

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-955054661=:322
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: nvram.diff

--- linux-2.3.paul/Makefile	Sat Mar 25 06:50:03 2000
+++ linux/Makefile	Thu Apr  6 22:14:13 2000
@@ -164,8 +164,8 @@
 DRIVERS-$(CONFIG_SBUS) += drivers/sbus/sbus.a
 DRIVERS-$(CONFIG_ZORRO) += drivers/zorro/zorro.a
 DRIVERS-$(CONFIG_FC4) += drivers/fc4/fc4.a
-DRIVERS-$(CONFIG_PPC) += drivers/macintosh/macintosh.a
-DRIVERS-$(CONFIG_MAC) += drivers/macintosh/macintosh.a
+DRIVERS-$(CONFIG_PPC) += drivers/macintosh/macintosh.o
+DRIVERS-$(CONFIG_MAC) += drivers/macintosh/macintosh.o
 DRIVERS-$(CONFIG_ISAPNP) += drivers/pnp/pnp.o
 DRIVERS-$(CONFIG_SGI_IP22) += drivers/sgi/sgi.a
 DRIVERS-$(CONFIG_VT) += drivers/video/video.o
--- linux-2.3.paul/drivers/macintosh/Makefile	Mon Feb 14 09:19:29 2000
+++ linux/drivers/macintosh/Makefile	Thu Apr  6 22:18:43 2000
@@ -12,20 +12,20 @@
 SUB_DIRS     :=
 MOD_SUB_DIRS := $(SUB_DIRS)

-L_TARGET := macintosh.a
-L_OBJS   :=
+O_TARGET := macintosh.o
+O_OBJS   :=
 M_OBJS   :=

 ifeq ($(CONFIG_PMAC_PBOOK),y)
-  L_OBJS += mediabay.o
+  O_OBJS += mediabay.o
 else
   ifeq ($(CONFIG_MAC_FLOPPY),y)
-    L_OBJS += mediabay.o
+    O_OBJS += mediabay.o
   endif
 endif

 ifeq ($(CONFIG_MAC_SERIAL),y)
-  L_OBJS += macserial.o
+  O_OBJS += macserial.o
 else
   ifeq ($(CONFIG_MAC_SERIAL),m)
     M_OBJS += macserial.o
@@ -33,7 +33,7 @@
 endif

 ifeq ($(CONFIG_NVRAM),y)
-  L_OBJS += nvram.o
+  O_OBJS += nvram.o
 else
   ifeq ($(CONFIG_NVRAM),m)
     M_OBJS += nvram.o
@@ -41,39 +41,39 @@
 endif

 ifdef CONFIG_ADB
-  LX_OBJS  := adb.o
+  OX_OBJS  := adb.o
 endif

 ifdef CONFIG_ADB_KEYBOARD
-  L_OBJS += mac_keyb.o
+  O_OBJS += mac_keyb.o
 endif

 ifdef CONFIG_ADB_MACII
-  L_OBJS += via-macii.o
+  O_OBJS += via-macii.o
 endif

 ifdef CONFIG_ADB_MACIISI
-  L_OBJS += via-maciisi.o
+  O_OBJS += via-maciisi.o
 endif

 ifdef CONFIG_ADB_CUDA
-  L_OBJS += via-cuda.o
+  O_OBJS += via-cuda.o
 endif

 ifdef CONFIG_ADB_IOP
-  L_OBJS += adb-iop.o
+  O_OBJS += adb-iop.o
 endif

 ifdef CONFIG_ADB_PMU
-  L_OBJS += via-pmu.o
+  O_OBJS += via-pmu.o
 endif

 ifdef CONFIG_ADB_PMU68K
-  L_OBJS += via-pmu68k.o
+  O_OBJS += via-pmu68k.o
 endif

 ifdef CONFIG_ADB_MACIO
-  L_OBJS += macio-adb.o
+  O_OBJS += macio-adb.o
 endif

 include $(TOPDIR)/Rules.make
--- linux-2.3.paul/drivers/macintosh/nvram.c	Fri Feb 11 00:19:57 2000
+++ linux/drivers/macintosh/nvram.c	Thu Apr  6 22:20:40 2000
@@ -96,14 +96,17 @@
 	&nvram_fops
 };

-int nvram_init(void)
+int __init nvram_init(void)
 {
 	printk(KERN_INFO "Macintosh non-volatile memory driver v%s\n",
 		NVRAM_VERSION);
 	misc_register(&nvram_dev);
 	return 0;
 }
-#ifdef MODULE
+
+#ifndef MODULE
+__initcall(nvram_init);
+#else
 int init_module (void)
 {
         return( nvram_init() );

--134392852-1804289383-955054661=:322--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
