Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 36A292C04E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 11:16:36 +1000 (EST)
Message-ID: <1372036573.3944.115.camel@pasglop>
Subject: Re: Inbound PCI and Memory Corruption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter LaDow <pladow@gmail.com>
Date: Mon, 24 Jun 2013 11:16:13 +1000
In-Reply-To: <F3E9F49F-9C68-4BCB-B2A0-507AB1B2F10F@gmail.com>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
 <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
 <1371945647.3944.106.camel@pasglop>
 <F3E9F49F-9C68-4BCB-B2A0-507AB1B2F10F@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Peter LaDow <petela@gocougs.wsu.edu>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-23 at 17:56 -0700, Peter LaDow wrote:
> 
> On Jun 22, 2013, at 5:00 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> 
> > On Fri, 2013-06-21 at 10:14 -0700, Peter LaDow wrote:
> >> 
> > Afaik e300 is slightly out of order, maybe it's missing a memory
> barrier
> > somewhere.... One thing to try is to add some to the dma_map/unmap
> ops.
> > 
> > Also audit the driver to ensure that it properly uses barriers when
> > populating descriptors (and maybe compare to a more recent version
> of
> > the driver upstream).
> Thanks for the tips.
> 
> I've been working with the folk at Intel on the e1000-dev list, and
> they did add memory barriers. And I've tried the latest e1000 drivers
> (direct from the e1000 tree) with no luck.
> 
> I've done PCI traces, and there is no DMA after the disable is written
> to the e1000 part. All I can think is that there may be posted writes,
> the kernel goes on to cleanup the DMA buffers. But there are write
> memory barriers, so I don't see how this is possible.
> 
> Are the memory barriers meaningful in single processor builds?

Yes. However they have no effect on posted writes by the chip. You
need to do an MMIO read for these to take effect.

Also dbl check that the MMU is indeed mapping all these pages with the
"M" bit.

Cheers,
Ben.
