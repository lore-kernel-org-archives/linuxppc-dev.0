Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1C0B688D6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 06:22:50 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] PPC32 8xx: support for the physmapped flash on m8xx
Date: Tue, 17 Jan 2006 22:22:27 +0300
Message-Id: <20060117192227.20199.91774.stgit@vitb.dev.rtsoft.ru>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Implemented more correct way to support physmapped flash on m8xx
than map in mtd.

The areas intended to contain bootloader are protected readonly.
Note that CFI and JEDEC stuff should be configured properly in order
this to work, e.g. for 885/86x CFI should support 4-chip flash interleave.
Also fixed compilation warning.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/ppc/syslib/m8xx_setup.c |   50 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
index 688616d..efe3308 100644
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -34,6 +34,13 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 
+#if defined(CONFIG_MTD) && defined(CONFIG_MTD_PHYSMAP)
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#endif
+
 #include <asm/mmu.h>
 #include <asm/reg.h>
 #include <asm/residual.h>
@@ -49,6 +56,34 @@
 
 #include "ppc8xx_pic.h"
 
+#ifdef CONFIG_MTD_PHYSMAP
+#define MPC8xxADS_BANK_WIDTH 4
+#endif
+
+#define MPC8xxADS_U_BOOT_SIZE          0x80000
+#define MPC8xxADS_FREE_AREA_OFFSET     MPC8xxADS_U_BOOT_SIZE
+
+#if defined(CONFIG_MTD_PARTITIONS)
+ /*
+   NOTE: bank width and interleave relative to the installed flash
+   should have been chosen within MTD_CFI_GEOMETRY options.
+ */
+static struct mtd_partition mpc8xxads_partitions[] = {
+	{
+		.name = "bootloader",
+		.size = MPC8xxADS_U_BOOT_SIZE,
+		.offset = 0,
+		.mask_flags   = MTD_WRITEABLE,  /* force read-only */
+	}, {
+		.name = "User FS",
+		.offset = MPC8xxADS_FREE_AREA_OFFSET
+	}
+};
+
+#define mpc8xxads_part_num (sizeof (mpc8xxads_partitions) / sizeof (mpc8xxads_partitions[0]))
+
+#endif
+
 static int m8xx_set_rtc_time(unsigned long time);
 static unsigned long m8xx_get_rtc_time(void);
 void m8xx_calibrate_decr(void);
@@ -71,6 +106,10 @@ board_init(void)
 void __init
 m8xx_setup_arch(void)
 {
+#if defined(CONFIG_MTD) && defined(CONFIG_MTD_PHYSMAP)
+	bd_t *binfo = (bd_t *)__res;
+#endif
+
 	/* Reset the Communication Processor Module.
 	*/
 	m8xx_cpm_reset();
@@ -106,6 +145,17 @@ m8xx_setup_arch(void)
 	}
 #endif
 #endif
+
+#if defined (CONFIG_MPC86XADS) || defined (CONFIG_MPC885ADS)
+#if defined(CONFIG_MTD_PHYSMAP)
+       physmap_configure(binfo->bi_flashstart, binfo->bi_flashsize,
+                                               MPC8xxADS_BANK_WIDTH, NULL);
+#ifdef CONFIG_MTD_PARTITIONS
+       physmap_set_partitions(mpc8xxads_partitions, mpc8xxads_part_num);
+#endif /* CONFIG_MTD_PARTITIONS */
+#endif /* CONFIG_MTD_PHYSMAP */
+#endif
+
 	board_init();
 }
 
