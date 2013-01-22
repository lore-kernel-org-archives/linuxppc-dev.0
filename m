Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CD6BB2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2013 08:11:01 +1100 (EST)
Date: Tue, 22 Jan 2013 22:10:49 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] powerpc/5200: Fix size to request_mem_region() call
Message-ID: <20130122221049.0bc73953@crub>
In-Reply-To: <1358473200-17886-1-git-send-email-grant.likely@secretlab.ca>
References: <1358473200-17886-1-git-send-email-grant.likely@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On Fri, 18 Jan 2013 01:39:59 +0000
Grant Likely <grant.likely@secretlab.ca> wrote:

> The Bestcomm driver requests a memory region larger than the one
> described in the device tree. This is due to an extra undocumented field
> in the bestcomm register structure. This hasn't been a problem up to
> now, but there is a patch pending to make the DT platform_bus support
> code use platform_device_add() which tightens the rules and provides
> extra checks for drivers to stay within the specified register regions.
> 
> Alternately, I could have removed the extra field from the structure,
> but I'm not sure if it is still needed for resume to work. Better be
> safe and leave it in.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/sysdev/bestcomm/bestcomm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

There is a patch moving this driver to drivers/dma,

http://patchwork.ozlabs.org/patch/191153/

I've applied it to my 5xxx next branch.

> diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
> index d913063..81c3314 100644
> --- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
> +++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
> @@ -414,7 +414,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>  		goto error_sramclean;
>  	}
>  
> -	if (!request_mem_region(res_bcom.start, sizeof(struct mpc52xx_sdma),
> +	if (!request_mem_region(res_bcom.start, resource_size(&res_bcom),
>  				DRIVER_NAME)) {
>  		printk(KERN_ERR DRIVER_NAME ": "
>  			"Can't request registers region\n");

similar change is needed for release_mem_region() in error path
and in driver's remove() function.

Thanks,

Anatolij
