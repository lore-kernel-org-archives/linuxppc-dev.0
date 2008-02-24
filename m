Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 45F77DDE05
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 02:16:57 +1100 (EST)
Message-ID: <47C18A4E.5080804@scram.de>
Date: Sun, 24 Feb 2008 16:16:30 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCHv4 2.6.25] i2c: adds support for i2c bus on
	Freescale	CPM1/CPM2 controllers
References: <47A1C4E9.4000003@scram.de>
	<20080221130520.12b01553@hyperion.delvare>
	<47BEAF00.50106@scram.de> <20080223212823.GA22131@lixom.net>
In-Reply-To: <20080223212823.GA22131@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jean Delvare <khali@linux-fr.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
	Scott Wood <scottwood@freescale.com>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Olof,

>> 2. record the I2c name in the dts tree, either as seperate tag (like linux,i2c-name="<i2c-name>")
>>    or as additional compatible entry (like compatible="...", "linux,<i2c-name>").
> 
> I have to say no on this one. The device tree is not supposed to know
> about how linux uses devices, there are firmwares out there that don't
> use DTS for thier device trees, etc.

I still believe this this could be done for embedded devices which are usually booted
via wrapper or U-Boot as those devices will most probably use the most exotic I2c devices
out there (e.g. home-grown devices used by stbs). However, I'm not an device tree expert.
 
>> 3. use a glue layer with a translation map.
> 
> In my opinion this is an OK solution since the same information has to
> be added somewhere already anyway -- eiither to the drivers or to this
> translation table. It should of course be an abstacted shared table,
> preferrably contained under the i2c source directories since several
> platforms and architectures might share them.

I could think of a mixture between 2. and 3.:

Using the compatible attribute with the manufacturer stripped off as I2c name by default
and using an exception table. For now, the struct i2c_driver_device would currently only
need one entry ("dallas,ds1374", "rtc-ds1374").

Thanks,
Jochen
