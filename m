Return-Path: <SRS0=sLSx=7Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82343C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 14:54:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1BD20738
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 14:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1BD20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cX4w4Zr2zDqd0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 00:54:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.178.242;
 helo=mslow2.mail.gandi.net; envelope-from=miquel.raynal@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cVrc0SSFzDqbl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2020 23:59:11 +1000 (AEST)
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
 by mslow2.mail.gandi.net (Postfix) with ESMTP id 9FC0A3A1D7B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2020 13:51:09 +0000 (UTC)
Received: from xps13 (unknown [91.224.148.103])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 489CA240011;
 Wed,  3 Jun 2020 13:50:29 +0000 (UTC)
Date: Wed, 3 Jun 2020 15:50:27 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH 01/10] mtd: rawnand: fsl_upm: Remove unused mtd var
Message-ID: <20200603155027.6ab65597@xps13>
In-Reply-To: <20200603134922.1352340-2-boris.brezillon@collabora.com>
References: <20200603134922.1352340-1-boris.brezillon@collabora.com>
 <20200603134922.1352340-2-boris.brezillon@collabora.com>
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
2020 15:49:13 +0200:

> The mtd var in fun_wait_rnb() is now unused, let's get rid of it and
> fix the warning resulting from this unused var.
> 
> Fixes: 50a487e7719c ("mtd: rawnand: Pass a nand_chip object to chip->dev_ready()")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/mtd/nand/raw/fsl_upm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
> index 627deb26db51..76d1032cd35e 100644
> --- a/drivers/mtd/nand/raw/fsl_upm.c
> +++ b/drivers/mtd/nand/raw/fsl_upm.c
> @@ -62,7 +62,6 @@ static int fun_chip_ready(struct nand_chip *chip)
>  static void fun_wait_rnb(struct fsl_upm_nand *fun)
>  {
>  	if (fun->rnb_gpio[fun->mchip_number] >= 0) {
> -		struct mtd_info *mtd = nand_to_mtd(&fun->chip);
>  		int cnt = 1000000;
>  
>  		while (--cnt && !fun_chip_ready(&fun->chip))

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
