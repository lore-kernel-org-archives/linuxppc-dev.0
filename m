Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 96BCF1A04A2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Nov 2015 21:49:02 +1100 (AEDT)
Message-Id: <20151101104206.531667409@telegraphics.com.au>
Date: Sun, 01 Nov 2015 21:42:19 +1100
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Subject: [PATCH v7 17/26] powerpc,
 fbdev: Use arch_nvram_ops methods instead of nvram_read_byte() and
 nvram_write_byte()
References: <20151101104202.301856132@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make use of arch_nvram_ops in device drivers so that the nvram_* function
exports can be removed.

Since they are no longer global symbols, rename the PPC32 nvram_* functions
appropriately.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

Changed since v4:
- Split off the CONFIG_PPC32, CONFIG_PPC_PMAC and CONFIG_NVRAM tests into
a separate patch.

---
 arch/powerpc/kernel/setup_32.c             |    8 ++++----
 drivers/char/generic_nvram.c               |    4 ++--
 drivers/video/fbdev/controlfb.c            |    4 ++--
 drivers/video/fbdev/imsttfb.c              |    4 ++--
 drivers/video/fbdev/matrox/matroxfb_base.c |    2 +-
 drivers/video/fbdev/platinumfb.c           |    4 ++--
 drivers/video/fbdev/valkyriefb.c           |    4 ++--
 7 files changed, 15 insertions(+), 15 deletions(-)

Index: linux/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux.orig/arch/powerpc/kernel/setup_32.c	2015-11-01 21:41:42.000000000 +1100
+++ linux/arch/powerpc/kernel/setup_32.c	2015-11-01 21:41:45.000000000 +1100
@@ -176,20 +176,18 @@ __setup("l3cr=", ppc_setup_l3cr);
 
 #ifdef CONFIG_GENERIC_NVRAM
 
-unsigned char nvram_read_byte(int addr)
+static unsigned char ppc_nvram_read_byte(int addr)
 {
 	if (ppc_md.nvram_read_val)
 		return ppc_md.nvram_read_val(addr);
 	return 0xff;
 }
-EXPORT_SYMBOL(nvram_read_byte);
 
-void nvram_write_byte(unsigned char val, int addr)
+static void ppc_nvram_write_byte(unsigned char val, int addr)
 {
 	if (ppc_md.nvram_write_val)
 		ppc_md.nvram_write_val(addr, val);
 }
-EXPORT_SYMBOL(nvram_write_byte);
 
 static ssize_t ppc_nvram_get_size(void)
 {
@@ -206,6 +204,8 @@ static long ppc_nvram_sync(void)
 }
 
 const struct nvram_ops arch_nvram_ops = {
+	.read_byte      = ppc_nvram_read_byte,
+	.write_byte     = ppc_nvram_write_byte,
 	.get_size       = ppc_nvram_get_size,
 	.sync           = ppc_nvram_sync,
 };
Index: linux/drivers/char/generic_nvram.c
===================================================================
--- linux.orig/drivers/char/generic_nvram.c	2015-11-01 21:41:42.000000000 +1100
+++ linux/drivers/char/generic_nvram.c	2015-11-01 21:41:45.000000000 +1100
@@ -63,7 +63,7 @@ static ssize_t read_nvram(struct file *f
 	if (*ppos >= nvram_len)
 		return 0;
 	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count)
-		if (__put_user(nvram_read_byte(i), p))
+		if (__put_user(arch_nvram_ops.read_byte(i), p))
 			return -EFAULT;
 	*ppos = i;
 	return p - buf;
@@ -83,7 +83,7 @@ static ssize_t write_nvram(struct file *
 	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count) {
 		if (__get_user(c, p))
 			return -EFAULT;
-		nvram_write_byte(c, i);
+		arch_nvram_ops.write_byte(c, i);
 	}
 	*ppos = i;
 	return p - buf;
Index: linux/drivers/video/fbdev/controlfb.c
===================================================================
--- linux.orig/drivers/video/fbdev/controlfb.c	2015-11-01 21:41:23.000000000 +1100
+++ linux/drivers/video/fbdev/controlfb.c	2015-11-01 21:41:45.000000000 +1100
@@ -415,7 +415,7 @@ static int __init init_control(struct fb
 	/* Try to pick a video mode out of NVRAM if we have one. */
 #ifdef CONFIG_NVRAM
 	if (default_cmode == CMODE_NVRAM) {
-		cmode = nvram_read_byte(NV_CMODE);
+		cmode = arch_nvram_ops.read_byte(NV_CMODE);
 		if(cmode < CMODE_8 || cmode > CMODE_32)
 			cmode = CMODE_8;
 	} else
@@ -423,7 +423,7 @@ static int __init init_control(struct fb
 		cmode=default_cmode;
 #ifdef CONFIG_NVRAM
 	if (default_vmode == VMODE_NVRAM) {
-		vmode = nvram_read_byte(NV_VMODE);
+		vmode = arch_nvram_ops.read_byte(NV_VMODE);
 		if (vmode < 1 || vmode > VMODE_MAX ||
 		    control_mac_modes[vmode - 1].m[full] < cmode) {
 			sense = read_control_sense(p);
Index: linux/drivers/video/fbdev/imsttfb.c
===================================================================
--- linux.orig/drivers/video/fbdev/imsttfb.c	2015-11-01 21:41:43.000000000 +1100
+++ linux/drivers/video/fbdev/imsttfb.c	2015-11-01 21:41:45.000000000 +1100
@@ -1393,12 +1393,12 @@ static void init_imstt(struct fb_info *i
 		int vmode = init_vmode, cmode = init_cmode;
 
 		if (vmode == -1) {
-			vmode = nvram_read_byte(NV_VMODE);
+			vmode = arch_nvram_ops.read_byte(NV_VMODE);
 			if (vmode <= 0 || vmode > VMODE_MAX)
 				vmode = VMODE_640_480_67;
 		}
 		if (cmode == -1) {
-			cmode = nvram_read_byte(NV_CMODE);
+			cmode = arch_nvram_ops.read_byte(NV_CMODE);
 			if (cmode < CMODE_8 || cmode > CMODE_32)
 				cmode = CMODE_8;
 		}
Index: linux/drivers/video/fbdev/matrox/matroxfb_base.c
===================================================================
--- linux.orig/drivers/video/fbdev/matrox/matroxfb_base.c	2015-11-01 21:41:43.000000000 +1100
+++ linux/drivers/video/fbdev/matrox/matroxfb_base.c	2015-11-01 21:41:45.000000000 +1100
@@ -1878,7 +1878,7 @@ static int initMatrox2(struct matrox_fb_
 			default_vmode = VMODE_640_480_60;
 #if defined(CONFIG_PPC32) && defined(CONFIG_NVRAM)
 		if (default_cmode == CMODE_NVRAM)
-			default_cmode = nvram_read_byte(NV_CMODE);
+			default_cmode = arch_nvram_ops.read_byte(NV_CMODE);
 #endif
 		if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 			default_cmode = CMODE_8;
Index: linux/drivers/video/fbdev/platinumfb.c
===================================================================
--- linux.orig/drivers/video/fbdev/platinumfb.c	2015-11-01 21:41:23.000000000 +1100
+++ linux/drivers/video/fbdev/platinumfb.c	2015-11-01 21:41:45.000000000 +1100
@@ -349,7 +349,7 @@ static int platinum_init_fb(struct fb_in
 	printk(KERN_INFO "platinumfb: Monitor sense value = 0x%x, ", sense);
 	if (default_vmode == VMODE_NVRAM) {
 #ifdef CONFIG_NVRAM
-		default_vmode = nvram_read_byte(NV_VMODE);
+		default_vmode = arch_nvram_ops.read_byte(NV_VMODE);
 		if (default_vmode <= 0 || default_vmode > VMODE_MAX ||
 		    !platinum_reg_init[default_vmode-1])
 #endif
@@ -362,7 +362,7 @@ static int platinum_init_fb(struct fb_in
 		default_vmode = VMODE_640_480_60;
 #ifdef CONFIG_NVRAM
 	if (default_cmode == CMODE_NVRAM)
-		default_cmode = nvram_read_byte(NV_CMODE);
+		default_cmode = arch_nvram_ops.read_byte(NV_CMODE);
 #endif
 	if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 		default_cmode = CMODE_8;
Index: linux/drivers/video/fbdev/valkyriefb.c
===================================================================
--- linux.orig/drivers/video/fbdev/valkyriefb.c	2015-11-01 21:41:43.000000000 +1100
+++ linux/drivers/video/fbdev/valkyriefb.c	2015-11-01 21:41:45.000000000 +1100
@@ -285,7 +285,7 @@ static void __init valkyrie_choose_mode(
 	/* Try to pick a video mode out of NVRAM if we have one. */
 #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
 	if (default_vmode == VMODE_NVRAM) {
-		default_vmode = nvram_read_byte(NV_VMODE);
+		default_vmode = arch_nvram_ops.read_byte(NV_VMODE);
 		if (default_vmode <= 0
 		 || default_vmode > VMODE_MAX
 		 || !valkyrie_reg_init[default_vmode - 1])
@@ -298,7 +298,7 @@ static void __init valkyrie_choose_mode(
 		default_vmode = VMODE_640_480_67;
 #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
 	if (default_cmode == CMODE_NVRAM)
-		default_cmode = nvram_read_byte(NV_CMODE);
+		default_cmode = arch_nvram_ops.read_byte(NV_CMODE);
 #endif
 
 	/*
