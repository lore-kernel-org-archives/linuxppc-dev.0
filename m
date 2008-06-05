Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0AB74DEBD1
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:09:30 +1000 (EST)
Message-ID: <48480FAC.3020406@freescale.com>
Date: Thu, 05 Jun 2008 11:09:16 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>	
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>	
	<20080604211942.2bddc860@zod.rchland.ibm.com>	
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<935d90b908261c8e5862caeeb1f396aa@kernel.crashing.org>
In-Reply-To: <935d90b908261c8e5862caeeb1f396aa@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Stefan Roese <sr@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> Sounds to me like both simply need to use adapter->nr. 

How can a non-I2C driver get the adapter structure for another driver that is an
I2C driver?

> For access to
> Linux-internal data structures (and that is what this "index" is), you
> shouldn't have to go via the device tree.  If the Linux data structures
> do not have the information you need, well, fix that.

The fabric driver doesn't have access to any I2C structures when it starts
looking for the codec driver.  The fabric driver is like an OF platform driver,
in that it's OF-aware and machine-specific.  By parsing the device tree (which
is the only tool I have to know how the board is laid out), the fabric driver
can determine that SSI1 is attached to a CS4270 on I2C bus #1, address 0x4F.
That's the only information it has.

The CS4270 driver, on the other hand, knows nothing about OF.  It just knows
whatever is passed to its I2C probe function, i.e. the i2c_adapter and
i2c_client structures.

So in order for the two drivers to be able to link to each other, there needs to
be some code that takes data from the device tree and places it into the I2C
data structures.

-- 
Timur Tabi
Linux kernel developer at Freescale
