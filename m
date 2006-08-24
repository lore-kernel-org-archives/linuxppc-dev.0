Return-Path: <vows_siu@yahoo.com.hk>
Received: from wmail05dat.netvigator.com (wmail05.netvigator.com
	[218.102.48.220]) by ozlabs.org (Postfix) with ESMTP id 5CC0D67C29
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 12:51:25 +1000 (EST)
From: "alva" <vows_siu@yahoo.com.hk>
To: <Phil.Nitschke@avalon.com.au>, "'Matt Porter'" <mporter@embeddedalley.com>
Subject: RE: ioremap() fails for >64 MB
Date: Thu, 24 Aug 2006 10:54:23 +0800
Message-ID: <000001c6c728$9aeeac30$8500a8c0@dc.roysiu.servebbs.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1250"
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

I think 64MB limitation of ioremap() is due to the kernel's page size.
When compiling kernel, it has an option to choose the memory page size
which is default 64MB. To use memory greater than 64MB, there is two
methods. One is to make the kernel's page size larger as Phil Nitschke
said. Another is to modify ioremap() a little bit --- just make it use
another file for "mmap" while larger than 64MB. Since the central
concept of linux is file-based, I think more files are not harmful that
only waste a little bit inode structure. And it is much more feasible
that one can choose to use file in memory or harddisk or mounted device
harddisk/memory ... ...

-----Original Message-----
From: linuxppc-embedded-bounces+vows_siu=yahoo.com.hk@ozlabs.org
[mailto:linuxppc-embedded-bounces+vows_siu=yahoo.com.hk@ozlabs.org] On
Behalf Of Phil Nitschke
Sent: Wednesday, August 23, 2006 6:01 PM
To: Matt Porter
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ioremap() fails for >64 MB

On Tue, 2006-08-22 at 09:22 -0500, Matt Porter wrote:
> On Tue, Aug 22, 2006 at 05:11:09PM +0930, Phil Nitschke wrote:
> > Hi all,
> > 
> > I have 2 GB memory on a 7448 processor, and want to reserve a huge
chunk
> > of it at boot-time, then ioremap() it into the kernel space inside a
> > device driver.  So far I've succeeded with 64 MB, but can't go any
> > higher, as mm/vmalloc.c tells me: "allocation failed: out of vmalloc
> > space - use vmalloc=<size> to increase size."
> > 
> > So I tried adding a vmalloc line to the kernel command line as
follows:
> > Kernel cmd line: root=/dev/nfs rw mem=1920M vmalloc=1024M
nfsroot=... 
>  
> Yeah, that suggestion is bogus. That option can't help with getting
> more vmalloc space in this case.
> 
> > So the vmalloc=<size> argument has made no difference.  What do I
need
> > to do to make this work?
> 
> Go to the "Advanced setup" menu. There's a number of options to
provide
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

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 
No virus found in this incoming message.
Checked by AVG Free Edition.
Version: 7.1.405 / Virus Database: 268.11.5/425 - Release Date:
2006/8/22
 

-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.405 / Virus Database: 268.11.5/426 - Release Date:
2006/8/23
 
