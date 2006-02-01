Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C152468A02
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 04:00:37 +1100 (EST)
Message-ID: <43E0E9A7.4040508@ovro.caltech.edu>
Date: Wed, 01 Feb 2006 09:02:31 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
References: <35786B99AB3FDC45A8215724617919736D9217@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <35786B99AB3FDC45A8215724617919736D9217@gbrwgceumf01.eu.xerox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Jenkins, Clive wrote:
>>>>readl() and ioread32() read the registers in little-endian format!
>>>
>>>Correct. That's how it is implemented on all platforms. Think for
>>>example of an pci device driver. Using these IO functions, the
>>>driver will become platform independent, running without
>>>modifications on little- and big-endian machines.
>>
>>I just stumbled across the section in Rubini 3rd Ed that mislead
>>me into believing that the readl()/writel() were machine endianness
>>dependent, i.e., LE on x86, BE on PPC.
> 
> 
>>p453 of his book has a PCI DMA example, where he uses the
>>cpu_to_le32() macros inside calls writel().
> 
> 
>>However, since these functions are internally implemented to
>>perform LE operations, this example appears to be incorrect.
> 
> 
>>Would you agree?
> 
> 
> No, I think it is correct.
> 
> On most architectures readl() and writel() assume you are
> accessing MMIO on the PCI bus, which is little-endian.
> So these macros convert between the endian-ness of the CPU
> and the endian-ness of the PCI bus.
> 
> Clive

Hey Clive,

Right, but in the 440EP source, and probably on other PowerPC
ports, readl() and writel() perform the endian conversion for
you, so if you wrote an operation as

   writel(register_address, cpu_to_le32(data));

you would get *two* little endian conversions, i.e., you
would write the bytes in the wrong order.

I haven't looked in the source for other big-endian architecures
yet. I wonder if the ARM stuff is big, or little endian?

The original question came about while I was trying to read
back PLX-9054 registers (a PCI-to-local bus bridge on a PCI
adapter board).

I search through the other drivers for the 440EP peripherals
that are not on the PCI bus showed that the authors used
the in_be32() and out_be32() calls. The comment at the top
of this email indicates that the readl() and writel() are
effectively 'reserved' for PCI accesses. I didn't get this
impression from reading Rubini.

Thanks for you comments. Feel free to add more comments!

Cheers
Dave
