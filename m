Return-Path: <Phil.Nitschke@avalon.com.au>
Received: from camden.avalon.com.au (unknown [150.101.131.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBE9F67DAF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 20:08:11 +1000 (EST)
Subject: Re: ioremap() fails for >64 MB
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: Matt Porter <mporter@embeddedalley.com>
In-Reply-To: <20060822142233.GA21339@gate.crashing.org>
References: <1156232469.26041.19.camel@caxton.int.avalon.com.au>
	<20060822142233.GA21339@gate.crashing.org>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 19:30:37 +0930
Message-Id: <1156327238.6735.9.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-22 at 09:22 -0500, Matt Porter wrote:
> On Tue, Aug 22, 2006 at 05:11:09PM +0930, Phil Nitschke wrote:
> > Hi all,
> > 
> > I have 2 GB memory on a 7448 processor, and want to reserve a huge chunk
> > of it at boot-time, then ioremap() it into the kernel space inside a
> > device driver.  So far I've succeeded with 64 MB, but can't go any
> > higher, as mm/vmalloc.c tells me: "allocation failed: out of vmalloc
> > space - use vmalloc=<size> to increase size."
> > 
> > So I tried adding a vmalloc line to the kernel command line as follows:
> > Kernel cmd line: root=/dev/nfs rw mem=1920M vmalloc=1024M nfsroot=... 
>  
> Yeah, that suggestion is bogus. That option can't help with getting
> more vmalloc space in this case.
> 
> > So the vmalloc=<size> argument has made no difference.  What do I need
> > to do to make this work?
> 
> Go to the "Advanced setup" menu. There's a number of options to provide
> fine-grained control of the PPC kernel virtual address space.

<SNIP>

Thanks Matt (and others) for your suggestions.  Matt has given me the
answers I was looking for.

Since my (2 GB) memory is within the (4 GB) addressable by a 32-bit
processor, why do I need high memory at all?  

Are there performance implications on this platform from having a non
optimal low/high ratio?

> That said, why don't you just use alloc_bootmem() to reserve memory
> for your driver at boot time? 

I avoided this simply because I wanted to load/unload my driver (during
development), and alloc_bootmem() seemed better suited to drivers
compiled into the kernel.  But I'll look again at this idea if further
problems arise with the approach above.

Thanks again,

-- 
Phil
