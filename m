Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 172952C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:43:03 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 437/493] char: remove use of __devexit
Date: Mon, 19 Nov 2012 13:26:26 -0500
Message-Id: <1353349642-3677-437-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: David Airlie <airlied@linux.ie>, Marcel Selhorst <tpmdd@selhorst.net>,
 platform-driver-x86@vger.kernel.org, Rajiv Andrade <mail@srajiv.net>,
 Mattia Dongili <malattia@linux.it>, tpmdd-devel@lists.sourceforge.net,
 Olof Johansson <olof@lixom.net>, openipmi-developer@lists.sourceforge.net,
 Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Sirrix AG <tpmdd@sirrix.com>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: David Airlie <airlied@linux.ie> 
Cc: Olof Johansson <olof@lixom.net> 
Cc: Mattia Dongili <malattia@linux.it> 
Cc: Kent Yoder <key@linux.vnet.ibm.com> 
Cc: Rajiv Andrade <mail@srajiv.net> 
Cc: Marcel Selhorst <tpmdd@selhorst.net> 
Cc: Sirrix AG <tpmdd@sirrix.com> 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: openipmi-developer@lists.sourceforge.net 
Cc: platform-driver-x86@vger.kernel.org 
Cc: tpmdd-devel@lists.sourceforge.net 
---
 drivers/char/agp/ali-agp.c                 | 2 +-
 drivers/char/agp/amd-k7-agp.c              | 2 +-
 drivers/char/agp/amd64-agp.c               | 2 +-
 drivers/char/agp/ati-agp.c                 | 2 +-
 drivers/char/agp/efficeon-agp.c            | 2 +-
 drivers/char/agp/i460-agp.c                | 2 +-
 drivers/char/agp/intel-agp.c               | 2 +-
 drivers/char/agp/nvidia-agp.c              | 2 +-
 drivers/char/agp/sgi-agp.c                 | 2 +-
 drivers/char/agp/sis-agp.c                 | 2 +-
 drivers/char/agp/sworks-agp.c              | 2 +-
 drivers/char/agp/uninorth-agp.c            | 2 +-
 drivers/char/agp/via-agp.c                 | 2 +-
 drivers/char/hw_random/atmel-rng.c         | 2 +-
 drivers/char/hw_random/bcm63xx-rng.c       | 2 +-
 drivers/char/hw_random/exynos-rng.c        | 2 +-
 drivers/char/hw_random/n2-drv.c            | 2 +-
 drivers/char/hw_random/pasemi-rng.c        | 2 +-
 drivers/char/hw_random/picoxcell-rng.c     | 2 +-
 drivers/char/hw_random/ppc4xx-rng.c        | 2 +-
 drivers/char/hw_random/timeriomem-rng.c    | 2 +-
 drivers/char/hw_random/virtio-rng.c        | 2 +-
 drivers/char/ipmi/ipmi_si_intf.c           | 6 +++---
 drivers/char/sonypi.c                      | 2 +-
 drivers/char/tb0219.c                      | 2 +-
 drivers/char/tpm/tpm_i2c_infineon.c        | 2 +-
 drivers/char/tpm/tpm_ibmvtpm.c             | 2 +-
 drivers/char/tpm/tpm_infineon.c            | 2 +-
 drivers/char/tpm/tpm_tis.c                 | 2 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 4 ++--
 30 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/char/agp/ali-agp.c b/drivers/char/agp/ali-agp.c
index 9eb629b..0e69e60 100644
--- a/drivers/char/agp/ali-agp.c
+++ b/drivers/char/agp/ali-agp.c
@@ -374,7 +374,7 @@ found:
 	return agp_add_bridge(bridge);
 }
 
-static void __devexit agp_ali_remove(struct pci_dev *pdev)
+static void agp_ali_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 2e1efa9..cb9c9f9 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -480,7 +480,7 @@ static int agp_amdk7_probe(struct pci_dev *pdev,
 	return agp_add_bridge(bridge);
 }
 
-static void __devexit agp_amdk7_remove(struct pci_dev *pdev)
+static void agp_amdk7_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index f4086c5..280c0d5 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -579,7 +579,7 @@ static int agp_amd64_probe(struct pci_dev *pdev,
 	return 0;
 }
 
-static void __devexit agp_amd64_remove(struct pci_dev *pdev)
+static void agp_amd64_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/ati-agp.c b/drivers/char/agp/ati-agp.c
index 6aeb624..485b15c 100644
--- a/drivers/char/agp/ati-agp.c
+++ b/drivers/char/agp/ati-agp.c
@@ -533,7 +533,7 @@ found:
 	return agp_add_bridge(bridge);
 }
 
-static void __devexit agp_ati_remove(struct pci_dev *pdev)
+static void agp_ati_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/efficeon-agp.c b/drivers/char/agp/efficeon-agp.c
index bf80cf1..08a465e 100644
--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -407,7 +407,7 @@ static int agp_efficeon_probe(struct pci_dev *pdev,
 	return agp_add_bridge(bridge);
 }
 
-static void __devexit agp_efficeon_remove(struct pci_dev *pdev)
+static void agp_efficeon_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/i460-agp.c b/drivers/char/agp/i460-agp.c
index bda2215..0436bf1 100644
--- a/drivers/char/agp/i460-agp.c
+++ b/drivers/char/agp/i460-agp.c
@@ -611,7 +611,7 @@ static int agp_intel_i460_probe(struct pci_dev *pdev,
 	return agp_add_bridge(bridge);
 }
 
-static void __devexit agp_intel_i460_remove(struct pci_dev *pdev)
+static void agp_intel_i460_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index ad6739e..362e744 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -819,7 +819,7 @@ found_gmch:
 	return err;
 }
 
-static void __devexit agp_intel_remove(struct pci_dev *pdev)
+static void agp_intel_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
index 1f7fddf..adaa47b 100644
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -388,7 +388,7 @@ static int agp_nvidia_probe(struct pci_dev *pdev,
 	return agp_add_bridge(bridge);
 }
 
-static void __devexit agp_nvidia_remove(struct pci_dev *pdev)
+static void agp_nvidia_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/sgi-agp.c b/drivers/char/agp/sgi-agp.c
index 8356e89..05b8d02 100644
--- a/drivers/char/agp/sgi-agp.c
+++ b/drivers/char/agp/sgi-agp.c
@@ -327,7 +327,7 @@ static int agp_sgi_init(void)
 	return 0;
 }
 
-static void __devexit agp_sgi_cleanup(void)
+static void agp_sgi_cleanup(void)
 {
 	kfree(sgi_tioca_agp_bridges);
 	sgi_tioca_agp_bridges = NULL;
diff --git a/drivers/char/agp/sis-agp.c b/drivers/char/agp/sis-agp.c
index 7d6f3c6..37ee0eb 100644
--- a/drivers/char/agp/sis-agp.c
+++ b/drivers/char/agp/sis-agp.c
@@ -211,7 +211,7 @@ static int agp_sis_probe(struct pci_dev *pdev,
 	return agp_add_bridge(bridge);
 }
 
-static void __devexit agp_sis_remove(struct pci_dev *pdev)
+static void agp_sis_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
index d1b063b..d046de9 100644
--- a/drivers/char/agp/sworks-agp.c
+++ b/drivers/char/agp/sworks-agp.c
@@ -518,7 +518,7 @@ static int agp_serverworks_probe(struct pci_dev *pdev,
 	return agp_add_bridge(bridge);
 }
 
-static void __devexit agp_serverworks_remove(struct pci_dev *pdev)
+static void agp_serverworks_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index d7168ca..2d29f04 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -663,7 +663,7 @@ static int agp_uninorth_probe(struct pci_dev *pdev,
 	return agp_add_bridge(bridge);
 }
 
-static void __devexit agp_uninorth_remove(struct pci_dev *pdev)
+static void agp_uninorth_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index 774fe1e..8b2c285 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -485,7 +485,7 @@ static int agp_via_probe(struct pci_dev *pdev,
 	return agp_add_bridge(bridge);
 }
 
-static void __devexit agp_via_remove(struct pci_dev *pdev)
+static void agp_via_remove(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index 0f6ca8f..7c73d4a 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -98,7 +98,7 @@ err_enable:
 	return ret;
 }
 
-static int __devexit atmel_trng_remove(struct platform_device *pdev)
+static int atmel_trng_remove(struct platform_device *pdev)
 {
 	struct atmel_trng *trng = platform_get_drvdata(pdev);
 
diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
index c46fc74..f343b7d 100644
--- a/drivers/char/hw_random/bcm63xx-rng.c
+++ b/drivers/char/hw_random/bcm63xx-rng.c
@@ -145,7 +145,7 @@ out:
 	return ret;
 }
 
-static int __devexit bcm63xx_rng_remove(struct platform_device *pdev)
+static int bcm63xx_rng_remove(struct platform_device *pdev)
 {
 	struct hwrng *rng = platform_get_drvdata(pdev);
 	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
diff --git a/drivers/char/hw_random/exynos-rng.c b/drivers/char/hw_random/exynos-rng.c
index 92d302a..48bbfec 100644
--- a/drivers/char/hw_random/exynos-rng.c
+++ b/drivers/char/hw_random/exynos-rng.c
@@ -134,7 +134,7 @@ static int exynos_rng_probe(struct platform_device *pdev)
 	return hwrng_register(&exynos_rng->rng);
 }
 
-static int __devexit exynos_rng_remove(struct platform_device *pdev)
+static int exynos_rng_remove(struct platform_device *pdev)
 {
 	struct exynos_rng *exynos_rng = platform_get_drvdata(pdev);
 
diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index 5819c7b..20b962e 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -719,7 +719,7 @@ out:
 	return err;
 }
 
-static int __devexit n2rng_remove(struct platform_device *op)
+static int n2rng_remove(struct platform_device *op)
 {
 	struct n2rng *np = dev_get_drvdata(&op->dev);
 
diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
index da5dfb5..c6df5b2 100644
--- a/drivers/char/hw_random/pasemi-rng.c
+++ b/drivers/char/hw_random/pasemi-rng.c
@@ -122,7 +122,7 @@ static int rng_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static int __devexit rng_remove(struct platform_device *dev)
+static int rng_remove(struct platform_device *dev)
 {
 	void __iomem *rng_regs = (void __iomem *)pasemi_rng.priv;
 
diff --git a/drivers/char/hw_random/picoxcell-rng.c b/drivers/char/hw_random/picoxcell-rng.c
index b4f7f06..973b951 100644
--- a/drivers/char/hw_random/picoxcell-rng.c
+++ b/drivers/char/hw_random/picoxcell-rng.c
@@ -151,7 +151,7 @@ err_enable:
 	return ret;
 }
 
-static int __devexit picoxcell_trng_remove(struct platform_device *pdev)
+static int picoxcell_trng_remove(struct platform_device *pdev)
 {
 	hwrng_unregister(&picoxcell_trng);
 	clk_disable(rng_clk);
diff --git a/drivers/char/hw_random/ppc4xx-rng.c b/drivers/char/hw_random/ppc4xx-rng.c
index c4b89c2..732c330 100644
--- a/drivers/char/hw_random/ppc4xx-rng.c
+++ b/drivers/char/hw_random/ppc4xx-rng.c
@@ -111,7 +111,7 @@ static int ppc4xx_rng_probe(struct platform_device *dev)
 	return err;
 }
 
-static int __devexit ppc4xx_rng_remove(struct platform_device *dev)
+static int ppc4xx_rng_remove(struct platform_device *dev)
 {
 	void __iomem *rng_regs = (void __iomem *) ppc4xx_rng.priv;
 
diff --git a/drivers/char/hw_random/timeriomem-rng.c b/drivers/char/hw_random/timeriomem-rng.c
index 0153d0c..849db19 100644
--- a/drivers/char/hw_random/timeriomem-rng.c
+++ b/drivers/char/hw_random/timeriomem-rng.c
@@ -130,7 +130,7 @@ failed:
 	return ret;
 }
 
-static int __devexit timeriomem_rng_remove(struct platform_device *pdev)
+static int timeriomem_rng_remove(struct platform_device *pdev)
 {
 	del_timer_sync(&timeriomem_rng_timer);
 	hwrng_unregister(&timeriomem_rng_ops);
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index bb78033..b65c103 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -119,7 +119,7 @@ static int virtrng_probe(struct virtio_device *vdev)
 	return probe_common(vdev);
 }
 
-static void __devexit virtrng_remove(struct virtio_device *vdev)
+static void virtrng_remove(struct virtio_device *vdev)
 {
 	remove_common(vdev);
 }
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 94c5b88..14ab4c4 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2228,7 +2228,7 @@ err_free:
 	return -EINVAL;
 }
 
-static void __devexit ipmi_pnp_remove(struct pnp_dev *dev)
+static void ipmi_pnp_remove(struct pnp_dev *dev)
 {
 	struct smi_info *info = pnp_get_drvdata(dev);
 
@@ -2529,7 +2529,7 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
 	return 0;
 }
 
-static void __devexit ipmi_pci_remove(struct pci_dev *pdev)
+static void ipmi_pci_remove(struct pci_dev *pdev)
 {
 	struct smi_info *info = pci_get_drvdata(pdev);
 	cleanup_one_si(info);
@@ -2635,7 +2635,7 @@ static int ipmi_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit ipmi_remove(struct platform_device *dev)
+static int ipmi_remove(struct platform_device *dev)
 {
 #ifdef CONFIG_OF
 	cleanup_one_si(dev_get_drvdata(&dev->dev));
diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 861efa4..d780295 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1428,7 +1428,7 @@ static int sonypi_probe(struct platform_device *dev)
 	return error;
 }
 
-static int __devexit sonypi_remove(struct platform_device *dev)
+static int sonypi_remove(struct platform_device *dev)
 {
 	sonypi_disable();
 
diff --git a/drivers/char/tb0219.c b/drivers/char/tb0219.c
index 76e3aea..34c63f8 100644
--- a/drivers/char/tb0219.c
+++ b/drivers/char/tb0219.c
@@ -318,7 +318,7 @@ static int tb0219_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit tb0219_remove(struct platform_device *dev)
+static int tb0219_remove(struct platform_device *dev)
 {
 	_machine_restart = old_machine_restart;
 
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index bcdb078..fb447bd 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -656,7 +656,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *client,
 	return rc;
 }
 
-static int __devexit tpm_tis_i2c_remove(struct i2c_client *client)
+static int tpm_tis_i2c_remove(struct i2c_client *client)
 {
 	struct tpm_chip *chip = tpm_dev.chip;
 	release_locality(chip, chip->vendor.locality, 1);
diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index a027bd8..9978609 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -267,7 +267,7 @@ static int ibmvtpm_crq_send_init(struct ibmvtpm_dev *ibmvtpm)
  * Return value:
  *	0
  */
-static int __devexit tpm_ibmvtpm_remove(struct vio_dev *vdev)
+static int tpm_ibmvtpm_remove(struct vio_dev *vdev)
 {
 	struct ibmvtpm_dev *ibmvtpm = ibmvtpm_get_data(&vdev->dev);
 	int rc = 0;
diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 0126e80..2b480c2 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -594,7 +594,7 @@ err_last:
 	return rc;
 }
 
-static __devexit void tpm_inf_pnp_remove(struct pnp_dev *dev)
+static void tpm_inf_pnp_remove(struct pnp_dev *dev)
 {
 	struct tpm_chip *chip = pnp_get_drvdata(dev);
 
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 419a7e0..ea31daf 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -783,7 +783,7 @@ static struct pnp_device_id tpm_pnp_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);
 
-static __devexit void tpm_tis_pnp_remove(struct pnp_dev *dev)
+static void tpm_tis_pnp_remove(struct pnp_dev *dev)
 {
 	struct tpm_chip *chip = pnp_get_drvdata(dev);
 
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index d10085f..5224da52 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -717,7 +717,7 @@ static struct hwicap_driver_config fifo_icap_config = {
 	.reset = fifo_icap_reset,
 };
 
-static int __devexit hwicap_remove(struct device *dev)
+static int hwicap_remove(struct device *dev)
 {
 	struct hwicap_drvdata *drvdata;
 
@@ -822,7 +822,7 @@ static int hwicap_drv_probe(struct platform_device *pdev)
 			&buffer_icap_config, regs);
 }
 
-static int __devexit hwicap_drv_remove(struct platform_device *pdev)
+static int hwicap_drv_remove(struct platform_device *pdev)
 {
 	return hwicap_remove(&pdev->dev);
 }
-- 
1.8.0
