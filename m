Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-234-thursday.dmz.nerim.net
	[195.5.254.234]) by ozlabs.org (Postfix) with ESMTP id 65A7B67B2B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 03:53:20 +1000 (EST)
Received: from kraid.nerim.net (smtp-104-thursday.nerim.net [62.4.16.104])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id EC08FC9C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 19:25:47 +0200 (CEST)
Date: Thu, 9 Jun 2005 19:25:51 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Randy Vinson <rvinson@mvista.com>
Message-Id: <20050609192551.76b103ea.khali@linux-fr.org>
In-Reply-To: <42A0D714.1050601@mvista.com>
References: <42A0CD46.60300@mvista.com>
	<20050603214653.GA15314@gate.ebshome.net>
	<42A0D714.1050601@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LM, Sensors <lm-sensors@lm-sensors.org>, linuxppc-embedded@ozlabs.org
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

Hi Randy and all,

Sorry for the delay.

[Eugene Surovegin]
> I wonder, why you chose to use those 1-byte SMBus transfers instead
> of  i2c transfer.

[Randy Vinson]
> I was simply following the guidelines in 
> Documentation/i2c/writing-clients as noted in the driver header. This 
> note was in the driver I used as my base, so I just followed along.

The document file says:

"If you can choose between plain i2c communication and SMBus level
communication, please use the last. All adapters understand SMBus level
commands, but only some of them understand plain i2c!"

The "if you can choose" is important. It doesn't suggest that you should
use a less efficient way, but that you use the SMBus API when the I2C
transfer you want to use happens to exist in the SMBus API.

Even when sticking to SMBus commands, it is quite frequent that there
are different ways to retrieve the same information, of varying
availability and speed. One good example of this are EEPROMs. EEPROMs
are I2C devices which can be accessed using SMBus commands. You can read
bytes one by one (SMBus Read Byte Data command), or continuously as
different reads (first one SMBus Write Byte, then many SMBus Read Byte),
or continuously as a single read (I2C Block Read, supported by some
SMBus controllers). If you look at the eeprom.c drivers, you'll see that
the second and the third method are both implemented. The advantage is
that:

1* The SMBus Write/Read Byte method is supported by almost all SMBus and
all I2C masters.

2* The I2C Block Read method is twice as fast, and works on all true I2C
masters and a few SMBus masters.

So we get the best from each hardware configuration.

 As I read the DS1374 datasheet, it appears to support all three modes
(it's a true I2C device) so you should be able to do something similar
to what is done in the eeprom driver.

> I checked http://secure.netroedge.com/~lm78/supported.html, 
> http://secure.netroedge.com/~lm78/newdrivers.html and looked in the 
> lm_sensors-2.9.1 tarball before I started and didn't see a driver for 
> the DS1374 listed. That's why I threw mine together. Maybe I missed
> it.

The DS1374 isn't a hardware monitoring driver, so it doesn't have to be
listed here (although we happen to list a few miscellaneous drivers).

-- 
Jean Delvare
