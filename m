Message-Id: <200002052004.PAA03426@fermi.cmf.nrl.navy.mil>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: anyone build 2.3.42 for ppc?
In-reply-to: Your message of "Sat, 05 Feb 2000 13:23:59 EST."
             <389C6ABF.1138CC1B@mandrakesoft.com>
Date: Sat, 05 Feb 2000 15:04:03 -0500
From: Chas Williams <chas@cmf.nrl.navy.mil>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <389C6ABF.1138CC1B@mandrakesoft.com>,Jeff Garzik writes:
>Ah!  The solution:  follow the example in other makefiles, and create
>'macintosh.o' not 'macintosh.a'.  That is the only problem...

ok then, the patch that 'correctly' adds nvram support back into 2.3.42
would look more like:

--- Makefile.000	Sat Feb  5 14:28:42 2000
+++ Makefile	Sat Feb  5 14:28:53 2000
@@ -203,7 +203,7 @@
 endif

 ifdef CONFIG_PPC
-DRIVERS := $(DRIVERS) drivers/macintosh/macintosh.a
+DRIVERS := $(DRIVERS) drivers/macintosh/macintosh.o
 endif

 ifeq ($(CONFIG_ISAPNP),y)
--- drivers/macintosh/Makefile.000	Sat Feb  5 14:25:10 2000
+++ drivers/macintosh/Makefile	Sat Feb  5 14:44:01 2000
@@ -12,16 +12,16 @@
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
 endif

 ifeq ($(CONFIG_MAC_SERIAL),y)
-  L_OBJS += macserial.o
+  O_OBJS += macserial.o
 else
   ifeq ($(CONFIG_MAC_SERIAL),m)
     M_OBJS += macserial.o
@@ -29,7 +29,7 @@
 endif

 ifeq ($(CONFIG_NVRAM),y)
-  L_OBJS += nvram.o
+  O_OBJS += nvram.o
 else
   ifeq ($(CONFIG_NVRAM),m)
     M_OBJS += nvram.o
@@ -37,35 +37,35 @@
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

 ifdef CONFIG_ADB_MACIO
-  L_OBJS += macio-adb.o
+  O_OBJS += macio-adb.o
 endif

 include $(TOPDIR)/Rules.make
--- drivers/macintosh/nvram.c.000	Sat Feb  5 08:43:10 2000
+++ drivers/macintosh/nvram.c	Sat Feb  5 09:12:39 2000
@@ -102,14 +102,17 @@
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

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
