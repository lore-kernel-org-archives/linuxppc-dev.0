Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1DA72DE247
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:17:27 +1000 (EST)
Message-ID: <48344B02.7070308@scram.de>
Date: Wed, 21 May 2008 18:17:06 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC] Add i2c pins to dts and board setup
References: <4833FA0C.5090800@scram.de>
	<20080521151003.GA13858@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080521151003.GA13858@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Linux I2C <i2c@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

>> +   - linux,i2c-index : Can be used to hard code an i2c bus number.
>> +   - linux,i2c-class : Can be used to override the i2c class.
>
> Why do we need this?

There are still a bunch of i2c drivers using the old API (mainly v4l and dvb stuff)
which are slowly being converted by their subsystem maintainers, though.

> It'd be better to just convert any needed old-style drivers than add this
> to the device tree.

Sure. That's why the parameters are only optional. Once all i2c drivers are
converted, these parameters won't be used anymore. Maybe they should be marked
as deprecated.

>> +   - bus-frequency : Can be used to set the i2c bus frequency. If unspecified,
>> +     a default frequency of 60kHz is being used.
> 
> clock-frequency is the standard name for such things.

I was just confused by the fact that unlike a serial port, i2c is a bus itself.

Thanks,
Jochen
