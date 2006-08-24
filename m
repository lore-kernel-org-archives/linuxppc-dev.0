Return-Path: <mporter@embeddedalley.com>
Received: from matthew-porters-computer.local (cpe-088197.static.wadsnet.net
	[65.114.88.197]) by ozlabs.org (Postfix) with ESMTP id 52E2867CDC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 23:27:35 +1000 (EST)
Date: Thu, 24 Aug 2006 08:56:13 -0400
From: Matt Porter <mporter@embeddedalley.com>
To: Phil Nitschke <Phil.Nitschke@avalon.com.au>
Subject: Re: ioremap() fails for >64 MB
Message-ID: <20060824125613.GB23291@matthew-porters-computer.local>
References: <1156232469.26041.19.camel@caxton.int.avalon.com.au>
	<20060822142233.GA21339@gate.crashing.org>
	<1156327238.6735.9.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1156327238.6735.9.camel@lamorak.int.avalon.com.au>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 23, 2006 at 07:30:37PM +0930, Phil Nitschke wrote:
> On Tue, 2006-08-22 at 09:22 -0500, Matt Porter wrote:
> > On Tue, Aug 22, 2006 at 05:11:09PM +0930, Phil Nitschke wrote:
> > > Hi all,
> > > 
> > > I have 2 GB memory on a 7448 processor, and want to reserve a huge chunk
> > > of it at boot-time, then ioremap() it into the kernel space inside a
> > > device driver.  So far I've succeeded with 64 MB, but can't go any
> > > higher, as mm/vmalloc.c tells me: "allocation failed: out of vmalloc
> > > space - use vmalloc=<size> to increase size."
> > > 
> > > So I tried adding a vmalloc line to the kernel command line as follows:
> > > Kernel cmd line: root=/dev/nfs rw mem=1920M vmalloc=1024M nfsroot=... 
> >  
> > Yeah, that suggestion is bogus. That option can't help with getting
> > more vmalloc space in this case.
> > 
> > > So the vmalloc=<size> argument has made no difference.  What do I need
> > > to do to make this work?
> > 
> > Go to the "Advanced setup" menu. There's a number of options to provide
> > fine-grained control of the PPC kernel virtual address space.
> 
> <SNIP>
> 
> Thanks Matt (and others) for your suggestions.  Matt has given me the
> answers I was looking for.
> 
> Since my (2 GB) memory is within the (4 GB) addressable by a 32-bit
> processor, why do I need high memory at all?  

Dan answered this one...
 
> Are there performance implications on this platform from having a non
> optimal low/high ratio?
 
It "depends". In PPC, we've always has kernelbase at 0xc0000000, however,
the dirty secret is that we still haven't have a 3:1 user:kernel split
like some other arches.  We've always had TASK_SIZE at 0x80000000 which
really results in a 1:1 split.  So, as long as you don't modify
TASK_SIZE, there's no chance of starving memory hungry user space
applications. There's already this waste space from 0x80000000-0xbfffffff
that was left due to legacy PReP reasons.

Even if you do modify TASK_SIZE down to something like 0x40000000,
for a 1:3 split, many embedded apps are perfectly happy with this
space, YMMV.

It's important that you understand how the userspace works at the
low level, plus VSIDs (on classic PPC), and the general concepts
of the virtual memory organization between kernel and userspace before
you mess with all these advanced options.  They are under advanced
options since they can easily make your system inoperable with the
improper settings.

> > That said, why don't you just use alloc_bootmem() to reserve memory
> > for your driver at boot time? 
> 
> I avoided this simply because I wanted to load/unload my driver (during
> development), and alloc_bootmem() seemed better suited to drivers
> compiled into the kernel.  But I'll look again at this idea if further
> problems arise with the approach above.

I see. It doesn't have any bearing on using a loadable module since
alloc_bootmem() is only called by your board port code. Your loadable
module just uses that reserved area and manages it on its own.

In any case, either approach will work.

-Matt
