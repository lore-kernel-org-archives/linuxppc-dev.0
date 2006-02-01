Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "wvmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7B553689FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 05:36:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Date: Wed, 1 Feb 2006 18:35:05 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D921B@gbrwgceumf01.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>
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

>>>p453 of his book has a PCI DMA example, where he uses the
>>>cpu_to_le32() macros inside calls writel().

>>>However, since these functions are internally implemented to
>>>perform LE operations, this example appears to be incorrect.

>>>Would you agree?
=20
>> No, I think it is correct.

I said this without looking up the example you cited.
I agree now, the example is incorrect; and yes, file a bug
report at oreilly!

I think, from memory, that elsewhere in the book Rubini does
say that readl()... are for the PCI bus, but cross-arch issues
are only addressed in certain sections.

I always find out exactly what these macros do on the arch
I am using, then I know where I stand. I find LXR (Google it if
you don't know it) good for browsing the source of vanilla
kernels. After finding out how and where it is done, I then
double check the relevant files of the actual kernel I am using.

ppc implementations of readl, writel, cpu_to_le32 use the byte-
reversed load/store word instructions.

Clive
