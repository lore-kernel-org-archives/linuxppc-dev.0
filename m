Return-Path: <sr@denx.de>
Received: from natsluvver.rzone.de (natsluvver.rzone.de [81.169.145.176])
	by ozlabs.org (Postfix) with ESMTP id B2938689F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 20:58:05 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to read
	little-endian?
Date: Wed, 25 Jan 2006 10:57:47 +0100
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu>
In-Reply-To: <43D66D06.9090904@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601251057.47619.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

On Tuesday 24 January 2006 19:08, David Hawkins wrote:
> readl() and ioread32() read the registers in little-endian format!

Correct. That's how it is implemented on all platforms. Think for example of 
an pci device driver. Using these IO functions, the driver will become 
platform independent, running without modifications on little- and big-endian 
machines.

> If the processor was reading from the PCI bus, then sure, I
> could understand why this might be used, but even then, that
> should be up to the user, eg. by using cpu_to_le32 etc.

No. Please see above.

> Should I just be using pointers for remapped processor
> registers, and only use readl(), ioread32(), etc, on external
> memory?

That's how I do it. Only use readl() and friends for pci spaces (or other 
little endian memory mapped areas).

Best regards,
Stefan
