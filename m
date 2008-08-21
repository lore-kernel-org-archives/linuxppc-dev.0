Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8E424761C
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:01:49 +1000 (EST)
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080821163256.GC15669@ld0162-tx32.am.freescale.net>
References: <20080821.001012.265401427.davem@davemloft.net>
	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Fri, 22 Aug 2008 08:01:37 +1000
Message-Id: <1219356097.21386.143.camel@pasglop>
Mime-Version: 1.0
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-21 at 11:32 -0500, Scott Wood wrote:
> On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
> > Mostly straightforward stuff _except_ for the I2C address encoding.
> > 
> > What I2C IEEE1275 device binding was used to write that code in
> > of_i2c.c?  Is it some PowerPC specific thing?  Was it "invented"
> > by the embedded folks (I hope not)?
> 
> Yes, it was "invented".  There was no documented i2c OF binding that I
> could find, and AFAIR nobody came forward with examples of existing
> practice at the time.

Well, there were examples in the powermac code :-)

> > And, furthermore, the device address is shifted up 1 bit higher
> > than the Linux I2C layer expects.  It includes the low direction
> > bit, bit 0, so we have to shift it down by 1 bit before we give
> > it to the Linux I2C layer.
> 
> Yuck.

Apple does the same. IE. I take the address from "reg" and shift it
right by one bit before passing it to linux.

> > 2) When CONFIG_SPARC, shift the device address down by one bit before
> >    giving it to the Linux I2C layer.
> 
> Maybe we should distinguish by the type of I2C bus node instead.

Or fix the embedded stuff :-)

Ben.
