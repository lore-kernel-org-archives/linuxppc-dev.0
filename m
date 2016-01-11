Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE0F71A0050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 09:17:53 +1100 (AEDT)
Message-ID: <1452550673.23317.1.camel@ellerman.id.au>
Subject: Re: simple_alloc space tramples initrd
From: Michael Ellerman <mpe@ellerman.id.au>
To: dwalker@fifo99.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 12 Jan 2016 09:17:53 +1100
In-Reply-To: <20160111164916.GA18065@fifo99.com>
References: <20160108174506.GA12105@fifo99.com>
 <1452481774.31943.3.camel@ellerman.id.au>
 <20160111164916.GA18065@fifo99.com>
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

On Mon, 2016-01-11 at 08:49 -0800, dwalker@fifo99.com wrote:
> On Mon, Jan 11, 2016 at 02:09:34PM +1100, Michael Ellerman wrote:
> > On Fri, 2016-01-08 at 09:45 -0800, dwalker@fifo99.com wrote:
> > > Hi,
> > > 
> > > A powerpc machine I'm working on has this problem where the
> > > simple_alloc_init() area is trampling the initrd. The two are placed fairly
> > > close together.
> > 
> > Which machine / platform?
> 
> It's not upstream yet. I'm still putting the patches together, that's when this
> issue came up. I can send an RFC if you want to look at the patches.

OK. Thanks but I don't need more patches to look at :)

I was just trying to narrow down which code you were talking about.

> > I don't really know that code very well. But ideally either the boot loader
> > gives you space, or the platform boot code is smart enough to detect that there
> > is insufficient room and puts the heap somewhere else.
> 
> It seems like the kernel should be able to handle it. I believe the bootloader passes
> the initrd location , but I don't think it's evaluated till later in the boot up. For
> simple_alloc_init() it seems all platforms just assume the space is empty without checking.

Yeah that's what I see too, which seems like it's liable to break, but
obviously hasn't for anyone else yet.

The bootloader must pass the initrd location, otherwise the kernel can't use
it, so it seems like the kernel should be able to notice when they are too
close. But it may be complicated by the sequencing of the code.

cheers
