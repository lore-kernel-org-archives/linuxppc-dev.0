Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2DE3FDDF13
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 01:19:57 +1000 (EST)
Message-ID: <4820770B.1010002@scram.de>
Date: Tue, 06 May 2008 17:19:39 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [i2c] [PATCH6/7] i2c: adds support for i2c bus on
	Freescale	CPM1/CPM2 controllers
References: <47FF71A9.4010907@scram.de> <20080506135113.GA4265@pengutronix.de>
In-Reply-To: <20080506135113.GA4265@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux I2C <i2c@lm-sensors.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfram,

>> +	/* Begin transmission */
>> +	setbits8(&i2c_reg->i2com, 0x80);
> Hardcoded value. (I also wonder if 0x81 might be more suitable, as it
> keeps the "be-a-master"-bit set. Still, both values work with my setup.)

>> +#ifdef I2C_CHIP_ERRATA
>> +	/*
>> +	 * Chip errata, clear enable. This is not needed on rev D4 CPUs.
>> +	 * Disabling I2C too early may cause too short stop condition
>> +	 */
>> +	udelay(4);
>> +	clrbits8(&i2c_reg->i2mod, 1);
> I was unable to find the corresponding errata document, still I wonder
> if it is a 0 which should have been written? The text says "clear" and
> according to the reference manual, this means the bit should be 0.

setbits8() and clrbits8() use a bitmask as second argument.

setbits8(&i2c_reg->i2com, 0x80) will set bit 7 on the i2com register but 
leave bit 0 untouched. Likewise, clrbits8(&i2c_reg->i2mod, 1) will clear bit 0.

Thanks,
Jochen
