Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6961968A10
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 04:51:52 +1100 (EST)
Message-ID: <43E0F5A8.4000604@ovro.caltech.edu>
Date: Wed, 01 Feb 2006 09:53:44 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
References: <35786B99AB3FDC45A8215724617919736D9217@gbrwgceumf01.eu.xerox.net>
	<43E0E9A7.4040508@ovro.caltech.edu> <20060201104405.C16064@cox.net>
In-Reply-To: <20060201104405.C16064@cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org, "Jenkins, Clive" <Clive.Jenkins@xerox.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> The book implicitly focuses on x86 driver developers, that's
> why you don't get an explicit statement about this...
> "everything" is PCI in that world.
> 
> read*/write* and ioread*/iowrite* generate outbound little
> endian cycles on ALL arches, period.  They are intended
> only for PCI use and have generic names only because of
> the assumption that "all the world is a PC".
> 
> Now, what it takes to to generate outbound little endian cycles
> varies. On some arches, it's just a store (native LE) on
> other arches, it's a reversed store (PPC), others still configure
> their PCI bridge hardware to do byte swapping in hardware (typically
> if their arch doesn't have a simple byte-swapping store like PPC).
> 
> The example you cite on pg. 453 of Rubini looks broken for BE
> systems. It works on LE systems since cpu_to_le32() does nothing
> and writel is a simply dereference. That's pure luck. On PPC,
> for example, that would write a big endian bus_addr to the fictitious
> PCI device which is not what they want.

Great! An authoritive answer!

Re: endianness, even cooler on the 440EP, in your mmap()
implementation you can set the _PAGE_ENDIAN flag, and
user-space will see the PCI device in little endian
format. Fun stuff!

Thanks Matt.

Dave
