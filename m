Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FB3FDE5F4
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:13:46 +1000 (EST)
Message-ID: <484810A3.5070301@freescale.com>
Date: Thu, 05 Jun 2008 11:13:23 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>	
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>	
	<20080604211942.2bddc860@zod.rchland.ibm.com>	
	<4848028B.5060105@freescale.com>	
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>	
	<48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
In-Reply-To: <fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> That is still Linux internal artifacts leaking out.  Don't encode that
> data into the device tree.

The I2C bus number is *not* an internal artifact.  On Freescale parts, the one
I2C adapter is specifically designated I2C1, and the 2nd one is specifically
designated I2C2.  This is part of the silicon, and so the device tree should
specify it.

> Besides, the whole thing looks bass ackwards and doesn't match the
> Linux driver model.  'busses' should register 'devices'.  'drivers'
> should then bind to those 'devices'.  Where ASoC is concerned, the i2c
> bus should register its own child devices, which includes the codecs,
> and an ASoC codec driver should bind against it.  The fabric driver
> should then use the codec's exported API.

Sorry, I don't really understand that.  The codec driver is just an I2C driver
that registers callbacks with ASoC.  The fabric driver does not know what codec
driver is present.  In many cases, there could be multiple codecs.  Sometimes
they're the same type of codec, just at different I2C addresses.  Sometimes,
they're completely different codecs.  So I could have any number of codec
drivers loaded.  How would I know which exported API to call?

-- 
Timur Tabi
Linux kernel developer at Freescale
