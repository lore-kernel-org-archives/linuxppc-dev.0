Return-Path: <boojin.kim@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by ozlabs.org (Postfix) with ESMTP id EA62FB6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2012 21:06:40 +1000 (EST)
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M2X00BD3IV0RD50@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 23 Apr 2012 20:06:37 +0900 (KST)
Received: from DOBOOJINKIM03 ([12.23.119.77])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M2X0005PIV0OT60@mmp1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 23 Apr 2012 20:06:36 +0900 (KST)
From: Boojin Kim <boojin.kim@samsung.com>
To: 'Vinod Koul' <vinod.koul@linux.intel.com>,
 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
 <056201cd2135$10ea5b70$32bf1250$%kim@samsung.com>
 <20120423095013.GL24211@n2100.arm.linux.org.uk>
 <1335175278.31825.108.camel@vkoul-udesk3>
In-reply-to: <1335175278.31825.108.camel@vkoul-udesk3>
Subject: RE: [PATCH 5/9] dmaengine: provide a common function for completing a
 dma descriptor
Date: Mon, 23 Apr 2012 20:06:36 +0900
Message-id: <000001cd2141$26914d60$73b3e820$%kim@samsung.com>
Cc: 'Stephen Warren' <swarren@nvidia.com>,
 'Linus Walleij' <linus.walleij@stericsson.com>,
 'Srinidhi Kasagar' <srinidhi.kasagar@stericsson.com>,
 'Dan Williams' <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vinod Koul wrote:
> Sent: Monday, April 23, 2012 7:01 PM
> To: Russell King - ARM Linux
> Cc: 'Stephen Warren'; 'Linus Walleij'; 'Srinidhi Kasagar'; Boojin Kim; 'Dan Williams'; 'Li Yang';
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 5/9] dmaengine: provide a common function for completing a dma descriptor
>
> On Mon, 2012-04-23 at 10:50 +0100, Russell King - ARM Linux wrote:
> > On Mon, Apr 23, 2012 at 06:40:06PM +0900, Boojin Kim wrote:
> > > I met a problem on DMA cyclic mode (DMA_CYCLIC) for sound playback.
> > > Kernel BUG occurs during DMA transfer with DMA cyclic mode.
> > > This patch makes the cookies into zero. But, cookies should be kept
> > > during cyclic mode because cyclic mode re-uses the cookies.
> >
> > The protection is there to prevent cookies being accidentally re-used.
> > If you're running a cyclic transfer, even then you shouldn't be completing
> > the same cookie time and time again - I think Vinod also concurs with this.
> Right :)
> I recently committed patch for imx-dma which doesn't mark the cyclic
> descriptor as complete. Descriptor represents a transaction and makes no
> sense to complete t if the transaction is still continuing.
Dear Vinod,
you already fixed it. :) thanks.
And I have other question. (Actually, It doesn't relate to this patch.)
I met the DMA probing fail problem on Linux 3.4.
It's because the return value on regulator_get() is changed
from ENODEV to EPROBE_DEFER in case not to supply a vcore regulator.
So, I try to change the check value about the return value of regulator_get()
in amba_get_enable_vcore()from ENODEV to EPROBE_DEFER.
How about it ? Do you already fix it too?

Thanks,
Boojin

> >
> > I think our preference is for cyclic transfers to entire remain uncompleted,
> > or to get a new cookie each time they allegedly "complete".
> No it is not complete. Cyclic never completes, it aborts when user
> wants. The "notification" interrupt is for updating the
> counters/notifying (timestamp/periods elapsed in sound), and shouldn't
> be used for anything else
>
> --
> ~Vinod
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
