Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58B6267C1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 00:10:34 +1000 (EST)
Date: Tue, 22 Aug 2006 09:22:33 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: Phil.Nitschke@avalon.com.au
Subject: Re: ioremap() fails for >64 MB
Message-ID: <20060822142233.GA21339@gate.crashing.org>
References: <1156232469.26041.19.camel@caxton.int.avalon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1156232469.26041.19.camel@caxton.int.avalon.com.au>
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

On Tue, Aug 22, 2006 at 05:11:09PM +0930, Phil Nitschke wrote:
> Hi all,
> 
> I have 2 GB memory on a 7448 processor, and want to reserve a huge chunk
> of it at boot-time, then ioremap() it into the kernel space inside a
> device driver.  So far I've succeeded with 64 MB, but can't go any
> higher, as mm/vmalloc.c tells me: "allocation failed: out of vmalloc
> space - use vmalloc=<size> to increase size."
> 
> So I tried adding a vmalloc line to the kernel command line as follows:
> Kernel cmd line: root=/dev/nfs rw mem=1920M vmalloc=1024M nfsroot=... 
 
Yeah, that suggestion is bogus. That option can't help with getting
more vmalloc space in this case.

> So the vmalloc=<size> argument has made no difference.  What do I need
> to do to make this work?

Go to the "Advanced setup" menu. There's a number of options to provide
fine-grained control of the PPC kernel virtual address space. The key
here is that you have lots of RAM. By default 768MB will be mapped into
kernel lowmem space.  This is mapped from 0xc0000000-0xefffffff. You
probably have highmem on (I hope), so there is a highmem pool at
0xfe000000.  Your vmalloc space should start at 0xf1000000 (16 MB offset
past end of lowmem). Any io_block_map() calls will further constrain your
vmalloc space below the highmem pool. I imagine you have stuff 
permanently mapped that way down through about 0xf6000000 which would
leave just about around 64MB+ for vmalloc space.

The quick test is to modify the "Set maximum low memory" option to
0x20000000 (512MB). This should immediately give you and additional
256MB of vmalloc space as the vmalloc range will now start at
0xe1000000. If that works to allow a 128MB ioremap and you still need
much bigger ioremaps, you can also set "virtual address of kernel base"
down to 0xa0000000 or 0x80000000.

That said, why don't you just use alloc_bootmem() to reserve memory
for your driver at boot time? Then there's no need to bother with
ioremap for your driver then. Just save the pointer to your reserved
area somewhere and then use the space in your driver.  A lot of people
use this approach for unusual cases like this. If you need something
dynamic (i.e. with cmdline control) alloc, then bigphysarea is basically
a wrapper around bootmem allocation.

-Matt
