Return-Path: <flylist@linuxkernel.net>
Received: from sarang.flyduck.com (c-24-6-74-43.hsd1.ca.comcast.net
	[24.6.74.43]) by ozlabs.org (Postfix) with ESMTP id AA1C967B34
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 04:08:00 +1000 (EST)
Message-ID: <013c01c53c63$8b4e98e0$0d02a8c0@acting>
From: "Ho Lee" <flylist@linuxkernel.net>
To: "Chris Elston" <chris.elston@radstone.co.uk>
References: <F38DEABE0E171746B133C1ABBD142D9703691AFD@radmail.Radstone.Local>
Date: Fri, 8 Apr 2005 10:51:05 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MTD Mapping driver - out of vmalloc space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Chris,

How about setting PAGE_OFFSET to 0x80000000, that is 2G/2G split?
It would make enough virtual address space. I've never tried on PPC,
so I don't know the side effect of this. 

-- Ho

----- Original Message ----- 
From: "Chris Elston" <chris.elston@radstone.co.uk>
To: <linuxppc-embedded@ozlabs.org>
Sent: Friday, April 08, 2005 7:42 AM
Subject: MTD Mapping driver - out of vmalloc space


Dear all,

I'm writing an MTD mapping driver for a board with (up to) 512M SDRAM, and
(up to) 256M Flash and I've hit a bit of a problem.  The standard way to write
a mapping driver seems to be to map the whole of the Flash into kernel virtual
memory space.  While this is not a problem for small Flash devices, I'm hitting
the limit of the vmalloc space.  

So I decided to modify my mapping driver to work through a smaller virtual 
addressing window.

Basically, all reads/writes are redirected through my custom functions which
first ensure that the correct physical address range is mapped into virtual
space and then drop through to the standard read/write functions.  The mapping
is achieved using ioremap/iounmap calls.  (code attached)

David Woodhouse pointed out that this approach is not viable because the reads
and writes must be atomic - and ioremap can potentially sleep.  So I'm stuck as
to how to proceed.

Ideally what I'd like is to be able to allocate a block of virtual addresses at 
init time and then dynamically modify the physical address range that it refers to.
Since I wouldn't be requesting any more vmalloc space - just changing the mapping 
for the space I have got - I'd hopefully be able to make this a non-blocking
operation.  Unfortunately I have no idea how to go about this - or even if it's
possible :)

Thanks in advance,

Chris.

________________________________________________________________________
This e-mail has been scanned for all viruses by Star. The
service is powered by MessageLabs. For more information on a proactive
anti-virus service working around the clock, around the globe, visit:
http://www.star.net.uk
________________________________________________________________________


--------------------------------------------------------------------------------


> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
