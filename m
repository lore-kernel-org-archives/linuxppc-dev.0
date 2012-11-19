Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 9F8502C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:43:03 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 227/493] edac: remove use of __devinit
Date: Mon, 19 Nov 2012 13:22:56 -0500
Message-Id: <1353349642-3677-227-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: "Arvind R." <arvino55@gmail.com>, linux-mips@linux-mips.org,
 Mark Gross <mark.gross@intel.com>, Mauro Carvalho Chehab <mchehab@redhat.com>,
 Jason Uhlenkott <juhlenko@akamai.com>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Borislav Petkov <bp@alien8.de>, Doug Thompson <dougthompson@xmission.com>,
 Olof Johansson <olof@lixom.net>, Egor Martovetsky <egor@pasemi.com>,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Tim Small <tim@buttersideup.com>
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
Cc: Doug Thompson <dougthompson@xmission.com> 
Cc: Borislav Petkov <bp@alien8.de> 
Cc: Mark Gross <mark.gross@intel.com> 
Cc: Jason Uhlenkott <juhlenko@akamai.com> 
Cc: Mauro Carvalho Chehab <mchehab@redhat.com> 
Cc: Tim Small <tim@buttersideup.com> 
Cc: Ranganathan Desikan <ravi@jetztechnologies.com> 
Cc: "Arvind R." <arvino55@gmail.com> 
Cc: Egor Martovetsky <egor@pasemi.com> 
Cc: Olof Johansson <olof@lixom.net> 
Cc: linux-edac@vger.kernel.org 
Cc: linux-mips@linux-mips.org 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/edac/amd64_edac.c       |  2 +-
 drivers/edac/amd76x_edac.c      |  2 +-
 drivers/edac/cell_edac.c        |  4 ++--
 drivers/edac/cpc925_edac.c      |  2 +-
 drivers/edac/e752x_edac.c       |  2 +-
 drivers/edac/e7xxx_edac.c       |  2 +-
 drivers/edac/highbank_l2_edac.c |  2 +-
 drivers/edac/highbank_mc_edac.c |  6 +++---
 drivers/edac/i3000_edac.c       |  2 +-
 drivers/edac/i3200_edac.c       |  2 +-
 drivers/edac/i5000_edac.c       |  2 +-
 drivers/edac/i5100_edac.c       | 14 +++++++-------
 drivers/edac/i5400_edac.c       |  2 +-
 drivers/edac/i7300_edac.c       |  4 ++--
 drivers/edac/i7core_edac.c      |  2 +-
 drivers/edac/i82443bxgx_edac.c  |  2 +-
 drivers/edac/i82860_edac.c      |  2 +-
 drivers/edac/i82875p_edac.c     |  2 +-
 drivers/edac/i82975x_edac.c     |  2 +-
 drivers/edac/mpc85xx_edac.c     |  8 ++++----
 drivers/edac/mv64x60_edac.c     |  8 ++++----
 drivers/edac/octeon_edac-l2c.c  |  2 +-
 drivers/edac/octeon_edac-lmc.c  |  2 +-
 drivers/edac/octeon_edac-pc.c   |  2 +-
 drivers/edac/octeon_edac-pci.c  |  2 +-
 drivers/edac/pasemi_edac.c      |  2 +-
 drivers/edac/ppc4xx_edac.c      | 14 +++++++-------
 drivers/edac/r82600_edac.c      |  2 +-
 drivers/edac/sb_edac.c          |  2 +-
 drivers/edac/tile_edac.c        |  4 ++--
 drivers/edac/x38_edac.c         |  2 +-
 31 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c147e1e..fbc9f43 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2563,7 +2563,7 @@ err_ret:
 	return ret;
 }
 
-static int __devinit amd64_probe_one_instance(struct pci_dev *pdev,
+static int amd64_probe_one_instance(struct pci_dev *pdev,
 					     const struct pci_device_id *mc_type)
 {
 	u8 nid = get_node_id(pdev);
diff --git a/drivers/edac/amd76x_edac.c b/drivers/edac/amd76x_edac.c
index 0430c35..af986bc 100644
--- a/drivers/edac/amd76x_edac.c
+++ b/drivers/edac/amd76x_edac.c
@@ -301,7 +301,7 @@ fail:
 }
 
 /* returns count (>= 0), or negative on error */
-static int __devinit amd76x_init_one(struct pci_dev *pdev,
+static int amd76x_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	edac_dbg(0, "\n");
diff --git a/drivers/edac/cell_edac.c b/drivers/edac/cell_edac.c
index b99bf19..c276157 100644
--- a/drivers/edac/cell_edac.c
+++ b/drivers/edac/cell_edac.c
@@ -124,7 +124,7 @@ static void cell_edac_check(struct mem_ctl_info *mci)
 	}
 }
 
-static void __devinit cell_edac_init_csrows(struct mem_ctl_info *mci)
+static void cell_edac_init_csrows(struct mem_ctl_info *mci)
 {
 	struct csrow_info		*csrow = mci->csrows[0];
 	struct dimm_info		*dimm;
@@ -164,7 +164,7 @@ static void __devinit cell_edac_init_csrows(struct mem_ctl_info *mci)
 	}
 }
 
-static int __devinit cell_edac_probe(struct platform_device *pdev)
+static int cell_edac_probe(struct platform_device *pdev)
 {
 	struct cbe_mic_tm_regs __iomem	*regs;
 	struct mem_ctl_info		*mci;
diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index c2ef134..7f3c571 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -932,7 +932,7 @@ static int cpc925_mc_get_channels(void __iomem *vbase)
 	return dual;
 }
 
-static int __devinit cpc925_probe(struct platform_device *pdev)
+static int cpc925_probe(struct platform_device *pdev)
 {
 	static int edac_mc_idx;
 	struct mem_ctl_info *mci;
diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
index 697acd5..ee69530 100644
--- a/drivers/edac/e752x_edac.c
+++ b/drivers/edac/e752x_edac.c
@@ -1390,7 +1390,7 @@ fail:
 }
 
 /* returns count (>= 0), or negative on error */
-static int __devinit e752x_init_one(struct pci_dev *pdev,
+static int e752x_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	edac_dbg(0, "\n");
diff --git a/drivers/edac/e7xxx_edac.c b/drivers/edac/e7xxx_edac.c
index 2b401ef..9ceb779 100644
--- a/drivers/edac/e7xxx_edac.c
+++ b/drivers/edac/e7xxx_edac.c
@@ -528,7 +528,7 @@ fail0:
 }
 
 /* returns count (>= 0), or negative on error */
-static int __devinit e7xxx_init_one(struct pci_dev *pdev,
+static int e7xxx_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	edac_dbg(0, "\n");
diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
index e599b00..c2bd8c6 100644
--- a/drivers/edac/highbank_l2_edac.c
+++ b/drivers/edac/highbank_l2_edac.c
@@ -50,7 +50,7 @@ static irqreturn_t highbank_l2_err_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit highbank_l2_err_probe(struct platform_device *pdev)
+static int highbank_l2_err_probe(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *dci;
 	struct hb_l2_drvdata *drvdata;
diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
index 7ea4cc2..4695dd2 100644
--- a/drivers/edac/highbank_mc_edac.c
+++ b/drivers/edac/highbank_mc_edac.c
@@ -119,7 +119,7 @@ static const struct file_operations highbank_mc_debug_inject_fops = {
 	.llseek = generic_file_llseek,
 };
 
-static void __devinit highbank_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
+static void highbank_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
 {
 	if (mci->debugfs)
 		debugfs_create_file("inject_ctrl", S_IWUSR, mci->debugfs, mci,
@@ -127,11 +127,11 @@ static void __devinit highbank_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
 ;
 }
 #else
-static void __devinit highbank_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
+static void highbank_mc_create_debugfs_nodes(struct mem_ctl_info *mci)
 {}
 #endif
 
-static int __devinit highbank_mc_probe(struct platform_device *pdev)
+static int highbank_mc_probe(struct platform_device *pdev)
 {
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c
index 22d43a0..b39b54a 100644
--- a/drivers/edac/i3000_edac.c
+++ b/drivers/edac/i3000_edac.c
@@ -455,7 +455,7 @@ fail:
 }
 
 /* returns count (>= 0), or negative on error */
-static int __devinit i3000_init_one(struct pci_dev *pdev,
+static int i3000_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	int rc;
diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index 532fabb..1c2a44a 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -419,7 +419,7 @@ fail:
 	return rc;
 }
 
-static int __devinit i3200_init_one(struct pci_dev *pdev,
+static int i3200_init_one(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	int rc;
diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index 782b2880e..e67f0f9 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -1489,7 +1489,7 @@ fail0:
  *		negative on error
  *		count (>= 0)
  */
-static int __devinit i5000_init_one(struct pci_dev *pdev,
+static int i5000_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
 	int rc;
diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index da5975e..ed6b6d2 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -638,7 +638,7 @@ static struct pci_dev *pci_get_device_func(unsigned vendor,
 	return ret;
 }
 
-static unsigned long __devinit i5100_npages(struct mem_ctl_info *mci,
+static unsigned long i5100_npages(struct mem_ctl_info *mci,
 					    int csrow)
 {
 	struct i5100_priv *priv = mci->pvt_info;
@@ -660,7 +660,7 @@ static unsigned long __devinit i5100_npages(struct mem_ctl_info *mci,
 		((unsigned long long) (1ULL << addr_lines) / PAGE_SIZE);
 }
 
-static void __devinit i5100_init_mtr(struct mem_ctl_info *mci)
+static void i5100_init_mtr(struct mem_ctl_info *mci)
 {
 	struct i5100_priv *priv = mci->pvt_info;
 	struct pci_dev *mms[2] = { priv->ch0mm, priv->ch1mm };
@@ -732,7 +732,7 @@ static int i5100_read_spd_byte(const struct mem_ctl_info *mci,
  *   o not the only way to may chip selects to dimm slots
  *   o investigate if there is some way to obtain this map from the bios
  */
-static void __devinit i5100_init_dimm_csmap(struct mem_ctl_info *mci)
+static void i5100_init_dimm_csmap(struct mem_ctl_info *mci)
 {
 	struct i5100_priv *priv = mci->pvt_info;
 	int i;
@@ -762,7 +762,7 @@ static void __devinit i5100_init_dimm_csmap(struct mem_ctl_info *mci)
 	}
 }
 
-static void __devinit i5100_init_dimm_layout(struct pci_dev *pdev,
+static void i5100_init_dimm_layout(struct pci_dev *pdev,
 					     struct mem_ctl_info *mci)
 {
 	struct i5100_priv *priv = mci->pvt_info;
@@ -784,7 +784,7 @@ static void __devinit i5100_init_dimm_layout(struct pci_dev *pdev,
 	i5100_init_dimm_csmap(mci);
 }
 
-static void __devinit i5100_init_interleaving(struct pci_dev *pdev,
+static void i5100_init_interleaving(struct pci_dev *pdev,
 					      struct mem_ctl_info *mci)
 {
 	u16 w;
@@ -830,7 +830,7 @@ static void __devinit i5100_init_interleaving(struct pci_dev *pdev,
 	i5100_init_mtr(mci);
 }
 
-static void __devinit i5100_init_csrows(struct mem_ctl_info *mci)
+static void i5100_init_csrows(struct mem_ctl_info *mci)
 {
 	int i;
 	struct i5100_priv *priv = mci->pvt_info;
@@ -864,7 +864,7 @@ static void __devinit i5100_init_csrows(struct mem_ctl_info *mci)
 	}
 }
 
-static int __devinit i5100_init_one(struct pci_dev *pdev,
+static int i5100_init_one(struct pci_dev *pdev,
 				    const struct pci_device_id *id)
 {
 	int rc;
diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index 5c25d01..f49797a 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -1373,7 +1373,7 @@ fail0:
  *		negative on error
  *		count (>= 0)
  */
-static int __devinit i5400_init_one(struct pci_dev *pdev,
+static int i5400_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
 	int rc;
diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index 62629fd..ad19604 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -923,7 +923,7 @@ static void i7300_put_devices(struct mem_ctl_info *mci)
  *    Device 21 function 0:		PCI_DEVICE_ID_INTEL_I7300_MCH_FB0
  *    Device 22 function 0:		PCI_DEVICE_ID_INTEL_I7300_MCH_FB1
  */
-static int __devinit i7300_get_devices(struct mem_ctl_info *mci)
+static int i7300_get_devices(struct mem_ctl_info *mci)
 {
 	struct i7300_pvt *pvt;
 	struct pci_dev *pdev;
@@ -1008,7 +1008,7 @@ error:
  * @pdev: struct pci_dev pointer
  * @id: struct pci_device_id pointer - currently unused
  */
-static int __devinit i7300_init_one(struct pci_dev *pdev,
+static int i7300_init_one(struct pci_dev *pdev,
 				    const struct pci_device_id *id)
 {
 	struct mem_ctl_info *mci;
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index aa0a97e..e61f775 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -2305,7 +2305,7 @@ fail0:
  *		< 0 for error code
  */
 
-static int __devinit i7core_probe(struct pci_dev *pdev,
+static int i7core_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
 	int rc, count = 0;
diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
index 454ba5a..2acb2a0 100644
--- a/drivers/edac/i82443bxgx_edac.c
+++ b/drivers/edac/i82443bxgx_edac.c
@@ -353,7 +353,7 @@ fail:
 EXPORT_SYMBOL_GPL(i82443bxgx_edacmc_probe1);
 
 /* returns count (>= 0), or negative on error */
-static int __devinit i82443bxgx_edacmc_init_one(struct pci_dev *pdev,
+static int i82443bxgx_edacmc_init_one(struct pci_dev *pdev,
 						const struct pci_device_id *ent)
 {
 	int rc;
diff --git a/drivers/edac/i82860_edac.c b/drivers/edac/i82860_edac.c
index 040c1d5..f99abb9 100644
--- a/drivers/edac/i82860_edac.c
+++ b/drivers/edac/i82860_edac.c
@@ -254,7 +254,7 @@ fail:
 }
 
 /* returns count (>= 0), or negative on error */
-static int __devinit i82860_init_one(struct pci_dev *pdev,
+static int i82860_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	int rc;
diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
index a330640..8c0e858 100644
--- a/drivers/edac/i82875p_edac.c
+++ b/drivers/edac/i82875p_edac.c
@@ -479,7 +479,7 @@ fail0:
 }
 
 /* returns count (>= 0), or negative on error */
-static int __devinit i82875p_init_one(struct pci_dev *pdev,
+static int i82875p_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	int rc;
diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
index b6478a9..06965a1 100644
--- a/drivers/edac/i82975x_edac.c
+++ b/drivers/edac/i82975x_edac.c
@@ -682,7 +682,7 @@ fail0:
 }
 
 /* returns count (>= 0), or negative on error */
-static int __devinit i82975x_init_one(struct pci_dev *pdev,
+static int i82975x_init_one(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	int rc;
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 4fe66fa..42a840d 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -212,7 +212,7 @@ static irqreturn_t mpc85xx_pci_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-int __devinit mpc85xx_pci_err_probe(struct platform_device *op)
+int mpc85xx_pci_err_probe(struct platform_device *op)
 {
 	struct edac_pci_ctl_info *pci;
 	struct mpc85xx_pci_pdata *pdata;
@@ -504,7 +504,7 @@ static irqreturn_t mpc85xx_l2_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit mpc85xx_l2_err_probe(struct platform_device *op)
+static int mpc85xx_l2_err_probe(struct platform_device *op)
 {
 	struct edac_device_ctl_info *edac_dev;
 	struct mpc85xx_l2_pdata *pdata;
@@ -885,7 +885,7 @@ static irqreturn_t mpc85xx_mc_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci)
+static void mpc85xx_init_csrows(struct mem_ctl_info *mci)
 {
 	struct mpc85xx_mc_pdata *pdata = mci->pvt_info;
 	struct csrow_info *csrow;
@@ -964,7 +964,7 @@ static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci)
 	}
 }
 
-static int __devinit mpc85xx_mc_err_probe(struct platform_device *op)
+static int mpc85xx_mc_err_probe(struct platform_device *op)
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index da27a7a..542fad7 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -100,7 +100,7 @@ static int __init mv64x60_pci_fixup(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit mv64x60_pci_err_probe(struct platform_device *pdev)
+static int mv64x60_pci_err_probe(struct platform_device *pdev)
 {
 	struct edac_pci_ctl_info *pci;
 	struct mv64x60_pci_pdata *pdata;
@@ -271,7 +271,7 @@ static irqreturn_t mv64x60_sram_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit mv64x60_sram_err_probe(struct platform_device *pdev)
+static int mv64x60_sram_err_probe(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *edac_dev;
 	struct mv64x60_sram_pdata *pdata;
@@ -439,7 +439,7 @@ static irqreturn_t mv64x60_cpu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit mv64x60_cpu_err_probe(struct platform_device *pdev)
+static int mv64x60_cpu_err_probe(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *edac_dev;
 	struct resource *r;
@@ -697,7 +697,7 @@ static void mv64x60_init_csrows(struct mem_ctl_info *mci,
 	dimm->edac_mode = EDAC_SECDED;
 }
 
-static int __devinit mv64x60_mc_err_probe(struct platform_device *pdev)
+static int mv64x60_mc_err_probe(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
diff --git a/drivers/edac/octeon_edac-l2c.c b/drivers/edac/octeon_edac-l2c.c
index 5f459aa..6ffe45a 100644
--- a/drivers/edac/octeon_edac-l2c.c
+++ b/drivers/edac/octeon_edac-l2c.c
@@ -38,7 +38,7 @@ static void co_l2c_poll(struct edac_device_ctl_info *l2c)
 	}
 }
 
-static int __devinit co_l2c_probe(struct platform_device *pdev)
+static int co_l2c_probe(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *l2c;
 	union cvmx_l2t_err l2t_err;
diff --git a/drivers/edac/octeon_edac-lmc.c b/drivers/edac/octeon_edac-lmc.c
index e0c1e44..dab702b 100644
--- a/drivers/edac/octeon_edac-lmc.c
+++ b/drivers/edac/octeon_edac-lmc.c
@@ -50,7 +50,7 @@ static void co_lmc_poll(struct mem_ctl_info *mci)
 	writeq(cfg0.u64, lmc_base + LMC_MEM_CFG0);
 }
 
-static int __devinit co_lmc_probe(struct platform_device *pdev)
+static int co_lmc_probe(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci;
 	union lmc_mem_cfg0 cfg0;
diff --git a/drivers/edac/octeon_edac-pc.c b/drivers/edac/octeon_edac-pc.c
index 9d13061..3af79fb 100644
--- a/drivers/edac/octeon_edac-pc.c
+++ b/drivers/edac/octeon_edac-pc.c
@@ -66,7 +66,7 @@ static struct notifier_block co_cache_error_notifier = {
 	.notifier_call = co_cache_error_event,
 };
 
-static int __devinit co_cache_error_probe(struct platform_device *pdev)
+static int co_cache_error_probe(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *ed;
 	int res = 0;
diff --git a/drivers/edac/octeon_edac-pci.c b/drivers/edac/octeon_edac-pci.c
index e72b96e..89ee5e0 100644
--- a/drivers/edac/octeon_edac-pci.c
+++ b/drivers/edac/octeon_edac-pci.c
@@ -64,7 +64,7 @@ static void co_pci_poll(struct edac_pci_ctl_info *pci)
 	}
 }
 
-static int __devinit co_pci_probe(struct platform_device *pdev)
+static int co_pci_probe(struct platform_device *pdev)
 {
 	struct edac_pci_ctl_info *pci;
 	int res = 0;
diff --git a/drivers/edac/pasemi_edac.c b/drivers/edac/pasemi_edac.c
index 69f08d6..0c60c38 100644
--- a/drivers/edac/pasemi_edac.c
+++ b/drivers/edac/pasemi_edac.c
@@ -188,7 +188,7 @@ static int pasemi_edac_init_csrows(struct mem_ctl_info *mci,
 	return 0;
 }
 
-static int __devinit pasemi_edac_probe(struct pci_dev *pdev,
+static int pasemi_edac_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	struct mem_ctl_info *mci = NULL;
diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index bf09576..1478367 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -838,7 +838,7 @@ ppc4xx_edac_isr(int irq, void *dev_id)
  *
  * Returns a device type width enumeration.
  */
-static enum dev_type __devinit
+static enum dev_type
 ppc4xx_edac_get_dtype(u32 mcopt1)
 {
 	switch (mcopt1 & SDRAM_MCOPT1_WDTH_MASK) {
@@ -862,7 +862,7 @@ ppc4xx_edac_get_dtype(u32 mcopt1)
  *
  * Returns a memory type enumeration.
  */
-static enum mem_type __devinit
+static enum mem_type
 ppc4xx_edac_get_mtype(u32 mcopt1)
 {
 	bool rden = ((mcopt1 & SDRAM_MCOPT1_RDEN_MASK) == SDRAM_MCOPT1_RDEN);
@@ -893,7 +893,7 @@ ppc4xx_edac_get_mtype(u32 mcopt1)
  * Returns 0 if OK; otherwise, -EINVAL if the memory bank size
  * configuration cannot be determined.
  */
-static int __devinit
+static int
 ppc4xx_edac_init_csrows(struct mem_ctl_info *mci, u32 mcopt1)
 {
 	const struct ppc4xx_edac_pdata *pdata = mci->pvt_info;
@@ -1011,7 +1011,7 @@ ppc4xx_edac_init_csrows(struct mem_ctl_info *mci, u32 mcopt1)
  *
  * Returns 0 if OK; otherwise, < 0 on error.
  */
-static int __devinit
+static int
 ppc4xx_edac_mc_init(struct mem_ctl_info *mci,
 		    struct platform_device *op,
 		    const dcr_host_t *dcr_host,
@@ -1105,7 +1105,7 @@ ppc4xx_edac_mc_init(struct mem_ctl_info *mci,
  * Returns 0 if OK; otherwise, -ENODEV if the interrupts could not be
  * mapped and assigned.
  */
-static int __devinit
+static int
 ppc4xx_edac_register_irq(struct platform_device *op, struct mem_ctl_info *mci)
 {
 	int status = 0;
@@ -1183,7 +1183,7 @@ ppc4xx_edac_register_irq(struct platform_device *op, struct mem_ctl_info *mci)
  * Returns 0 if the DCRs were successfully mapped; otherwise, < 0 on
  * error.
  */
-static int __devinit
+static int
 ppc4xx_edac_map_dcrs(const struct device_node *np, dcr_host_t *dcr_host)
 {
 	unsigned int dcr_base, dcr_len;
@@ -1232,7 +1232,7 @@ ppc4xx_edac_map_dcrs(const struct device_node *np, dcr_host_t *dcr_host)
  * Returns 0 if the controller instance was successfully bound to the
  * driver; otherwise, < 0 on error.
  */
-static int __devinit ppc4xx_edac_probe(struct platform_device *op)
+static int ppc4xx_edac_probe(struct platform_device *op)
 {
 	int status = 0;
 	u32 mcopt1, memcheck;
diff --git a/drivers/edac/r82600_edac.c b/drivers/edac/r82600_edac.c
index 664b4c1..b963b70 100644
--- a/drivers/edac/r82600_edac.c
+++ b/drivers/edac/r82600_edac.c
@@ -359,7 +359,7 @@ fail:
 }
 
 /* returns count (>= 0), or negative on error */
-static int __devinit r82600_init_one(struct pci_dev *pdev,
+static int r82600_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	edac_dbg(0, "\n");
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 79559f2..24cb900 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1692,7 +1692,7 @@ fail0:
  *		< 0 for error code
  */
 
-static int __devinit sbridge_probe(struct pci_dev *pdev,
+static int sbridge_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
 	int rc;
diff --git a/drivers/edac/tile_edac.c b/drivers/edac/tile_edac.c
index 89c3c6b..16966e0 100644
--- a/drivers/edac/tile_edac.c
+++ b/drivers/edac/tile_edac.c
@@ -82,7 +82,7 @@ static void tile_edac_check(struct mem_ctl_info *mci)
  * Initialize the 'csrows' table within the mci control structure with the
  * addressing of memory.
  */
-static int __devinit tile_edac_init_csrows(struct mem_ctl_info *mci)
+static int tile_edac_init_csrows(struct mem_ctl_info *mci)
 {
 	struct csrow_info	*csrow = mci->csrows[0];
 	struct tile_edac_priv	*priv = mci->pvt_info;
@@ -120,7 +120,7 @@ static int __devinit tile_edac_init_csrows(struct mem_ctl_info *mci)
 	return 0;
 }
 
-static int __devinit tile_edac_mc_probe(struct platform_device *pdev)
+static int tile_edac_mc_probe(struct platform_device *pdev)
 {
 	char			hv_file[32];
 	int			hv_devhdl;
diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
index 2301418..7088028 100644
--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -418,7 +418,7 @@ fail:
 	return rc;
 }
 
-static int __devinit x38_init_one(struct pci_dev *pdev,
+static int x38_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	int rc;
-- 
1.8.0
