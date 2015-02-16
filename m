Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0137.outbound.protection.outlook.com [207.46.100.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A9101A0F1E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 02:51:30 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v2 05/10] fsl_bman: Add self-tester
Date: Mon, 16 Feb 2015 09:46:16 -0600
Message-ID: <1424101581-22109-6-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Geoff Thorpe <Geoff.Thorpe@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Geoff Thorpe <Geoff.Thorpe@freescale.com>

Change-Id: If1b44bb013addc1e855c73a4e6ff74bc8b6e4829
Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
---
 drivers/soc/freescale/Kconfig            |  26 ++++
 drivers/soc/freescale/Makefile           |   8 +-
 drivers/soc/freescale/bman.c             |  16 +--
 drivers/soc/freescale/bman_api.c         |  14 +--
 drivers/soc/freescale/bman_portal.c      |  18 +--
 drivers/soc/freescale/bman_priv.h        |   2 +-
 drivers/soc/freescale/bman_test.c        |  56 +++++++++
 drivers/soc/freescale/bman_test.h        |  44 +++++++
 drivers/soc/freescale/bman_test_api.c    | 181 ++++++++++++++++++++++++++++
 drivers/soc/freescale/bman_test_thresh.c | 196 +++++++++++++++++++++++++++++++
 drivers/soc/freescale/dpaa_alloc.c       |   2 +-
 drivers/soc/freescale/dpaa_sys.h         |   2 +-
 drivers/soc/freescale/qman.c             |  26 ++--
 drivers/soc/freescale/qman_api.c         |  18 +--
 drivers/soc/freescale/qman_portal.c      |  18 +--
 drivers/soc/freescale/qman_priv.h        |   2 +-
 include/linux/fsl_bman.h                 |  10 +-
 include/linux/fsl_qman.h                 |  18 +--
 18 files changed, 582 insertions(+), 75 deletions(-)
 create mode 100644 drivers/soc/freescale/bman_test.c
 create mode 100644 drivers/soc/freescale/bman_test.h
 create mode 100644 drivers/soc/freescale/bman_test_api.c
 create mode 100644 drivers/soc/freescale/bman_test_thresh.c

diff --git a/drivers/soc/freescale/Kconfig b/drivers/soc/freescale/Kconfig
index 9329c5c..6786b94 100644
--- a/drivers/soc/freescale/Kconfig
+++ b/drivers/soc/freescale/Kconfig
@@ -47,6 +47,32 @@ config FSL_BMAN_CONFIG
 	  linux image is running as a guest OS under the hypervisor, only one
 	  guest OS ("the control plane") needs this option.
 
+config FSL_BMAN_TEST
+	tristate "BMan self-tests"
+	default n
+	---help---
+	  This option compiles self-test code for BMan.
+
+config FSL_BMAN_TEST_HIGH
+	bool "BMan high-level self-test"
+	depends on FSL_BMAN_TEST
+	default y
+	---help---
+	  This requires the presence of cpu-affine portals, and performs
+	  high-level API testing with them (whichever portal(s) are affine to
+	  the cpu(s) the test executes on).
+
+config FSL_BMAN_TEST_THRESH
+	bool "BMan threshold test"
+	depends on FSL_BMAN_TEST
+	default y
+	---help---
+	  Multi-threaded (SMP) test of BMan pool depletion. A pool is seeded
+	  before multiple threads (one per cpu) create pool objects to track
+	  depletion state changes. The pool is then drained to empty by a
+	  "drainer" thread, and the other threads that they observe exactly
+	  the depletion state changes that are expected.
+
 endif # FSL_BMAN
 
 config FSL_QMAN
diff --git a/drivers/soc/freescale/Makefile b/drivers/soc/freescale/Makefile
index 69be592..09f31b0 100644
--- a/drivers/soc/freescale/Makefile
+++ b/drivers/soc/freescale/Makefile
@@ -2,10 +2,14 @@
 obj-$(CONFIG_FSL_DPA)				+= dpaa_alloc.o
 obj-$(CONFIG_HAS_FSL_QBMAN)			+= qbman_driver.o
 
-# Bman
+# BMan
 obj-$(CONFIG_FSL_BMAN)				+= bman_api.o
 obj-$(CONFIG_FSL_BMAN_CONFIG)			+= bman.o bman_portal.o
+obj-$(CONFIG_FSL_BMAN_TEST)			+= bman_tester.o
+bman_tester-y					 = bman_test.o
+bman_tester-$(CONFIG_FSL_BMAN_TEST_API)		+= bman_test_api.o
+bman_tester-$(CONFIG_FSL_BMAN_TEST_THRESH)	+= bman_test_thresh.o
 
-# Qman
+# QMan
 obj-$(CONFIG_FSL_QMAN)				+= qman_api.o qman_utils.o
 obj-$(CONFIG_FSL_QMAN_CONFIG)			+= qman.o qman_portal.o
diff --git a/drivers/soc/freescale/bman.c b/drivers/soc/freescale/bman.c
index fba6ae0..66986f2 100644
--- a/drivers/soc/freescale/bman.c
+++ b/drivers/soc/freescale/bman.c
@@ -275,7 +275,7 @@ static int __init fsl_bman_init(struct device_node *node)
 	BUG_ON(!bm);
 	bm_node = node;
 	bm_get_version(bm, &id, &major, &minor);
-	pr_info("Bman ver:%04x,%02x,%02x\n", id, major, minor);
+	pr_info("BMan ver:%04x,%02x,%02x\n", id, major, minor);
 	if ((major == 1) && (minor == 0)) {
 		bman_ip_rev = BMAN_REV10;
 		bman_pool_max = 64;
@@ -286,7 +286,7 @@ static int __init fsl_bman_init(struct device_node *node)
 		bman_ip_rev = BMAN_REV21;
 		bman_pool_max = 64;
 	} else {
-		pr_warn("unknown Bman version, default to rev1.0\n");
+		pr_warn("unknown BMan version, default to rev1.0\n");
 	}
 
 	return 0;
@@ -330,7 +330,7 @@ static void log_edata_bits(u32 bit_count)
 {
 	u32 i, j, mask = 0xffffffff;
 
-	pr_warn("Bman ErrInt, EDATA:\n");
+	pr_warn("BMan ErrInt, EDATA:\n");
 	i = bit_count/32;
 	if (bit_count%32) {
 		i++;
@@ -351,13 +351,13 @@ static void log_additional_error_info(u32 isr_val, u32 ecsr_val)
 	ecir_val.ecir_raw = bm_in(ECIR);
 	/* Is portal info valid */
 	if (ecsr_val & PORTAL_ECSR_ERR) {
-		pr_warn("Bman ErrInt: SWP id %d, numb %d, pid %d\n",
+		pr_warn("BMan ErrInt: SWP id %d, numb %d, pid %d\n",
 			ecir_val.info.portal_num, ecir_val.info.numb,
 			ecir_val.info.pid);
 	}
 	if (ecsr_val & (BM_EIRQ_SBEI|BM_EIRQ_MBEI)) {
 		eadr_val.eadr_raw = bm_in(EADR);
-		pr_warn("Bman ErrInt: EADR Memory: %s, 0x%x\n",
+		pr_warn("BMan ErrInt: EADR Memory: %s, 0x%x\n",
 			error_mdata[eadr_val.info.memid].txt,
 			error_mdata[eadr_val.info.memid].addr_mask
 				& eadr_val.info.eadr);
@@ -365,7 +365,7 @@ static void log_additional_error_info(u32 isr_val, u32 ecsr_val)
 	}
 }
 
-/* Bman interrupt handler */
+/* BMan interrupt handler */
 static irqreturn_t bman_isr(int irq, void *ptr)
 {
 	u32 isr_val, ier_val, ecsr_val, isr_mask, i;
@@ -379,14 +379,14 @@ static irqreturn_t bman_isr(int irq, void *ptr)
 		return IRQ_NONE;
 	for (i = 0; i < BMAN_HWE_COUNT; i++) {
 		if (bman_hwerr_txts[i].mask & isr_mask) {
-			pr_warn("Bman ErrInt: %s\n", bman_hwerr_txts[i].txt);
+			pr_warn("BMan ErrInt: %s\n", bman_hwerr_txts[i].txt);
 			if (bman_hwerr_txts[i].mask & ecsr_val) {
 				log_additional_error_info(isr_mask, ecsr_val);
 				/* Re-arm error capture registers */
 				bm_out(ECSR, ecsr_val);
 			}
 			if (bman_hwerr_txts[i].mask & BMAN_ERRS_TO_UNENABLE) {
-				pr_devel("Bman un-enabling error 0x%x\n",
+				pr_devel("BMan un-enabling error 0x%x\n",
 					bman_hwerr_txts[i].mask);
 				ier_val &= ~bman_hwerr_txts[i].mask;
 				bm_err_isr_enable_write(bm, ier_val);
diff --git a/drivers/soc/freescale/bman_api.c b/drivers/soc/freescale/bman_api.c
index ab16f16..7bb4840 100644
--- a/drivers/soc/freescale/bman_api.c
+++ b/drivers/soc/freescale/bman_api.c
@@ -66,8 +66,8 @@ struct bman_portal {
 };
 
 /* For an explanation of the locking, redirection, or affine-portal logic,
- * please consult the Qman driver for details. This is the same, only simpler
- * (no fiddly Qman-specific bits.) */
+ * please consult the QMan driver for details. This is the same, only simpler
+ * (no fiddly QMan-specific bits.) */
 #ifdef CONFIG_FSL_DPA_PORTAL_SHARE
 #define PORTAL_IRQ_LOCK(p, irqflags) \
 	do { \
@@ -118,7 +118,7 @@ static inline struct bman_portal *get_poll_portal(void)
 #define put_poll_portal()
 
 /* GOTCHA: this object type refers to a pool, it isn't *the* pool. There may be
- * more than one such object per Bman buffer pool, eg. if different users of the
+ * more than one such object per BMan buffer pool, eg. if different users of the
  * pool are operating via different portals. */
 struct bman_pool {
 	struct bman_pool_params params;
@@ -219,15 +219,15 @@ struct bman_portal *bman_create_portal(
 	__p->addr.addr_ce = config->addr_virt[DPA_PORTAL_CE];
 	__p->addr.addr_ci = config->addr_virt[DPA_PORTAL_CI];
 	if (bm_rcr_init(__p, bm_rcr_pvb, bm_rcr_cce)) {
-		pr_err("Bman RCR initialisation failed\n");
+		pr_err("BMan RCR initialisation failed\n");
 		goto fail_rcr;
 	}
 	if (bm_mc_init(__p)) {
-		pr_err("Bman MC initialisation failed\n");
+		pr_err("BMan MC initialisation failed\n");
 		goto fail_mc;
 	}
 	if (bm_isr_init(__p)) {
-		pr_err("Bman ISR initialisation failed\n");
+		pr_err("BMan ISR initialisation failed\n");
 		goto fail_isr;
 	}
 	portal->pools = kmalloc(2 * sizeof(*pools), GFP_KERNEL);
@@ -273,7 +273,7 @@ struct bman_portal *bman_create_portal(
 	/* Need RCR to be empty before continuing */
 	ret = bm_rcr_get_fill(__p);
 	if (ret) {
-		pr_err("Bman RCR unclean\n");
+		pr_err("BMan RCR unclean\n");
 		goto fail_rcr_empty;
 	}
 	/* Success */
diff --git a/drivers/soc/freescale/bman_portal.c b/drivers/soc/freescale/bman_portal.c
index 1c67065..a91081c 100644
--- a/drivers/soc/freescale/bman_portal.c
+++ b/drivers/soc/freescale/bman_portal.c
@@ -134,12 +134,12 @@ static struct bman_portal * __init init_pcfg(struct bm_portal_config *pcfg)
 #ifdef CONFIG_FSL_DPA_PIRQ_SLOW
 		bman_p_irqsource_add(p, BM_PIRQ_RCRI | BM_PIRQ_BSCN);
 #endif
-		pr_info("Bman portal %s initialised, cpu %d\n",
+		pr_info("BMan portal %s initialised, cpu %d\n",
 			pcfg->public_cfg.is_shared ? "(shared) " : "",
 			pcfg->public_cfg.cpu);
 		affine_bportals[pcfg->public_cfg.cpu] = p;
 	} else
-		pr_crit("Bman portal failure on cpu %d\n",
+		pr_crit("BMan portal failure on cpu %d\n",
 			pcfg->public_cfg.cpu);
 
 	return p;
@@ -151,9 +151,9 @@ static void __init init_slave(int cpu)
 
 	p = bman_create_affine_slave(shared_portals[shared_portals_idx++], cpu);
 	if (!p)
-		pr_err("Bman slave portal failure on cpu %d\n", cpu);
+		pr_err("BMan slave portal failure on cpu %d\n", cpu);
 	else
-		pr_info("Bman portal %s initialised, cpu %d\n", "(slave) ", cpu);
+		pr_info("BMan portal %s initialised, cpu %d\n", "(slave) ", cpu);
 	if (shared_portals_idx >= num_shared_portals)
 		shared_portals_idx = 0;
 	affine_bportals[cpu] = p;
@@ -192,7 +192,7 @@ static void bman_offline_cpu(unsigned int cpu)
 	}
 }
 
-/* Initialise the Bman driver. The meat of this function deals with portals. The
+/* Initialise the BMan driver. The meat of this function deals with portals. The
  * following describes the flow of portal-handling, the code "steps" refer to
  * this description;
  * 1. Portal configs are parsed from the device-tree into 'unused_pcfgs', with
@@ -231,12 +231,12 @@ int __init bman_init(void)
 	int cpu;
 	struct cpumask offline_cpus;
 
-	/* Initialise the Bman (CCSR) device */
+	/* Initialise the BMan (CCSR) device */
 	for_each_compatible_node(dn, NULL, "fsl,bman") {
 		if (!bman_init_ccsr(dn))
-			pr_info("Bman err interrupt handler present\n");
+			pr_info("BMan err interrupt handler present\n");
 		else
-			pr_err("Bman CCSR setup failed\n");
+			pr_err("BMan CCSR setup failed\n");
 	}
 	/* Step 1. See comments at the beginning of the file. */
 	for_each_compatible_node(dn, NULL, "fsl,bman-portal") {
@@ -321,7 +321,7 @@ int __init bman_init(void)
 	if (!cpumask_empty(&slave_cpus))
 		for_each_cpu(cpu, &slave_cpus)
 			init_slave(cpu);
-	pr_info("Bman portals initialised\n");
+	pr_info("BMan portals initialised\n");
 	cpumask_andnot(&offline_cpus, cpu_possible_mask, cpu_online_mask);
 	for_each_cpu(cpu, &offline_cpus)
 		bman_offline_cpu(cpu);
diff --git a/drivers/soc/freescale/bman_priv.h b/drivers/soc/freescale/bman_priv.h
index a183cc6..842ec37 100644
--- a/drivers/soc/freescale/bman_priv.h
+++ b/drivers/soc/freescale/bman_priv.h
@@ -131,7 +131,7 @@ int bman_have_ccsr(void);
 
 #ifdef CONFIG_FSL_BMAN_CONFIG
 /* Set depletion thresholds associated with a buffer pool. Requires that the
- * operating system have access to Bman CCSR (ie. compiled in support and
+ * operating system have access to BMan CCSR (ie. compiled in support and
  * run-time access courtesy of the device-tree). */
 int bm_pool_set(u32 bpid, const u32 *thresholds);
 #define BM_POOL_THRESH_SW_ENTER 0
diff --git a/drivers/soc/freescale/bman_test.c b/drivers/soc/freescale/bman_test.c
new file mode 100644
index 0000000..350f2f8
--- /dev/null
+++ b/drivers/soc/freescale/bman_test.c
@@ -0,0 +1,56 @@
+/* Copyright 2008-2011 Freescale Semiconductor, Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "bman_test.h"
+
+MODULE_AUTHOR("Geoff Thorpe");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("BMan testing");
+
+static int test_init(void)
+{
+#ifdef CONFIG_FSL_BMAN_TEST_HIGH
+	int loop = 1;
+	while (loop--)
+		bman_test_api();
+#endif
+#ifdef CONFIG_FSL_BMAN_TEST_THRESH
+	bman_test_thresh();
+#endif
+	return 0;
+}
+
+static void test_exit(void)
+{
+}
+
+module_init(test_init);
+module_exit(test_exit);
diff --git a/drivers/soc/freescale/bman_test.h b/drivers/soc/freescale/bman_test.h
new file mode 100644
index 0000000..a0f5147
--- /dev/null
+++ b/drivers/soc/freescale/bman_test.h
@@ -0,0 +1,44 @@
+/* Copyright 2008-2011 Freescale Semiconductor, Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+
+#include <linux/fsl_bman.h>
+
+void bman_test_api(void);
+void bman_test_thresh(void);
diff --git a/drivers/soc/freescale/bman_test_api.c b/drivers/soc/freescale/bman_test_api.c
new file mode 100644
index 0000000..467cde7
--- /dev/null
+++ b/drivers/soc/freescale/bman_test_api.c
@@ -0,0 +1,181 @@
+/* Copyright 2008-2011 Freescale Semiconductor, Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "bman_test.h"
+#include "bman_priv.h"
+
+/*************/
+/* constants */
+/*************/
+
+#define PORTAL_OPAQUE	((void *)0xf00dbeef)
+#define POOL_OPAQUE	((void *)0xdeadabba)
+#define NUM_BUFS	93
+#define LOOPS		3
+#define BMAN_TOKEN_MASK 0x00FFFFFFFFFFLLU
+
+/***************/
+/* global vars */
+/***************/
+
+static struct bman_pool *pool;
+static int depleted;
+static struct bm_buffer bufs_in[NUM_BUFS] ____cacheline_aligned;
+static struct bm_buffer bufs_out[NUM_BUFS] ____cacheline_aligned;
+static int bufs_received;
+
+/* Predeclare the callback so we can instantiate pool parameters */
+static void depletion_cb(struct bman_portal *, struct bman_pool *, void *, int);
+
+/**********************/
+/* internal functions */
+/**********************/
+
+static void bufs_init(void)
+{
+	int i;
+	for (i = 0; i < NUM_BUFS; i++)
+		bm_buffer_set64(&bufs_in[i], 0xfedc01234567LLU * i);
+	bufs_received = 0;
+}
+
+static inline int bufs_cmp(const struct bm_buffer *a, const struct bm_buffer *b)
+{
+	if ((bman_ip_rev == BMAN_REV20) || (bman_ip_rev == BMAN_REV21)) {
+
+		/* On SoCs with BMan revison 2.0, BMan only respects the 40
+		 * LS-bits of buffer addresses, masking off the upper 8-bits on
+		 * release commands. The API provides for 48-bit addresses
+		 * because some SoCs support all 48-bits. When generating
+		 * garbage addresses for testing, we either need to zero the
+		 * upper 8-bits when releasing to BMan (otherwise we'll be
+		 * disappointed when the buffers we acquire back from BMan
+		 * don't match), or we need to mask the upper 8-bits off when
+		 * comparing. We do the latter.
+		 */
+		if ((bm_buffer_get64(a) & BMAN_TOKEN_MASK)
+				< (bm_buffer_get64(b) & BMAN_TOKEN_MASK))
+			return -1;
+		if ((bm_buffer_get64(a) & BMAN_TOKEN_MASK)
+				> (bm_buffer_get64(b) & BMAN_TOKEN_MASK))
+			return 1;
+	} else {
+		if (bm_buffer_get64(a) < bm_buffer_get64(b))
+			return -1;
+		if (bm_buffer_get64(a) > bm_buffer_get64(b))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void bufs_confirm(void)
+{
+	int i, j;
+	for (i = 0; i < NUM_BUFS; i++) {
+		int matches = 0;
+		for (j = 0; j < NUM_BUFS; j++)
+			if (!bufs_cmp(&bufs_in[i], &bufs_out[j]))
+				matches++;
+		BUG_ON(matches != 1);
+	}
+}
+
+/********/
+/* test */
+/********/
+
+static void depletion_cb(struct bman_portal *__portal, struct bman_pool *__pool,
+			void *pool_ctx, int __depleted)
+{
+	BUG_ON(__pool != pool);
+	BUG_ON(pool_ctx != POOL_OPAQUE);
+	depleted = __depleted;
+}
+
+void bman_test_api(void)
+{
+	struct bman_pool_params pparams = {
+		.flags = BMAN_POOL_FLAG_DEPLETION | BMAN_POOL_FLAG_DYNAMIC_BPID,
+		.cb = depletion_cb,
+		.cb_ctx = POOL_OPAQUE,
+	};
+	int i, loops = LOOPS;
+
+	bufs_init();
+
+	pr_info("BMAN:	--- starting high-level test ---\n");
+
+	pool = bman_new_pool(&pparams);
+	BUG_ON(!pool);
+
+	/*******************/
+	/* Release buffers */
+	/*******************/
+do_loop:
+	i = 0;
+	while (i < NUM_BUFS) {
+		u32 flags = BMAN_RELEASE_FLAG_WAIT;
+		int num = 8;
+		if ((i + num) > NUM_BUFS)
+			num = NUM_BUFS - i;
+		if ((i + num) == NUM_BUFS)
+			flags |= BMAN_RELEASE_FLAG_WAIT_SYNC;
+		if (bman_release(pool, bufs_in + i, num, flags))
+			panic("bman_release() failed\n");
+		i += num;
+	}
+
+	/*******************/
+	/* Acquire buffers */
+	/*******************/
+	while (i > 0) {
+		int tmp, num = 8;
+		if (num > i)
+			num = i;
+		tmp = bman_acquire(pool, bufs_out + i - num, num, 0);
+		BUG_ON(tmp != num);
+		i -= num;
+	}
+	i = bman_acquire(pool, NULL, 1, 0);
+	BUG_ON(i > 0);
+
+	bufs_confirm();
+
+	if (--loops)
+		goto do_loop;
+
+	/************/
+	/* Clean up */
+	/************/
+	bman_free_pool(pool);
+	pr_info("BMAN:	--- finished high-level test ---\n");
+}
diff --git a/drivers/soc/freescale/bman_test_thresh.c b/drivers/soc/freescale/bman_test_thresh.c
new file mode 100644
index 0000000..c03db24
--- /dev/null
+++ b/drivers/soc/freescale/bman_test_thresh.c
@@ -0,0 +1,196 @@
+/* Copyright 2010-2011 Freescale Semiconductor, Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "bman_test.h"
+
+/* Test constants */
+#define TEST_NUMBUFS	129728
+#define TEST_EXIT	129536
+#define TEST_ENTRY	129024
+
+struct affine_test_data {
+	struct task_struct *t;
+	int cpu;
+	int expect_affinity;
+	int drain;
+	int num_enter;
+	int num_exit;
+	struct list_head node;
+	struct completion wakethread;
+	struct completion wakeparent;
+};
+
+static void cb_depletion(struct bman_portal *portal,
+			struct bman_pool *pool,
+			void *opaque,
+			int depleted)
+{
+	struct affine_test_data *data = opaque;
+	int c = smp_processor_id();
+	pr_info("cb_depletion: bpid=%d, depleted=%d, cpu=%d, original=%d\n",
+		bman_get_params(pool)->bpid, !!depleted, c, data->cpu);
+	/* We should be executing on the CPU of the thread that owns the pool if
+	 * and that CPU has an affine portal (ie. it isn't slaved). */
+	BUG_ON((c != data->cpu) && data->expect_affinity);
+	BUG_ON((c == data->cpu) && !data->expect_affinity);
+	if (depleted)
+		data->num_enter++;
+	else
+		data->num_exit++;
+}
+
+/* Params used to set up a pool, this also dynamically allocates a BPID */
+static const struct bman_pool_params params_nocb = {
+	.flags = BMAN_POOL_FLAG_DYNAMIC_BPID | BMAN_POOL_FLAG_THRESH,
+	.thresholds = { TEST_ENTRY, TEST_EXIT, 0, 0 }
+};
+
+/* Params used to set up each cpu's pool with callbacks enabled */
+static struct bman_pool_params params_cb = {
+	.bpid = 0, /* will be replaced to match pool_nocb */
+	.flags = BMAN_POOL_FLAG_DEPLETION,
+	.cb = cb_depletion
+};
+
+static struct bman_pool *pool_nocb;
+static LIST_HEAD(threads);
+
+static int affine_test(void *__data)
+{
+	struct bman_pool *pool;
+	struct affine_test_data *data = __data;
+	struct bman_pool_params my_params = params_cb;
+
+	pr_info("thread %d: starting\n", data->cpu);
+	/* create the pool */
+	my_params.cb_ctx = data;
+	pool = bman_new_pool(&my_params);
+	BUG_ON(!pool);
+	complete(&data->wakeparent);
+	wait_for_completion(&data->wakethread);
+	init_completion(&data->wakethread);
+
+	/* if we're the drainer, we get signalled for that */
+	if (data->drain) {
+		struct bm_buffer buf;
+		int ret;
+		pr_info("thread %d: draining...\n", data->cpu);
+		do {
+			ret = bman_acquire(pool, &buf, 1, 0);
+		} while (ret > 0);
+		pr_info("thread %d: draining done.\n", data->cpu);
+		complete(&data->wakeparent);
+		wait_for_completion(&data->wakethread);
+		init_completion(&data->wakethread);
+	}
+
+	/* cleanup */
+	bman_free_pool(pool);
+	while (!kthread_should_stop())
+		cpu_relax();
+	pr_info("thread %d: exiting\n", data->cpu);
+	return 0;
+}
+
+static struct affine_test_data *start_affine_test(int cpu, int drain)
+{
+	struct affine_test_data *data = kmalloc(sizeof(*data), GFP_KERNEL);
+
+	if (!data)
+		return NULL;
+	data->cpu = cpu;
+	data->expect_affinity = cpumask_test_cpu(cpu, bman_affine_cpus());
+	data->drain = drain;
+	data->num_enter = 0;
+	data->num_exit = 0;
+	init_completion(&data->wakethread);
+	init_completion(&data->wakeparent);
+	list_add_tail(&data->node, &threads);
+	data->t = kthread_create(affine_test, data, "threshtest%d", cpu);
+	BUG_ON(IS_ERR(data->t));
+	kthread_bind(data->t, cpu);
+	wake_up_process(data->t);
+	return data;
+}
+
+void bman_test_thresh(void)
+{
+	int loop = TEST_NUMBUFS;
+	int ret, num_cpus = 0;
+	struct affine_test_data *data, *drainer = NULL;
+
+	pr_info("bman_test_thresh: start\n");
+
+	/* allocate a BPID and seed it */
+	pool_nocb = bman_new_pool(&params_nocb);
+	BUG_ON(!pool_nocb);
+	while (loop--) {
+		struct bm_buffer buf;
+		bm_buffer_set64(&buf, 0x0badbeef + loop);
+		ret = bman_release(pool_nocb, &buf, 1,
+					BMAN_RELEASE_FLAG_WAIT);
+		BUG_ON(ret);
+	}
+	while (!bman_rcr_is_empty())
+		cpu_relax();
+	pr_info("bman_test_thresh: buffers are in\n");
+
+	/* create threads and wait for them to create pools */
+	params_cb.bpid = bman_get_params(pool_nocb)->bpid;
+	for_each_cpu(loop, cpu_online_mask) {
+		data = start_affine_test(loop, drainer ? 0 : 1);
+		BUG_ON(!data);
+		if (!drainer)
+			drainer = data;
+		num_cpus++;
+		wait_for_completion(&data->wakeparent);
+	}
+
+	/* signal the drainer to start draining */
+	complete(&drainer->wakethread);
+	wait_for_completion(&drainer->wakeparent);
+	init_completion(&drainer->wakeparent);
+
+	/* tear down */
+	list_for_each_entry_safe(data, drainer, &threads, node) {
+		complete(&data->wakethread);
+		ret = kthread_stop(data->t);
+		BUG_ON(ret);
+		list_del(&data->node);
+		/* check that we get the expected callbacks (and no others) */
+		BUG_ON(data->num_enter != 1);
+		BUG_ON(data->num_exit != 0);
+		kfree(data);
+	}
+	bman_free_pool(pool_nocb);
+
+	pr_info("bman_test_thresh: done\n");
+}
diff --git a/drivers/soc/freescale/dpaa_alloc.c b/drivers/soc/freescale/dpaa_alloc.c
index 0215477..88a4786 100644
--- a/drivers/soc/freescale/dpaa_alloc.c
+++ b/drivers/soc/freescale/dpaa_alloc.c
@@ -365,7 +365,7 @@ static u32 release_id_range(struct dpa_alloc *alloc, u32 id, u32 count,
 	return total_invalid;
 }
 
-/* Bman APIs are front-ends to the common code */
+/* BMan APIs are front-ends to the common code */
 
 #ifdef CONFIG_FSL_BMAN
 static DECLARE_DPA_ALLOC(bpalloc); /* BPID allocator */
diff --git a/drivers/soc/freescale/dpaa_sys.h b/drivers/soc/freescale/dpaa_sys.h
index 86b280c..6631b2a 100644
--- a/drivers/soc/freescale/dpaa_sys.h
+++ b/drivers/soc/freescale/dpaa_sys.h
@@ -240,7 +240,7 @@ static inline type *name##_find(struct dpa_rbtree *tree, u32 val) \
 /* Bootargs */
 /************/
 
-/* Qman has "qportals=" and Bman has "bportals=", they use the same syntax
+/* QMan has "qportals=" and BMan has "bportals=", they use the same syntax
  * though; a comma-separated list of items, each item being a cpu index and/or a
  * range of cpu indices, and each item optionally be prefixed by "s" to indicate
  * that the portal associated with that cpu should be shared. See bman_driver.c
diff --git a/drivers/soc/freescale/qman.c b/drivers/soc/freescale/qman.c
index 3d7d02e..f791884 100644
--- a/drivers/soc/freescale/qman.c
+++ b/drivers/soc/freescale/qman.c
@@ -259,7 +259,7 @@ static const struct qman_error_info_mdata error_mdata[] = {
 /*
  * TODO: unimplemented registers
  *
- * Keeping a list here of Qman registers I have not yet covered;
+ * Keeping a list here of QMan registers I have not yet covered;
  * QCSP_DD_IHRSR, QCSP_DD_IHRFR, QCSP_DD_HASR,
  * DCP_DD_IHRSR, DCP_DD_IHRFR, DCP_DD_HASR, CM_CFG,
  * QMAN_EECC, QMAN_SBET, QMAN_EINJ, QMAN_SBEC0-12
@@ -476,7 +476,7 @@ static int __init fsl_qman_init(struct device_node *node)
 	qm = qm_create(regs);
 	qm_node = node;
 	qm_get_version(qm, &id, &major, &minor);
-	pr_info("Qman ver:%04x,%02x,%02x\n", id, major, minor);
+	pr_info("QMan ver:%04x,%02x,%02x\n", id, major, minor);
 	if (!qman_ip_rev) {
 		if ((major == 1) && (minor == 0)) {
 			pr_err("QMAN rev1.0 on P4080 rev1 is not supported!\n");
@@ -493,7 +493,7 @@ static int __init fsl_qman_init(struct device_node *node)
 		else if ((major == 3) && (minor == 1))
 			qman_ip_rev = QMAN_REV31;
 		else {
-			pr_warn("unknown Qman version, default to rev1.1\n");
+			pr_warn("unknown QMan version, default to rev1.1\n");
 			qman_ip_rev = QMAN_REV11;
 		}
 	}
@@ -529,7 +529,7 @@ static void log_edata_bits(u32 bit_count)
 {
 	u32 i, j, mask = 0xffffffff;
 
-	pr_warn("Qman ErrInt, EDATA:\n");
+	pr_warn("QMan ErrInt, EDATA:\n");
 	i = bit_count/32;
 	if (bit_count%32) {
 		i++;
@@ -553,17 +553,17 @@ static void log_additional_error_info(u32 isr_val, u32 ecsr_val)
 		union qman_ecir2 ecir2_val;
 		ecir2_val.ecir2_raw = qm_in(ECIR2);
 		if (ecsr_val & PORTAL_ECSR_ERR) {
-			pr_warn("Qman ErrInt: %s id %d\n",
+			pr_warn("QMan ErrInt: %s id %d\n",
 				(ecir2_val.info.portal_type) ?
 				"DCP" : "SWP", ecir2_val.info.portal_num);
 		}
 		if (ecsr_val & (FQID_ECSR_ERR | QM_EIRQ_IECE)) {
-			pr_warn("Qman ErrInt: ecir.fqid 0x%x\n",
+			pr_warn("QMan ErrInt: ecir.fqid 0x%x\n",
 				ecir_val.info.fqid);
 		}
 		if (ecsr_val & (QM_EIRQ_SBEI|QM_EIRQ_MBEI)) {
 			eadr_val.eadr_raw = qm_in(EADR);
-			pr_warn("Qman ErrInt: EADR Memory: %s, 0x%x\n",
+			pr_warn("QMan ErrInt: EADR Memory: %s, 0x%x\n",
 				error_mdata[eadr_val.info_rev3.memid].txt,
 				error_mdata[eadr_val.info_rev3.memid].addr_mask
 					& eadr_val.info_rev3.eadr);
@@ -572,17 +572,17 @@ static void log_additional_error_info(u32 isr_val, u32 ecsr_val)
 		}
 	} else {
 		if (ecsr_val & PORTAL_ECSR_ERR) {
-			pr_warn("Qman ErrInt: %s id %d\n",
+			pr_warn("QMan ErrInt: %s id %d\n",
 				(ecir_val.info.portal_type) ?
 				"DCP" : "SWP", ecir_val.info.portal_num);
 		}
 		if (ecsr_val & FQID_ECSR_ERR) {
-			pr_warn("Qman ErrInt: ecir.fqid 0x%x\n",
+			pr_warn("QMan ErrInt: ecir.fqid 0x%x\n",
 				ecir_val.info.fqid);
 		}
 		if (ecsr_val & (QM_EIRQ_SBEI|QM_EIRQ_MBEI)) {
 			eadr_val.eadr_raw = qm_in(EADR);
-			pr_warn("Qman ErrInt: EADR Memory: %s, 0x%x\n",
+			pr_warn("QMan ErrInt: EADR Memory: %s, 0x%x\n",
 				error_mdata[eadr_val.info.memid].txt,
 				error_mdata[eadr_val.info.memid].addr_mask
 					& eadr_val.info.eadr);
@@ -591,7 +591,7 @@ static void log_additional_error_info(u32 isr_val, u32 ecsr_val)
 	}
 }
 
-/* Qman interrupt handler */
+/* QMan interrupt handler */
 static irqreturn_t qman_isr(int irq, void *ptr)
 {
 	u32 isr_val, ier_val, ecsr_val, isr_mask, i;
@@ -605,14 +605,14 @@ static irqreturn_t qman_isr(int irq, void *ptr)
 		return IRQ_NONE;
 	for (i = 0; i < QMAN_HWE_COUNT; i++) {
 		if (qman_hwerr_txts[i].mask & isr_mask) {
-			pr_warn("Qman ErrInt: %s\n", qman_hwerr_txts[i].txt);
+			pr_warn("QMan ErrInt: %s\n", qman_hwerr_txts[i].txt);
 			if (qman_hwerr_txts[i].mask & ecsr_val) {
 				log_additional_error_info(isr_mask, ecsr_val);
 				/* Re-arm error capture registers */
 				qm_out(ECSR, ecsr_val);
 			}
 			if (qman_hwerr_txts[i].mask & QMAN_ERRS_TO_UNENABLE) {
-				pr_devel("Qman un-enabling error 0x%x\n",
+				pr_devel("QMan un-enabling error 0x%x\n",
 					qman_hwerr_txts[i].mask);
 				ier_val &= ~qman_hwerr_txts[i].mask;
 				qm_err_isr_enable_write(qm, ier_val);
diff --git a/drivers/soc/freescale/qman_api.c b/drivers/soc/freescale/qman_api.c
index 2d980b3..08dbb36 100644
--- a/drivers/soc/freescale/qman_api.c
+++ b/drivers/soc/freescale/qman_api.c
@@ -388,24 +388,24 @@ struct qman_portal *qman_create_portal(
 	 */
 	if (qm_eqcr_init(__p, qm_eqcr_pvb,
 			portal->use_eqcr_ci_stashing ? 3 : 0, 1)) {
-		pr_err("Qman EQCR initialisation failed\n");
+		pr_err("QMan EQCR initialisation failed\n");
 		goto fail_eqcr;
 	}
 	if (qm_dqrr_init(__p, config, qm_dqrr_dpush, qm_dqrr_pvb,
 			qm_dqrr_cdc, DQRR_MAXFILL)) {
-		pr_err("Qman DQRR initialisation failed\n");
+		pr_err("QMan DQRR initialisation failed\n");
 		goto fail_dqrr;
 	}
 	if (qm_mr_init(__p, qm_mr_pvb, qm_mr_cci)) {
-		pr_err("Qman MR initialisation failed\n");
+		pr_err("QMan MR initialisation failed\n");
 		goto fail_mr;
 	}
 	if (qm_mc_init(__p)) {
-		pr_err("Qman MC initialisation failed\n");
+		pr_err("QMan MC initialisation failed\n");
 		goto fail_mc;
 	}
 	if (qm_isr_init(__p)) {
-		pr_err("Qman ISR initialisation failed\n");
+		pr_err("QMan ISR initialisation failed\n");
 		goto fail_isr;
 	}
 	/* static interrupt-gating controls */
@@ -473,20 +473,20 @@ struct qman_portal *qman_create_portal(
 	qm_isr_disable_write(__p, isdr);
 	ret = qm_eqcr_get_fill(__p);
 	if (ret) {
-		pr_err("Qman EQCR unclean\n");
+		pr_err("QMan EQCR unclean\n");
 		goto fail_eqcr_empty;
 	}
 	isdr ^= (QM_PIRQ_DQRI | QM_PIRQ_MRI);
 	qm_isr_disable_write(__p, isdr);
 	if (qm_dqrr_current(__p) != NULL) {
-		pr_err("Qman DQRR unclean\n");
+		pr_err("QMan DQRR unclean\n");
 		qm_dqrr_cdc_consume_n(__p, 0xffff);
 	}
 	if (qm_mr_current(__p) != NULL) {
 		/* special handling, drain just in case it's a few FQRNIs */
 		if (drain_mr_fqrni(__p)) {
 			const struct qm_mr_entry *e = qm_mr_current(__p);
-			pr_err("Qman MR unclean, MR VERB 0x%x, "
+			pr_err("QMan MR unclean, MR VERB 0x%x, "
 			       "rc 0x%x\n, addr 0x%x",
 			       e->verb, e->ern.rc, e->ern.fd.addr_lo);
 			goto fail_dqrr_mr_empty;
@@ -841,7 +841,7 @@ static noinline void clear_vdqcr(struct qman_portal *p, struct qman_fq *fq)
  * above potential conflicts, but that this function itself is not re-entrant
  * (this is because the function tracks one end of each FIFO in the portal and
  * we do *not* want to lock that). So the consequence is that it is safe for
- * user callbacks to call into any Qman API *except* qman_poll() (as that's the
+ * user callbacks to call into any QMan API *except* qman_poll() (as that's the
  * sole API that could be invoking the callback through this function).
  */
 static inline unsigned int __poll_portal_fast(struct qman_portal *p,
diff --git a/drivers/soc/freescale/qman_portal.c b/drivers/soc/freescale/qman_portal.c
index ac1b80f..7216de1 100644
--- a/drivers/soc/freescale/qman_portal.c
+++ b/drivers/soc/freescale/qman_portal.c
@@ -109,7 +109,7 @@ static void qman_get_ip_revision(struct device_node *dn)
 			if (ip_rev) {
 				qman_ip_rev = ip_rev;
 			} else {
-				pr_warn("unknown Qman version,"
+				pr_warn("unknown QMan version,"
 					" default to rev1.1\n");
 				qman_ip_rev = QMAN_REV11;
 			}
@@ -311,11 +311,11 @@ static struct qman_portal *init_pcfg(struct qm_portal_config *pcfg)
 		irq_sources |= QM_PIRQ_DQRI;
 #endif
 		qman_p_irqsource_add(p, irq_sources);
-		pr_info("Qman portal %sinitialised, cpu %d\n",
+		pr_info("QMan portal %sinitialised, cpu %d\n",
 			pcfg->public_cfg.is_shared ? "(shared) " : "",
 			pcfg->public_cfg.cpu);
 	} else
-		pr_crit("Qman portal failure on cpu %d\n",
+		pr_crit("QMan portal failure on cpu %d\n",
 			pcfg->public_cfg.cpu);
 	return p;
 }
@@ -327,9 +327,9 @@ static void init_slave(int cpu)
 	set_cpus_allowed_ptr(current, get_cpu_mask(cpu));
 	p = qman_create_affine_slave(shared_portals[shared_portals_idx++], cpu);
 	if (!p)
-		pr_err("Qman slave portal failure on cpu %d\n", cpu);
+		pr_err("QMan slave portal failure on cpu %d\n", cpu);
 	else
-		pr_info("Qman portal %sinitialised, cpu %d\n", "(slave) ", cpu);
+		pr_info("QMan portal %sinitialised, cpu %d\n", "(slave) ", cpu);
 	set_cpus_allowed_ptr(current, &oldmask);
 	if (shared_portals_idx >= num_shared_portals)
 		shared_portals_idx = 0;
@@ -397,12 +397,12 @@ __init int qman_init(void)
 #endif
 	struct cpumask offline_cpus;
 
-	/* Initialise the Qman (CCSR) device */
+	/* Initialise the QMan (CCSR) device */
 	for_each_compatible_node(dn, NULL, "fsl,qman") {
 		if (!qman_init_ccsr(dn))
-			pr_info("Qman err interrupt handler present\n");
+			pr_info("QMan err interrupt handler present\n");
 		else
-			pr_err("Qman CCSR setup failed\n");
+			pr_err("QMan CCSR setup failed\n");
 	}
 #ifdef CONFIG_FSL_QMAN_FQ_LOOKUP
 	/* Setup lookup table for FQ demux */
@@ -495,7 +495,7 @@ __init int qman_init(void)
 	if (!cpumask_empty(&slave_cpus))
 		for_each_cpu(cpu, &slave_cpus)
 			init_slave(cpu);
-	pr_info("Qman portals initialised\n");
+	pr_info("QMan portals initialised\n");
 	cpumask_andnot(&offline_cpus, cpu_possible_mask, cpu_online_mask);
 	for_each_cpu(cpu, &offline_cpus)
 		qman_offline_cpu(cpu);
diff --git a/drivers/soc/freescale/qman_priv.h b/drivers/soc/freescale/qman_priv.h
index da9021b..2a5fa2d 100644
--- a/drivers/soc/freescale/qman_priv.h
+++ b/drivers/soc/freescale/qman_priv.h
@@ -41,7 +41,7 @@
 	/* ----------------- */
 	/* Congestion Groups */
 	/* ----------------- */
-/* This wrapper represents a bit-array for the state of the 256 Qman congestion
+/* This wrapper represents a bit-array for the state of the 256 QMan congestion
  * groups. Is also used as a *mask* for congestion groups, eg. so we ignore
  * those that don't concern us. We harness the structure and accessor details
  * already used in the management command to query congestion groups. */
diff --git a/include/linux/fsl_bman.h b/include/linux/fsl_bman.h
index 16845d3..5883453 100644
--- a/include/linux/fsl_bman.h
+++ b/include/linux/fsl_bman.h
@@ -42,7 +42,7 @@ extern "C" {
 #define BM_PIRQ_RCRI	0x00000002	/* RCR Ring (below threshold) */
 #define BM_PIRQ_BSCN	0x00000001	/* Buffer depletion State Change */
 
-/* This wrapper represents a bit-array for the depletion state of the 64 Bman
+/* This wrapper represents a bit-array for the depletion state of the 64 BMan
  * buffer pools. */
 struct bman_depletion {
 	u32 __state[2];
@@ -74,7 +74,7 @@ static inline void bman_depletion_unset(struct bman_depletion *c, u8 bpid)
 }
 
 /* ------------------------------------------------------- */
-/* --- Bman data structures (and associated constants) --- */
+/* --- BMan data structures (and associated constants) --- */
 
 /* Represents s/w corenet portal mapped data structures */
 struct bm_rcr_entry;	/* RCR (Release Command Ring) entries */
@@ -204,7 +204,7 @@ struct bm_mc_result {
 /* Represents a managed portal */
 struct bman_portal;
 
-/* This object type represents Bman buffer pools. */
+/* This object type represents BMan buffer pools. */
 struct bman_pool;
 
 struct bman_portal_config {
@@ -241,7 +241,7 @@ struct bman_pool_params {
 	void *cb_ctx;
 	/* depletion-entry/exit thresholds, if BMAN_POOL_FLAG_THRESH is set. NB:
 	 * this is only allowed if BMAN_POOL_FLAG_DYNAMIC_BPID is used *and*
-	 * when run in the control plane (which controls Bman CCSR). This array
+	 * when run in the control plane (which controls BMan CCSR). This array
 	 * matches the definition of bm_pool_set(). */
 	u32 thresholds[4];
 };
@@ -350,7 +350,7 @@ void bman_poll(void);
  * bman_rcr_is_empty - Determine if portal's RCR is empty
  *
  * For use in situations where a cpu-affine caller needs to determine when all
- * releases for the local portal have been processed by Bman but can't use the
+ * releases for the local portal have been processed by BMan but can't use the
  * BMAN_RELEASE_FLAG_WAIT_SYNC flag to do this from the final bman_release().
  * The function forces tracking of RCR consumption (which normally doesn't
  * happen until release processing needs to find space to put new release
diff --git a/include/linux/fsl_qman.h b/include/linux/fsl_qman.h
index c12cbd3..f52e919 100644
--- a/include/linux/fsl_qman.h
+++ b/include/linux/fsl_qman.h
@@ -109,7 +109,7 @@ static inline u32 QM_SDQCR_CHANNELS_POOL_CONV(u16 channel)
 
 
 /* ------------------------------------------------------- */
-/* --- Qman data structures (and associated constants) --- */
+/* --- QMan data structures (and associated constants) --- */
 
 /* Represents s/w corenet portal mapped data structures */
 struct qm_eqcr_entry;	/* EQCR (EnQueue Command Ring) entries */
@@ -978,12 +978,12 @@ u32 qman_fqid_pool_used(struct qman_fqid_pool *pool);
 /* Represents a managed portal */
 struct qman_portal;
 
-/* This object type represents Qman frame queue descriptors (FQD), it is
+/* This object type represents QMan frame queue descriptors (FQD), it is
  * cacheline-aligned, and initialised by qman_create_fq(). The structure is
  * defined further down. */
 struct qman_fq;
 
-/* This object type represents a Qman congestion group, it is defined further
+/* This object type represents a QMan congestion group, it is defined further
  * down. */
 struct qman_cgr;
 
@@ -1083,7 +1083,7 @@ enum qman_fq_state {
  *
  * (b) when and if configuring the FQ for context stashing, specify how ever
  *     many cachelines are required to stash 'struct my_fq', to accelerate not
- *     only the Qman driver but the callback as well.
+ *     only the QMan driver but the callback as well.
  */
 
 struct qman_fq_cb {
@@ -1358,7 +1358,7 @@ void qman_dca(struct qm_dqrr_entry *dq, int park_request);
  * qman_eqcr_is_empty - Determine if portal's EQCR is empty
  *
  * For use in situations where a cpu-affine caller needs to determine when all
- * enqueues for the local portal have been processed by Qman but can't use the
+ * enqueues for the local portal have been processed by QMan but can't use the
  * QMAN_ENQUEUE_FLAG_WAIT_SYNC flag to do this from the final qman_enqueue().
  * The function forces tracking of EQCR consumption (which normally doesn't
  * happen until enqueue processing needs to find space to put new enqueue
@@ -1372,7 +1372,7 @@ int qman_eqcr_is_empty(void);
  * @handler: callback for processing DCP ERNs
  * @affine: whether this handler is specific to the locally affine portal
  *
- * If a hardware block's interface to Qman (ie. its direct-connect portal, or
+ * If a hardware block's interface to QMan (ie. its direct-connect portal, or
  * DCP) is configured not to receive enqueue rejections, then any enqueues
  * through that DCP that are rejected will be sent to a given software portal.
  * If @affine is non-zero, then this handler will only be used for DCP ERNs
@@ -1582,13 +1582,13 @@ int qman_volatile_dequeue(struct qman_fq *fq, u32 flags, u32 vdqcr);
  * (and FLAG_WAIT not specified), congestion avoidance (FLAG_WATCH_CGR
  * specified), etc. If the ring is full and FLAG_WAIT is specified, this
  * function will block. If FLAG_INTERRUPT is set, the EQCI bit of the portal
- * interrupt will assert when Qman consumes the EQCR entry (subject to "status
- * disable", "enable", and "inhibit" registers). If FLAG_DCA is set, Qman will
+ * interrupt will assert when QMan consumes the EQCR entry (subject to "status
+ * disable", "enable", and "inhibit" registers). If FLAG_DCA is set, QMan will
  * perform an implied "discrete consumption acknowledgement" on the dequeue
  * ring's (DQRR) entry, at the ring index specified by the FLAG_DCA_IDX(x)
  * macro. (As an alternative to issuing explicit DCA actions on DQRR entries,
  * this implicit DCA can delay the release of a "held active" frame queue
- * corresponding to a DQRR entry until Qman consumes the EQCR entry - providing
+ * corresponding to a DQRR entry until QMan consumes the EQCR entry - providing
  * order-preservation semantics in packet-forwarding scenarios.) If FLAG_DCA is
  * set, then FLAG_DCA_PARK can also be set to imply that the DQRR consumption
  * acknowledgement should "park request" the "held active" frame queue. Ie.
-- 
2.3.0
