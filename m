Return-Path: <krzysztof.h1@poczta.fm>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by ozlabs.org (Postfix) with ESMTP id 9F694DE058
	for <linuxppc-dev@ozlabs.org>; Sun, 17 May 2009 18:00:57 +1000 (EST)
Date: Sun, 17 May 2009 10:06:43 +0200
From: Krzysztof Helt <krzysztof.h1@poczta.fm>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: Add PLB support and cleanup
	DCR in xilinxfb driver.
Message-Id: <20090517100643.9d00e980.krzysztof.h1@poczta.fm>
In-Reply-To: <20090515181237.22961.64270.stgit@localhost.localdomain>
References: <20090515181237.22961.64270.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fbdev-devel@lists.sourceforge.net,
	Antonino Daplas <adaplas@gmail.com>, Suneel <suneelg@xilinx.com>,
	linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant and John,

On Fri, 15 May 2009 12:19:17 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> Antonino,
> 

Antonino is gone for quite a long time. I have reviewed your patch.
I have two comments only. Both are of small caliber.

> If you prefer, I'm willing to merge it via my powerpc tree.
> 

As you prefer. If you want to send it here, CC it top Andrew Morton.

>  drivers/video/xilinxfb.c |  290 ++++++++++++++++++++++++----------------------
>  1 files changed, 151 insertions(+), 139 deletions(-)
> 
> 
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index 40a3a2a..7a868bd 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c

(...)

> @@ -107,17 +111,28 @@ static struct fb_var_screeninfo xilinx_fb_var = {
>  	.activate =	FB_ACTIVATE_NOW
>  };
>  
> +
> +#define PLB_ACCESS_FLAG	0x1		/* 1 = PLB, 0 = DCR */
> +
>  struct xilinxfb_drvdata {
>  
>  	struct fb_info	info;		/* FB driver info record */
>  
> -	u32		regs_phys;	/* phys. address of the control registers */
> -	u32 __iomem	*regs;		/* virt. address of the control registers */
> +	phys_addr_t	regs_phys;	/* phys. address of the control
> +						registers */

There are fields fb_info.fix.mmio_start and fb_info.fix.mmio_len for
physical IO range used by framebuffer. There is no field for
virtual IO address so the "regs" below must stay.

> +	void __iomem	*regs;		/* virt. address of the control
> +						registers */
> +
> +	dcr_host_t      dcr_host;
> +	unsigned int    dcr_start;
> +	unsigned int    dcr_len;
>  
>  	void		*fb_virt;	/* virt. address of the frame buffer */
>  	dma_addr_t	fb_phys;	/* phys. address of the frame buffer */
>  	int		fb_alloced;	/* Flag, was the fb memory alloced? */
>  
> +	u8 		flags;		/* features of the driver */
> +
>  	u32		reg_ctrl_default;
>  
>  	u32		pseudo_palette[PALETTE_ENTRIES_NO];

(...)

> @@ -247,7 +266,10 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
>  	if (!drvdata->fb_virt) {
>  		dev_err(dev, "Could not allocate frame buffer memory\n");
>  		rc = -ENOMEM;
> -		goto err_fbmem;
> +		if (drvdata->flags & PLB_ACCESS_FLAG)
> +			goto err_fbmem;
> +		else
> +			goto err_region;
>  	}
>  

The code after labels err_fbmem and err_region is also
modified so there is no need for the if clause here (just
do "goto err_fbmem").

>  	/* Clear (turn to black) the framebuffer */


The rest of the patch is ok for me.

Regards,
Krzysztof

----------------------------------------------------------------------
Fantastyczne nagrody do zgarniecia!
Zagraj >> http://link.interia.pl/f2177 
