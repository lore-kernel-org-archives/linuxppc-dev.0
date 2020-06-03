Return-Path: <SRS0=sLSx=7Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6E8C433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 14:50:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8C920738
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 14:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8C920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cX0D0XRczDqQW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 00:50:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.183.199;
 helo=relay9-d.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cVqX2KT1zDqRX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2020 23:58:14 +1000 (AEST)
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DE971FF80B;
 Wed,  3 Jun 2020 13:58:03 +0000 (UTC)
Date: Wed, 3 Jun 2020 15:58:02 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH 05/10] mtd: rawnand: fsl_upm: Use
 platform_get_resource() + devm_ioremap_resource()
Message-ID: <20200603155802.12165328@xps13>
In-Reply-To: <20200603134922.1352340-6-boris.brezillon@collabora.com>
References: <20200603134922.1352340-1-boris.brezillon@collabora.com>
 <20200603134922.1352340-6-boris.brezillon@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@microchip.com>,
 Anton Vorontsov <anton@enomsg.org>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Boris Brezillon <boris.brezillon@collabora.com> wrote on Wed,  3 Jun
2020 15:49:17 +0200:

> Replace the of_address_to_resource() + devm_ioremap() calls by
> platform_get_resource() + devm_ioremap_resource() ones which allows us
> to get rid of one error message since devm_ioremap_resource() already
> takes care of that.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/mtd/nand/raw/fsl_upm.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
> index a3e3a968891d..54851e9ea784 100644
> --- a/drivers/mtd/nand/raw/fsl_upm.c
> +++ b/drivers/mtd/nand/raw/fsl_upm.c
> @@ -14,7 +14,6 @@
>  #include <linux/mtd/nand_ecc.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/mtd.h>
> -#include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_gpio.h>
>  #include <linux/io.h>
> @@ -197,7 +196,7 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
>  static int fun_probe(struct platform_device *ofdev)
>  {
>  	struct fsl_upm_nand *fun;
> -	struct resource io_res;
> +	struct resource *io_res;
>  	const __be32 *prop;
>  	int rnb_gpio;
>  	int ret;
> @@ -208,13 +207,12 @@ static int fun_probe(struct platform_device *ofdev)
>  	if (!fun)
>  		return -ENOMEM;
>  
> -	ret = of_address_to_resource(ofdev->dev.of_node, 0, &io_res);
> -	if (ret) {
> -		dev_err(&ofdev->dev, "can't get IO base\n");
> -		return ret;
> -	}
> +	io_res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> +	fun->io_base = devm_ioremap_resource(&ofdev->dev, io_res);

Why not even using devm_platform_ioremap_resource() resource directly?
