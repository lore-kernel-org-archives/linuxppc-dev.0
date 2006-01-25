Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 90D8A68A6A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 05:51:35 +1100 (EST)
Date: Wed, 25 Jan 2006 10:51:31 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to read
	little-endian?
Message-ID: <20060125185131.GA7425@gate.ebshome.net>
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu> <200601251057.47619.sr@denx.de>
	<43D7C2EF.5060508@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43D7C2EF.5060508@ovro.caltech.edu>
Cc: Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2006 at 10:26:55AM -0800, David Hawkins wrote:
> Hi Stefan,
> 
> >>readl() and ioread32() read the registers in little-endian format!
> > 
> > Correct. That's how it is implemented on all platforms. Think for example of 
> > an pci device driver. Using these IO functions, the driver will become 
> > platform independent, running without modifications on little- and big-endian 
> > machines.
> 
> Ok, I figured that was probably the case. Thanks for the confirmation.
> 
> >>Should I just be using pointers for remapped processor
> >>registers, and only use readl(), ioread32(), etc, on external
> >>memory?
> > 
> > That's how I do it. Only use readl() and friends for pci spaces (or other 
> > little endian memory mapped areas).
> 
> I took a look at the Yosemite network and USB drivers, it looks like
> the authors of those drivers chose to use in_be32() and out_be32().
> 
> Personally I like the concept of using pointers, or more usefully
> pointers to structure overlays for device control. However, the
> impression I have is that this is inherently more non-portable
> than using the readl()/writel(), ioread32()/iowrite32(), and
> now I guess I can add in_be32()/out_be32() to that list.
> 
> But if you use pointers, thats good enough for me!

use in_/out_ accessors, not pointers. Look at other 4xx drivers (i2c, 
emac)

Also, you don't have worry about this code being non-portable, because 
every chip has it's own GPIO impl anyway.

-- 
Eugene
