Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 367B3DE220
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:00:06 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so140340anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 09:00:05 -0700 (PDT)
Message-ID: <fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
Date: Thu, 5 Jun 2008 10:00:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <48480987.1070701@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
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

On Thu, Jun 5, 2008 at 9:43 AM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
>> if you need explicit indexing then use an alias.  My opinion however
>> is that explicit indexing is unnecessary and is just an artifact of
>> current i2c subsystem internals.  There is already enough information
>> in the device tree to match i2c devices with i2c busses without
>> resorting to indexes.
>
> Not for ALSA SoC V2 devices.  In ASoC V2, the "fabric" driver needs to identify
> the codec by its specific I2C bus and address number.  The codec driver is not
> an OF driver (normally), so it doesn't have access to any OF data.  It's just an
> I2C driver, so its given an I2C address and some number that represents an adapter.
>
> Therefore, the fabric driver and the codec driver need to independently
> determine the I2C bus number, and they need to match.  The fabric driver parses
> the OF tree and looks up the cell-index property.  The codec driver uses the
> adapter->nr variable.  The patch I posted ensures that the two contain the same
> number.

That is still Linux internal artifacts leaking out.  Don't encode that
data into the device tree.

Besides, the whole thing looks bass ackwards and doesn't match the
Linux driver model.  'busses' should register 'devices'.  'drivers'
should then bind to those 'devices'.  Where ASoC is concerned, the i2c
bus should register its own child devices, which includes the codecs,
and an ASoC codec driver should bind against it.  The fabric driver
should then use the codec's exported API.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
