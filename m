Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-4.online-age.net (ext-nj2ut-4.online-age.net
	[64.14.54.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B2861DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 20:26:53 +1100 (EST)
Received: from int-nj2ut-6.online-age.net (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by ext-nj2ut-4.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mAC9Qn1e019938
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 04:26:49 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by int-nj2ut-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mAC9QmFB019039
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 04:26:49 -0500
Received: from ubuntu8041.localdomain (localhost [127.0.0.1])
	by ubuntu8041.localdomain (Postfix) with ESMTP id 23E7D5E07F
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 09:26:57 +0000 (GMT)
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH] [RFC] Exposing mmio nvrams greater than 8MB using
	generic_nvram
To: linuxppc-dev@ozlabs.org
Date: Wed, 12 Nov 2008 09:26:56 +0000
Message-ID: <20081112092652.8763.15100.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have been looking for a way to access the nvram on our board and expose it
to userspace. The board has a 128kB nvram, the mmio_nvram driver seemed to be
a capable of mapping this device.

generic_nvram seemed initially to be the correct way of exposing the driver
to userspace, however it was hard-coded to assume an nvram of 8kB. The
mmio_nvram driver also didn't provide the functions expected by
generic_nvram.

The patch below extends generic_nvram and mmio_nvram. I realise this is
really not ready yet (I dread to think how this patch could break other's
builds), however I am interested in knowing if this is the correct approach
to take or whether I am missing a much more suitable one.

Martyn
---

 arch/powerpc/boot/dts/gef_sbc610.dts           |    6 +++++
 arch/powerpc/configs/86xx/gef_sbc610_defconfig |    4 ++-
 arch/powerpc/include/asm/nvram.h               |    3 ++
 arch/powerpc/kernel/setup_32.c                 |    8 ++++++
 arch/powerpc/platforms/86xx/Kconfig            |    1 +
 arch/powerpc/platforms/86xx/gef_sbc610.c       |    5 ++++
 arch/powerpc/sysdev/mmio_nvram.c               |   32 ++++++++++++++++++++++++
 drivers/char/generic_nvram.c                   |   24 ++++++++++++++----
 8 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index e78c355..ed230bf 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -84,6 +84,12 @@
 			  6 0 0xfd000000 0x00800000     // IO FPGA (8-bit)
 			  7 0 0xfd800000 0x00800000>;   // IO FPGA (32-bit)
 
+		nvram@3,0 {
+			device_type = "nvram";
+			compatible = "simtek,stk14ca8";
+			reg = <0x3 0x0 0x20000>;
+		};
+
 		fpga@4,0 {
 			compatible = "gef,fpga-regs";
 			reg = <0x4 0x0 0x40>;
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index b539433..3dfd252 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -178,7 +178,7 @@ CONFIG_MPIC=y
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
 # CONFIG_PPC_RTAS is not set
-# CONFIG_MMIO_NVRAM is not set
+CONFIG_MMIO_NVRAM=y
 # CONFIG_PPC_MPC106 is not set
 # CONFIG_PPC_970_NAP is not set
 # CONFIG_PPC_INDIRECT_IO is not set
@@ -991,7 +991,7 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_HW_RANDOM=y
-# CONFIG_NVRAM is not set
+CONFIG_NVRAM=y
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
index efde5ac..71df8b2 100644
--- a/arch/powerpc/include/asm/nvram.h
+++ b/arch/powerpc/include/asm/nvram.h
@@ -107,6 +107,9 @@ extern void	pmac_xpram_write(int xpaddr, u8 data);
 /* Synchronize NVRAM */
 extern void	nvram_sync(void);
 
+/* Determine NVRAM size */
+extern ssize_t nvram_size(void);
+
 /* Normal access to NVRAM */
 extern unsigned char nvram_read_byte(int i);
 extern void nvram_write_byte(unsigned char c, int i);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index c1a2762..8130b9b 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -200,6 +200,14 @@ void nvram_write_byte(unsigned char val, int addr)
 }
 EXPORT_SYMBOL(nvram_write_byte);
 
+ssize_t nvram_size(void)
+{
+	if (ppc_md.nvram_size)
+		return ppc_md.nvram_size();
+	return 0;
+}
+EXPORT_SYMBOL(nvram_size);
+
 void nvram_sync(void)
 {
 	if (ppc_md.nvram_sync)
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 8e56939..be4e9f9 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -34,6 +34,7 @@ config MPC8610_HPCD
 config GEF_SBC610
 	bool "GE Fanuc SBC610"
 	select DEFAULT_UIMAGE
+	select MMIO_NVRAM
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select HAS_RAPIDIO
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index fb371f5..2daec46 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -34,6 +34,7 @@
 #include <asm/udbg.h>
 
 #include <asm/mpic.h>
+#include <asm/nvram.h>
 
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>
@@ -96,6 +97,10 @@ static void __init gef_sbc610_setup_arch(void)
 			printk(KERN_WARNING "Unable to map board registers\n");
 		of_node_put(regs);
 	}
+
+#if defined(CONFIG_MMIO_NVRAM)
+	mmio_nvram_init();
+#endif
 }
 
 /* Return the PCB revision */
diff --git a/arch/powerpc/sysdev/mmio_nvram.c b/arch/powerpc/sysdev/mmio_nvram.c
index 7b49633..2073242 100644
--- a/arch/powerpc/sysdev/mmio_nvram.c
+++ b/arch/powerpc/sysdev/mmio_nvram.c
@@ -53,6 +53,23 @@ static ssize_t mmio_nvram_read(char *buf, size_t count, loff_t *index)
 	return count;
 }
 
+static unsigned char mmio_nvram_read_val(int addr)
+{
+	unsigned long flags;
+	unsigned char val;
+
+	if (addr >= mmio_nvram_len)
+		return 0xff;
+
+	spin_lock_irqsave(&mmio_nvram_lock, flags);
+
+	val = ioread8(mmio_nvram_start + addr);
+
+	spin_unlock_irqrestore(&mmio_nvram_lock, flags);
+
+	return val;
+}
+
 static ssize_t mmio_nvram_write(char *buf, size_t count, loff_t *index)
 {
 	unsigned long flags;
@@ -72,6 +89,19 @@ static ssize_t mmio_nvram_write(char *buf, size_t count, loff_t *index)
 	return count;
 }
 
+void mmio_nvram_write_val(int addr, unsigned char val)
+{
+	unsigned long flags;
+
+	if (addr < mmio_nvram_len) {
+		spin_lock_irqsave(&mmio_nvram_lock, flags);
+
+		iowrite8(val, mmio_nvram_start + addr);
+
+		spin_unlock_irqrestore(&mmio_nvram_lock, flags);
+	}
+}
+
 static ssize_t mmio_nvram_get_size(void)
 {
 	return mmio_nvram_len;
@@ -114,6 +144,8 @@ int __init mmio_nvram_init(void)
 	printk(KERN_INFO "mmio NVRAM, %luk at 0x%lx mapped to %p\n",
 	       mmio_nvram_len >> 10, nvram_addr, mmio_nvram_start);
 
+	ppc_md.nvram_read_val	= mmio_nvram_read_val;
+	ppc_md.nvram_write_val	= mmio_nvram_write_val;
 	ppc_md.nvram_read	= mmio_nvram_read;
 	ppc_md.nvram_write	= mmio_nvram_write;
 	ppc_md.nvram_size	= mmio_nvram_get_size;
diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
index a00869c..904d2b4 100644
--- a/drivers/char/generic_nvram.c
+++ b/drivers/char/generic_nvram.c
@@ -28,6 +28,8 @@
 
 #define NVRAM_SIZE	8192
 
+static ssize_t nvram_len;
+
 static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
 {
 	lock_kernel();
@@ -36,7 +38,7 @@ static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
 		offset += file->f_pos;
 		break;
 	case 2:
-		offset += NVRAM_SIZE;
+		offset += nvram_len;
 		break;
 	}
 	if (offset < 0) {
@@ -56,9 +58,9 @@ static ssize_t read_nvram(struct file *file, char __user *buf,
 
 	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
-	if (*ppos >= NVRAM_SIZE)
+	if (*ppos >= nvram_len)
 		return 0;
-	for (i = *ppos; count > 0 && i < NVRAM_SIZE; ++i, ++p, --count)
+	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count)
 		if (__put_user(nvram_read_byte(i), p))
 			return -EFAULT;
 	*ppos = i;
@@ -74,9 +76,9 @@ static ssize_t write_nvram(struct file *file, const char __user *buf,
 
 	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
-	if (*ppos >= NVRAM_SIZE)
+	if (*ppos >= nvram_len)
 		return 0;
-	for (i = *ppos; count > 0 && i < NVRAM_SIZE; ++i, ++p, --count) {
+	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count) {
 		if (__get_user(c, p))
 			return -EFAULT;
 		nvram_write_byte(c, i);
@@ -133,9 +135,19 @@ static struct miscdevice nvram_dev = {
 
 int __init nvram_init(void)
 {
+	int ret = 0;
+
 	printk(KERN_INFO "Generic non-volatile memory driver v%s\n",
 		NVRAM_VERSION);
-	return misc_register(&nvram_dev);
+	if ((ret = misc_register(&nvram_dev)) != 0)
+		goto out;
+
+	nvram_len = nvram_size();
+	if (nvram_len == 0)
+		nvram_len = NVRAM_SIZE;
+
+out:
+	return ret;
 }
 
 void __exit nvram_cleanup(void)
