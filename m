Date: Mon, 28 Jan 2002 09:08:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Cc: hollis@austin.ibm.com, Sven Dickert <Sven.Dickert@planb.de>,
	Leigh Brown <leigh@solinno.co.uk>
Subject: /proc/residual (CONFIG_PREP_PROCRESIDUAL)
Message-ID: <20020128160822.GH19960@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all.  Here's a version of the /proc/residual patch (originally by
David Monro, updated for 2.4 by Sven Dickert) vs current 2_4_devel.
This is slightly different than the previous versions that've been
floating around:
1) It can't be a module now.  After talking to Al Viro, doing /proc
stuff in a module correctly is a giant PITA (it wasn't working in the
previous versions I don't think...)
2) Use __initcall() instead of editing fs/proc/root.c.  This should make
it easier to run past Marcelo/Linus, since it only touches PPC-specific
things (and the help file).
3) I cleaned up the DPRINTK() macros slightly in a few places.

In some quick testing on my machine, I always got the same image file
(md5'ed).  Can a few more people try this and make sure it still works
for them?  Thanks.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== Documentation/Configure.help 1.109 vs edited =====
--- 1.109/Documentation/Configure.help	Wed Jan 23 18:06:24 2002
+++ edited/Documentation/Configure.help	Mon Jan 28 08:25:59 2002
@@ -14413,6 +14413,14 @@
   Unless you expect to boot on a PReP system, there is not need to
   select Y.

+PReP residual data avaiable in /proc/residual
+CONFIG_PROC_PREPRESIDUAL
+  Enabling this option will create a /proc/residual file which allows
+  you to get at the residual data on PReP systems (the data the firmware
+  passes to the kernel describing the system. You will need a tool
+  (lsresidual) to parse it. If you aren't on a PReP system, you don't
+  want this. It is also available as a module (prep_residual.o).
+
 /dev file system support
 CONFIG_DEVFS_FS
   This is support for devfs, a virtual file system (like /proc) which
===== arch/ppc/config.in 1.114 vs edited =====
--- 1.114/arch/ppc/config.in	Sun Jan 20 13:30:26 2002
+++ edited/arch/ppc/config.in	Mon Jan 28 08:25:59 2002
@@ -393,6 +393,7 @@
   bool 'Support for Open Firmware device tree in /proc' CONFIG_PROC_DEVICETREE
   bool 'Support for RTAS (RunTime Abstraction Services) in /proc' CONFIG_PPC_RTAS
   bool 'Support for PReP Residual Data' CONFIG_PREP_RESIDUAL
+  dep_bool '  Support for reading of PReP Residual data in /proc' CONFIG_PROC_PREPRESIDUAL $CONFIG_PREP_RESIDUAL
 fi

 bool 'Default bootloader kernel arguments' CONFIG_CMDLINE_BOOL
===== arch/ppc/platforms/Makefile 1.15 vs edited =====
--- 1.15/arch/ppc/platforms/Makefile	Sat Jan 26 17:32:42 2002
+++ edited/arch/ppc/platforms/Makefile	Mon Jan 28 08:26:25 2002
@@ -49,6 +49,7 @@
 obj-$(CONFIG_PMAC_PBOOK)	+= sleep.o
 obj-$(CONFIG_PPC_RTAS)		+= error_log.o proc_rtas.o
 obj-$(CONFIG_PREP_RESIDUAL)	+= residual.o
+obj-$(CONFIG_PROC_PREPRESIDUAL)	+= prep_procresidual.o
 obj-$(CONFIG_ADIR)		+= adir_setup.o adir_pic.o adir_pci.o
 obj-$(CONFIG_EV64260)		+= ev64260_setup.o
 obj-$(CONFIG_GEMINI)		+= gemini_pci.o gemini_setup.o gemini_prom.o
--- a/dev/null	Wed Dec 31 17:00:00 1969
+++ b/arch/ppc/platforms/prep_procresidual.c	Mon Jan 28 08:25:59 2002
@@ -0,0 +1,105 @@
+/*
+ *  linux/arch/ppc/platforms/prep_procresidual.c
+ *
+ *  Copyright (C) 2000 by David Monro
+ *  Ported to linux 2.4 by Sven Dickert 2001
+ *  Additional cleanups by Tom Rini, Jan 26 2002.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+
+#include <asm/residual.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DPRINTK(x...) printk(x)
+#else
+#define DPRINTK(x...)
+#endif
+
+static int
+prep_residual_open(struct inode *inode, struct file *file)
+{
+	if (res->ResidualLength == 0)
+		return -ENOENT;
+
+	DPRINTK("/proc/residual opened\n");
+
+	return 0;
+}
+
+static int
+prep_residual_release(struct inode *inode, struct file *file)
+{
+	if (res->ResidualLength == 0)
+		return -ENOENT;
+
+	DPRINTK("/proc/residual released\n");
+
+	return 0;
+}
+
+static ssize_t
+prep_residual_read(struct file *file, char *buf, size_t count, loff_t * ppos)
+{
+	int retval;
+	int rlen = res->ResidualLength;
+	int offset = *ppos;
+
+	DPRINTK("prep_residual_read called, offset = %d\n", offset);
+
+	/* Make sure we're have something to do, and are called correctly */
+	if (!count)
+		return 0;
+	else if (rlen == 0)
+		retval = -ENOENT;
+	else if (!buf || count < 0)
+		retval = -EINVAL;
+	else
+		retval = verify_area(VERIFY_WRITE, buf, count);
+
+	if (retval)
+		return retval;
+
+	if ((count + offset) > rlen)
+		count = rlen - offset;
+
+	copy_to_user(buf, ((char *) res) + offset, count);
+	*ppos += count;
+
+	return count;
+}
+
+static struct file_operations proc_prep_residual_operations = {
+	read:prep_residual_read,
+	open:prep_residual_open,
+	release:prep_residual_release,
+};
+
+struct proc_dir_entry *entry;
+
+int __init
+prep_procresidual_init(void)
+{
+	DPRINTK("Registering /proc/residual... ");
+
+	entry = create_proc_entry("residual", S_IFREG | S_IRUGO, &proc_root);
+
+	if (entry)
+		entry->proc_fops = &proc_prep_residual_operations;
+	else
+		return -EAGAIN;
+
+	return 0;
+}
+
+__initcall(prep_procresidual_init);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
