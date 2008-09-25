Return-Path: <pku.leo@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 0FFC6DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 16:54:56 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so85707eyi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 23:54:54 -0700 (PDT)
Message-ID: <2a27d3730809242354u4cc24b96yda3973bfc3ddac92@mail.gmail.com>
Date: Thu, 25 Sep 2008 14:54:54 +0800
From: "Li Yang" <leoli@freescale.com>
Sender: pku.leo@gmail.com
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH v2] fsl-dma: allow Freescale Elo DMA driver to be compiled
	as a module
In-Reply-To: <1222293567-17694-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1222293567-17694-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 5:59 AM, Timur Tabi <timur@freescale.com> wrote:
> Modify the Freescale Elo / Elo Plus DMA driver so that it can be compiled as
> a module.
>
> The primary change is to stop treating the DMA controller as a bus, and the
> DMA channels as devices on the bus.  This is because the Open Firmware (OF)
> kernel code does not allow busses to be removed, so although we can call
> of_platform_bus_probe() to probe the DMA channels, there is no
> of_platform_bus_remove().  Instead, the DMA channels are manually probed,
> similar to what fsl_elbc_nand.c does.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> v2: updated per comments
>
> This patch is for the 2.6.28 kernel.  This patch exposes a bug in the dmatest
> module, so my other patch "dmatest: properly handle duplicate DMA channels"
> should be applied if this patch is applied.
[snip]
> +static void __exit of_fsl_dma_exit(void)
> +{
> +       of_unregister_platform_driver(&of_fsl_dma_driver);
>  }
>
> -subsys_initcall(of_fsl_dma_chan_init);
>  subsys_initcall(of_fsl_dma_init);

Not a critical problem.  But module_init() are preferred for modules.

> +module_exit(of_fsl_dma_exit);
> +
> +MODULE_DESCRIPTION("Freescale Elo / Elo Plus DMA driver");
> +MODULE_LICENSE("GPL");

Acked-by: Li Yang <leoli@freescale.com>

- Leo
