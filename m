Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03169B7254
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:06:31 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9173Uos020170
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:03:30 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9176V9N2138158
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:31 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9176TWh005798
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:31 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH 15/18] mtd: Fix endianness issues from device tree
Date: Fri,  1 Oct 2010 17:06:08 +1000
Message-Id: <1285916771-18033-16-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Julia Lawall <julia@diku.dk>, Ian Munsie <imunsie@au1.ibm.com>,
	linux-mtd@lists.infradead.org, Sean MacLennan <smaclennan@pikatech.com>,
	Tejun Heo <tj@kernel.org>, paulus@samba.org,
	Steve Deiters <SteveDeiters@basler.com>,
	Anatolij Gustschin <agust@denx.de>, David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch adds the appropriate conversions to correct the endianness
issues in the MTD driver whenever it accesses the device tree (which is
always big endian).

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/mtd/maps/physmap_of.c  |   14 +++++++-------
 drivers/mtd/nand/fsl_upm.c     |    8 ++++----
 drivers/mtd/nand/mpc5121_nfc.c |    4 ++--
 drivers/mtd/nand/ndfc.c        |    8 ++++----
 drivers/mtd/ofpart.c           |    6 +++---
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index fe63f6b..ec4011c 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -50,7 +50,7 @@ static int parse_obsolete_partitions(struct platform_device *dev,
 {
 	int i, plen, nr_parts;
 	const struct {
-		u32 offset, len;
+		__be32 offset, len;
 	} *part;
 	const char *names;
 
@@ -69,9 +69,9 @@ static int parse_obsolete_partitions(struct platform_device *dev,
 	names = of_get_property(dp, "partition-names", &plen);
 
 	for (i = 0; i < nr_parts; i++) {
-		info->parts[i].offset = part->offset;
-		info->parts[i].size   = part->len & ~1;
-		if (part->len & 1) /* bit 0 set signifies read only partition */
+		info->parts[i].offset = be32_to_cpu(part->offset);
+		info->parts[i].size   = be32_to_cpu(part->len) & ~1;
+		if (be32_to_cpu(part->len) & 1) /* bit 0 set signifies read only partition */
 			info->parts[i].mask_flags = MTD_WRITEABLE;
 
 		if (names && (plen > 0)) {
@@ -226,11 +226,11 @@ static int __devinit of_flash_probe(struct platform_device *dev,
 	struct resource res;
 	struct of_flash *info;
 	const char *probe_type = match->data;
-	const u32 *width;
+	const __be32 *width;
 	int err;
 	int i;
 	int count;
-	const u32 *p;
+	const __be32 *p;
 	int reg_tuple_size;
 	struct mtd_info **mtd_list = NULL;
 	resource_size_t res_size;
@@ -294,7 +294,7 @@ static int __devinit of_flash_probe(struct platform_device *dev,
 		info->list[i].map.name = dev_name(&dev->dev);
 		info->list[i].map.phys = res.start;
 		info->list[i].map.size = res_size;
-		info->list[i].map.bankwidth = *width;
+		info->list[i].map.bankwidth = be32_to_cpup(width);
 
 		err = -ENOMEM;
 		info->list[i].map.virt = ioremap(info->list[i].map.phys,
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 4eff8b2..8da9014 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -222,7 +222,7 @@ static int __devinit fun_probe(struct platform_device *ofdev,
 {
 	struct fsl_upm_nand *fun;
 	struct resource io_res;
-	const uint32_t *prop;
+	const __be32 *prop;
 	int rnb_gpio;
 	int ret;
 	int size;
@@ -270,7 +270,7 @@ static int __devinit fun_probe(struct platform_device *ofdev,
 			goto err1;
 		}
 		for (i = 0; i < fun->mchip_count; i++)
-			fun->mchip_offsets[i] = prop[i];
+			fun->mchip_offsets[i] = be32_to_cpu(prop[i]);
 	} else {
 		fun->mchip_count = 1;
 	}
@@ -295,13 +295,13 @@ static int __devinit fun_probe(struct platform_device *ofdev,
 
 	prop = of_get_property(ofdev->dev.of_node, "chip-delay", NULL);
 	if (prop)
-		fun->chip_delay = *prop;
+		fun->chip_delay = be32_to_cpup(prop);
 	else
 		fun->chip_delay = 50;
 
 	prop = of_get_property(ofdev->dev.of_node, "fsl,upm-wait-flags", &size);
 	if (prop && size == sizeof(uint32_t))
-		fun->wait_flags = *prop;
+		fun->wait_flags = be32_to_cpup(prop);
 	else
 		fun->wait_flags = FSL_UPM_WAIT_RUN_PATTERN |
 				  FSL_UPM_WAIT_WRITE_BYTE;
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index df0c1da..aeb27a1 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -660,7 +660,7 @@ static int __devinit mpc5121_nfc_probe(struct platform_device *op,
 #endif
 	struct nand_chip *chip;
 	unsigned long regs_paddr, regs_size;
-	const uint *chips_no;
+	const __be32 *chips_no;
 	int resettime = 0;
 	int retval = 0;
 	int rev, len;
@@ -803,7 +803,7 @@ static int __devinit mpc5121_nfc_probe(struct platform_device *op,
 	}
 
 	/* Detect NAND chips */
-	if (nand_scan(mtd, *chips_no)) {
+	if (nand_scan(mtd, be32_to_cpup(chips_no))) {
 		dev_err(dev, "NAND Flash not found !\n");
 		devm_free_irq(dev, prv->irq, mtd);
 		retval = -ENXIO;
diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
index 510554e..c9ae0a5 100644
--- a/drivers/mtd/nand/ndfc.c
+++ b/drivers/mtd/nand/ndfc.c
@@ -229,7 +229,7 @@ static int __devinit ndfc_probe(struct platform_device *ofdev,
 				const struct of_device_id *match)
 {
 	struct ndfc_controller *ndfc = &ndfc_ctrl;
-	const u32 *reg;
+	const __be32 *reg;
 	u32 ccr;
 	int err, len;
 
@@ -244,7 +244,7 @@ static int __devinit ndfc_probe(struct platform_device *ofdev,
 		dev_err(&ofdev->dev, "unable read reg property (%d)\n", len);
 		return -ENOENT;
 	}
-	ndfc->chip_select = reg[0];
+	ndfc->chip_select = be32_to_cpu(reg[0]);
 
 	ndfc->ndfcbase = of_iomap(ofdev->dev.of_node, 0);
 	if (!ndfc->ndfcbase) {
@@ -257,7 +257,7 @@ static int __devinit ndfc_probe(struct platform_device *ofdev,
 	/* It is ok if ccr does not exist - just default to 0 */
 	reg = of_get_property(ofdev->dev.of_node, "ccr", NULL);
 	if (reg)
-		ccr |= *reg;
+		ccr |= be32_to_cpup(reg);
 
 	out_be32(ndfc->ndfcbase + NDFC_CCR, ccr);
 
@@ -265,7 +265,7 @@ static int __devinit ndfc_probe(struct platform_device *ofdev,
 	reg = of_get_property(ofdev->dev.of_node, "bank-settings", NULL);
 	if (reg) {
 		int offset = NDFC_BCFG0 + (ndfc->chip_select << 2);
-		out_be32(ndfc->ndfcbase + offset, *reg);
+		out_be32(ndfc->ndfcbase + offset, be32_to_cpup(reg));
 	}
 
 	err = ndfc_chip_init(ndfc, ofdev->dev.of_node);
diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
index 8bf7dc6..a996718 100644
--- a/drivers/mtd/ofpart.c
+++ b/drivers/mtd/ofpart.c
@@ -44,7 +44,7 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
 	pp = NULL;
 	i = 0;
 	while ((pp = of_get_next_child(node, pp))) {
-		const u32 *reg;
+		const __be32 *reg;
 		int len;
 
 		reg = of_get_property(pp, "reg", &len);
@@ -53,8 +53,8 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
 			continue;
 		}
 
-		(*pparts)[i].offset = reg[0];
-		(*pparts)[i].size = reg[1];
+		(*pparts)[i].offset = be32_to_cpu(reg[0]);
+		(*pparts)[i].size = be32_to_cpu(reg[1]);
 
 		partname = of_get_property(pp, "label", &len);
 		if (!partname)
-- 
1.7.1
