Return-Path: <B32616@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 55274B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 19:51:32 +1100 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Liu Qiang-B32616 <B32616@freescale.com>, "jgarzik@pobox.com"
 <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: RE: [PATCH V2] fsl-sata: I/O load balancing
Date: Fri, 10 Feb 2012 08:51:17 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB701E91A@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1327025958-10605-1-git-send-email-qiang.liu@freescale.com>
In-Reply-To: <1327025958-10605-1-git-send-email-qiang.liu@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jeff,

Do you have any suggestion about this patch :)


> -----Original Message-----
> From: Liu Qiang-B32616
> Sent: Friday, January 20, 2012 10:19 AM
> To: jgarzik@pobox.com; linux-ide@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Liu
> Qiang-B32616
> Subject: [PATCH V2] fsl-sata: I/O load balancing
>=20
> From: Qiang Liu <qiang.liu@freescale.com>
>=20
> Reduce interrupt signals through reset Interrupt Coalescing Control Reg.
> Provide dynamic method to adjust interrupt signals and timer ticks by
> sysfs.
> It is a tradeoff for different applications.
>=20
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> ---
>=20
> change for V2
> 	support dynamic config interrupt coalescing register by /sysfs
> 	test random small file with iometer
> Description:
>   1. fsl-sata interrupt will be raised 130 thousand times when write 8G
> file
>     (dd if=3D/dev/zero of=3D/dev/sda2 bs=3D128K count=3D65536);
>   2. most of interrupts raised because of only 1-4 commands completed;
>   3. only 30 thousand times will be raised after set max interrupt
> threshold,
>     more interrupts are coalesced as the description of ICC;
>=20
> Test methods and results:
>   1. test sequential large file performance,
>   [root@p2020ds root]# echo 31 524287 > \
>   	/sys/devices/soc.0/ffe18000.sata/intr_coalescing
>   [root@p2020ds root]# dd if=3D/dev/zero of=3D/dev/sda2 bs=3D128K count=
=3D65536 &
>   [root@p2020ds root]# top
>=20
>   CPU %  |  dd   |  flush-8:0 | softirq
>   ---------------------------------------
>   before | 20-22 |    17-19   |    7
>   ---------------------------------------
>   after  | 18-21 |    15-16   |    5
>   ---------------------------------------
>   2. test random small file with iometer,  iometer paramters:
>    4 I/Os burst length, 1MB transfer request size, 100% write, 2MB file
> size
>    as default configuration of interrupt coalescing register, 1
> interrupts and  no timeout config, total write performance is 119MB per
> second,
>    after config with the maximum value, write performance is 110MB per
> second.
>=20
>   After compare the test results, a configuable interrupt coalescing
> should be
>   better when cope with flexible context.
>=20
>  drivers/ata/sata_fsl.c |  111
> ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 107 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c index
> 3547000..41ca495 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -6,7 +6,7 @@
>   * Author: Ashish Kalra <ashish.kalra@freescale.com>
>   * Li Yang <leoli@freescale.com>
>   *
> - * Copyright (c) 2006-2007, 2011 Freescale Semiconductor, Inc.
> + * Copyright (c) 2006-2007, 2011-2012 Freescale Semiconductor, Inc.
>   *
>   * This program is free software; you can redistribute  it and/or modify
> it
>   * under  the terms of  the GNU General  Public License as published by
> the @@ -26,6 +26,15 @@  #include <asm/io.h>  #include
> <linux/of_platform.h>
>=20
> +static unsigned int intr_coalescing_count;
> +module_param(intr_coalescing_count, int, S_IRUGO);
> +MODULE_PARM_DESC(intr_coalescing_count,
> +				 "INT coalescing count threshold (1..31)");
> +
> +static unsigned int intr_coalescing_ticks;
> +module_param(intr_coalescing_ticks, int, S_IRUGO);
> +MODULE_PARM_DESC(intr_coalescing_ticks,
> +				 "INT coalescing timer threshold in AHB ticks");
>  /* Controller information */
>  enum {
>  	SATA_FSL_QUEUE_DEPTH	=3D 16,
> @@ -83,6 +92,16 @@ enum {
>  };
>=20
>  /*
> + * Interrupt Coalescing Control Register bitdefs  */ enum {
> +	ICC_MIN_INT_COUNT_THRESHOLD	=3D 1,
> +	ICC_MAX_INT_COUNT_THRESHOLD	=3D ((1 << 5) - 1),
> +	ICC_MIN_INT_TICKS_THRESHOLD	=3D 0,
> +	ICC_MAX_INT_TICKS_THRESHOLD	=3D ((1 << 19) - 1),
> +	ICC_SAFE_INT_TICKS		=3D 1,
> +};
> +
> +/*
>  * Host Controller command register set - per port  */  enum { @@ -263,9
> +282,66 @@ struct sata_fsl_host_priv {
>  	int irq;
>  	int data_snoop;
>  	u32 quirks;
> +	struct device_attribute intr_coalescing;
>  #define SATA_FSL_QUIRK_P3P5_ERRATA	(1 << 0)
>  };
>=20
> +static void fsl_sata_set_irq_coalescing(struct ata_host *host,
> +		unsigned int count, unsigned int ticks) {
> +	struct sata_fsl_host_priv *host_priv =3D host->private_data;
> +	void __iomem *hcr_base =3D host_priv->hcr_base;
> +
> +	if (count > ICC_MAX_INT_COUNT_THRESHOLD)
> +		count =3D ICC_MAX_INT_COUNT_THRESHOLD;
> +	else if (count < ICC_MIN_INT_COUNT_THRESHOLD)
> +		count =3D ICC_MIN_INT_COUNT_THRESHOLD;
> +
> +	if (ticks > ICC_MAX_INT_TICKS_THRESHOLD)
> +		ticks =3D ICC_MAX_INT_TICKS_THRESHOLD;
> +	else if ((ICC_MIN_INT_TICKS_THRESHOLD =3D=3D ticks) &&
> +			(count > ICC_MIN_INT_COUNT_THRESHOLD))
> +		ticks =3D ICC_SAFE_INT_TICKS;
> +
> +	spin_lock(&host->lock);
> +	iowrite32((count << 24 | ticks), hcr_base + ICC);
> +
> +	intr_coalescing_count =3D count;
> +	intr_coalescing_ticks =3D ticks;
> +	spin_unlock(&host->lock);
> +
> +	DPRINTK("intrrupt coalescing, count =3D 0x%x, ticks =3D %x\n",
> +			intr_coalescing_count, intr_coalescing_ticks);
> +	DPRINTK("ICC register status: (hcr base: 0x%x) =3D 0x%x\n",
> +			hcr_base, ioread32(hcr_base + ICC)); }
> +
> +static ssize_t fsl_sata_intr_coalescing_show(struct device *dev,
> +		struct device_attribute *attr, char *buf) {
> +	return sprintf(buf, "%d	%d\n",
> +			intr_coalescing_count, intr_coalescing_ticks); }
> +
> +static ssize_t fsl_sata_intr_coalescing_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	unsigned int coalescing_count,	coalescing_ticks;
> +
> +	if (sscanf(buf, "%d%d",
> +				&coalescing_count,
> +				&coalescing_ticks) !=3D 2) {
> +		printk(KERN_ERR "fsl-sata: wrong parameter format.\n");
> +		return -EINVAL;
> +	}
> +
> +	fsl_sata_set_irq_coalescing(dev_get_drvdata(dev),
> +			coalescing_count, coalescing_ticks);
> +
> +	return strlen(buf);
> +}
> +
>  static void sata_fsl_dev_config(struct ata_device *dev)  {
>  		dev->max_sectors =3D 16;
> @@ -352,11 +428,11 @@ static unsigned int sata_fsl_fill_sg(struct
> ata_queued_cmd *qc, void *cmd_desc,
>  			(unsigned long long)sg_addr, sg_len);
>=20
>  		/* warn if each s/g element is not dword aligned */
> -		if (sg_addr & 0x03)
> +		if (unlikely(sg_addr & 0x03))
>  			ata_port_printk(qc->ap, KERN_ERR,
>  					"s/g addr unaligned : 0x%llx\n",
>  					(unsigned long long)sg_addr);
> -		if (sg_len & 0x03)
> +		if (unlikely(sg_len & 0x03))
>  			ata_port_printk(qc->ap, KERN_ERR,
>  					"s/g len unaligned : 0x%x\n", sg_len);
>=20
> @@ -1305,6 +1381,13 @@ static int sata_fsl_init_controller(struct
> ata_host *host)
>  	iowrite32(0x00000FFFF, hcr_base + DE);
>=20
>  	/*
> +	 * reset the number of command complete bits which will cause the
> +	 * interrupt to be signaled
> +	 */
> +	fsl_sata_set_irq_coalescing(host, intr_coalescing_count,
> +			intr_coalescing_ticks);
> +
> +	/*
>  	 * host controller will be brought on-line, during xx_port_start()
>  	 * callback, that should also initiate the OOB, COMINIT sequence
>  	 */
> @@ -1368,7 +1451,7 @@ static int sata_fsl_probe(struct platform_device
> *ofdev)
>  	void __iomem *csr_base =3D NULL;
>  	struct sata_fsl_host_priv *host_priv =3D NULL;
>  	int irq;
> -	struct ata_host *host;
> +	struct ata_host *host =3D NULL;
>  	u32 temp;
>=20
>  	struct ata_port_info pi =3D sata_fsl_port_info[0]; @@ -1430,6
> +1513,10 @@ static int sata_fsl_probe(struct platform_device *ofdev)
>=20
>  	/* allocate host structure */
>  	host =3D ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_FSL_MAX_PORTS);
> +	if (!host) {
> +		retval =3D -ENOMEM;
> +		goto error_exit_with_cleanup;
> +	}
>=20
>  	/* host->iomap is not used currently */
>  	host->private_data =3D host_priv;
> @@ -1447,10 +1534,24 @@ static int sata_fsl_probe(struct platform_device
> *ofdev)
>=20
>  	dev_set_drvdata(&ofdev->dev, host);
>=20
> +	host_priv->intr_coalescing.show =3D fsl_sata_intr_coalescing_show;
> +	host_priv->intr_coalescing.store =3D fsl_sata_intr_coalescing_store;
> +	sysfs_attr_init(&host_priv->intr_coalescing.attr);
> +	host_priv->intr_coalescing.attr.name =3D "intr_coalescing";
> +	host_priv->intr_coalescing.attr.mode =3D S_IRUGO | S_IWUSR;
> +	retval =3D device_create_file(host->dev, &host_priv->intr_coalescing);
> +	if (retval)
> +		goto error_exit_with_cleanup;
> +
>  	return 0;
>=20
>  error_exit_with_cleanup:
>=20
> +	if (host) {
> +		dev_set_drvdata(&ofdev->dev, NULL);
> +		ata_host_detach(host);
> +	}
> +
>  	if (hcr_base)
>  		iounmap(hcr_base);
>  	if (host_priv)
> @@ -1464,6 +1565,8 @@ static int sata_fsl_remove(struct platform_device
> *ofdev)
>  	struct ata_host *host =3D dev_get_drvdata(&ofdev->dev);
>  	struct sata_fsl_host_priv *host_priv =3D host->private_data;
>=20
> +	device_remove_file(&ofdev->dev, &host_priv->intr_coalescing);
> +
>  	ata_host_detach(host);
>=20
>  	dev_set_drvdata(&ofdev->dev, NULL);
> --
> 1.7.5.1
