Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52C73DDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 04:30:43 +1000 (EST)
Message-Id: <47B7FAA6-434C-440A-B55D-03C9882809CE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dan Williams <dan.j.williams@intel.com>
In-Reply-To: <1221837088-19539-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] fsl-dma: allow Freescale Elo DMA driver to be compiled as
	a module
Date: Wed, 24 Sep 2008 13:30:27 -0500
References: <1221837088-19539-1-git-send-email-timur@freescale.com>
Cc: zw@zh-kernel.org, Li Yang <leoli@freescale.com>,
	Timur Tabi <timur@freescale.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 19, 2008, at 10:11 AM, Timur Tabi wrote:

> Modify the Freescale Elo / Elo Plus DMA driver so that it can be  
> compiled as
> a module.
>
> The primary change is to stop treating the DMA controller as a bus,  
> and the
> DMA channels as devices on the bus.  This is because the Open  
> Firmware (OF)
> kernel code does not allow busses to be removed, so although we can  
> call
> of_platform_bus_probe() to probe the DMA channels, there is no
> of_platform_bus_remove().  Therefore, the DMA channels must be  
> manually probed.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> (Reposting because I forgot to CC: the maintainers)
>
> This patch is for the 2.6.28 kernel.  This patch exposes a bug in  
> the dmatest
> module, so my other patch "dmatest: properly handle duplicate DMA  
> channels"
> should be applied if this patch is applied.
>
> drivers/dma/Kconfig  |   10 ++--
> drivers/dma/fsldma.c |  165 +++++++++++++++++++++++++++++++++ 
> +----------------
> drivers/dma/fsldma.h |    2 +
> 3 files changed, 119 insertions(+), 58 deletions(-)

Dan, any update on this patch?

- k
