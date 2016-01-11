Return-Path: <dwalker@fifo99.com>
Received: from ip-172-31-12-36.us-west-2.compute.internal
 (ec2-54-201-57-178.us-west-2.compute.amazonaws.com [54.201.57.178])
 by lists.ozlabs.org (Postfix) with ESMTP id 3D60E1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 03:57:26 +1100 (AEDT)
Date: Mon, 11 Jan 2016 08:49:17 -0800
From: dwalker@fifo99.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: simple_alloc space tramples initrd
Message-ID: <20160111164916.GA18065@fifo99.com>
References: <20160108174506.GA12105@fifo99.com>
 <1452481774.31943.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452481774.31943.3.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 11, 2016 at 02:09:34PM +1100, Michael Ellerman wrote:
> On Fri, 2016-01-08 at 09:45 -0800, dwalker@fifo99.com wrote:
> > Hi,
> > 
> > A powerpc machine I'm working on has this problem where the
> > simple_alloc_init() area is trampling the initrd. The two are placed fairly
> > close together.
> 
> Which machine / platform?

It's not upstream yet. I'm still putting the patches together, that's when this
issue came up. I can send an RFC if you want to look at the patches.
 
> > I have a fix for this proposed to add a section into
> > arch/powerpc/boot/zImage.lds.S called "mallocarea" to account for this space,
> > but not all powerpc platforms use simple_alloc_init(). So for those platforms
> > it's a waste.
> 
> Yeah I don't really like the sound of that. We could do it if it was behind a
> CONFIG option, but hopefully there is a better solution.
> 
> > Another alternative is to alter the bootloader to place more space between
> > the kernel image and initrd image.
> >
> > I wanted to get some feedback on the right way to fix this. It seems like it
> > could be a generic issue on powerpc, or it's possibly already fixed someplace
> > and I just haven't noticed.
> 
> I don't really know that code very well. But ideally either the boot loader
> gives you space, or the platform boot code is smart enough to detect that there
> is insufficient room and puts the heap somewhere else.

It seems like the kernel should be able to handle it. I believe the bootloader passes
the initrd location , but I don't think it's evaluated till later in the boot up. For
simple_alloc_init() it seems all platforms just assume the space is empty without checking.

Daniel
