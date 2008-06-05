Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AFECDE853
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:52:32 +1000 (EST)
In-Reply-To: <48480987.1070701@freescale.com>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>	
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>	
	<20080604211942.2bddc860@zod.rchland.ibm.com>	
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <935d90b908261c8e5862caeeb1f396aa@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Date: Thu, 5 Jun 2008 17:52:16 +0200
To: Timur Tabi <timur@freescale.com>
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

>> if you need explicit indexing then use an alias.  My opinion however
>> is that explicit indexing is unnecessary and is just an artifact of
>> current i2c subsystem internals.  There is already enough information
>> in the device tree to match i2c devices with i2c busses without
>> resorting to indexes.
>
> Not for ALSA SoC V2 devices.  In ASoC V2, the "fabric" driver needs to 
> identify
> the codec by its specific I2C bus and address number.  The codec 
> driver is not
> an OF driver (normally), so it doesn't have access to any OF data.  
> It's just an
> I2C driver, so its given an I2C address and some number that 
> represents an adapter.
>
> Therefore, the fabric driver and the codec driver need to independently
> determine the I2C bus number, and they need to match.  The fabric 
> driver parses
> the OF tree and looks up the cell-index property.  The codec driver 
> uses the
> adapter->nr variable.  The patch I posted ensures that the two contain 
> the same
> number.

Sounds to me like both simply need to use adapter->nr.  For access to
Linux-internal data structures (and that is what this "index" is), you
shouldn't have to go via the device tree.  If the Linux data structures
do not have the information you need, well, fix that.


Segher
