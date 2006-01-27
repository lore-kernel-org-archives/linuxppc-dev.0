Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0F8D867EC8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jan 2006 10:31:41 +1100 (EST)
Message-ID: <43DAACCA.10603@ovro.caltech.edu>
Date: Fri, 27 Jan 2006 15:29:14 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to read
	little-endian?
References: <43CC3E37.4040707@softadvances.com>
	<20060125185131.GA7425@gate.ebshome.net>
	<43D7D334.3070709@ovro.caltech.edu> <200601261120.48251.sr@denx.de>
In-Reply-To: <200601261120.48251.sr@denx.de>
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


Hey Stefan,

 >>readl() and ioread32() read the registers in little-endian format!
 >
 > Correct. That's how it is implemented on all platforms. Think for
 > example of an pci device driver. Using these IO functions, the
 > driver will become platform independent, running without
 > modifications on little- and big-endian machines.

I just stumbled across the section in Rubini 3rd Ed that mislead
me into believing that the readl()/writel() were machine endianness
dependent, i.e., LE on x86, BE on PPC.

p453 of his book has a PCI DMA example, where he uses the
cpu_to_le32() macros inside calls writel().

However, since these functions are internally implemented to
perform LE operations, this example appears to be incorrect.

Would you agree?

I just checked the Oreilly web site for errata's and this is not
listed. If you agree that the example is incorrect, then I'll
submit an errata.

Dave
