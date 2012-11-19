Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id A1CB32C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:38:01 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 226/493] dma: remove use of __devinit
Date: Mon, 19 Nov 2012 13:22:55 -0500
Message-Id: <1353349642-3677-226-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: Zhang Wei <zw@zh-kernel.org>, Viresh Kumar <viresh.linux@gmail.com>,
 Barry Song <baohua.song@csr.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Viresh Kumar <viresh.linux@gmail.com> 
Cc: Li Yang <leoli@freescale.com> 
Cc: Zhang Wei <zw@zh-kernel.org> 
Cc: Barry Song <baohua.song@csr.com> 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: linux-arm-kernel@lists.infradead.org 
---
 drivers/dma/dw_dmac.c         | 4 ++--
 drivers/dma/edma.c            | 2 +-
 drivers/dma/fsldma.c          | 4 ++--
 drivers/dma/intel_mid_dma.c   | 2 +-
 drivers/dma/iop-adma.c        | 8 ++++----
 drivers/dma/mmp_pdma.c        | 4 ++--
 drivers/dma/mmp_tdma.c        | 4 ++--
 drivers/dma/mpc512x_dma.c     | 2 +-
 drivers/dma/mv_xor.c          | 6 +++---
 drivers/dma/pch_dma.c         | 2 +-
 drivers/dma/pl330.c           | 2 +-
 drivers/dma/ppc4xx/adma.c     | 2 +-
 drivers/dma/sa11x0-dma.c      | 4 ++--
 drivers/dma/sh/shdma.c        | 4 ++--
 drivers/dma/sirf-dma.c        | 2 +-
 drivers/dma/tegra20-apb-dma.c | 2 +-
 drivers/dma/timb_dma.c        | 2 +-
 17 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 67f6358..476e9c8 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1502,7 +1502,7 @@ static void dw_dma_off(struct dw_dma *dw)
 
 #ifdef CONFIG_OF
 static struct dw_dma_platform_data *
-__devinit dw_dma_parse_dt(struct platform_device *pdev)
+dw_dma_parse_dt(struct platform_device *pdev)
 {
 	struct device_node *sn, *cn, *np = pdev->dev.of_node;
 	struct dw_dma_platform_data *pdata;
@@ -1585,7 +1585,7 @@ dw_dma_parse_dt(struct platform_device *pdev)
 }
 #endif
 
-static int __devinit dw_probe(struct platform_device *pdev)
+static int dw_probe(struct platform_device *pdev)
 {
 	struct dw_dma_platform_data *pdata;
 	struct resource		*io;
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 5e5cce4..232b458 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -545,7 +545,7 @@ static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 	INIT_LIST_HEAD(&dma->channels);
 }
 
-static int __devinit edma_probe(struct platform_device *pdev)
+static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_cc *ecc;
 	int ret;
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 094437b..4fc2980 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1221,7 +1221,7 @@ out_unwind:
 /* OpenFirmware Subsystem                                                     */
 /*----------------------------------------------------------------------------*/
 
-static int __devinit fsl_dma_chan_probe(struct fsldma_device *fdev,
+static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	struct device_node *node, u32 feature, const char *compatible)
 {
 	struct fsldma_chan *chan;
@@ -1324,7 +1324,7 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
 	kfree(chan);
 }
 
-static int __devinit fsldma_of_probe(struct platform_device *op)
+static int fsldma_of_probe(struct platform_device *op)
 {
 	struct fsldma_device *fdev;
 	struct device_node *child;
diff --git a/drivers/dma/intel_mid_dma.c b/drivers/dma/intel_mid_dma.c
index dffdeff..bc764af 100644
--- a/drivers/dma/intel_mid_dma.c
+++ b/drivers/dma/intel_mid_dma.c
@@ -1225,7 +1225,7 @@ static void middma_shutdown(struct pci_dev *pdev)
  * Initialize the PCI device, map BARs, query driver data.
  * Call setup_dma to complete contoller and chan initilzation
  */
-static int __devinit intel_mid_dma_probe(struct pci_dev *pdev,
+static int intel_mid_dma_probe(struct pci_dev *pdev,
 					const struct pci_device_id *id)
 {
 	struct middma_device *device;
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 80d986a..62a59fd 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -968,7 +968,7 @@ static void iop_adma_issue_pending(struct dma_chan *chan)
  */
 #define IOP_ADMA_TEST_SIZE 2000
 
-static int __devinit iop_adma_memcpy_self_test(struct iop_adma_device *device)
+static int iop_adma_memcpy_self_test(struct iop_adma_device *device)
 {
 	int i;
 	void *src, *dest;
@@ -1042,7 +1042,7 @@ out:
 }
 
 #define IOP_ADMA_NUM_SRC_TEST 4 /* must be <= 15 */
-static int __devinit
+static int
 iop_adma_xor_val_self_test(struct iop_adma_device *device)
 {
 	int i, src_idx;
@@ -1243,7 +1243,7 @@ out:
 }
 
 #ifdef CONFIG_RAID6_PQ
-static int __devinit
+static int
 iop_adma_pq_zero_sum_self_test(struct iop_adma_device *device)
 {
 	/* combined sources, software pq results, and extra hw pq results */
@@ -1429,7 +1429,7 @@ static int __devexit iop_adma_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int __devinit iop_adma_probe(struct platform_device *pdev)
+static int iop_adma_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret = 0, i;
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 4777986..13bdf4a 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -720,7 +720,7 @@ static int __devexit mmp_pdma_remove(struct platform_device *op)
 	return 0;
 }
 
-static int __devinit mmp_pdma_chan_init(struct mmp_pdma_device *pdev,
+static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev,
 							int idx, int irq)
 {
 	struct mmp_pdma_phy *phy  = &pdev->phy[idx];
@@ -764,7 +764,7 @@ static struct of_device_id mmp_pdma_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);
 
-static int __devinit mmp_pdma_probe(struct platform_device *op)
+static int mmp_pdma_probe(struct platform_device *op)
 {
 	struct mmp_pdma_device *pdev;
 	const struct of_device_id *of_id;
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 7d7fc6b..323821c 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -475,7 +475,7 @@ static int __devexit mmp_tdma_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
+static int mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
 						int idx, int irq, int type)
 {
 	struct mmp_tdma_chan *tdmac;
@@ -515,7 +515,7 @@ static struct of_device_id mmp_tdma_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mmp_tdma_dt_ids);
 
-static int __devinit mmp_tdma_probe(struct platform_device *pdev)
+static int mmp_tdma_probe(struct platform_device *pdev)
 {
 	enum mmp_tdma_type type;
 	const struct of_device_id *of_id;
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 4b8754b..2cd024a 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -641,7 +641,7 @@ mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 	return &mdesc->desc;
 }
 
-static int __devinit mpc_dma_probe(struct platform_device *op)
+static int mpc_dma_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
 	struct device *dev = &op->dev;
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 119ed50..3ef4095 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -895,7 +895,7 @@ static void mv_xor_issue_pending(struct dma_chan *chan)
  */
 #define MV_XOR_TEST_SIZE 2000
 
-static int __devinit mv_xor_memcpy_self_test(struct mv_xor_device *device)
+static int mv_xor_memcpy_self_test(struct mv_xor_device *device)
 {
 	int i;
 	void *src, *dest;
@@ -969,7 +969,7 @@ out:
 }
 
 #define MV_XOR_NUM_SRC_TEST 4 /* must be <= 15 */
-static int __devinit
+static int
 mv_xor_xor_self_test(struct mv_xor_device *device)
 {
 	int i, src_idx;
@@ -1093,7 +1093,7 @@ static int __devexit mv_xor_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int __devinit mv_xor_probe(struct platform_device *pdev)
+static int mv_xor_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	int irq;
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index ee3d567..aed6e0c 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -843,7 +843,7 @@ static int pch_dma_resume(struct pci_dev *pdev)
 }
 #endif
 
-static int __devinit pch_dma_probe(struct pci_dev *pdev,
+static int pch_dma_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
 	struct pch_dma *pd;
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 665668b..95555f3 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2851,7 +2851,7 @@ static irqreturn_t pl330_irq_handler(int irq, void *data)
 		return IRQ_NONE;
 }
 
-static int __devinit
+static int
 pl330_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct dma_pl330_platdata *pdat;
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 5c6717c..b94afc3 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4361,7 +4361,7 @@ static void ppc440spe_adma_release_irqs(struct ppc440spe_adma_device *adev,
 /**
  * ppc440spe_adma_probe - probe the asynch device
  */
-static int __devinit ppc440spe_adma_probe(struct platform_device *ofdev)
+static int ppc440spe_adma_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct resource res;
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 1255d9b..2ad628d 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -826,7 +826,7 @@ static const struct sa11x0_dma_channel_desc chan_desc[] = {
 	CD(Ser4SSPRc, DDAR_RW),
 };
 
-static int __devinit sa11x0_dma_init_dmadev(struct dma_device *dmadev,
+static int sa11x0_dma_init_dmadev(struct dma_device *dmadev,
 	struct device *dev)
 {
 	unsigned i;
@@ -891,7 +891,7 @@ static void sa11x0_dma_free_channels(struct dma_device *dmadev)
 	}
 }
 
-static int __devinit sa11x0_dma_probe(struct platform_device *pdev)
+static int sa11x0_dma_probe(struct platform_device *pdev)
 {
 	struct sa11x0_dma_dev *d;
 	struct resource *res;
diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index 7dcf4e0..8201bb4 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -483,7 +483,7 @@ static struct notifier_block sh_dmae_nmi_notifier __read_mostly = {
 	.priority	= 1,
 };
 
-static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id,
+static int sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id,
 					int irq, unsigned long flags)
 {
 	const struct sh_dmae_channel *chan_pdata = &shdev->pdata->channel[id];
@@ -646,7 +646,7 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 	.get_partial = sh_dmae_get_partial,
 };
 
-static int __devinit sh_dmae_probe(struct platform_device *pdev)
+static int sh_dmae_probe(struct platform_device *pdev)
 {
 	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
 	unsigned long irqflags = IRQF_DISABLED,
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 62d42c9..c3de6ed 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -550,7 +550,7 @@ bool sirfsoc_dma_filter_id(struct dma_chan *chan, void *chan_id)
 }
 EXPORT_SYMBOL(sirfsoc_dma_filter_id);
 
-static int __devinit sirfsoc_dma_probe(struct platform_device *op)
+static int sirfsoc_dma_probe(struct platform_device *op)
 {
 	struct device_node *dn = op->dev.of_node;
 	struct device *dev = &op->dev;
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 655c434..efdfffa 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1197,7 +1197,7 @@ static const struct of_device_id tegra_dma_of_match[] __devinitconst = {
 MODULE_DEVICE_TABLE(of, tegra_dma_of_match);
 #endif
 
-static int __devinit tegra_dma_probe(struct platform_device *pdev)
+static int tegra_dma_probe(struct platform_device *pdev)
 {
 	struct resource	*res;
 	struct tegra_dma *tdma;
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 4e0dff5..98cf51e 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -667,7 +667,7 @@ static irqreturn_t td_irq(int irq, void *devid)
 }
 
 
-static int __devinit td_probe(struct platform_device *pdev)
+static int td_probe(struct platform_device *pdev)
 {
 	struct timb_dma_platform_data *pdata = pdev->dev.platform_data;
 	struct timb_dma *td;
-- 
1.8.0
