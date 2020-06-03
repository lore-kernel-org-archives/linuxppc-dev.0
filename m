Return-Path: <SRS0=sLSx=7Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52B9C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:09:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8644C206E6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 15:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8644C206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cXQ56r7fzDqf0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 01:09:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=collabora.com (client-ip=46.235.227.227;
 helo=bhuna.collabora.co.uk; envelope-from=boris.brezillon@collabora.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cVtb01qTzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2020 00:00:54 +1000 (AEST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 79F3C2A0682;
 Wed,  3 Jun 2020 15:00:51 +0100 (BST)
Date: Wed, 3 Jun 2020 16:00:47 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 05/10] mtd: rawnand: fsl_upm: Use
 platform_get_resource() + devm_ioremap_resource()
Message-ID: <20200603160047.0262fcfc@collabora.com>
In-Reply-To: <20200603155802.12165328@xps13>
References: <20200603134922.1352340-1-boris.brezillon@collabora.com>
 <20200603134922.1352340-6-boris.brezillon@collabora.com>
 <20200603155802.12165328@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
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

On Wed, 3 Jun 2020 15:58:02 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Boris Brezillon <boris.brezillon@collabora.com> wrote on Wed,  3 Jun
> 2020 15:49:17 +0200:
> 
> > Replace the of_address_to_resource() + devm_ioremap() calls by
> > platform_get_resource() + devm_ioremap_resource() ones which allows us
> > to get rid of one error message since devm_ioremap_resource() already
> > takes care of that.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/mtd/nand/raw/fsl_upm.c | 23 +++++++----------------
> >  1 file changed, 7 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
> > index a3e3a968891d..54851e9ea784 100644
> > --- a/drivers/mtd/nand/raw/fsl_upm.c
> > +++ b/drivers/mtd/nand/raw/fsl_upm.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/mtd/nand_ecc.h>
> >  #include <linux/mtd/partitions.h>
> >  #include <linux/mtd/mtd.h>
> > -#include <linux/of_address.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/io.h>
> > @@ -197,7 +196,7 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
> >  static int fun_probe(struct platform_device *ofdev)
> >  {
> >  	struct fsl_upm_nand *fun;
> > -	struct resource io_res;
> > +	struct resource *io_res;
> >  	const __be32 *prop;
> >  	int rnb_gpio;
> >  	int ret;
> > @@ -208,13 +207,12 @@ static int fun_probe(struct platform_device *ofdev)
> >  	if (!fun)
> >  		return -ENOMEM;
> >  
> > -	ret = of_address_to_resource(ofdev->dev.of_node, 0, &io_res);
> > -	if (ret) {
> > -		dev_err(&ofdev->dev, "can't get IO base\n");
> > -		return ret;
> > -	}
> > +	io_res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> > +	fun->io_base = devm_ioremap_resource(&ofdev->dev, io_res);  
> 
> Why not even using devm_platform_ioremap_resource() resource directly?

Because I need to pass the resource to fsl_upm_find().
