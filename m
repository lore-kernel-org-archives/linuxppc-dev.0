Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id DE811688F8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 14:57:47 +1100 (EST)
Message-ID: <43A78139.8030505@ru.mvista.com>
Date: Tue, 20 Dec 2005 06:57:45 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Subject: [PATCH]ppc32: Adds PQ2FADS flash SIMM support as physmap device
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Implemented more correct way to support physmapped flash on PQ2FADS
than map in mtd (which is already removed from the mtd tree).

The areas intended to contain bootloader are protected readonly.
Note that CFI and JEDEC stuff should be configured properly in order
this to work, e.g. for 8272 CFI should support 4-chip flash interleave.
Also fixed compilation warning.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

---
commit 3af1e7e029c4fd50236078e48e79f8112a999de8
tree f84ee4fe92d616a0f640e1e86601a003d887b807
parent a8450a334dc930d7284800c457d91ed55a1a3dd7
author Vitaly Bordug <vbordug@ru.mvista.com> Sun, 18 Dec 2005 21:26:13 +0300
committer Vitaly Bordug <vbordug@ru.mvista.com> Sun, 18 Dec 2005 21:26:13 +0300

  arch/ppc/syslib/m8260_setup.c |   71 ++++++++++++++++++++++++++++++++++++++++-
  1 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/syslib/m8260_setup.c b/arch/ppc/syslib/m8260_setup.c
index 76a2aa4..693e8dc 100644
--- a/arch/ppc/syslib/m8260_setup.c
+++ b/arch/ppc/syslib/m8260_setup.c
@@ -20,6 +20,13 @@
  #include <linux/seq_file.h>
  #include <linux/irq.h>

+#if defined(CONFIG_MTD) && defined(CONFIG_MTD_PHYSMAP)
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#endif
+
  #include <asm/mmu.h>
  #include <asm/io.h>
  #include <asm/pgtable.h>
@@ -28,9 +35,58 @@
  #include <asm/machdep.h>
  #include <asm/bootinfo.h>
  #include <asm/time.h>
+#include <asm/ppc_sys.h>

  #include "cpm2_pic.h"

+#ifdef CONFIG_MTD_PHYSMAP
+#define PQ2FADS_BANK_WIDTH 4
+#endif
+
+#if defined(CONFIG_MTD_PARTITIONS)
+/*
+  NOTE: bank width and interleave relative to the installed flash
+  should have been chosen within MTD_CFI_GEOMETRY options.
+ */
+
+static struct mtd_partition pq2fads_partitions[] = {
+        {
+#if defined(CONFIG_ADS8272)
+		.name           = "HRCW",
+                .size           = 0x40000,
+                .offset         = 0,
+                .mask_flags     = MTD_WRITEABLE,  /* force read-only */
+        }, {
+                .name           = "User FS",
+                .size           = 0x5c0000,
+                .offset         = 0x40000,
+#else
+                .name           = "User FS",
+                .size           = 0x600000,
+                .offset         = 0,
+#endif
+        }, {
+                .name           = "uImage",
+                .size           = 0x100000,
+                .offset         = 0x600000,
+                .mask_flags     = MTD_WRITEABLE,  /* force read-only */
+        }, {
+                .name           = "bootloader",
+                .size           = 0x40000,
+                .offset         = 0x700000,
+                .mask_flags     = MTD_WRITEABLE,  /* force read-only */
+        }, {
+                .name           = "bootloader env",
+                .size           = 0x40000,
+                .offset         = 0x740000,
+                .mask_flags     = MTD_WRITEABLE,  /* force read-only */
+        }
+};
+
+#define pq2fads_part_num (sizeof (pq2fads_partitions) / sizeof (pq2fads_partitions[0]))
+
+#endif
+
  unsigned char __res[sizeof(bd_t)];

  extern void pq2_find_bridges(void);
@@ -46,6 +102,9 @@ m82xx_board_setup(void)
  static void __init
  m8260_setup_arch(void)
  {
+#if defined(CONFIG_MTD) && defined(CONFIG_MTD_PHYSMAP)
+	bd_t *binfo = (bd_t *)__res;
+#endif
  	/* Print out Vendor and Machine info. */
  	printk(KERN_INFO "%s %s port\n", CPUINFO_VENDOR, CPUINFO_MACHINE);

@@ -64,7 +123,17 @@ m8260_setup_arch(void)
  #endif

  	identify_ppc_sys_by_name_and_id(BOARD_CHIP_NAME,
-				in_be32(CPM_MAP_ADDR + CPM_IMMR_OFFSET));
+				in_be32((void*)(CPM_MAP_ADDR + CPM_IMMR_OFFSET)));
+
+#if defined (CONFIG_ADS8272) || defined (CONFIG_PQ2FADS)
+#if defined(CONFIG_MTD_PHYSMAP)
+	physmap_configure(binfo->bi_flashstart, binfo->bi_flashsize,
+						PQ2FADS_BANK_WIDTH, NULL);
+#ifdef CONFIG_MTD_PARTITIONS	
+	physmap_set_partitions(pq2fads_partitions, pq2fads_part_num);
+#endif /* CONFIG_MTD_PARTITIONS */
+#endif /* CONFIG_MTD_PHYSMAP */
+#endif

  	m82xx_board_setup();
  }
