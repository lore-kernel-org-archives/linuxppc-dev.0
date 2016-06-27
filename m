Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSxW1vfGzDsRR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:32:15 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/38] powerpc/pmac: Remove early allocation of the SMU
 command buffer
Date: Mon, 27 Jun 2016 21:29:12 +1000
Message-Id: <1467026976-7974-15-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SMU command buffer needs to be allocated below 2G using memblock.

In the past, this had to be done very early from the arch code as
memblock wasn't available past that point. That is no longer the
case though, smu_init() is called from setup_arch() when memblock
is still functional these days. So move the allocation to the
SMU driver itself.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/smu.h          |  7 -------
 arch/powerpc/platforms/powermac/setup.c | 16 ----------------
 drivers/macintosh/smu.c                 |  9 ++++++++-
 3 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/smu.h b/arch/powerpc/include/asm/smu.h
index f280dd1..ddee470 100644
--- a/arch/powerpc/include/asm/smu.h
+++ b/arch/powerpc/include/asm/smu.h
@@ -471,13 +471,6 @@ extern int smu_get_rtc_time(struct rtc_time *time, int spinwait);
 extern int smu_set_rtc_time(struct rtc_time *time, int spinwait);
 
 /*
- * SMU command buffer absolute address, exported by pmac_setup,
- * this is allocated very early during boot.
- */
-extern unsigned long smu_cmdbuf_abs;
-
-
-/*
  * Kernel asynchronous i2c interface
  */
 
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 19de197..43d02c2 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -52,7 +52,6 @@
 #include <linux/suspend.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 
 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -97,11 +96,6 @@ int sccdbg;
 sys_ctrler_t sys_ctrler = SYS_CTRLER_UNKNOWN;
 EXPORT_SYMBOL(sys_ctrler);
 
-#ifdef CONFIG_PMAC_SMU
-unsigned long smu_cmdbuf_abs;
-EXPORT_SYMBOL(smu_cmdbuf_abs);
-#endif
-
 static void pmac_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *np;
@@ -325,7 +319,6 @@ static void __init pmac_setup_arch(void)
     defined(CONFIG_PPC64)
 	pmac_nvram_init();
 #endif
-
 #ifdef CONFIG_PPC32
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -615,15 +608,6 @@ static int __init pmac_probe(void)
 	DMA_MODE_WRITE = 2;
 #endif /* CONFIG_PPC32 */
 
-#ifdef CONFIG_PMAC_SMU
-	/*
-	 * SMU based G5s need some memory below 2Gb, at least the current
-	 * driver needs that. We have to allocate it now. We allocate 4k
-	 * (1 small page) for now.
-	 */
-	smu_cmdbuf_abs = memblock_alloc_base(4096, 4096, 0x80000000UL);
-#endif /* CONFIG_PMAC_SMU */
-
 	pm_power_off = pmac_power_off;
 
 	return 1;
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index d531f80..d6f72c8 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -38,6 +38,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include <linux/memblock.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -99,6 +100,7 @@ static DEFINE_MUTEX(smu_mutex);
 static struct smu_device	*smu;
 static DEFINE_MUTEX(smu_part_access);
 static int smu_irq_inited;
+static unsigned long smu_cmdbuf_abs;
 
 static void smu_i2c_retry(unsigned long data);
 
@@ -479,8 +481,13 @@ int __init smu_init (void)
 
 	printk(KERN_INFO "SMU: Driver %s %s\n", VERSION, AUTHOR);
 
+	/*
+	 * SMU based G5s need some memory below 2Gb. Thankfully this is
+	 * called at a time where memblock is still available.
+	 */
+	smu_cmdbuf_abs = memblock_alloc_base(4096, 4096, 0x80000000UL);
 	if (smu_cmdbuf_abs == 0) {
-		printk(KERN_ERR "SMU: Command buffer not allocated !\n");
+		printk(KERN_ERR "SMU: Command buffer allocation failed !\n");
 		ret = -EINVAL;
 		goto fail_np;
 	}
-- 
2.7.4
