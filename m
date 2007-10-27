Return-Path: <SRS0=/0kd=PV=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 9BB0FDDE43
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 14:54:51 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 1/2] PowerPC: Add 44x NDFC device-tree aware support
Date: Sat, 27 Oct 2007 06:53:32 +0200
References: <20071026163958.GA11784@ru.mvista.com>
In-Reply-To: <20071026163958.GA11784@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710270653.32459.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Valentine,

On Friday 26 October 2007, Valentine Barshak wrote:
> This adds device-tree aware PowerPC 44x NDFC (NAND Flash Controller)
> driver. The code is based on the original ndfc.c driver by Thomas Gleixne=
r.
> The major difference is that here we try to handle all chips found as one
> mtd device instead of having a separate one on each chip.
> The partition handling code is based on the physmap_of one.
> The the first 4 bits of the "bank-mask" property show which of the 4 NDFC
> banks have chips attached. The "bank-width" property is 1 for 8-bit flash
> and 2 for a 16-bit one.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Are you sure you have the Signed-off-by from Thomas already on this?

> ---
> =A0drivers/mtd/nand/Kconfig =A0 | =A0 =A07
> =A0drivers/mtd/nand/Makefile =A0| =A0 =A01
> =A0drivers/mtd/nand/ndfc_of.c | =A0449
> +++++++++++++++++++++++++++++++++++++++++++++ include/linux/mtd/ndfc.h =
=A0 |
> =A0 =A04
> =A04 files changed, 461 insertions(+)
>
> diff -pruN linux-2.6.orig/drivers/mtd/nand/Kconfig
> linux-2.6/drivers/mtd/nand/Kconfig ---
> linux-2.6.orig/drivers/mtd/nand/Kconfig=A0=A0=A0=A0=A02007-10-25 19:20:05=
=2E000000000
> +0400 +++ linux-2.6/drivers/mtd/nand/Kconfig=A0=A02007-10-26 16:16:20.000=
000000
> +0400 @@ -158,6 +158,13 @@ config MTD_NAND_NDFC
> =A0=A0=A0=A0=A0=A0=A0=A0help
> =A0=A0=A0=A0=A0=A0=A0=A0 NDFC Nand Flash Controllers are integrated in IB=
M/AMCC's 4xx SoCs
> =A0
> +config MTD_NAND_NDFC_OF
> +=A0=A0=A0=A0=A0=A0=A0tristate "NDFC OF Nand Flash Controller"
> +=A0=A0=A0=A0=A0=A0=A0depends on 44x
> +=A0=A0=A0=A0=A0=A0=A0select MTD_NAND_ECC_SMC
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 NDFC OF Nand Flash Controllers are integrated in P=
owerPC44x SoCs
> +
> =A0config MTD_NAND_S3C2410_CLKSTOP
> =A0=A0=A0=A0=A0=A0=A0=A0bool "S3C2410 NAND IDLE clock stop"
> =A0=A0=A0=A0=A0=A0=A0=A0depends on MTD_NAND_S3C2410
> diff -pruN linux-2.6.orig/drivers/mtd/nand/Makefile
> linux-2.6/drivers/mtd/nand/Makefile ---
> linux-2.6.orig/drivers/mtd/nand/Makefile=A0=A0=A0=A02007-10-25 19:20:05.0=
00000000
> +0400 +++ linux-2.6/drivers/mtd/nand/Makefile=A02007-10-26 16:16:20.00000=
0000
> +0400 @@ -24,6 +24,7 @@ obj-$(CONFIG_MTD_NAND_TS7250)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0+=3D ts7250
> =A0obj-$(CONFIG_MTD_NAND_NANDSIM)=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D nandsim.o
> =A0obj-$(CONFIG_MTD_NAND_CS553X)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D cs553x=
_nand.o
> =A0obj-$(CONFIG_MTD_NAND_NDFC)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D nd=
fc.o
> +obj-$(CONFIG_MTD_NAND_NDFC_OF)=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D ndfc_of.o
> =A0obj-$(CONFIG_MTD_NAND_AT91)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D at=
91_nand.o
> =A0obj-$(CONFIG_MTD_NAND_CM_X270)=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D cmx270_n=
and.o
> =A0obj-$(CONFIG_MTD_NAND_BASLER_EXCITE)=A0=A0=A0+=3D excite_nandflash.o
> diff -pruN linux-2.6.orig/drivers/mtd/nand/ndfc_of.c
> linux-2.6/drivers/mtd/nand/ndfc_of.c ---
> linux-2.6.orig/drivers/mtd/nand/ndfc_of.c=A0=A0=A01970-01-01 03:00:00.000=
000000
> +0300 +++ linux-2.6/drivers/mtd/nand/ndfc_of.c=A0=A0=A0=A0=A0=A0=A0=A0200=
7-10-26
> 17:28:57.000000000 +0400 @@ -0,0 +1,449 @@
> +/*
> + * =A0PowerPC 44x NDFC (NanD Flash Controller) driver
> + * =A0with OF device tree support.
> + *
> + * =A0Based on the original ndfc driver by Thomas Gleixner
> + *
> + * =A0Copyright 2006 IBM
> + *
> + * =A0This program is free software; you can redistribute=A0=A0=A0=A0=A0=
=A0=A0=A0 it and/or
> modify it + * =A0under =A0the terms of=A0=A0=A0=A0=A0=A0=A0=A0 the GNU Ge=
neral =A0Public License
> as published by the + * =A0Free Software Foundation; =A0either version 2 =
of
> the=A0License, or (at your + * =A0option) any later version.
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/nand_ecc.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/ndfc.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/io.h>
> +
> +
> +struct of_ndfc {
> +=A0=A0=A0=A0=A0=A0=A0__iomem void=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*ba=
se;
> +=A0=A0=A0=A0=A0=A0=A0struct resource=A0=A0=A0=A0=A0=A0=A0=A0=A0*res;
> +=A0=A0=A0=A0=A0=A0=A0unsigned=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0bank_width;
> +=A0=A0=A0=A0=A0=A0=A0unsigned =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0chip_cnt;
> +=A0=A0=A0=A0=A0=A0=A0unsigned char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0chip_=
map[NDFC_MAX_BANKS];
> +=A0=A0=A0=A0=A0=A0=A0struct nand_hw_control=A0=A0control;
> +=A0=A0=A0=A0=A0=A0=A0struct nand_chip=A0=A0=A0=A0=A0=A0=A0=A0chip;
> +=A0=A0=A0=A0=A0=A0=A0struct mtd_info=A0=A0=A0=A0=A0=A0=A0=A0=A0mtd;
> +#ifdef CONFIG_MTD_PARTITIONS
> +=A0=A0=A0=A0=A0=A0=A0struct mtd_partition=A0=A0=A0=A0*parts;
> +#endif
> +};
> +
> +static inline u32 ndfc_raw_readl(struct of_ndfc *ndfc, u32 off)
> +{
> +	return __raw_readl(ndfc->base + off);
> +}
> +
> +static inline void ndfc_raw_writel(struct of_ndfc *ndfc, u32 off, u32 va=
l)
> +{
> +	__raw_writel(val, ndfc->base + off);
> +}
> +
> +static inline void ndfc_writel(struct of_ndfc *ndfc, u32 off, u32 val)
> +{
> +	writel(val, ndfc->base + off);
> +}
> +
> +static void ndfc_select_chip(struct mtd_info *mtd, int chip)
> +{
> +	struct nand_chip *this =3D mtd->priv;
> +	struct of_ndfc *ndfc =3D this->priv;
> +	uint32_t ccr;
> +
> +	ccr =3D ndfc_raw_readl(ndfc, NDFC_CCR);
> +	if ((chip >=3D 0) && (chip < ndfc->chip_cnt))  {
> +		ccr &=3D ~NDFC_CCR_BS_MASK;
> +		ccr |=3D NDFC_CCR_BS(ndfc->chip_map[chip]);
> +	} else
> +		ccr |=3D NDFC_CCR_RESET_CE;
> +	ndfc_raw_writel(ndfc, NDFC_CCR, ccr);
> +}
> +
> +static void ndfc_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int
> ctrl) +{
> +	struct nand_chip *this =3D mtd->priv;
> +	struct of_ndfc *ndfc =3D this->priv;
> +
> +	if (cmd =3D=3D NAND_CMD_NONE)
> +		return;
> +
> +	if (ctrl & NAND_CLE)
> +		ndfc_writel(ndfc, NDFC_CMD, cmd & 0xff);
> +	else
> +		ndfc_writel(ndfc, NDFC_ALE, cmd & 0xff);
> +}
> +
> +static int ndfc_ready(struct mtd_info *mtd)
> +{
> +	struct nand_chip *this =3D mtd->priv;
> +	struct of_ndfc *ndfc =3D this->priv;
> +
> +	return ndfc_raw_readl(ndfc, NDFC_STAT) & NDFC_STAT_IS_READY;
> +}
> +
> +static void ndfc_enable_hwecc(struct mtd_info *mtd, int mode)
> +{
> +	uint32_t ccr;
> +	struct nand_chip *this =3D mtd->priv;
> +	struct of_ndfc *ndfc =3D this->priv;
> +
> +	ccr =3D ndfc_raw_readl(ndfc, NDFC_CCR);
> +	ccr |=3D NDFC_CCR_RESET_ECC;
> +	ndfc_raw_writel(ndfc, NDFC_CCR, ccr);
> +	wmb();

I suspect that when we use the in_be32() and friends functions for IO acces=
s,=20
the memory-barriers can go away.

> +}
> +
> +
> +static int ndfc_calculate_ecc(struct mtd_info *mtd,
> +			      const u_char *dat, u_char *ecc_code)
> +{
> +	uint32_t ecc;
> +	struct nand_chip *this =3D mtd->priv;
> +	struct of_ndfc *ndfc =3D this->priv;
> +	uint8_t *p =3D (uint8_t *)&ecc;
> +
> +	wmb();

Same here.

> +	ecc =3D ndfc_raw_readl(ndfc, NDFC_ECC);
> +	ecc_code[0] =3D p[1];
> +	ecc_code[1] =3D p[2];
> +	ecc_code[2] =3D p[3];
> +
> +	return 0;
> +}
> +
> +
> +/*
> + * Speedups for buffer read/write/verify
> + *
> + * NDFC allows 32bit read/write of data. So we can speed up the buffer
> + * functions. No further checking, as nand_base will always read/write
> + * page aligned.
> + */
> +static void ndfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
> +{
> +	struct nand_chip *this =3D mtd->priv;
> +	struct of_ndfc *ndfc =3D this->priv;
> +	uint32_t *p =3D (uint32_t *) buf;
> +
> +	for(;len > 0; len -=3D 4)
> +		*p++ =3D ndfc_raw_readl(ndfc, NDFC_DATA);
> +}
> +
> +static void ndfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int
> len) +{
> +	struct nand_chip *this =3D mtd->priv;
> +	struct of_ndfc *ndfc =3D this->priv;
> +	uint32_t *p =3D (uint32_t *) buf;
> +
> +	for(;len > 0; len -=3D 4)
> +		ndfc_raw_writel(ndfc, NDFC_DATA, *p++);
> +}
> +
> +static int ndfc_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int
> len) +{
> +	struct nand_chip *this =3D mtd->priv;
> +	struct of_ndfc *ndfc =3D this->priv;
> +	uint32_t *p =3D (uint32_t *) buf;
> +
> +	for(;len > 0; len -=3D 4)
> +		if (*p++ !=3D ndfc_raw_readl(ndfc, NDFC_DATA))
> +			return -EFAULT;
> +	return 0;
> +}
> +
> +
> +
> +static void ndfc_chip_init(struct nand_chip *chip,
> +				struct of_ndfc *ndfc)
> +{
> +	chip->IO_ADDR_R =3D ndfc->base + NDFC_DATA;
> +	chip->IO_ADDR_W =3D ndfc->base + NDFC_DATA;
> +	chip->cmd_ctrl =3D ndfc_hwcontrol;
> +	chip->dev_ready =3D ndfc_ready;
> +	chip->select_chip =3D ndfc_select_chip;
> +	chip->chip_delay =3D 50;
> +	chip->priv =3D ndfc;
> +	if (ndfc->bank_width =3D=3D 2)
> +		chip->options |=3D NAND_BUSWIDTH_16;
> +	chip->controller =3D &ndfc->control;
> +	chip->read_buf =3D ndfc_read_buf;
> +	chip->write_buf =3D ndfc_write_buf;
> +	chip->verify_buf =3D ndfc_verify_buf;
> +	chip->ecc.correct =3D nand_correct_data;
> +	chip->ecc.hwctl =3D ndfc_enable_hwecc;
> +	chip->ecc.calculate =3D ndfc_calculate_ecc;
> +	chip->ecc.mode =3D NAND_ECC_HW;
> +	chip->ecc.size =3D 256;
> +	chip->ecc.bytes =3D 3;
> +	ndfc->mtd.priv =3D chip;
> +	ndfc->mtd.owner =3D THIS_MODULE;
> +}
> +
> +
> +#ifdef CONFIG_MTD_PARTITIONS
> +#define OF_FLASH_PARTS(ndfc)	((ndfc)->parts)
> +
> +static int __devinit parse_partitions(struct of_ndfc *ndfc,
> +				      struct of_device *dev)
> +{
> +	const char *partname;
> +	static const char *part_probe_types[]
> +		=3D { "cmdlinepart", "RedBoot", NULL };
> +	struct device_node *dp =3D dev->node, *pp;
> +	int nr_parts, i;
> +
> +	/* First look for RedBoot table or partitions on the command
> +	 * line, these take precedence over device tree information */
> +	nr_parts =3D parse_mtd_partitions(&ndfc->mtd, part_probe_types,
> +					&ndfc->parts, 0);
> +	if (nr_parts > 0) {
> +		add_mtd_partitions(&ndfc->mtd, ndfc->parts, nr_parts);
> +		return 0;
> +	}
> +
> +	/* First count the subnodes */
> +	nr_parts =3D 0;
> +	for (pp =3D dp->child; pp; pp =3D pp->sibling)
> +		nr_parts++;
> +
> +	if (nr_parts =3D=3D 0)
> +		return 0;
> +
> +	ndfc->parts =3D kzalloc(nr_parts * sizeof(*ndfc->parts),
> +			      GFP_KERNEL);
> +	if (!ndfc->parts)
> +		return -ENOMEM;
> +
> +	for (pp =3D dp->child, i =3D 0; pp; pp =3D pp->sibling, i++) {
> +		const u32 *reg;
> +		int len;
> +
> +		reg =3D of_get_property(pp, "reg", &len);
> +		if (!reg || (len !=3D 2*sizeof(u32))) {
> +			dev_err(&dev->dev, "Invalid 'reg' on %s\n",
> +				dp->full_name);
> +			kfree(ndfc->parts);
> +			ndfc->parts =3D NULL;
> +			return -EINVAL;
> +		}
> +		ndfc->parts[i].offset =3D reg[0];
> +		ndfc->parts[i].size =3D reg[1];
> +
> +		partname =3D of_get_property(pp, "label", &len);
> +		if (!partname)
> +			partname =3D of_get_property(pp, "name", &len);
> +		ndfc->parts[i].name =3D (char *)partname;
> +
> +		if (of_get_property(pp, "read-only", &len))
> +			ndfc->parts[i].mask_flags =3D MTD_WRITEABLE;
> +	}
> +
> +	return nr_parts;
> +}

This parse_partition code looks very much like the code in the physmap_of=20
driver. I think it would be a good idea not to duplicate this code, but to=
=20
extract it and use one version in both drivers.

> +#else /* MTD_PARTITIONS */
> +#define	OF_FLASH_PARTS(ndfc)		(0)
> +#define parse_partitions(ndfc, dev)	(0)
> +#endif /* MTD_PARTITIONS */
> +
> +
> +static int of_ndfc_remove(struct of_device *dev)
> +{
> +	struct of_ndfc *ndfc;
> +
> +	ndfc =3D dev_get_drvdata(&dev->dev);
> +	if (!ndfc)
> +		return 0;
> +
> +	if (OF_FLASH_PARTS(ndfc)) {
> +		del_mtd_partitions(&ndfc->mtd);
> +		kfree(OF_FLASH_PARTS(ndfc));
> +	} else {
> +		del_mtd_device(&ndfc->mtd);
> +	}
> +	nand_release(&ndfc->mtd);
> +
> +	dev_set_drvdata(&dev->dev, NULL);
> +
> +	if (ndfc->base)
> +		iounmap(ndfc->base);
> +
> +	if (ndfc->res) {
> +		release_resource(ndfc->res);
> +		kfree(ndfc->res);
> +	}
> +
> +	kfree(ndfc);
> +
> +	return 0;
> +}
> +
> +
> +static int __devinit ndfc_map_banks(struct of_ndfc *ndfc, const u32 *mas=
k)
> +{
> +	unsigned cnt, i, tmp;
> +	uint32_t bcr;
> +
> +	if (!ndfc || !mask)
> +		return -EINVAL;
> +
> +	/* Disable all banks */
> +	for (cnt =3D 0; cnt < NDFC_MAX_BANKS; cnt++) {
> +		ndfc_raw_writel(ndfc, NDFC_BCFG0 + (cnt << 2), 0);
> +	}
> +
> +	/* Enable bank and set default RE/WE/CE timings */
> +	bcr =3D NDFC_BxCFG_EN | NDFC_BxCFG_RR(2) | NDFC_BxCFG_RWH(2) |
> +				NDFC_BxCFG_RWP(2) | NDFC_BxCFG_CRW(2);
> +	if (ndfc->bank_width =3D=3D 2)
> +		bcr |=3D NDFC_BxCFG_SZ_16BIT;
> +
> +	cnt =3D 0;
> +	tmp =3D *mask;
> +	while ((i =3D ffs(tmp)) && (cnt < NDFC_MAX_BANKS)) {
> +		i--;
> +		tmp &=3D ~(1 << i);
> +		ndfc->chip_map[cnt++] =3D i;
> +		ndfc_raw_writel(ndfc, NDFC_BCFG0 + (i << 2), bcr);
> +	}
> +	ndfc->chip_cnt =3D cnt;
> +	return cnt;
> +}
> +
> +
> +static int __devinit of_ndfc_probe(struct of_device *dev,
> +				    const struct of_device_id *match)
> +{
> +	struct device_node *dp =3D dev->node;
> +	struct resource res;
> +	struct of_ndfc *ndfc;
> +	const u32 *prop;
> +	resource_size_t rlen;
> +	int err;
> +
> +	err =3D -ENXIO;
> +	if (of_address_to_resource(dp, 0, &res)) {
> +		dev_err(&dev->dev, "can't get IO address from device tree\n");
> +		goto err_out;
> +	}
> +
> +       	dev_dbg(&dev->dev, "regs: %.8llx-%.8llx\n",
> +		(unsigned long long)res.start, (unsigned long long)res.end);
> +
> +	ndfc =3D kzalloc(sizeof(struct of_ndfc), GFP_KERNEL);
> +	if (!ndfc) {
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	rlen =3D res.end - res.start + 1;
> +	ndfc->res =3D request_mem_region(res.start, rlen, dev->dev.bus_id);
> +	if (!ndfc->res) {
> +		err =3D -EBUSY;
> +		goto err_free_out;
> +	}
> +
> +	ndfc->base =3D ioremap(res.start, rlen);
> +	if (!ndfc->base) {
> +		err =3D -ENXIO;
> +		goto err_rel_out;
> +	}
> +
> +	spin_lock_init(&ndfc->control.lock);
> +	init_waitqueue_head(&ndfc->control.wq);
> +
> +	prop =3D of_get_property(dp, "bank-width", NULL);
> +	ndfc->bank_width =3D ((prop) && (*prop) =3D=3D 2) ? 2 : 1;
> +
> +	prop =3D of_get_property(dp, "bank-mask", NULL);
> +	err =3D ndfc_map_banks(ndfc, prop);
> +	if (err <=3D 0) {
> +		dev_err(&dev->dev, "no banks found\n");
> +		err =3D -ENODEV;
> +		goto err_unmap_out;
> +	}
> +
> +	ndfc_chip_init(&ndfc->chip, ndfc);
> +	dev_set_drvdata(&dev->dev, ndfc);
> +
> +	dev_info(&dev->dev, "NDFC driver initialized. Chip-Rev: 0x%08x\n",
> +			ndfc_raw_readl(ndfc, NDFC_REVID));
> +
> +	err =3D nand_scan_ident(&ndfc->mtd, ndfc->chip_cnt);
> +	if (err)
> +		goto err_dat_out;
> +
> +	if ((ndfc->mtd.writesize !=3D 2048) && (ndfc->mtd.writesize !=3D 512)) {
> +		dev_err(&dev->dev, "unexpected NAND flash writesize %d",
> +			ndfc->mtd.writesize);
> +		goto err_dat_out;
> +	}
> +
> +	err =3D nand_scan_tail(&ndfc->mtd);
> +	if (err)
> +		goto err_dat_out;
> +
> +	err =3D parse_partitions(ndfc, dev);
> +	if (err < 0)
> +		goto err_dat_out;
> +
> +	if (err > 0)
> +		add_mtd_partitions(&ndfc->mtd, OF_FLASH_PARTS(ndfc), err);
> +	else
> +		add_mtd_device(&ndfc->mtd);
> +
> +	return 0;
> +
> +err_dat_out:
> +	dev_set_drvdata(&dev->dev, NULL);
> +err_unmap_out:
> +	iounmap(ndfc->base);
> +err_rel_out:
> +	release_resource(ndfc->res);
> +	kfree(ndfc->res);
> +err_free_out:
> +	kfree(ndfc);
> +err_out:
> +	return err;
> +}
> +
> +static struct of_device_id of_ndfc_match[] =3D {
> +	{
> +		.compatible	=3D "ibm,ndfc",
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_ndfc_match);
> +
> +static struct of_platform_driver of_ndfc_driver =3D {
> +	.name		=3D "of-ndfc",
> +	.match_table	=3D of_ndfc_match,
> +	.probe		=3D of_ndfc_probe,
> +	.remove		=3D of_ndfc_remove,
> +};
> +
> +static int __init of_ndfc_init(void)
> +{
> +	return of_register_platform_driver(&of_ndfc_driver);
> +}
> +
> +static void __exit of_ndfc_exit(void)
> +{
> +	of_unregister_platform_driver(&of_ndfc_driver);
> +}
> +
> +module_init(of_ndfc_init);
> +module_exit(of_ndfc_exit);
> +
> +MODULE_LICENSE("GPL");
> +
> +
> +MODULE_DESCRIPTION("OF driver for NDFC");
> diff -pruN linux-2.6.orig/include/linux/mtd/ndfc.h
> linux-2.6/include/linux/mtd/ndfc.h ---
> linux-2.6.orig/include/linux/mtd/ndfc.h	2007-10-25 19:20:42.000000000 +04=
00
> +++ linux-2.6/include/linux/mtd/ndfc.h	2007-10-26 16:19:42.000000000 +0400
> @@ -52,6 +52,10 @@
>  #define NDFC_BxCFG_SZ_MASK	0x08000000 /* Bank Size */
>  #define NDFC_BxCFG_SZ_8BIT	0x00000000 /* 8bit */
>  #define NDFC_BxCFG_SZ_16BIT	0x08000000 /* 16bit */
> +#define NDFC_BxCFG_RR(x)	(((x) & 0x7) << 0)
> +#define NDFC_BxCFG_RWH(x)	(((x) & 0x7) << 4)
> +#define NDFC_BxCFG_RWP(x)	(((x) & 0x7) << 8)
> +#define NDFC_BxCFG_CRW(x)	(((x) & 0x7) << 12)
>
>  #define NDFC_MAX_BANKS		4

Best regards,
Stefan
