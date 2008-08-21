Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6BA1DE7A2
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 02:33:17 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7LGX7kc012277
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 09:33:07 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m7LGWugn020776
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 11:32:56 -0500 (CDT)
Date: Thu, 21 Aug 2008 11:32:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-ID: <20080821163256.GC15669@ld0162-tx32.am.freescale.net>
References: <20080821.001012.265401427.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080821.001012.265401427.davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
> Mostly straightforward stuff _except_ for the I2C address encoding.
> 
> What I2C IEEE1275 device binding was used to write that code in
> of_i2c.c?  Is it some PowerPC specific thing?  Was it "invented"
> by the embedded folks (I hope not)?

Yes, it was "invented".  There was no documented i2c OF binding that I
could find, and AFAIR nobody came forward with examples of existing
practice at the time.

> And, furthermore, the device address is shifted up 1 bit higher
> than the Linux I2C layer expects.  It includes the low direction
> bit, bit 0, so we have to shift it down by 1 bit before we give
> it to the Linux I2C layer.

Yuck.

> 2) When CONFIG_SPARC, shift the device address down by one bit before
>    giving it to the Linux I2C layer.

Maybe we should distinguish by the type of I2C bus node instead.

-Scott
