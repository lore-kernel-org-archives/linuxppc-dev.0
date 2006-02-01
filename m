Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler1.mail.xerox.com (wvmler1.mail.xerox.com [13.8.138.216])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "wvmler1.mail.xerox.com",
	Issuer "wvmler1.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3D9E7689F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 22:28:16 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Date: Wed, 1 Feb 2006 11:19:21 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D9217@gbrwgceumf01.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>, "Stefan Roese" <sr@denx.de>
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

> >>readl() and ioread32() read the registers in little-endian format!
> >
> > Correct. That's how it is implemented on all platforms. Think for
> > example of an pci device driver. Using these IO functions, the
> > driver will become platform independent, running without
> > modifications on little- and big-endian machines.
>
> I just stumbled across the section in Rubini 3rd Ed that mislead
> me into believing that the readl()/writel() were machine endianness
> dependent, i.e., LE on x86, BE on PPC.

> p453 of his book has a PCI DMA example, where he uses the
> cpu_to_le32() macros inside calls writel().

> However, since these functions are internally implemented to
> perform LE operations, this example appears to be incorrect.

> Would you agree?

No, I think it is correct.

On most architectures readl() and writel() assume you are
accessing MMIO on the PCI bus, which is little-endian.
So these macros convert between the endian-ness of the CPU
and the endian-ness of the PCI bus.

Clive
