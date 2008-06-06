Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6C5EDDF96
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:20:54 +1000 (EST)
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <48480987.1070701@freescale.com>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 14:20:40 +1000
Message-Id: <1212726040.12464.21.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Stefan Roese <sr@denx.de>,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-06-05 at 10:43 -0500, Timur Tabi wrote:
> Grant Likely wrote:
> 
> > if you need explicit indexing then use an alias.  My opinion however
> > is that explicit indexing is unnecessary and is just an artifact of
> > current i2c subsystem internals.  There is already enough information
> > in the device tree to match i2c devices with i2c busses without
> > resorting to indexes.
> 
> Not for ALSA SoC V2 devices.  In ASoC V2, the "fabric" driver needs to identify
> the codec by its specific I2C bus and address number.  The codec driver is not
> an OF driver (normally), so it doesn't have access to any OF data.  It's just an
> I2C driver, so its given an I2C address and some number that represents an adapter.

Any struct device can have an OF node. We need to fix things so they get
filled properly.

> Therefore, the fabric driver and the codec driver need to independently
> determine the I2C bus number, and they need to match.  The fabric driver parses
> the OF tree and looks up the cell-index property.  The codec driver uses the
> adapter->nr variable.  The patch I posted ensures that the two contain the same
> number.

No, the fabric driver should get to its device node in a way or another,
and from there, find a pointer (via a phandle) to it's codec, and match
that to an i2c device.

If the current infrastructure doesn't allow that kind of matching, it
needs to be fixed.

Ben.
