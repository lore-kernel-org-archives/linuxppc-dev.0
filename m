Return-Path: <dwalker@fifo99.com>
Received: from ip-172-31-12-36.us-west-2.compute.internal
 (ec2-54-201-57-178.us-west-2.compute.amazonaws.com [54.201.57.178])
 by lists.ozlabs.org (Postfix) with ESMTP id BDB2B1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 10:16:03 +1100 (AEDT)
Date: Mon, 11 Jan 2016 15:07:54 -0800
From: dwalker@fifo99.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: simple_alloc space tramples initrd
Message-ID: <20160111230754.GA18849@fifo99.com>
References: <20160108174506.GA12105@fifo99.com>
 <1452481774.31943.3.camel@ellerman.id.au>
 <20160111164916.GA18065@fifo99.com>
 <1452550673.23317.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452550673.23317.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 12, 2016 at 09:17:53AM +1100, Michael Ellerman wrote:
> On Mon, 2016-01-11 at 08:49 -0800, dwalker@fifo99.com wrote:
> > On Mon, Jan 11, 2016 at 02:09:34PM +1100, Michael Ellerman wrote:
> > > On Fri, 2016-01-08 at 09:45 -0800, dwalker@fifo99.com wrote:
> > > > Hi,
> > > > 
> > > > A powerpc machine I'm working on has this problem where the
> > > > simple_alloc_init() area is trampling the initrd. The two are placed fairly
> > > > close together.
> > > 
> > > Which machine / platform?
> > 
> > It's not upstream yet. I'm still putting the patches together, that's when this
> > issue came up. I can send an RFC if you want to look at the patches.
> 
> OK. Thanks but I don't need more patches to look at :)
> 
> I was just trying to narrow down which code you were talking about.

It's coming eventually anyways ;) ..

> > > I don't really know that code very well. But ideally either the boot loader
> > > gives you space, or the platform boot code is smart enough to detect that there
> > > is insufficient room and puts the heap somewhere else.
> > 
> > It seems like the kernel should be able to handle it. I believe the bootloader passes
> > the initrd location , but I don't think it's evaluated till later in the boot up. For
> > simple_alloc_init() it seems all platforms just assume the space is empty without checking.
> 
> Yeah that's what I see too, which seems like it's liable to break, but
> obviously hasn't for anyone else yet.
> 
> The bootloader must pass the initrd location, otherwise the kernel can't use
> it, so it seems like the kernel should be able to notice when they are too
> close. But it may be complicated by the sequencing of the code.


I found a similar one,

arch/powerpc/boot/ps3.c:platform_init()

I realized that in platform_init() your discovering the initrd location, so you do have
access to the values. In ps3 you can see how if the initrd is placed in the 16megs after
the kernel image then the simple_alloc code could corrupt it.

I think it would be appropriate to check the initrd location in that function (since it's available)
and make a choice to put the simple_alloc area after the initrd if the areas overlap. Does that make
sense ?

Daniel
