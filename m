Return-Path: <michael.firth@bt.com>
Received: from smtp4.smtp.bt.com (smtp4.smtp.bt.com [217.32.164.151])
	by ozlabs.org (Postfix) with ESMTP id 2FE07DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Dec 2007 20:50:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Maximum ioremap size for ppc arch?
Date: Wed, 5 Dec 2007 09:50:16 -0000
Message-ID: <36D7B34A3A79F84F82FA0C154F299F2506080F6F@E03MVX1-UKDY.domain1.systemhost.net>
In-Reply-To: <20071203153009.GA30746@gate.crashing.org>
From: <michael.firth@bt.com>
To: <mporter@kernel.crashing.org>
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

> -----Original Message-----
> From: Matt Porter [mailto:mporter@kernel.crashing.org]=20
> Sent: 03 December 2007 15:30
> To: Firth,MJC,Michael,DMM R
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Maximum ioremap size for ppc arch?
>=20
> On Mon, Dec 03, 2007 at 09:22:06AM -0000, michael.firth@bt.com wrote:
> > I'm trying to get am MPC834x system running that has=20
> 256MBytes of NOR=20
> > flash connected.
> >=20
> > The physmap flash driver is failing to ioremap() that=20
> amount of space,=20
> > while on a similar system with 128Mbytes of flash, there are no=20
> > problems.
> >=20
> > Is this a known limitation of ioremap() on the ppc architecture, or=20
> > specifically the MPC834x family, and is there any=20
> (hopefully easy) way=20
> > to increase this limit?
>=20
> The answer is "it depends". It depends on the amount of=20
> system memory you have. By default, your system memory is=20
> mapped at 0xc0000000, leaving not enough space for vmalloc=20
> allocations to grab 256MB for the ioremap (and avoid the=20
> fixed virtual mapping in the high virtual address area).
>=20
> See the "Advanced setup" menu. Normally, you can set "Set=20
> custom kernel base address" to 0xa0000000 safely. That will=20
> give you an additional 256MB of vmalloc space. On=20
> arch/powerpc, you'll also have to set "Size of user task=20
> space" to 0x80000000 or 0xa0000000.
>=20
> -Matt
>=20

I've solved my problem for now, but I'm not sure I'm that happy that
it's a scalable solution.

I tried moving the kernel base address to 0x80000000, but the system
became very unstable - in particular, though it detected the flash
partitions, as soon as I tried to write to them the system spontaneously
rebooted - not even a kernel panic, just a straight reboot.

As I'm using arch/ppc, it seems that the default user task space is
0x80000000 which shouldn't have conflicted with this.

It seemed that the bottom of the vmalloc space is defined as 'start of
kernel + amount of physical RAM', which in the case of our board becomes
'0xc0000000 + 0x10000000', as there is 256MB of RAM present. The top of
vmalloc space was being limited by the CPU registers, mapped by IMMRBAR.
This was configured to 0xe0000000, which left only 256MB of vmalloc
space.

I've got things working by moving IMMRBAR up to 0xeff00000, which gives
nearly 256MB more vmalloc space.

My main queries are:
1) Why did changing the kernel base address to 0x80000000 make the
system unstable? Would 0xa0000000 as suggested not have caused this
problem?
2) Currently IMMRBAR has the same physical and virtual address. Does
this need to be the case? If this is a restriction, it seems to mean
that the top 256MB of the virtual address space becomes unusable.
3) Why the kernel is designed to run at 0xc0000000? This seems to leave
only 1GB of addressing space for all the physically addressable memory
(RAM + ioremapped + registers), while reserving 3GB of space for user
processes. The 3GB is presumably mostly unusable on a system without a
large amount of swap, as the 1GB limit on memory will prevent much more
than that being available for user space.

Thanks for the assistance so far, the pointer to the definition of
VMALLOC_START and VMALLOC_END gave me the hook in I needed to work out
where the limitation was coming from. I would suggest that its also
worth changing at the error message that's generated when the vmalloc
space is exhausted:

"allocation failed: out of vmalloc space - use vmalloc=3D<size> to
increase size."

>From my understanding of the code so far, it seems that the 'vmalloc'
command line option is only available on the x86 architecture.

What is the process for getting a concensus on this, and getting the
message changed?

Thanks again

Michael
