Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id D9E581A065A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Nov 2015 21:49:02 +1100 (AEDT)
Message-Id: <20151101104207.781688728@telegraphics.com.au>
Date: Sun, 01 Nov 2015 21:42:24 +1100
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v7 22/26] powerpc: Remove pmac_xpram_{read,write} functions
References: <20151101104202.301856132@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The arch_nvram_ops methods provide a uniform API for drivers and ioctls.
This API is used to replace older APIs like the nvram_{read,write}_byte()
exports and the pmac_xpram_{read,write} functions.

The latter API is removed in this patch. The addition of the
get_partition() method to struct nvram_ops makes that possible.
pmac_xpram_read() becomes unused once pmac_time_init() is converted
to use arch_nvram_ops. pmac_xpram_write() was already unused.

drivers/char/nvram.c also benefits with the removal of the CONFIG_PPC_PMAC
macro from that file.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 arch/powerpc/include/asm/nvram.h        |    4 ----
 arch/powerpc/kernel/nvram_64.c          |    3 +++
 arch/powerpc/kernel/setup_32.c          |    3 +++
 arch/powerpc/platforms/powermac/nvram.c |   28 +++-------------------------
 arch/powerpc/platforms/powermac/time.c  |   17 +++++++++++++----
 drivers/char/nvram.c                    |    6 ++----
 include/linux/nvram.h                   |    1 +
 7 files changed, 25 insertions(+), 37 deletions(-)

Index: linux/arch/powerpc/include/asm/nvram.h
===================================================================
--- linux.orig/arch/powerpc/include/asm/nvram.h	2015-11-01 21:41:42.000000000 +1100
+++ linux/arch/powerpc/include/asm/nvram.h	2015-11-01 21:41:53.000000000 +1100
@@ -74,10 +74,6 @@ extern loff_t nvram_find_partition(const
 /* Return partition offset in nvram */
 extern int	pmac_get_partition(int partition);
 
-/* Direct access to XPRAM on PowerMacs */
-extern u8	pmac_xpram_read(int xpaddr);
-extern void	pmac_xpram_write(int xpaddr, u8 data);
-
 /* Initialize NVRAM OS partition */
 extern int __init nvram_init_os_partition(struct nvram_os_partition *part);
 
Index: linux/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux.orig/arch/powerpc/kernel/setup_32.c	2015-11-01 21:41:48.000000000 +1100
+++ linux/arch/powerpc/kernel/setup_32.c	2015-11-01 21:41:53.000000000 +1100
@@ -208,6 +208,9 @@ const struct nvram_ops arch_nvram_ops =
 	.write_byte     = ppc_nvram_write_byte,
 	.get_size       = ppc_nvram_get_size,
 	.sync           = ppc_nvram_sync,
+#ifdef CONFIG_PPC_PMAC
+	.get_partition  = pmac_get_partition,
+#endif
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
Index: linux/arch/powerpc/platforms/powermac/nvram.c
===================================================================
--- linux.orig/arch/powerpc/platforms/powermac/nvram.c	2015-11-01 21:41:39.000000000 +1100
+++ linux/arch/powerpc/platforms/powermac/nvram.c	2015-11-01 21:41:53.000000000 +1100
@@ -629,29 +629,7 @@ bail:
 
 int pmac_get_partition(int partition)
 {
-	return nvram_partitions[partition];
+	if (machine_is(powermac))
+		return nvram_partitions[partition];
+	return -1;
 }
-
-u8 pmac_xpram_read(int xpaddr)
-{
-	int offset = pmac_get_partition(pmac_nvram_XPRAM);
-
-	if (offset < 0 || xpaddr < 0 || xpaddr > 0x100)
-		return 0xff;
-
-	return ppc_md.nvram_read_val(xpaddr + offset);
-}
-
-void pmac_xpram_write(int xpaddr, u8 data)
-{
-	int offset = pmac_get_partition(pmac_nvram_XPRAM);
-
-	if (offset < 0 || xpaddr < 0 || xpaddr > 0x100)
-		return;
-
-	ppc_md.nvram_write_val(xpaddr + offset, data);
-}
-
-EXPORT_SYMBOL(pmac_get_partition);
-EXPORT_SYMBOL(pmac_xpram_read);
-EXPORT_SYMBOL(pmac_xpram_write);
Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-11-01 21:41:51.000000000 +1100
+++ linux/drivers/char/nvram.c	2015-11-01 21:41:53.000000000 +1100
@@ -332,8 +332,7 @@ static long nvram_misc_ioctl(struct file
 		/* fall through */
 	case IOC_NVRAM_GET_OFFSET:
 		ret = -EINVAL;
-#ifdef CONFIG_PPC_PMAC
-		if (machine_is(powermac)) {
+		if (arch_nvram_ops.get_partition != NULL) {
 			int part, offset;
 
 			if (copy_from_user(&part, (void __user *)arg,
@@ -341,7 +340,7 @@ static long nvram_misc_ioctl(struct file
 				return -EFAULT;
 			if (part < pmac_nvram_OF || part > pmac_nvram_NR)
 				return -EINVAL;
-			offset = pmac_get_partition(part);
+			offset = arch_nvram_ops.get_partition(part);
 			if (offset < 0)
 				return -EINVAL;
 			if (copy_to_user((void __user *)arg,
@@ -349,7 +348,6 @@ static long nvram_misc_ioctl(struct file
 				return -EFAULT;
 			ret = 0;
 		}
-#endif
 		break;
 	case IOC_NVRAM_SYNC:
 		if (arch_nvram_ops.sync != NULL) {
Index: linux/include/linux/nvram.h
===================================================================
--- linux.orig/include/linux/nvram.h	2015-11-01 21:41:47.000000000 +1100
+++ linux/include/linux/nvram.h	2015-11-01 21:41:53.000000000 +1100
@@ -11,6 +11,7 @@ struct nvram_ops {
 	ssize_t         (*get_size)(void);
 #ifdef CONFIG_PPC
 	long            (*sync)(void);
+	int             (*get_partition)(int);
 #else
 	long            (*set_checksum)(void);
 	long            (*initialize)(void);
Index: linux/arch/powerpc/platforms/powermac/time.c
===================================================================
--- linux.orig/arch/powerpc/platforms/powermac/time.c	2015-11-01 21:41:51.000000000 +1100
+++ linux/arch/powerpc/platforms/powermac/time.c	2015-11-01 21:41:53.000000000 +1100
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/hardirq.h>
 #include <linux/rtc.h>
+#include <linux/nvram.h>
 
 #include <asm/sections.h>
 #include <asm/prom.h>
@@ -70,13 +71,21 @@ long __init pmac_time_init(void)
 	s32 delta = 0;
 #if defined(CONFIG_NVRAM) && defined(CONFIG_PPC32)
 	int dst;
+	int offset = arch_nvram_ops.get_partition(pmac_nvram_XPRAM);
 	
-	delta = ((s32)pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0x9)) << 16;
-	delta |= ((s32)pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0xa)) << 8;
-	delta |= pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0xb);
+	if (offset < 0)
+		return 0;
+
+	delta = arch_nvram_ops.read_byte(offset + PMAC_XPRAM_MACHINE_LOC + 9);
+	delta <<= 8;
+	delta |= arch_nvram_ops.read_byte(offset + PMAC_XPRAM_MACHINE_LOC + 10);
+	delta <<= 8;
+	delta |= arch_nvram_ops.read_byte(offset + PMAC_XPRAM_MACHINE_LOC + 11);
+
 	if (delta & 0x00800000UL)
 		delta |= 0xFF000000UL;
-	dst = ((pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0x8) & 0x80) != 0);
+	dst = arch_nvram_ops.read_byte(offset + PMAC_XPRAM_MACHINE_LOC + 8);
+	dst &= 0x80;
 	printk("GMT Delta read from XPRAM: %d minutes, DST: %s\n", delta/60,
 		dst ? "on" : "off");
 #endif
Index: linux/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux.orig/arch/powerpc/kernel/nvram_64.c	2015-11-01 21:41:51.000000000 +1100
+++ linux/arch/powerpc/kernel/nvram_64.c	2015-11-01 21:41:53.000000000 +1100
@@ -1109,6 +1109,9 @@ const struct nvram_ops arch_nvram_ops =
 	.write          = ppc_nvram_write,
 	.get_size       = ppc_nvram_get_size,
 	.sync           = ppc_nvram_sync,
+#ifdef CONFIG_PPC_PMAC
+	.get_partition  = pmac_get_partition,
+#endif
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
