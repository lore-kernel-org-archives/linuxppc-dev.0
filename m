Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D170B6F7E
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2012 11:35:26 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
Date: Mon, 16 Jan 2012 00:35:22 +0000
Message-ID: <4F1370C9.9010400@freescale.com>
References: <19504.1326673788@neuling.org>
In-Reply-To: <19504.1326673788@neuling.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> Fix a bunch of compiler errors and warnings introduced in:
>    commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
>    Author: Timur Tabi<timur@freescale.com>
>    drivers/video: fsl-diu-fb: merge all allocated data into one block
>
> Signed-off-by: Michael Neuling<mikey@neuling.org>
> ---
> Timur: you do compile test your patches, right? :-P

I have a script that tests each commit in a set to make sure it compiles,=20
so that git-bisect isn't broken.

> This is effecting mpc85xx_defconfig on mainline (and has been in
> linux-next for while already).
>
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index acf292b..78cac52 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -366,7 +366,7 @@ struct mfb_info {
>    */
>   struct fsl_diu_data {
>   	dma_addr_t dma_addr;
> -	struct fb_info fsl_diu_info[NUM_AOIS];
> +	struct fb_info *fsl_diu_info[NUM_AOIS];

This doesn't make any sense.  If you change fsl_diu_info into a pointer,=20
then where is the object being allocated?

--=20
Timur Tabi
Linux kernel developer at Freescale=
