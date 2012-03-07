Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A8280B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 05:22:29 +1100 (EST)
Date: Wed, 7 Mar 2012 18:21:55 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 0/9] DMA engine cookie handling cleanups
Message-ID: <20120307182155.GD18787@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <CABb+yY0A9=XKuw=N1fFXCB507zR3U=wofqATVcO_wtnnVrgXzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABb+yY0A9=XKuw=N1fFXCB507zR3U=wofqATVcO_wtnnVrgXzQ@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Vinod Koul <vinod.koul@intel.com>, Barry Song <baohua.song@csr.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 07, 2012 at 11:39:25PM +0530, Jassi Brar wrote:
> Compilation is broken without the following minor fix.
> After that you may add
>        Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 49c123f..abf35a3 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -339,7 +339,6 @@ static int pl330_control(struct dma_chan *chan,
> enum dma_ctrl_cmd cmd, unsigned
>  		/* Mark all desc done */
>  		list_for_each_entry_safe(desc, _dt, &pch->work_list , node) {
>  			desc->status = DONE;
> -			pch->completed = desc->txd.cookie;

I'm not sure just removing this is sufficient.  Presumably it's
there for some reason - maybe it needs replacing with a call to
dma_cookie_complete() to preserve existing behaviour?
