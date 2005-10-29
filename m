Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0ko9H030012@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:19 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 09/43] ppc32: nvram driver for chrp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

This implements a nvram acccess method, similar to
arch/ppc64/kernel/pSeries_nvram.c tested on CHRP B50.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/platforms/Makefile     |    3 +
 arch/ppc/platforms/chrp_nvram.c |   83 ++++++++++++++++++++++++++++++++++++++++
 arch/ppc/platforms/chrp_setup.c |    3 -
 include/asm-ppc/system.h        |    1 
 4 files changed, 88 insertions(+), 2 deletions(-)

diff -puN /dev/null arch/ppc/platforms/chrp_nvram.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/chrp_nvram.c	2005-10-28 17:44:02.000000000 -0700
@@ -0,0 +1,83 @@
+/*
+ *  c 2001 PPC 64 Team, IBM Corp
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ *
+ * /dev/nvram driver for PPC
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <asm/uaccess.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+
+static unsigned int nvram_size;
+static unsigned char nvram_buf[4];
+static DEFINE_SPINLOCK(nvram_lock);
+
+static unsigned char chrp_nvram_read(int addr)
+{
+	unsigned long done, flags;
+	unsigned char ret;
+
+	if (addr >= nvram_size) {
+		printk(KERN_DEBUG "%s: read addr %d > nvram_size %u\n",
+		       current->comm, addr, nvram_size);
+		return 0xff;
+	}
+	spin_lock_irqsave(&nvram_lock, flags);
+	if ((call_rtas("nvram-fetch", 3, 2, &done, addr, __pa(nvram_buf), 1) != 0) || 1 != done)
+		ret = 0xff;
+	else
+		ret = nvram_buf[0];
+	spin_unlock_irqrestore(&nvram_lock, flags);
+
+	return ret;
+}
+
+static void chrp_nvram_write(int addr, unsigned char val)
+{
+	unsigned long done, flags;
+
+	if (addr >= nvram_size) {
+		printk(KERN_DEBUG "%s: write addr %d > nvram_size %u\n",
+		       current->comm, addr, nvram_size);
+		return;
+	}
+	spin_lock_irqsave(&nvram_lock, flags);
+	nvram_buf[0] = val;
+	if ((call_rtas("nvram-store", 3, 2, &done, addr, __pa(nvram_buf), 1) != 0) || 1 != done)
+		printk(KERN_DEBUG "rtas IO error storing 0x%02x at %d", val, addr);
+	spin_unlock_irqrestore(&nvram_lock, flags);
+}
+
+void __init chrp_nvram_init(void)
+{
+	struct device_node *nvram;
+	unsigned int *nbytes_p, proplen;
+
+	nvram = of_find_node_by_type(NULL, "nvram");
+	if (nvram == NULL)
+		return;
+
+	nbytes_p = (unsigned int *)get_property(nvram, "#bytes", &proplen);
+	if (nbytes_p == NULL || proplen != sizeof(unsigned int))
+		return;
+
+	nvram_size = *nbytes_p;
+
+	printk(KERN_INFO "CHRP nvram contains %u bytes\n", nvram_size);
+	of_node_put(nvram);
+
+	ppc_md.nvram_read_val = chrp_nvram_read;
+	ppc_md.nvram_write_val = chrp_nvram_write;
+
+	return;
+}
diff -puN arch/ppc/platforms/chrp_setup.c~ppc32-nvram-driver-for-chrp arch/ppc/platforms/chrp_setup.c
--- devel/arch/ppc/platforms/chrp_setup.c~ppc32-nvram-driver-for-chrp	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/chrp_setup.c	2005-10-28 17:44:02.000000000 -0700
@@ -464,8 +464,7 @@ void __init
 chrp_init2(void)
 {
 #ifdef CONFIG_NVRAM
-// XX replace this in a more saner way
-//	pmac_nvram_init();
+	chrp_nvram_init();
 #endif
 
 	request_region(0x20,0x20,"pic1");
diff -puN arch/ppc/platforms/Makefile~ppc32-nvram-driver-for-chrp arch/ppc/platforms/Makefile
--- devel/arch/ppc/platforms/Makefile~ppc32-nvram-driver-for-chrp	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/Makefile	2005-10-28 17:45:21.000000000 -0700
@@ -14,6 +14,9 @@ obj-$(CONFIG_PPC_PMAC)		+= pmac_pic.o pm
 					pmac_low_i2c.o pmac_cache.o
 obj-$(CONFIG_PPC_CHRP)		+= chrp_setup.o chrp_time.o chrp_pci.o \
 					chrp_pegasos_eth.o
+ifeq ($(CONFIG_PPC_CHRP),y)
+obj-$(CONFIG_NVRAM)		+= chrp_nvram.o
+endif
 obj-$(CONFIG_PPC_PREP)		+= prep_pci.o prep_setup.o
 ifeq ($(CONFIG_PPC_PMAC),y)
 obj-$(CONFIG_NVRAM)		+= pmac_nvram.o
diff -puN include/asm-ppc/system.h~ppc32-nvram-driver-for-chrp include/asm-ppc/system.h
--- devel/include/asm-ppc/system.h~ppc32-nvram-driver-for-chrp	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/include/asm-ppc/system.h	2005-10-28 17:44:02.000000000 -0700
@@ -70,6 +70,7 @@ extern void _set_L3CR(unsigned long);
 #endif
 extern void via_cuda_init(void);
 extern void pmac_nvram_init(void);
+extern void chrp_nvram_init(void);
 extern void read_rtc_time(void);
 extern void pmac_find_display(void);
 extern void giveup_fpu(struct task_struct *);
_
