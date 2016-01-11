Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40E761A08BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 14:09:35 +1100 (AEDT)
Message-ID: <1452481774.31943.3.camel@ellerman.id.au>
Subject: Re: simple_alloc space tramples initrd
From: Michael Ellerman <mpe@ellerman.id.au>
To: dwalker@fifo99.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 11 Jan 2016 14:09:34 +1100
In-Reply-To: <20160108174506.GA12105@fifo99.com>
References: <20160108174506.GA12105@fifo99.com>
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

On Fri, 2016-01-08 at 09:45 -0800, dwalker@fifo99.com wrote:
> Hi,
> 
> A powerpc machine I'm working on has this problem where the
> simple_alloc_init() area is trampling the initrd. The two are placed fairly
> close together.

Which machine / platform?

> I have a fix for this proposed to add a section into
> arch/powerpc/boot/zImage.lds.S called "mallocarea" to account for this space,
> but not all powerpc platforms use simple_alloc_init(). So for those platforms
> it's a waste.

Yeah I don't really like the sound of that. We could do it if it was behind a
CONFIG option, but hopefully there is a better solution.

> Another alternative is to alter the bootloader to place more space between
> the kernel image and initrd image.
>
> I wanted to get some feedback on the right way to fix this. It seems like it
> could be a generic issue on powerpc, or it's possibly already fixed someplace
> and I just haven't noticed.

I don't really know that code very well. But ideally either the boot loader
gives you space, or the platform boot code is smart enough to detect that there
is insufficient room and puts the heap somewhere else.

cheers
