Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 00EE668A5A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 05:29:16 +1100 (EST)
Message-ID: <43D7C2EF.5060508@ovro.caltech.edu>
Date: Wed, 25 Jan 2006 10:26:55 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to read
	little-endian?
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu> <200601251057.47619.sr@denx.de>
In-Reply-To: <200601251057.47619.sr@denx.de>
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

Hi Stefan,

>>readl() and ioread32() read the registers in little-endian format!
> 
> Correct. That's how it is implemented on all platforms. Think for example of 
> an pci device driver. Using these IO functions, the driver will become 
> platform independent, running without modifications on little- and big-endian 
> machines.

Ok, I figured that was probably the case. Thanks for the confirmation.

>>Should I just be using pointers for remapped processor
>>registers, and only use readl(), ioread32(), etc, on external
>>memory?
> 
> That's how I do it. Only use readl() and friends for pci spaces (or other 
> little endian memory mapped areas).

I took a look at the Yosemite network and USB drivers, it looks like
the authors of those drivers chose to use in_be32() and out_be32().

Personally I like the concept of using pointers, or more usefully
pointers to structure overlays for device control. However, the
impression I have is that this is inherently more non-portable
than using the readl()/writel(), ioread32()/iowrite32(), and
now I guess I can add in_be32()/out_be32() to that list.

But if you use pointers, thats good enough for me!

Cheers
Dave
