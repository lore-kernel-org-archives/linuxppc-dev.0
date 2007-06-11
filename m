Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id BD691DDEE9
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 17:08:13 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <4666234B.2020208@am.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c52d99b0071ef223a51612ce7d0cddea@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 09/18] PS3: System-bus rework 
Date: Mon, 11 Jun 2007 02:07:50 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Jun 6 13:00:27 EST 2007, Geoff Levand wrote:

> Rework the PS3 system bus to unify device support.
>  - DMA region sizes must be a power of two
>  - storage bus DMA updates:
>   - Small fixes for the PS3 DMA core:
>       o fix alignment bug
>       o kill superfluous test
>       o indentation
>       o spelling
>       o export ps3_dma_region_{create,free}()
>   - ps3_dma_region_init():
>       o Add `addr' and `len' parameters, so you can create a DMA 
> region that
>         does not cover all memory (use `NULL' and `0' to cover all 
> memory).
>         This is needed because there are not sufficient IOMMU 
> resources to have
>         all DMA regions cover all memory.
>       o Uninline
>  - Added remove and shutdown routines to all to all drivers.

That'd be all y'all .

Oh, wait, changelogs are not ususally in Texan. :-)


>  - Added loadable module support to all drivers.
>  - Added HV calls for iopte management (needed by sound driver).
>


Just a quick scan through :


> --- a/arch/powerpc/platforms/ps3/mm.c
> +++ b/arch/powerpc/platforms/ps3/mm.c
> -#define DBG(fmt...) do{if(0)printk(fmt);}while(0)
> +#define DBG(fmt...) do { if (0) printk(fmt);} while (0)

While there isn't a style guide for one line defines, while you're 
adding spaces add one more after the ; before the } where a new line 
would normally appear.


> +       BUG_ON(!dev->bus_id);
> +       mutex_lock(&usage_hack.mutex);
> +
> +       if(dev->bus_id == 1 && dev->dev_id == 1) {
> +               usage_hack.sb_11++;

If you expect to leave this hack in for a while, how about adding a 
DEVICE_IS(dev, bus, device) macro?

milton
