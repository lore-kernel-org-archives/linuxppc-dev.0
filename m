Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6C40A68A3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 05:18:44 +1100 (EST)
Message-ID: <43E0FBFA.10103@ovro.caltech.edu>
Date: Wed, 01 Feb 2006 10:20:42 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
References: <35786B99AB3FDC45A8215724617919736D9217@gbrwgceumf01.eu.xerox.net>
	<43E0E9A7.4040508@ovro.caltech.edu> <20060201104405.C16064@cox.net>
	<43E0F81F.4050005@ovro.caltech.edu>
	<20060201181106.GA24138@gate.ebshome.net>
In-Reply-To: <20060201181106.GA24138@gate.ebshome.net>
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

Eugene Surovegin wrote:
> On Wed, Feb 01, 2006 at 10:04:15AM -0800, David Hawkins wrote:
> 
>>Matt,
>>
>>In the same vein as the readl()/writel() question, what
>>are the assumptions regarding memcpy_toio and memcpy_fromio?
>>
>>If the memcpy_to/fromio operations are intended only
>>for access to PCI devices, then they should also inherently
>>perform little-endianness conversion. For the test driver
>>I was working on, I did *not* find this the case, eg.
>>I implemented the test driver read() and write() using the
>>memcpy_to/fromio calls, and the data transfers occur
>>in big-endian (well, 'native' mode, since I also test the
>>same test driver with the PCI adapter in an x86 system).
>>
>>If memcpy_to/fromio can be used in a more general context,
>>then I can see why they operate in native mode.
>>
>>Just looking for enlightenment.
> 
> 
> This commands IIRC are intended for copying chunk of _bytes_. There 
> are no issues with endianess for bytes, e.g. they work just like 
> ordinary memcpy.
> 

True, good point.

I quite often implement a 'control' device to read/write/mmap PCI
device registers. In that case, the registers are usually 32-bit, so
if I wanted endian neutrality, I could either let the user-space
app determine the endianness and act accordingly, or force the
user-space app to always see little-endian registers by replacing
memcpy_to/fromio calls with a loop over read;/writel, and in mmap
making sure to set the _PAGE_ENDIAN flag. Of course, making mmap
endian-neutral depends on the 440EP page flags, which say an
ARM might not have.

Thanks for the valuable feedback guys.

Dave
