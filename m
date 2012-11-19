Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 6ABFA2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:38:01 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 238/493] mtd: remove use of __devinit
Date: Mon, 19 Nov 2012 13:23:07 -0500
Message-Id: <1353349642-3677-238-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: Wan ZongShun <mcuos.com@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org,
 Olof Johansson <olof@lixom.net>, David Woodhouse <dwmw2@infradead.org>,
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
Cc: David Woodhouse <dwmw2@infradead.org> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Olof Johansson <olof@lixom.net> 
Cc: Kyungmin Park <kyungmin.park@samsung.com> 
Cc: linux-mtd@lists.infradead.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/mtd/devices/m25p80.c           |  4 ++--
 drivers/mtd/devices/mtd_dataflash.c    |  8 ++++----
 drivers/mtd/devices/spear_smi.c        |  6 +++---
 drivers/mtd/devices/sst25l.c           |  4 ++--
 drivers/mtd/maps/amd76xrom.c           |  2 +-
 drivers/mtd/maps/autcpu12-nvram.c      |  2 +-
 drivers/mtd/maps/bfin-async-flash.c    |  2 +-
 drivers/mtd/maps/ck804xrom.c           |  2 +-
 drivers/mtd/maps/esb2rom.c             |  2 +-
 drivers/mtd/maps/gpio-addr-flash.c     |  2 +-
 drivers/mtd/maps/ichxrom.c             |  2 +-
 drivers/mtd/maps/intel_vr_nor.c        |  8 ++++----
 drivers/mtd/maps/lantiq-flash.c        |  2 +-
 drivers/mtd/maps/latch-addr-flash.c    |  2 +-
 drivers/mtd/maps/pci.c                 |  2 +-
 drivers/mtd/maps/physmap_of.c          |  8 ++++----
 drivers/mtd/maps/pismo.c               | 14 +++++++-------
 drivers/mtd/maps/pxa2xx-flash.c        |  2 +-
 drivers/mtd/maps/sa1100-flash.c        |  5 ++---
 drivers/mtd/maps/scb2_flash.c          |  4 ++--
 drivers/mtd/maps/sun_uflash.c          |  2 +-
 drivers/mtd/maps/vmu-flash.c           |  4 ++--
 drivers/mtd/nand/ams-delta.c           |  2 +-
 drivers/mtd/nand/atmel_nand.c          | 12 ++++++------
 drivers/mtd/nand/au1550nd.c            |  4 ++--
 drivers/mtd/nand/bf5xx_nand.c          |  4 ++--
 drivers/mtd/nand/cafe_nand.c           |  8 ++++----
 drivers/mtd/nand/denali_dt.c           |  2 +-
 drivers/mtd/nand/denali_pci.c          |  2 +-
 drivers/mtd/nand/fsl_elbc_nand.c       |  2 +-
 drivers/mtd/nand/fsl_ifc_nand.c        |  2 +-
 drivers/mtd/nand/fsl_upm.c             |  4 ++--
 drivers/mtd/nand/fsmc_nand.c           |  4 ++--
 drivers/mtd/nand/gpio.c                |  2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 16 ++++++++--------
 drivers/mtd/nand/jz4740_nand.c         |  4 ++--
 drivers/mtd/nand/lpc32xx_mlc.c         |  2 +-
 drivers/mtd/nand/lpc32xx_slc.c         |  2 +-
 drivers/mtd/nand/mpc5121_nfc.c         |  2 +-
 drivers/mtd/nand/mxc_nand.c            |  2 +-
 drivers/mtd/nand/ndfc.c                |  2 +-
 drivers/mtd/nand/nuc900_nand.c         |  2 +-
 drivers/mtd/nand/omap2.c               |  2 +-
 drivers/mtd/nand/pasemi_nand.c         |  2 +-
 drivers/mtd/nand/plat_nand.c           |  2 +-
 drivers/mtd/nand/sh_flctl.c            |  2 +-
 drivers/mtd/nand/sharpsl.c             |  2 +-
 drivers/mtd/nand/socrates_nand.c       |  2 +-
 drivers/mtd/onenand/generic.c          |  2 +-
 drivers/mtd/onenand/omap2.c            |  2 +-
 50 files changed, 92 insertions(+), 93 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 9ffd3c5..700f991 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -754,7 +754,7 @@ static const struct spi_device_id m25p_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, m25p_ids);
 
-static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
+static const struct spi_device_id *jedec_probe(struct spi_device *spi)
 {
 	int			tmp;
 	u8			code = OPCODE_RDID;
@@ -799,7 +799,7 @@ static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
  * matches what the READ command supports, at least until this driver
  * understands FAST_READ (for clocks over 25 MHz).
  */
-static int __devinit m25p_probe(struct spi_device *spi)
+static int m25p_probe(struct spi_device *spi)
 {
 	const struct spi_device_id	*id = spi_get_device_id(spi);
 	struct flash_platform_data	*data;
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 23ccc36..080cb1c 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -618,7 +618,7 @@ static char *otp_setup(struct mtd_info *device, char revision)
 /*
  * Register DataFlash device with MTD subsystem.
  */
-static int __devinit
+static int
 add_dataflash_otp(struct spi_device *spi, char *name,
 		int nr_pages, int pagesize, int pageoffset, char revision)
 {
@@ -679,7 +679,7 @@ add_dataflash_otp(struct spi_device *spi, char *name,
 	return err;
 }
 
-static inline int __devinit
+static inline int
 add_dataflash(struct spi_device *spi, char *name,
 		int nr_pages, int pagesize, int pageoffset)
 {
@@ -740,7 +740,7 @@ static struct flash_info __devinitdata dataflash_data [] = {
 	{ "at45db642d",  0x1f2800, 8192, 1024, 10, SUP_POW2PS | IS_POW2PS},
 };
 
-static struct flash_info *__devinit jedec_probe(struct spi_device *spi)
+static struct flash_info *jedec_probe(struct spi_device *spi)
 {
 	int			tmp;
 	uint8_t			code = OP_READ_ID;
@@ -823,7 +823,7 @@ static struct flash_info *__devinit jedec_probe(struct spi_device *spi)
  *   AT45DB0642  64Mbit  (8M)    xx111xxx (0x3c)   8192   1056     11
  *   AT45DB1282  128Mbit (16M)   xx0100xx (0x10)  16384   1056     11
  */
-static int __devinit dataflash_probe(struct spi_device *spi)
+static int dataflash_probe(struct spi_device *spi)
 {
 	int status;
 	struct flash_info	*info;
diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index e27737c..a30cd27 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -756,7 +756,7 @@ err_probe:
 
 
 #ifdef CONFIG_OF
-static int __devinit spear_smi_probe_config_dt(struct platform_device *pdev,
+static int spear_smi_probe_config_dt(struct platform_device *pdev,
 					       struct device_node *np)
 {
 	struct spear_smi_plat_data *pdata = dev_get_platdata(&pdev->dev);
@@ -799,7 +799,7 @@ static int __devinit spear_smi_probe_config_dt(struct platform_device *pdev,
 	return 0;
 }
 #else
-static int __devinit spear_smi_probe_config_dt(struct platform_device *pdev,
+static int spear_smi_probe_config_dt(struct platform_device *pdev,
 					       struct device_node *np)
 {
 	return -ENOSYS;
@@ -901,7 +901,7 @@ static int spear_smi_setup_banks(struct platform_device *pdev,
  * and do proper init for any found one.
  * Returns 0 on success, non zero otherwise
  */
-static int __devinit spear_smi_probe(struct platform_device *pdev)
+static int spear_smi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct spear_smi_plat_data *pdata = NULL;
diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index 9ebf86d..ab4154d 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -313,7 +313,7 @@ out:
 	return ret;
 }
 
-static struct flash_info *__devinit sst25l_match_device(struct spi_device *spi)
+static struct flash_info *sst25l_match_device(struct spi_device *spi)
 {
 	struct flash_info *flash_info = NULL;
 	struct spi_message m;
@@ -353,7 +353,7 @@ static struct flash_info *__devinit sst25l_match_device(struct spi_device *spi)
 	return flash_info;
 }
 
-static int __devinit sst25l_probe(struct spi_device *spi)
+static int sst25l_probe(struct spi_device *spi)
 {
 	struct flash_info *flash_info;
 	struct sst25l_flash *flash;
diff --git a/drivers/mtd/maps/amd76xrom.c b/drivers/mtd/maps/amd76xrom.c
index e2875d6..1a4f671 100644
--- a/drivers/mtd/maps/amd76xrom.c
+++ b/drivers/mtd/maps/amd76xrom.c
@@ -100,7 +100,7 @@ static void amd76xrom_cleanup(struct amd76xrom_window *window)
 }
 
 
-static int __devinit amd76xrom_init_one (struct pci_dev *pdev,
+static int amd76xrom_init_one (struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
 	static char *rom_probe_types[] = { "cfi_probe", "jedec_probe", NULL };
diff --git a/drivers/mtd/maps/autcpu12-nvram.c b/drivers/mtd/maps/autcpu12-nvram.c
index ca0313d..b8c8589 100644
--- a/drivers/mtd/maps/autcpu12-nvram.c
+++ b/drivers/mtd/maps/autcpu12-nvram.c
@@ -33,7 +33,7 @@ struct autcpu12_nvram_priv {
 	struct map_info map;
 };
 
-static int __devinit autcpu12_nvram_probe(struct platform_device *pdev)
+static int autcpu12_nvram_probe(struct platform_device *pdev)
 {
 	map_word tmp, save0, save1;
 	struct resource *res;
diff --git a/drivers/mtd/maps/bfin-async-flash.c b/drivers/mtd/maps/bfin-async-flash.c
index 340e8a2..658a7d0 100644
--- a/drivers/mtd/maps/bfin-async-flash.c
+++ b/drivers/mtd/maps/bfin-async-flash.c
@@ -123,7 +123,7 @@ static void bfin_flash_copy_to(struct map_info *map, unsigned long to, const voi
 
 static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", NULL };
 
-static int __devinit bfin_flash_probe(struct platform_device *pdev)
+static int bfin_flash_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct physmap_flash_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/mtd/maps/ck804xrom.c b/drivers/mtd/maps/ck804xrom.c
index 3d0e762..65fedb9 100644
--- a/drivers/mtd/maps/ck804xrom.c
+++ b/drivers/mtd/maps/ck804xrom.c
@@ -112,7 +112,7 @@ static void ck804xrom_cleanup(struct ck804xrom_window *window)
 }
 
 
-static int __devinit ck804xrom_init_one (struct pci_dev *pdev,
+static int ck804xrom_init_one (struct pci_dev *pdev,
 					 const struct pci_device_id *ent)
 {
 	static char *rom_probe_types[] = { "cfi_probe", "jedec_probe", NULL };
diff --git a/drivers/mtd/maps/esb2rom.c b/drivers/mtd/maps/esb2rom.c
index 08322b1..3797825 100644
--- a/drivers/mtd/maps/esb2rom.c
+++ b/drivers/mtd/maps/esb2rom.c
@@ -144,7 +144,7 @@ static void esb2rom_cleanup(struct esb2rom_window *window)
 	pci_dev_put(window->pdev);
 }
 
-static int __devinit esb2rom_init_one(struct pci_dev *pdev,
+static int esb2rom_init_one(struct pci_dev *pdev,
 				      const struct pci_device_id *ent)
 {
 	static char *rom_probe_types[] = { "cfi_probe", "jedec_probe", NULL };
diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 670af9a..9a6a3e1 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -185,7 +185,7 @@ static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", NULL };
  *	...
  * };
  */
-static int __devinit gpio_flash_probe(struct platform_device *pdev)
+static int gpio_flash_probe(struct platform_device *pdev)
 {
 	size_t i, arr_size;
 	struct physmap_flash_data *pdata;
diff --git a/drivers/mtd/maps/ichxrom.c b/drivers/mtd/maps/ichxrom.c
index 6689dcb..a9bab67 100644
--- a/drivers/mtd/maps/ichxrom.c
+++ b/drivers/mtd/maps/ichxrom.c
@@ -84,7 +84,7 @@ static void ichxrom_cleanup(struct ichxrom_window *window)
 }
 
 
-static int __devinit ichxrom_init_one (struct pci_dev *pdev,
+static int ichxrom_init_one (struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
 	static char *rom_probe_types[] = { "cfi_probe", "jedec_probe", NULL };
diff --git a/drivers/mtd/maps/intel_vr_nor.c b/drivers/mtd/maps/intel_vr_nor.c
index f6185d4..1694c03 100644
--- a/drivers/mtd/maps/intel_vr_nor.c
+++ b/drivers/mtd/maps/intel_vr_nor.c
@@ -68,7 +68,7 @@ static void __devexit vr_nor_destroy_partitions(struct vr_nor_mtd *p)
 	mtd_device_unregister(p->info);
 }
 
-static int __devinit vr_nor_init_partitions(struct vr_nor_mtd *p)
+static int vr_nor_init_partitions(struct vr_nor_mtd *p)
 {
 	/* register the flash bank */
 	/* partition the flash bank */
@@ -80,7 +80,7 @@ static void __devexit vr_nor_destroy_mtd_setup(struct vr_nor_mtd *p)
 	map_destroy(p->info);
 }
 
-static int __devinit vr_nor_mtd_setup(struct vr_nor_mtd *p)
+static int vr_nor_mtd_setup(struct vr_nor_mtd *p)
 {
 	static const char *probe_types[] =
 	    { "cfi_probe", "jedec_probe", NULL };
@@ -116,7 +116,7 @@ static void __devexit vr_nor_destroy_maps(struct vr_nor_mtd *p)
  * Initialize the map_info structure and map the flash.
  * Returns 0 on success, nonzero otherwise.
  */
-static int __devinit vr_nor_init_maps(struct vr_nor_mtd *p)
+static int vr_nor_init_maps(struct vr_nor_mtd *p)
 {
 	unsigned long csr_phys, csr_len;
 	unsigned long win_phys, win_len;
@@ -189,7 +189,7 @@ static void __devexit vr_nor_pci_remove(struct pci_dev *dev)
 	pci_disable_device(dev);
 }
 
-static int __devinit
+static int
 vr_nor_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct vr_nor_mtd *p = NULL;
diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index 4c032f1..58d1f61 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -109,7 +109,7 @@ ltq_copy_to(struct map_info *map, unsigned long to,
 	spin_unlock_irqrestore(&ebu_lock, flags);
 }
 
-static int __devinit
+static int
 ltq_mtd_probe(struct platform_device *pdev)
 {
 	struct mtd_part_parser_data ppdata;
diff --git a/drivers/mtd/maps/latch-addr-flash.c b/drivers/mtd/maps/latch-addr-flash.c
index 962a76a..ab0fead 100644
--- a/drivers/mtd/maps/latch-addr-flash.c
+++ b/drivers/mtd/maps/latch-addr-flash.c
@@ -125,7 +125,7 @@ static int latch_addr_flash_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int __devinit latch_addr_flash_probe(struct platform_device *dev)
+static int latch_addr_flash_probe(struct platform_device *dev)
 {
 	struct latch_addr_flash_data *latch_addr_data;
 	struct latch_addr_flash_info *info;
diff --git a/drivers/mtd/maps/pci.c b/drivers/mtd/maps/pci.c
index ddc8c0c..81a8caf 100644
--- a/drivers/mtd/maps/pci.c
+++ b/drivers/mtd/maps/pci.c
@@ -253,7 +253,7 @@ static struct pci_device_id mtd_pci_ids[] = {
  * Generic code follows.
  */
 
-static int __devinit
+static int
 mtd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct mtd_pci_info *info = (struct mtd_pci_info *)id->driver_data;
diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 6f19aca..55c37ed 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -77,7 +77,7 @@ static int of_flash_remove(struct platform_device *dev)
 /* Helper function to handle probing of the obsolete "direct-mapped"
  * compatible binding, which has an extra "probe-type" property
  * describing the type of flash probe necessary. */
-static struct mtd_info * __devinit obsolete_probe(struct platform_device *dev,
+static struct mtd_info *obsolete_probe(struct platform_device *dev,
 						  struct map_info *map)
 {
 	struct device_node *dp = dev->dev.of_node;
@@ -116,7 +116,7 @@ static struct mtd_info * __devinit obsolete_probe(struct platform_device *dev,
    information. */
 static const char *part_probe_types_def[] = { "cmdlinepart", "RedBoot",
 					"ofpart", "ofoldpart", NULL };
-static const char ** __devinit of_get_probes(struct device_node *dp)
+static const char **of_get_probes(struct device_node *dp)
 {
 	const char *cp;
 	int cplen;
@@ -145,14 +145,14 @@ static const char ** __devinit of_get_probes(struct device_node *dp)
 	return res;
 }
 
-static void __devinit of_free_probes(const char **probes)
+static void of_free_probes(const char **probes)
 {
 	if (probes != part_probe_types_def)
 		kfree(probes);
 }
 
 static struct of_device_id of_flash_match[];
-static int __devinit of_flash_probe(struct platform_device *dev)
+static int of_flash_probe(struct platform_device *dev)
 {
 	const char **part_probe_types;
 	const struct of_device_id *match;
diff --git a/drivers/mtd/maps/pismo.c b/drivers/mtd/maps/pismo.c
index 9f4e594..01db0d0 100644
--- a/drivers/mtd/maps/pismo.c
+++ b/drivers/mtd/maps/pismo.c
@@ -58,7 +58,7 @@ static void pismo_set_vpp(struct platform_device *pdev, int on)
 	pismo->vpp(pismo->vpp_data, on);
 }
 
-static unsigned int __devinit pismo_width_to_bytes(unsigned int width)
+static unsigned int pismo_width_to_bytes(unsigned int width)
 {
 	width &= 15;
 	if (width > 2)
@@ -66,7 +66,7 @@ static unsigned int __devinit pismo_width_to_bytes(unsigned int width)
 	return 1 << width;
 }
 
-static int __devinit pismo_eeprom_read(struct i2c_client *client, void *buf,
+static int pismo_eeprom_read(struct i2c_client *client, void *buf,
 	u8 addr, size_t size)
 {
 	int ret;
@@ -88,7 +88,7 @@ static int __devinit pismo_eeprom_read(struct i2c_client *client, void *buf,
 	return ret == ARRAY_SIZE(msg) ? size : -EIO;
 }
 
-static int __devinit pismo_add_device(struct pismo_data *pismo, int i,
+static int pismo_add_device(struct pismo_data *pismo, int i,
 	struct pismo_mem *region, const char *name, void *pdata, size_t psize)
 {
 	struct platform_device *dev;
@@ -129,7 +129,7 @@ static int __devinit pismo_add_device(struct pismo_data *pismo, int i,
 	return ret;
 }
 
-static int __devinit pismo_add_nor(struct pismo_data *pismo, int i,
+static int pismo_add_nor(struct pismo_data *pismo, int i,
 	struct pismo_mem *region)
 {
 	struct physmap_flash_data data = {
@@ -143,7 +143,7 @@ static int __devinit pismo_add_nor(struct pismo_data *pismo, int i,
 		&data, sizeof(data));
 }
 
-static int __devinit pismo_add_sram(struct pismo_data *pismo, int i,
+static int pismo_add_sram(struct pismo_data *pismo, int i,
 	struct pismo_mem *region)
 {
 	struct platdata_mtd_ram data = {
@@ -154,7 +154,7 @@ static int __devinit pismo_add_sram(struct pismo_data *pismo, int i,
 		&data, sizeof(data));
 }
 
-static void __devinit pismo_add_one(struct pismo_data *pismo, int i,
+static void pismo_add_one(struct pismo_data *pismo, int i,
 	const struct pismo_cs_block *cs, phys_addr_t base)
 {
 	struct device *dev = &pismo->client->dev;
@@ -210,7 +210,7 @@ static int __devexit pismo_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int __devinit pismo_probe(struct i2c_client *client,
+static int pismo_probe(struct i2c_client *client,
 				 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
diff --git a/drivers/mtd/maps/pxa2xx-flash.c b/drivers/mtd/maps/pxa2xx-flash.c
index f913a1c..b5120f9 100644
--- a/drivers/mtd/maps/pxa2xx-flash.c
+++ b/drivers/mtd/maps/pxa2xx-flash.c
@@ -49,7 +49,7 @@ struct pxa2xx_flash_info {
 static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };
 
 
-static int __devinit pxa2xx_flash_probe(struct platform_device *pdev)
+static int pxa2xx_flash_probe(struct platform_device *pdev)
 {
 	struct flash_platform_data *flash = pdev->dev.platform_data;
 	struct pxa2xx_flash_info *info;
diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
index a675bdb..7aebc82 100644
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -149,8 +149,7 @@ static void sa1100_destroy(struct sa_info *info, struct flash_platform_data *pla
 		plat->exit();
 }
 
-static struct sa_info *__devinit
-sa1100_setup_mtd(struct platform_device *pdev, struct flash_platform_data *plat)
+static struct sa_info *sa1100_setup_mtd(struct platform_device *pdev, struct flash_platform_data *plat)
 {
 	struct sa_info *info;
 	int nr, size, i, ret = 0;
@@ -246,7 +245,7 @@ sa1100_setup_mtd(struct platform_device *pdev, struct flash_platform_data *plat)
 
 static const char *part_probes[] = { "cmdlinepart", "RedBoot", NULL };
 
-static int __devinit sa1100_mtd_probe(struct platform_device *pdev)
+static int sa1100_mtd_probe(struct platform_device *pdev)
 {
 	struct flash_platform_data *plat = pdev->dev.platform_data;
 	struct sa_info *info;
diff --git a/drivers/mtd/maps/scb2_flash.c b/drivers/mtd/maps/scb2_flash.c
index d527608..bb1857f 100644
--- a/drivers/mtd/maps/scb2_flash.c
+++ b/drivers/mtd/maps/scb2_flash.c
@@ -69,7 +69,7 @@ static struct map_info scb2_map = {
 };
 static int region_fail;
 
-static int __devinit
+static int
 scb2_fixup_mtd(struct mtd_info *mtd)
 {
 	int i;
@@ -133,7 +133,7 @@ scb2_fixup_mtd(struct mtd_info *mtd)
 /* CSB5's 'Function Control Register' has bits for decoding @ >= 0xffc00000 */
 #define CSB5_FCR	0x41
 #define CSB5_FCR_DECODE_ALL 0x0e
-static int __devinit
+static int
 scb2_flash_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 {
 	u8 reg;
diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index 1c03ca7..2618e4d 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -108,7 +108,7 @@ int uflash_devinit(struct platform_device *op, struct device_node *dp)
 	return 0;
 }
 
-static int __devinit uflash_probe(struct platform_device *op)
+static int uflash_probe(struct platform_device *op)
 {
 	struct device_node *dp = op->dev.of_node;
 
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 5a83a26..84c3f5a 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -596,7 +596,7 @@ fail_name:
 }
 
 /* Handles very basic info about the flash, queries for details */
-static int __devinit vmu_connect(struct maple_device *mdev)
+static int vmu_connect(struct maple_device *mdev)
 {
 	unsigned long test_flash_data, basic_flash_data;
 	int c, error;
@@ -772,7 +772,7 @@ static void vmu_file_error(struct maple_device *mdev, void *recvbuf)
 }
 
 
-static int __devinit probe_maple_vmu(struct device *dev)
+static int probe_maple_vmu(struct device *dev)
 {
 	int error;
 	struct maple_device *mdev = to_maple_dev(dev);
diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 51dba43..703e373 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -173,7 +173,7 @@ static const struct gpio _mandatory_gpio[] = {
 /*
  * Main initialization routine
  */
-static int __devinit ams_delta_init(struct platform_device *pdev)
+static int ams_delta_init(struct platform_device *pdev)
 {
 	struct nand_chip *this;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 92623ac..aa3cb85 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -331,13 +331,13 @@ static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
  *               12-bits                20-bytes                 21-bytes
  *               24-bits                39-bytes                 42-bytes
  */
-static int __devinit pmecc_get_ecc_bytes(int cap, int sector_size)
+static int pmecc_get_ecc_bytes(int cap, int sector_size)
 {
 	int m = 12 + sector_size / 512;
 	return (m * cap + 7) / 8;
 }
 
-static void __devinit pmecc_config_ecc_layout(struct nand_ecclayout *layout,
+static void pmecc_config_ecc_layout(struct nand_ecclayout *layout,
 	int oobsize, int ecc_len)
 {
 	int i;
@@ -353,7 +353,7 @@ static void __devinit pmecc_config_ecc_layout(struct nand_ecclayout *layout,
 		oobsize - ecc_len - layout->oobfree[0].offset;
 }
 
-static void __devinit __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
+static void __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
 {
 	int table_size;
 
@@ -375,7 +375,7 @@ static void pmecc_data_free(struct atmel_nand_host *host)
 	kfree(host->pmecc_delta);
 }
 
-static int __devinit pmecc_data_alloc(struct atmel_nand_host *host)
+static int pmecc_data_alloc(struct atmel_nand_host *host)
 {
 	const int cap = host->pmecc_corr_cap;
 
@@ -1206,7 +1206,7 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
 }
 
 #if defined(CONFIG_OF)
-static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
+static int atmel_of_init_port(struct atmel_nand_host *host,
 					 struct device_node *np)
 {
 	u32 val, table_offset;
@@ -1293,7 +1293,7 @@ static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
 	return 0;
 }
 #else
-static int __devinit atmel_of_init_port(struct atmel_nand_host *host,
+static int atmel_of_init_port(struct atmel_nand_host *host,
 					 struct device_node *np)
 {
 	return -EINVAL;
diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index d84af46..73d6423 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -382,7 +382,7 @@ static void au1550_command(struct mtd_info *mtd, unsigned command, int column, i
 	while(!this->dev_ready(mtd));
 }
 
-static int __devinit find_nand_cs(unsigned long nand_base)
+static int find_nand_cs(unsigned long nand_base)
 {
 	void __iomem *base =
 			(void __iomem *)KSEG1ADDR(AU1000_STATIC_MEM_PHYS_ADDR);
@@ -403,7 +403,7 @@ static int __devinit find_nand_cs(unsigned long nand_base)
 	return -ENODEV;
 }
 
-static int __devinit au1550nd_probe(struct platform_device *pdev)
+static int au1550nd_probe(struct platform_device *pdev)
 {
 	struct au1550nd_platdata *pd;
 	struct au1550nd_ctx *ctx;
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 0afd4ac..56de9b6 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -658,7 +658,7 @@ static int bf5xx_nand_hw_init(struct bf5xx_nand_info *info)
 /*
  * Device management interface
  */
-static int __devinit bf5xx_nand_add_partition(struct bf5xx_nand_info *info)
+static int bf5xx_nand_add_partition(struct bf5xx_nand_info *info)
 {
 	struct mtd_info *mtd = &info->mtd;
 	struct mtd_partition *parts = info->platform->partitions;
@@ -725,7 +725,7 @@ static int bf5xx_nand_scan(struct mtd_info *mtd)
  * it can allocate all necessary resources then calls the
  * nand layer to look for devices
  */
-static int __devinit bf5xx_nand_probe(struct platform_device *pdev)
+static int bf5xx_nand_probe(struct platform_device *pdev)
 {
 	struct bf5xx_nand_platform *plat = to_nand_plat(pdev);
 	struct bf5xx_nand_info *info = NULL;
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 1b62f04..480834a 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -585,7 +585,7 @@ static int cafe_nand_block_bad(struct mtd_info *mtd, loff_t ofs, int getchip)
 }
 
 /* F_2[X]/(X**6+X+1)  */
-static unsigned short __devinit gf64_mul(u8 a, u8 b)
+static unsigned short gf64_mul(u8 a, u8 b)
 {
 	u8 c;
 	unsigned int i;
@@ -604,7 +604,7 @@ static unsigned short __devinit gf64_mul(u8 a, u8 b)
 }
 
 /* F_64[X]/(X**2+X+A**-1) with A the generator of F_64[X]  */
-static u16 __devinit gf4096_mul(u16 a, u16 b)
+static u16 gf4096_mul(u16 a, u16 b)
 {
 	u8 ah, al, bh, bl, ch, cl;
 
@@ -619,14 +619,14 @@ static u16 __devinit gf4096_mul(u16 a, u16 b)
 	return (ch << 6) ^ cl;
 }
 
-static int __devinit cafe_mul(int x)
+static int cafe_mul(int x)
 {
 	if (x == 0)
 		return 1;
 	return gf4096_mul(x, 0xe01);
 }
 
-static int __devinit cafe_nand_probe(struct pci_dev *pdev,
+static int cafe_nand_probe(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
 	struct mtd_info *mtd;
diff --git a/drivers/mtd/nand/denali_dt.c b/drivers/mtd/nand/denali_dt.c
index 445de7c..f9b593c 100644
--- a/drivers/mtd/nand/denali_dt.c
+++ b/drivers/mtd/nand/denali_dt.c
@@ -57,7 +57,7 @@ MODULE_DEVICE_TABLE(of, denali_nand_dt_ids);
 
 static u64 denali_dma_mask;
 
-static int __devinit denali_dt_probe(struct platform_device *ofdev)
+static int denali_dt_probe(struct platform_device *ofdev)
 {
 	struct resource *denali_reg, *nand_data;
 	struct denali_dt *dt;
diff --git a/drivers/mtd/nand/denali_pci.c b/drivers/mtd/nand/denali_pci.c
index ea074e6..f1f8f89 100644
--- a/drivers/mtd/nand/denali_pci.c
+++ b/drivers/mtd/nand/denali_pci.c
@@ -130,7 +130,7 @@ static struct pci_driver denali_pci_driver = {
 	.remove = denali_pci_remove,
 };
 
-static int __devinit denali_init_pci(void)
+static int denali_init_pci(void)
 {
 	pr_info("Spectra MTD driver built on %s @ %s\n", __DATE__, __TIME__);
 	return pci_register_driver(&denali_pci_driver);
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 4c4d3e5..2065720 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -799,7 +799,7 @@ static int fsl_elbc_chip_remove(struct fsl_elbc_mtd *priv)
 
 static DEFINE_MUTEX(fsl_elbc_nand_mutex);
 
-static int __devinit fsl_elbc_nand_probe(struct platform_device *pdev)
+static int fsl_elbc_nand_probe(struct platform_device *pdev)
 {
 	struct fsl_lbc_regs __iomem *lbc;
 	struct fsl_elbc_mtd *priv;
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 3551a99..4fa9ac5 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -922,7 +922,7 @@ static int match_bank(struct fsl_ifc_regs __iomem *ifc, int bank,
 
 static DEFINE_MUTEX(fsl_ifc_nand_mutex);
 
-static int __devinit fsl_ifc_nand_probe(struct platform_device *dev)
+static int fsl_ifc_nand_probe(struct platform_device *dev)
 {
 	struct fsl_ifc_regs __iomem *ifc;
 	struct fsl_ifc_mtd *priv;
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index b40661d..a564325 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -152,7 +152,7 @@ static void fun_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 		fun_wait_rnb(fun);
 }
 
-static int __devinit fun_chip_init(struct fsl_upm_nand *fun,
+static int fun_chip_init(struct fsl_upm_nand *fun,
 				   const struct device_node *upm_np,
 				   const struct resource *io_res)
 {
@@ -201,7 +201,7 @@ err:
 	return ret;
 }
 
-static int __devinit fun_probe(struct platform_device *ofdev)
+static int fun_probe(struct platform_device *ofdev)
 {
 	struct fsl_upm_nand *fun;
 	struct resource io_res;
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 6b59223..1d74464 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -864,7 +864,7 @@ static bool filter(struct dma_chan *chan, void *slave)
 }
 
 #ifdef CONFIG_OF
-static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
+static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
 					       struct device_node *np)
 {
 	struct fsmc_nand_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -886,7 +886,7 @@ static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
 	return 0;
 }
 #else
-static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
+static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
 					       struct device_node *np)
 {
 	return -ENOSYS;
diff --git a/drivers/mtd/nand/gpio.c b/drivers/mtd/nand/gpio.c
index 0b3c815..45f1a24 100644
--- a/drivers/mtd/nand/gpio.c
+++ b/drivers/mtd/nand/gpio.c
@@ -282,7 +282,7 @@ static void __iomem *request_and_remap(struct resource *res, size_t size,
 	return ptr;
 }
 
-static int __devinit gpio_nand_probe(struct platform_device *dev)
+static int gpio_nand_probe(struct platform_device *dev)
 {
 	struct gpiomtd *gpiomtd;
 	struct nand_chip *this;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 7ce6d01..2a251c9 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -319,7 +319,7 @@ int start_dma_with_bch_irq(struct gpmi_nand_data *this,
 	return 0;
 }
 
-static int __devinit
+static int
 acquire_register_block(struct gpmi_nand_data *this, const char *res_name)
 {
 	struct platform_device *pdev = this->pdev;
@@ -360,7 +360,7 @@ static void release_register_block(struct gpmi_nand_data *this)
 	res->bch_regs = NULL;
 }
 
-static int __devinit
+static int
 acquire_bch_irq(struct gpmi_nand_data *this, irq_handler_t irq_h)
 {
 	struct platform_device *pdev = this->pdev;
@@ -427,7 +427,7 @@ static void release_dma_channels(struct gpmi_nand_data *this)
 		}
 }
 
-static int __devinit acquire_dma_channels(struct gpmi_nand_data *this)
+static int acquire_dma_channels(struct gpmi_nand_data *this)
 {
 	struct platform_device *pdev = this->pdev;
 	struct resource *r_dma;
@@ -492,7 +492,7 @@ static char *extra_clks_for_mx6q[GPMI_CLK_MAX] = {
 	"gpmi_apb", "gpmi_bch", "gpmi_bch_apb", "per1_bch",
 };
 
-static int __devinit gpmi_get_clks(struct gpmi_nand_data *this)
+static int gpmi_get_clks(struct gpmi_nand_data *this)
 {
 	struct resources *r = &this->resources;
 	char **extra_clks = NULL;
@@ -538,7 +538,7 @@ err_clock:
 	return -ENOMEM;
 }
 
-static int __devinit acquire_resources(struct gpmi_nand_data *this)
+static int acquire_resources(struct gpmi_nand_data *this)
 {
 	struct pinctrl *pinctrl;
 	int ret;
@@ -588,7 +588,7 @@ static void release_resources(struct gpmi_nand_data *this)
 	release_dma_channels(this);
 }
 
-static int __devinit init_hardware(struct gpmi_nand_data *this)
+static int init_hardware(struct gpmi_nand_data *this)
 {
 	int ret;
 
@@ -1542,7 +1542,7 @@ static void gpmi_nfc_exit(struct gpmi_nand_data *this)
 	gpmi_free_dma_buffer(this);
 }
 
-static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
+static int gpmi_nfc_init(struct gpmi_nand_data *this)
 {
 	struct mtd_info  *mtd = &this->mtd;
 	struct nand_chip *chip = &this->nand;
@@ -1625,7 +1625,7 @@ static const struct of_device_id gpmi_nand_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, gpmi_nand_id_table);
 
-static int __devinit gpmi_nand_probe(struct platform_device *pdev)
+static int gpmi_nand_probe(struct platform_device *pdev)
 {
 	struct gpmi_nand_data *this;
 	const struct of_device_id *of_id;
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 2552fe2..5396b6c 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -322,7 +322,7 @@ static inline void jz_nand_iounmap_resource(struct resource *res, void __iomem *
 	release_mem_region(res->start, resource_size(res));
 }
 
-static int __devinit jz_nand_detect_bank(struct platform_device *pdev, struct jz_nand *nand, unsigned char bank, size_t chipnr, uint8_t *nand_maf_id, uint8_t *nand_dev_id) {
+static int jz_nand_detect_bank(struct platform_device *pdev, struct jz_nand *nand, unsigned char bank, size_t chipnr, uint8_t *nand_maf_id, uint8_t *nand_dev_id) {
 	int ret;
 	int gpio;
 	char gpio_name[9];
@@ -400,7 +400,7 @@ notfound_gpio:
 	return ret;
 }
 
-static int __devinit jz_nand_probe(struct platform_device *pdev)
+static int jz_nand_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz_nand *nand;
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 3115642..bb83daf 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -655,7 +655,7 @@ static struct lpc32xx_nand_cfg_mlc *lpc32xx_parse_dt(struct device *dev)
 /*
  * Probe for NAND controller
  */
-static int __devinit lpc32xx_nand_probe(struct platform_device *pdev)
+static int lpc32xx_nand_probe(struct platform_device *pdev)
 {
 	struct lpc32xx_nand_host *host;
 	struct mtd_info *mtd;
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 9e291b7..17267f2 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -755,7 +755,7 @@ static struct lpc32xx_nand_cfg_slc *lpc32xx_parse_dt(struct device *dev)
 /*
  * Probe for NAND controller
  */
-static int __devinit lpc32xx_nand_probe(struct platform_device *pdev)
+static int lpc32xx_nand_probe(struct platform_device *pdev)
 {
 	struct lpc32xx_nand_host *host;
 	struct mtd_info *mtd;
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 17fe0c9..f779e6a 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -626,7 +626,7 @@ static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
 		iounmap(prv->csreg);
 }
 
-static int __devinit mpc5121_nfc_probe(struct platform_device *op)
+static int mpc5121_nfc_probe(struct platform_device *op)
 {
 	struct device_node *rootnode, *dn = op->dev.of_node;
 	struct device *dev = &op->dev;
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index fbcb317..0887c2c 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1378,7 +1378,7 @@ static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
 }
 #endif
 
-static int __devinit mxcnd_probe(struct platform_device *pdev)
+static int mxcnd_probe(struct platform_device *pdev)
 {
 	struct nand_chip *this;
 	struct mtd_info *mtd;
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 32e6bef..6fa4588 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -197,7 +197,7 @@ err:
 	return ret;
 }
 
-static int __devinit ndfc_probe(struct platform_device *ofdev)
+static int ndfc_probe(struct platform_device *ofdev)
 {
 	struct ndfc_controller *ndfc;
 	const __be32 *reg;
diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index eed134c..00766df 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -246,7 +246,7 @@ static void nuc900_nand_enable(struct nuc900_nand *nand)
 	spin_unlock(&nand->lock);
 }
 
-static int __devinit nuc900_nand_probe(struct platform_device *pdev)
+static int nuc900_nand_probe(struct platform_device *pdev)
 {
 	struct nuc900_nand *nuc900_nand;
 	struct nand_chip *chip;
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 5c8978e..359293e 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1324,7 +1324,7 @@ static void omap3_free_bch(struct mtd_info *mtd)
 }
 #endif /* CONFIG_MTD_NAND_OMAP_BCH */
 
-static int __devinit omap_nand_probe(struct platform_device *pdev)
+static int omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
 	struct omap_nand_platform_data	*pdata;
diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index 1440e51..2e477cb 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -89,7 +89,7 @@ int pasemi_device_ready(struct mtd_info *mtd)
 	return !!(inl(lpcctl) & LBICTRL_LPCCTL_NR);
 }
 
-static int __devinit pasemi_nand_probe(struct platform_device *ofdev)
+static int pasemi_nand_probe(struct platform_device *ofdev)
 {
 	struct pci_dev *pdev;
 	struct device_node *np = ofdev->dev.of_node;
diff --git a/drivers/mtd/nand/plat_nand.c b/drivers/mtd/nand/plat_nand.c
index 95a1dba..32e2996 100644
--- a/drivers/mtd/nand/plat_nand.c
+++ b/drivers/mtd/nand/plat_nand.c
@@ -28,7 +28,7 @@ static const char *part_probe_types[] = { "cmdlinepart", NULL };
 /*
  * Probe for the NAND device.
  */
-static int __devinit plat_nand_probe(struct platform_device *pdev)
+static int plat_nand_probe(struct platform_device *pdev)
 {
 	struct platform_nand_data *pdata = pdev->dev.platform_data;
 	struct mtd_part_parser_data ppdata;
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 44a95da..607e6bd 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -1088,7 +1088,7 @@ static struct sh_flctl_platform_data *flctl_parse_dt(struct device *dev)
 }
 #endif /* CONFIG_OF */
 
-static int __devinit flctl_probe(struct platform_device *pdev)
+static int flctl_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct sh_flctl *flctl;
diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 541fd51..870f0ff 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -106,7 +106,7 @@ static int sharpsl_nand_calculate_ecc(struct mtd_info *mtd, const u_char * dat,
 /*
  * Main initialization routine
  */
-static int __devinit sharpsl_nand_probe(struct platform_device *pdev)
+static int sharpsl_nand_probe(struct platform_device *pdev)
 {
 	struct nand_chip *this;
 	struct resource *r;
diff --git a/drivers/mtd/nand/socrates_nand.c b/drivers/mtd/nand/socrates_nand.c
index 78b1a04..c9791fd 100644
--- a/drivers/mtd/nand/socrates_nand.c
+++ b/drivers/mtd/nand/socrates_nand.c
@@ -140,7 +140,7 @@ static int socrates_nand_device_ready(struct mtd_info *mtd)
 /*
  * Probe for the NAND device.
  */
-static int __devinit socrates_nand_probe(struct platform_device *ofdev)
+static int socrates_nand_probe(struct platform_device *ofdev)
 {
 	struct socrates_nand_host *host;
 	struct mtd_info *mtd;
diff --git a/drivers/mtd/onenand/generic.c b/drivers/mtd/onenand/generic.c
index 27aa44a..03e6af3 100644
--- a/drivers/mtd/onenand/generic.c
+++ b/drivers/mtd/onenand/generic.c
@@ -35,7 +35,7 @@ struct onenand_info {
 	struct onenand_chip	onenand;
 };
 
-static int __devinit generic_onenand_probe(struct platform_device *pdev)
+static int generic_onenand_probe(struct platform_device *pdev)
 {
 	struct onenand_info *info;
 	struct onenand_platform_data *pdata = pdev->dev.platform_data;
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index cb8ba6a..0c75bcc 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -630,7 +630,7 @@ static int omap2_onenand_disable(struct mtd_info *mtd)
 	return ret;
 }
 
-static int __devinit omap2_onenand_probe(struct platform_device *pdev)
+static int omap2_onenand_probe(struct platform_device *pdev)
 {
 	struct omap_onenand_platform_data *pdata;
 	struct omap2_onenand *c;
-- 
1.8.0
