Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f195.google.com (mail-iy0-f195.google.com
	[209.85.210.195]) by ozlabs.org (Postfix) with ESMTP id 370961007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 16:35:51 +1100 (EST)
Received: by iyj17 with SMTP id 17so5149333iyj.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Dec 2010 21:35:49 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 29 Dec 2010 22:35:45 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 1/6] mpc512x_dma: scatter/gather fix
Message-ID: <20101230053545.GA27954@angua.secretlab.ca>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
	<1288137180-3220-2-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288137180-3220-2-git-send-email-yanok@emcraft.com>
Cc: vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 27, 2010 at 01:52:55AM +0200, Ilya Yanok wrote:
> While testing mpc512x-dma driver with dmatest module I've found that
> I can hang the mpc512x-dma issueing request from multiple threads to
> the single channel.
> (insmod dmatest.ko max_channels=1 threads_per_chan=16)
> After investingating this case I've managed to find that this happens
> if and only if we have more than one quequed requests.
> In this case the driver tries to make use of hardware scatter/gather
> functionality. I've found two problems with scatter/gather:
>  1. When TCD is copied form RAM to the TCD register space with memcpy_io()
> e_sg bit eventually gets cleared. This results in only first TCD being
> executed. I've added setting of e_sg bit excplicitly in the TCD registers.
> BTW, what is the correct way to do this? (How can I use setbits with bitfield
> structure?) After that hardware loads consecutive TCDs and we hit the
> second issue.
>  2. Existing code clears int_maj bit in the last TCD so we never get
> an interrupt on transfefr completion.
> 
> With these fixes my tests with many threads of single channel succeed but
> tests that use many channels simultaneously still don't work reliable.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> Cc: Piotr Ziecik <kosmo@semihalf.com>

Merged for -next, thanks.

g.

> ---
>  drivers/dma/mpc512x_dma.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
> index 4e9cbf3..1bc04aa 100644
> --- a/drivers/dma/mpc512x_dma.c
> +++ b/drivers/dma/mpc512x_dma.c
> @@ -252,11 +252,13 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
>  		prev = mdesc;
>  	}
>  
> -	prev->tcd->start = 0;
>  	prev->tcd->int_maj = 1;
>  
>  	/* Send first descriptor in chain into hardware */
>  	memcpy_toio(&mdma->tcd[cid], first->tcd, sizeof(struct mpc_dma_tcd));
> +
> +	if (first != prev)
> +		mdma->tcd[cid].e_sg = 1;
>  	out_8(&mdma->regs->dmassrt, cid);
>  }
>  
> -- 
> 1.7.2.3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
