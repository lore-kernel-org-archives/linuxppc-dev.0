Return-Path: <mmporter@cox.net>
Received: from fed1rmmtai18.cox.net (fed1rmmtai18.cox.net [68.230.241.41])
	by ozlabs.org (Postfix) with ESMTP id 27FCC67A90
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 06:15:26 +1100 (EST)
Date: Thu, 27 Jan 2005 11:16:15 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050127111615.A4266@cox.net>
References: <c3d0340b0501271005409166e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b0501271005409166e6@mail.gmail.com>;
	from shawnxjin@gmail.com on Thu, Jan 27, 2005 at 10:05:33AM -0800
Cc: linuxppc <linuxppc-dev@ozlabs.org>
Subject: Re: Relocating interrupt vectors in ppc440?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 27, 2005 at 10:05:33AM -0800, Shawn Jin wrote:
> Hi,
> 
> Do interrupt vectors locate at low addresses physically in ppc440?

Yes.

> >From the processor's user manual I understand that the base address of
> interrupt vectors actually can be anywhere, set by IVPR. Also from
> head_44x.S I found the following comments
> 
> /*
>  * The Book E MMUs are always on so we don't need to handle
>  * interrupts in real mode as with previous PPC processors. In
>  * this case we handle interrupts in the kernel virtual address
>  * space.
>  *
>  * Interrupt vectors are dynamically placed relative to the
>  * interrupt prefix as determined by the address of interrupt_base.
>  * The interrupt vectors offsets are programmed using the labels
>  * for each interrupt vector entry.
>  *
>  */
> 
> The address of interrupt_base is 0xc0000224 in the image I built,
> which is a virtual address from kernel point of view. What's the
> corresponding physical address? Is it my SDRAM's physical base address
> + 0x224 (the offset)?

Yes.

> Assumed that the interrupt vectors locate at the low address space
> physically and given that there is 2GB SDRAM shared by two ppc440
> cores, can one of linux kernels run at the top of 1GB space? This
> means the interrupt vectors for this copy need to move to upper 1GB.
> Each core runs a copy of linux kernel independently.

Yes, you'd have to do something like the APUS code does by settings
PPC_MEMSTART appropriately for the second processor. Also, of course
limiting the memory on the first processor to 1GB. There's probably
a lot of fall out from PPC_MEMSTART being non-zero. I seem to
recall lots of assumptions about PPC_MEMSTART being at zero as
I was doing the ppc440 core work. You'll have to audit all the
MM paths for these assumptions, but it can be done.

> Any ideas about relocating interupt vectors in ppc440?

One idea is that if you really don't have to do it, then don't. :)

-Matt
