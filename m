Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 673581A0C98
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:01 +1000 (AEST)
Message-Id: <20150531010135.839511898@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:46 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC 14/24] powerpc: Add missing ppc_md.nvram_size for CHRP and
 PowerMac
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the nvram_size() function to those PowerPC platforms that don't already
have one: CHRP and PowerMac. This means that the ppc_md.nvram_size()
function can be used to implement arch_nvram_ops.get_size()

Since we are addressing inconsistencies here, also rename chrp_nvram_read
and chrp_nvram_write, which break the naming convention used across
PowerPC platforms for NVRAM accessor functions.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 arch/powerpc/platforms/chrp/nvram.c     |   14 ++++++++++----
 arch/powerpc/platforms/powermac/nvram.c |    9 +++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

Index: linux/arch/powerpc/platforms/chrp/nvram.c
===================================================================
--- linux.orig/arch/powerpc/platforms/chrp/nvram.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/powerpc/platforms/chrp/nvram.c	2015-05-31 11:01:15.000000000 +1000
@@ -23,7 +23,7 @@ static unsigned int nvram_size;
 static unsigned char nvram_buf[4];
 static DEFINE_SPINLOCK(nvram_lock);
 
-static unsigned char chrp_nvram_read(int addr)
+static unsigned char chrp_nvram_read_byte(int addr)
 {
 	unsigned int done;
 	unsigned long flags;
@@ -45,7 +45,7 @@ static unsigned char chrp_nvram_read(int
 	return ret;
 }
 
-static void chrp_nvram_write(int addr, unsigned char val)
+static void chrp_nvram_write_byte(int addr, unsigned char val)
 {
 	unsigned int done;
 	unsigned long flags;
@@ -63,6 +63,11 @@ static void chrp_nvram_write(int addr, u
 	spin_unlock_irqrestore(&nvram_lock, flags);
 }
 
+static ssize_t chrp_nvram_size(void)
+{
+	return nvram_size;
+}
+
 void __init chrp_nvram_init(void)
 {
 	struct device_node *nvram;
@@ -84,8 +89,9 @@ void __init chrp_nvram_init(void)
 	printk(KERN_INFO "CHRP nvram contains %u bytes\n", nvram_size);
 	of_node_put(nvram);
 
-	ppc_md.nvram_read_val = chrp_nvram_read;
-	ppc_md.nvram_write_val = chrp_nvram_write;
+	ppc_md.nvram_read_val  = chrp_nvram_read_byte;
+	ppc_md.nvram_write_val = chrp_nvram_write_byte;
+	ppc_md.nvram_size      = chrp_nvram_size;
 
 	return;
 }
Index: linux/arch/powerpc/platforms/powermac/nvram.c
===================================================================
--- linux.orig/arch/powerpc/platforms/powermac/nvram.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/powerpc/platforms/powermac/nvram.c	2015-05-31 11:01:15.000000000 +1000
@@ -147,6 +147,11 @@ static ssize_t core99_nvram_size(void)
 static volatile unsigned char __iomem *nvram_addr;
 static int nvram_mult;
 
+static ssize_t ppc32_nvram_size(void)
+{
+	return NVRAM_SIZE;
+}
+
 static unsigned char direct_nvram_read_byte(int addr)
 {
 	return in_8(&nvram_data[(addr & (NVRAM_SIZE - 1)) * nvram_mult]);
@@ -590,21 +595,25 @@ int __init pmac_nvram_init(void)
 		nvram_mult = 1;
 		ppc_md.nvram_read_val	= direct_nvram_read_byte;
 		ppc_md.nvram_write_val	= direct_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 	} else if (nvram_naddrs == 1) {
 		nvram_data = ioremap(r1.start, s1);
 		nvram_mult = (s1 + NVRAM_SIZE - 1) / NVRAM_SIZE;
 		ppc_md.nvram_read_val	= direct_nvram_read_byte;
 		ppc_md.nvram_write_val	= direct_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 	} else if (nvram_naddrs == 2) {
 		nvram_addr = ioremap(r1.start, s1);
 		nvram_data = ioremap(r2.start, s2);
 		ppc_md.nvram_read_val	= indirect_nvram_read_byte;
 		ppc_md.nvram_write_val	= indirect_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 	} else if (nvram_naddrs == 0 && sys_ctrler == SYS_CTRLER_PMU) {
 #ifdef CONFIG_ADB_PMU
 		nvram_naddrs = -1;
 		ppc_md.nvram_read_val	= pmu_nvram_read_byte;
 		ppc_md.nvram_write_val	= pmu_nvram_write_byte;
+		ppc_md.nvram_size	= ppc32_nvram_size;
 #endif /* CONFIG_ADB_PMU */
 	} else {
 		printk(KERN_ERR "Incompatible type of NVRAM\n");
