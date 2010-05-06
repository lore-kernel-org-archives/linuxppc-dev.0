Return-Path: <dedekind1@gmail.com>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35DDDB7D47
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 May 2010 16:43:16 +1000 (EST)
Received: from mgw-mx09.nokia.com ([192.100.105.134])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id
	o466h6nV027283
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 May 2010 09:43:09 +0300
Subject: Re: [PATCH resend] mpc5121_nfc: Changed SVR check to allow MPC5123.
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Steve Deiters <SteveDeiters@BASLER.com>
In-Reply-To: <181804936ABC2349BE503168465576460EA16F75@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460E95836C@exchserver.basler.com>
	<1272980863.3702.10.camel@localhost>
	<181804936ABC2349BE503168465576460EA16F75@exchserver.basler.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 May 2010 09:42:07 +0300
Message-ID: <1273128127.3702.201.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-05-05 at 13:48 -0500, Steve Deiters wrote:
> The revision in SVR for MPC5123 is 3.  The NFC is the same as MPC5121
> revision 2.
> 
> Signed-off-by: Steve Deiters <SteveDeiters@basler.com>
> ---
>  drivers/mtd/nand/mpc5121_nfc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mpc5121_nfc.c
> b/drivers/mtd/nand/mpc5121_nfc.c
> index 191bf99..dc04d74 100644
> --- a/drivers/mtd/nand/mpc5121_nfc.c
> +++ b/drivers/mtd/nand/mpc5121_nfc.c
> @@ -666,10 +666,10 @@ static int __devinit mpc5121_nfc_probe(struct
> of_device *op,
>  
>  	/*
>  	 * Check SoC revision. This driver supports only NFC
> -	 * in MPC5121 revision 2.
> +	 * in MPC5121 revision 2 and MPC5123 revision 3.
>  	 */
>  	rev = (mfspr(SPRN_SVR) >> 4) & 0xF;
> -	if (rev != 2) {
> +	if ((rev != 2) && (rev != 3)) {
>  		dev_err(dev, "SoC revision %u is not supported!\n",
> rev);
>  		return -ENXIO;
>  	}

Now your patch is line-wrapped. But I fixed it and pushed to
l2-mtd-2.6.git / master.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
