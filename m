Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0110.outbound.protection.outlook.com [157.56.111.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 156981A16AD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 01:53:14 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <devel@driverdev.osuosl.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC 07/10] fsl_bman: Add debugfs support
Date: Wed, 4 Feb 2015 08:48:39 -0600
Message-ID: <1423061322-16059-8-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1423061322-16059-1-git-send-email-Emilian.Medve@Freescale.com>
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

Change-Id: I7eea7aea8a58ad0c28451b70801c0d101e88d263
Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
---
 drivers/staging/fsl_qbman/Kconfig        |   7 ++
 drivers/staging/fsl_qbman/Makefile       |   2 +
 drivers/staging/fsl_qbman/bman_debugfs.c | 119 +++++++++++++++++++++++++++++++
 drivers/staging/fsl_qbman/bman_high.c    |  19 +++++
 drivers/staging/fsl_qbman/dpa_sys.h      |   1 +
 include/linux/fsl_bman.h                 |   6 ++
 6 files changed, 154 insertions(+)
 create mode 100644 drivers/staging/fsl_qbman/bman_debugfs.c

diff --git a/drivers/staging/fsl_qbman/Kconfig b/drivers/staging/fsl_qbman/Kconfig
index fdf2f3b..66a8361 100644
--- a/drivers/staging/fsl_qbman/Kconfig
+++ b/drivers/staging/fsl_qbman/Kconfig
@@ -74,6 +74,13 @@ config FSL_BMAN_TEST_THRESH
 	  "drainer" thread, and the other threads that they observe exactly
 	  the depletion state changes that are expected.
 
+config FSL_BMAN_DEBUGFS
+	tristate "BMan debugfs interface"
+	depends on DEBUG_FS
+	default y
+	---help---
+	  This option compiles debugfs code for BMan.
+
 endif # FSL_BMAN
 
 config FSL_QMAN
diff --git a/drivers/staging/fsl_qbman/Makefile b/drivers/staging/fsl_qbman/Makefile
index 04d61f7..0287eab 100644
--- a/drivers/staging/fsl_qbman/Makefile
+++ b/drivers/staging/fsl_qbman/Makefile
@@ -9,6 +9,8 @@ obj-$(CONFIG_FSL_BMAN_TEST)			 += bman_tester.o
 bman_tester-y					  = bman_test.o
 bman_tester-$(CONFIG_FSL_BMAN_TEST_HIGH)	 += bman_test_high.o
 bman_tester-$(CONFIG_FSL_BMAN_TEST_THRESH)	 += bman_test_thresh.o
+obj-$(CONFIG_FSL_BMAN_DEBUGFS)			 += bman_debugfs_interface.o
+bman_debugfs_interface-y			  = bman_debugfs.o
 
 # Qman
 obj-$(CONFIG_FSL_QMAN)				 += qman_high.o qman_utility.o
diff --git a/drivers/staging/fsl_qbman/bman_debugfs.c b/drivers/staging/fsl_qbman/bman_debugfs.c
new file mode 100644
index 0000000..b93e705
--- /dev/null
+++ b/drivers/staging/fsl_qbman/bman_debugfs.c
@@ -0,0 +1,119 @@
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
+#include <linux/module.h>
+#include <linux/fsl_bman.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+
+static struct dentry *dfs_root; /* debugfs root directory */
+
+/*******************************************************************************
+ *  Query Buffer Pool State
+ ******************************************************************************/
+static int query_bp_state_show(struct seq_file *file, void *offset)
+{
+	int ret;
+	struct bm_pool_state state;
+	int i, j;
+	u32 mask;
+
+	memset(&state, 0, sizeof(struct bm_pool_state));
+	ret = bman_query_pools(&state);
+	if (ret) {
+		seq_printf(file, "Error %d\n", ret);
+		return 0;
+	}
+	seq_puts(file, "bp_id  free_buffers_avail  bp_depleted\n");
+	for (i = 0; i < 2; i++) {
+		mask = 0x80000000;
+		for (j = 0; j < 32; j++) {
+			seq_printf(file,
+			 "  %-2u	   %-3s		    %-3s\n",
+			 (i*32)+j,
+			 (state.as.state.__state[i] & mask) ? "no" : "yes",
+			 (state.ds.state.__state[i] & mask) ? "yes" : "no");
+			 mask >>= 1;
+		}
+	}
+	return 0;
+}
+
+static int query_bp_state_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, query_bp_state_show, NULL);
+}
+
+static const struct file_operations query_bp_state_fops = {
+	.owner		= THIS_MODULE,
+	.open		= query_bp_state_open,
+	.read		= seq_read,
+	.release	= single_release,
+};
+
+static int __init bman_debugfs_module_init(void)
+{
+	int ret = 0;
+	struct dentry *d;
+
+	dfs_root = debugfs_create_dir("bman", NULL);
+
+	if (dfs_root == NULL) {
+		ret = -ENOMEM;
+		pr_err("Cannot create bman debugfs dir\n");
+		goto _return;
+	}
+	d = debugfs_create_file("query_bp_state",
+		S_IRUGO,
+		dfs_root,
+		NULL,
+		&query_bp_state_fops);
+	if (d == NULL) {
+		ret = -ENOMEM;
+		pr_err("Cannot create query_bp_state\n");
+		goto _return;
+	}
+	return 0;
+
+_return:
+	debugfs_remove_recursive(dfs_root);
+	return ret;
+}
+
+static void __exit bman_debugfs_module_exit(void)
+{
+	debugfs_remove_recursive(dfs_root);
+}
+
+
+module_init(bman_debugfs_module_init);
+module_exit(bman_debugfs_module_exit);
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/staging/fsl_qbman/bman_high.c b/drivers/staging/fsl_qbman/bman_high.c
index 3caad72..844fce8 100644
--- a/drivers/staging/fsl_qbman/bman_high.c
+++ b/drivers/staging/fsl_qbman/bman_high.c
@@ -997,6 +997,25 @@ int bman_flush_stockpile(struct bman_pool *pool, u32 flags)
 }
 EXPORT_SYMBOL(bman_flush_stockpile);
 
+int bman_query_pools(struct bm_pool_state *state)
+{
+	struct bman_portal *p = get_affine_portal();
+	struct bm_mc_result *mcr;
+	__maybe_unused unsigned long irqflags;
+
+	PORTAL_IRQ_LOCK(p, irqflags);
+	bm_mc_start(&p->p);
+	bm_mc_commit(&p->p, BM_MCC_VERB_CMD_QUERY);
+	while (!(mcr = bm_mc_result(&p->p)))
+		cpu_relax();
+	DPA_ASSERT((mcr->verb & BM_MCR_VERB_CMD_MASK) == BM_MCR_VERB_CMD_QUERY);
+	*state = mcr->query;
+	PORTAL_IRQ_UNLOCK(p, irqflags);
+	put_affine_portal();
+	return 0;
+}
+EXPORT_SYMBOL(bman_query_pools);
+
 #ifdef CONFIG_FSL_BMAN_CONFIG
 u32 bman_query_free_buffers(struct bman_pool *pool)
 {
diff --git a/drivers/staging/fsl_qbman/dpa_sys.h b/drivers/staging/fsl_qbman/dpa_sys.h
index 86b280c..545b7ad 100644
--- a/drivers/staging/fsl_qbman/dpa_sys.h
+++ b/drivers/staging/fsl_qbman/dpa_sys.h
@@ -54,6 +54,7 @@
 #include <linux/ioctl.h>
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
+#include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/smp.h>
diff --git a/include/linux/fsl_bman.h b/include/linux/fsl_bman.h
index 16845d3..675eb65 100644
--- a/include/linux/fsl_bman.h
+++ b/include/linux/fsl_bman.h
@@ -481,6 +481,12 @@ int bman_acquire(struct bman_pool *pool, struct bm_buffer *bufs, u8 num,
  */
 int bman_flush_stockpile(struct bman_pool *pool, u32 flags);
 
+/**
+ * bman_query_pools - Query all buffer pool states
+ * @state: storage for the queried availability and depletion states
+ */
+int bman_query_pools(struct bm_pool_state *state);
+
 #ifdef CONFIG_FSL_BMAN_CONFIG
 /**
  * bman_query_free_buffers - Query how many free buffers are in buffer pool
-- 
2.2.2
