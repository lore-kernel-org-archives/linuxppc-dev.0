Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AF2482C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 23:48:33 +1100 (EST)
Date: Thu, 26 Dec 2013 13:48:28 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v6 4/5] dma: mpc512x: register for device tree
 channel lookup
Message-ID: <20131226124828.GK8064@book.gsilab.sittig.org>
References: <1387886789-20249-1-git-send-email-a13xp0p0v88@gmail.com>
 <1387886789-20249-5-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387886789-20249-5-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ dropping devicetree, we're DMA specific here ]

On Tue, Dec 24, 2013 at 16:06 +0400, Alexander Popov wrote:
> 
> --- a/drivers/dma/mpc512x_dma.c
> +++ b/drivers/dma/mpc512x_dma.c
> [ ... ]
> @@ -950,6 +951,7 @@ static int mpc_dma_probe(struct platform_device *op)
>  	INIT_LIST_HEAD(&dma->channels);
>  	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
>  	dma_cap_set(DMA_SLAVE, dma->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>  
>  	for (i = 0; i < dma->chancnt; i++) {
>  		mchan = &mdma->channels[i];

What are the implications of this?  Is a comment due?

I haven't found documentation about the DMA_PRIVATE flag, only
saw commit 59b5ec21446b9 "dmaengine: introduce
dma_request_channel and private channels".  Alex, unless I'm
missing something this one-line change is quite a change in
semantics, and has dramatic influence on the code's behaviour
(ignores the DMA controller when looking for channels that can do
mem-to-mem transfers).

Please reason about this change some more, and explain what it
does and why it's needed.  Consider the fact that this driver
handles both MPC5121 as well as MPC8308 hardware.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
