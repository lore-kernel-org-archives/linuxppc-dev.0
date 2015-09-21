Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 063B31A38AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 17:10:29 +1000 (AEST)
Message-ID: <1442819428.354.2.camel@ellerman.id.au>
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org, Steven Rostedt
 <rostedt@goodmis.org>
Date: Mon, 21 Sep 2015 17:10:28 +1000
In-Reply-To: <alpine.DEB.2.11.1509181643550.3951@nanos>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
 <alpine.DEB.2.11.1509162159110.3951@nanos>
 <20150916215435.48bee4d3@grimm.local.home>
 <alpine.DEB.2.11.1509170911120.3951@nanos>
 <1442570517.5528.3.camel@ellerman.id.au>
 <20150918143204.GE29692@gate.crashing.org>
 <alpine.DEB.2.11.1509181643550.3951@nanos>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-09-18 at 16:45 +0200, Thomas Gleixner wrote:
> On Fri, 18 Sep 2015, Segher Boessenkool wrote:
> 
> > On Fri, Sep 18, 2015 at 08:01:57PM +1000, Michael Ellerman wrote:
> > > Weird.
> > > 
> > > Can you try:
> > > 
> > >   d690740f22f6 ("powerpc/powernv: Enable LEDS support")
> > > 
> > > That is the commit before my merge of Scott's tree, which had all the Freescale
> > > & 32-bit stuff.
> > > 
> > > If that works, it would isolate it to only about 30 commits from Scott's tree.
> > 
> > My theory is it is not a kernel problem at all; instead, uboot overwrites
> > some little part of the kernel image.
> 
> u-boot is just loading a cuImage which is a kernel with appended
> device tree. So u-boot is out of the picture,

Unless something is still DMA'ing after u-boot has handed over to the kernel.
We had that happen on OF years ago.

> still investigating (when time allows)

Thanks. I assume no one at Freescale has been able to reproduce this?

cheers
