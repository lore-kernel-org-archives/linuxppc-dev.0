Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-234-thursday.dmz.nerim.net
	[195.5.254.234]) by ozlabs.org (Postfix) with ESMTP id 8BD9A67B4D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 05:29:38 +1000 (EST)
Received: from mallaury.noc.nerim.net (smtp-104-thursday.noc.nerim.net
	[62.4.17.104])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 6A0ADDB9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 21:29:28 +0200 (CEST)
Date: Thu, 9 Jun 2005 21:29:33 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-Id: <20050609212933.2fa44d62.khali@linux-fr.org>
In-Reply-To: <42A89338.209@mvista.com>
References: <42A0CD46.60300@mvista.com>
	<20050603214653.GA15314@gate.ebshome.net>
	<42A0D714.1050601@mvista.com>
	<20050609192551.76b103ea.khali@linux-fr.org>
	<42A89338.209@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LM@ozlabs.org, linuxppc-embedded@ozlabs.org,
	Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] Re: [PATCH 1/2] Add support for Maxim/Dallas
 DS1374 Real-Time Clock Chip
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mark,

> I interpreted the doc the same way Randy did when I did the m41t00
> chip  code.  Also, Mark Studebaker seemed to support that
> interpretation in  this email:
> http://archives.andrew.net.au/lm-sensors/msg29325.html

I am not discussing the fast that using basic SMBus commands increases
the number of system the driver will be usable on. This is quite
obviously true, and I am fine with using this when there is no
performance drawback.

However, in the case of the DS1374, reading the registers as a block
would make the driver *much* faster and more simple. This has to be
considered, especially if the DS1374 chip is found on a limited number
of systems.

If you think the documentation should be updated to reflect that better,
well, patches are welcome ;)

> I suppose the best thing to do is check if the adapter is a true i2c 
> ctlr (something like: i2c_check_functionality(adapter, I2C_FUNC_I2C)) 
> and base the cmds used on that.
> 
> We can do something similar with I2C_FUNC_SMBUS_READ_I2C_BLOCK & 
> I2C_FUNC_SMBUS_WRITE_BLOCK_DATA to check if we can use the smbus
> block cmds too, correct?

There is actually no benefit in checking for true I2C, since the
commands you would then build would be exactly I2C_FUNC_SMBUS_READ_I2C
and I2C_FUNC_SMBUS_WRITE_BLOCK_DATA. Better check for these directly, as
some non-I2C masters will support them (especially the second, the first
one is only rarely found). If both functions are supported, go with
this. If not, either fallback to the current code, or drop this code and
state that this isn't supported (I'd do that). If it happens that this
support is ever needed, it can be added back at that time - but that
time may never actually come.

Thanks,
-- 
Jean Delvare
