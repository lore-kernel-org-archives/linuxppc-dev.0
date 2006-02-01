Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7B7A268A2D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 05:02:21 +1100 (EST)
Message-ID: <43E0F81F.4050005@ovro.caltech.edu>
Date: Wed, 01 Feb 2006 10:04:15 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
References: <35786B99AB3FDC45A8215724617919736D9217@gbrwgceumf01.eu.xerox.net>
	<43E0E9A7.4040508@ovro.caltech.edu> <20060201104405.C16064@cox.net>
In-Reply-To: <20060201104405.C16064@cox.net>
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

Matt,

In the same vein as the readl()/writel() question, what
are the assumptions regarding memcpy_toio and memcpy_fromio?

If the memcpy_to/fromio operations are intended only
for access to PCI devices, then they should also inherently
perform little-endianness conversion. For the test driver
I was working on, I did *not* find this the case, eg.
I implemented the test driver read() and write() using the
memcpy_to/fromio calls, and the data transfers occur
in big-endian (well, 'native' mode, since I also test the
same test driver with the PCI adapter in an x86 system).

If memcpy_to/fromio can be used in a more general context,
then I can see why they operate in native mode.

Just looking for enlightenment.

Cheers
Dave
