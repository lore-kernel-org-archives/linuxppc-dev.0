Date: Mon, 29 Dec 2003 23:37:34 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@lists/linuxppc.org
Cc: oprofile-list@lists.sourceforge.net
Subject: ppc32 timer tick oprofile support
Message-ID: <20031229123734.GB6587@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I was chasing an issue with xine on my tibook and missed not having
oprofile support. So here it is.

Anton

===== arch/ppc/Kconfig 1.57 vs edited =====
--- 1.57/arch/ppc/Kconfig	Fri Nov 14 18:50:56 2003
+++ edited/arch/ppc/Kconfig	Mon Dec 29 22:11:51 2003
@@ -1296,6 +1296,7 @@

 source "lib/Kconfig"

+source "arch/ppc/oprofile/Kconfig"

 menu "Kernel hacking"

===== arch/ppc/Makefile 1.74 vs edited =====
--- 1.74/arch/ppc/Makefile	Tue Oct 14 17:27:58 2003
+++ edited/arch/ppc/Makefile	Mon Dec 29 21:12:40 2003
@@ -44,6 +44,7 @@
 drivers-$(CONFIG_4xx)		+= arch/ppc/4xx_io/
 drivers-$(CONFIG_8260)		+= arch/ppc/8260_io/
 drivers-$(CONFIG_OCP)		+= arch/ppc/ocp/
+drivers-$(CONFIG_OPROFILE)	+= arch/ppc/oprofile/

 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm

===== arch/ppc/kernel/time.c 1.36 vs edited =====
--- 1.36/arch/ppc/kernel/time.c	Thu Dec 18 16:05:14 2003
+++ edited/arch/ppc/kernel/time.c	Mon Dec 29 21:18:54 2003
@@ -56,6 +56,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/time.h>
 #include <linux/init.h>
+#include <linux/profile.h>

 #include <asm/segment.h>
 #include <asm/io.h>
@@ -107,17 +108,23 @@
 	return delta;
 }

-extern unsigned long prof_cpu_mask;
-extern unsigned int * prof_buffer;
-extern unsigned long prof_len;
-extern unsigned long prof_shift;
 extern char _stext;

-static inline void ppc_do_profile (unsigned long nip)
+static inline void ppc_do_profile(struct pt_regs *regs)
 {
+	unsigned long nip;
+	extern unsigned long prof_cpu_mask;
+
+	profile_hook(regs);
+
+	if (user_mode(regs))
+		return;
+
 	if (!prof_buffer)
 		return;

+	nip = instruction_pointer(regs);
+
 	/*
 	 * Only measure the CPUs specified by /proc/irq/prof_cpu_mask.
 	 * (default is all CPUs.)
@@ -163,8 +170,7 @@

 	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
 		jiffy_stamp += tb_ticks_per_jiffy;
-		if (!user_mode(regs))
-			ppc_do_profile(instruction_pointer(regs));
+		ppc_do_profile(regs);
 	  	if (smp_processor_id())
 			continue;

--- /dev/null	2003-12-14 13:20:18.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/oprofile/Kconfig	2003-12-29 21:12:10.000000000 +1100
@@ -0,0 +1,23 @@
+
+menu "Profiling support"
+	depends on EXPERIMENTAL
+
+config PROFILING
+	bool "Profiling support (EXPERIMENTAL)"
+	help
+	  Say Y here to enable the extended profiling support mechanisms used
+	  by profilers such as OProfile.
+
+
+config OPROFILE
+	tristate "OProfile system profiling (EXPERIMENTAL)"
+	depends on PROFILING
+	help
+	  OProfile is a profiling system capable of profiling the
+	  whole system, include the kernel, kernel modules, libraries,
+	  and applications.
+
+	  If unsure, say N.
+
+endmenu
+
--- /dev/null	2003-12-14 13:20:18.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/oprofile/Makefile	2003-12-29 21:12:10.000000000 +1100
@@ -0,0 +1,9 @@
+obj-$(CONFIG_OPROFILE) += oprofile.o
+
+DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
+		oprof.o cpu_buffer.o buffer_sync.o \
+		event_buffer.o oprofile_files.o \
+		oprofilefs.o oprofile_stats.o \
+		timer_int.o )
+
+oprofile-y := $(DRIVER_OBJS) init.o
--- /dev/null	2003-12-14 13:20:18.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc/oprofile/init.c	2003-12-29 22:13:57.000000000 +1100
@@ -0,0 +1,25 @@
+/**
+ * @file init.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon <levon@movementarian.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/oprofile.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+
+extern void timer_init(struct oprofile_operations ** ops);
+
+int __init oprofile_arch_init(struct oprofile_operations ** ops)
+{
+	return -ENODEV;
+}
+
+
+void oprofile_arch_exit(void)
+{
+}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
