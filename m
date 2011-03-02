Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 750F6B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Mar 2011 10:25:19 +1100 (EST)
Subject: Re: [PATCH v2 3/9] fsldma: use channel name in printk output
From: Joe Perches <joe@perches.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
In-Reply-To: <1299104601-15447-4-git-send-email-iws@ovro.caltech.edu>
References: <1299104601-15447-1-git-send-email-iws@ovro.caltech.edu>
	<1299104601-15447-4-git-send-email-iws@ovro.caltech.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Mar 2011 15:17:36 -0800
Message-ID: <1299107856.4208.120.camel@Joe-Laptop>
Mime-Version: 1.0
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-02 at 14:23 -0800, Ira W. Snyder wrote:
> This makes debugging the driver much easier when multiple channels are
> running concurrently. In addition, you can see how much descriptor
> memory each channel has allocated via the dmapool API in sysfs.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
>  drivers/dma/fsldma.c |   60 +++++++++++++++++++++++++++----------------------
>  drivers/dma/fsldma.h |    1 +
>  2 files changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 2e1af45..6e3d3d7 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -37,7 +37,7 @@
>  
>  #include "fsldma.h"
>  
> -static const char msg_ld_oom[] = "No free memory for link descriptor\n";
> +static const char msg_ld_oom[] = "No free memory for link descriptor";
>  
>  /*
>   * Register Helpers
> @@ -207,7 +207,7 @@ static void dma_halt(struct fsldma_chan *chan)
>  	}
>  
>  	if (!dma_is_idle(chan))
> -		dev_err(chan->dev, "DMA halt timeout!\n");
> +		dev_err(chan->dev, "%s: DMA halt timeout!\n", chan->name);

I suggest instead you add:

#define chan_err(chan, fmt, arg...) 				\
	dev_err(chan->dev, "%s: " fmt, chan->name, ##arg);
#define chan_info(chan, fmt, arg...)				\
	dev_info(chan->dev, "%s: " fmt, chan->name, ##arg);
#define chan_dbg(chan, fmt, arg...)				\
	dev_dbg(chan->dev, "%s: " fmt, chan->name, ##arg);

and change the uses to be similar to:

	if (!dma_is_idle(chan))
		chan_err(chan, "DMA halt timeout!\n");

etc...
