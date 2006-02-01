Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C813368A02
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 05:11:09 +1100 (EST)
Date: Wed, 1 Feb 2006 10:11:06 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Message-ID: <20060201181106.GA24138@gate.ebshome.net>
References: <35786B99AB3FDC45A8215724617919736D9217@gbrwgceumf01.eu.xerox.net>
	<43E0E9A7.4040508@ovro.caltech.edu> <20060201104405.C16064@cox.net>
	<43E0F81F.4050005@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43E0F81F.4050005@ovro.caltech.edu>
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

On Wed, Feb 01, 2006 at 10:04:15AM -0800, David Hawkins wrote:
> Matt,
> 
> In the same vein as the readl()/writel() question, what
> are the assumptions regarding memcpy_toio and memcpy_fromio?
> 
> If the memcpy_to/fromio operations are intended only
> for access to PCI devices, then they should also inherently
> perform little-endianness conversion. For the test driver
> I was working on, I did *not* find this the case, eg.
> I implemented the test driver read() and write() using the
> memcpy_to/fromio calls, and the data transfers occur
> in big-endian (well, 'native' mode, since I also test the
> same test driver with the PCI adapter in an x86 system).
> 
> If memcpy_to/fromio can be used in a more general context,
> then I can see why they operate in native mode.
> 
> Just looking for enlightenment.

This commands IIRC are intended for copying chunk of _bytes_. There 
are no issues with endianess for bytes, e.g. they work just like 
ordinary memcpy.

-- 
Eugene
