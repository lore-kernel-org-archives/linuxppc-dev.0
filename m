Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id B947C2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Oct 2004 08:30:01 +1000 (EST)
Date: Thu, 28 Oct 2004 15:29:53 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Yoav Steinberg <YoavS@Go-WLAN.com>
Message-ID: <20041028152953.A2122@home.com>
References: <699F7BBB368A10479166148511F524174C2310@gn-ex01.Go80211.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <699F7BBB368A10479166148511F524174C2310@gn-ex01.Go80211.com>;
	from YoavS@Go-WLAN.com on Thu, Oct 28, 2004 at 10:53:38PM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ioremap questions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[Please fix your mailer, line length is way too big]

On Thu, Oct 28, 2004 at 10:53:38PM +0200, Yoav Steinberg wrote:
> Hello,
> i'm trying to map a physical address on the 440GP's external bus to a virtual address so I can access it from kernel space. While looking at the ebony.c file under the drivers/mtd/maps I saw that a function called ioremap64 was used.
> My questions:
> 1) Why use the ioremap64 function which receives a 64bit physical
> address when the CPU is a 32 bit CPU? It seems like this is a
> special function for th 44x series, is this true?

The CPU is 32-bit virtual (well, technically 41-bit but who's counting)
and 36-bit physical. This is a special function for any ppc32 platform
with >32-bit physical address space. It is needed because the kernel
does not yet support resources with >32-bit start/end fields. We
can and do perform fix-ups so ioremap() works for generic PCI drivers
and some other areas, but sometimes the fixup method can fail due
to overlapping address space and the resolution of the resource
fields. In that case, it is necessary to use ioremap64(). In
44x-specific drivers, it's generally a good idea to use ioremap64()
since you aren't hiding the real address behind the fixup code...
increasing readability.

> 2) There seem to be multiple ioremap functions: ioremap/64/_nocache
> etc. which is the most appropriate one? What are the differences?

For what you want to do, a custom driver, use ioremap64(). On ppc32,
ioremap_nocache() and ioremap() do the same thing. I've explained the
difference with ioremap64() above.

> 3) Do I need to call iounmap before remapping somethig previouslly
> mapped with ioremap? 

No. It will create a new mapping. It is, however, good practice to
use iounmap() when you are done using a resource. This frees up
vmalloc space in the kernel.  In many applications, this is
becoming a very limited address space.

-Matt
