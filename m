Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4A5D6DDEF8
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 05:35:49 +1100 (EST)
Message-ID: <47C2F15B.8070703@scram.de>
Date: Mon, 25 Feb 2008 17:48:27 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCHv4 2.6.25] i2c: adds support for i2c bus on
	Freescale	CPM1/CPM2 controllers
References: <47A1C4E9.4000003@scram.de>
	<20080221130520.12b01553@hyperion.delvare>
	<47BEAF00.50106@scram.de> <20080223212823.GA22131@lixom.net>
	<47C18A4E.5080804@scram.de> <20080224181509.GA6745@lixom.net>
In-Reply-To: <20080224181509.GA6745@lixom.net>
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

> And even if you DO decide to go that route, guess what? You need a
> translation table just as with (3) anyway!

True.

>>>> 3. use a glue layer with a translation map.
>>> In my opinion this is an OK solution since the same information has to
>>> be added somewhere already anyway -- eiither to the drivers or to this
>>> translation table. It should of course be an abstacted shared table,
>>> preferrably contained under the i2c source directories since several
>>> platforms and architectures might share them.
>> I could think of a mixture between 2. and 3.:
>>
>> Using the compatible attribute with the manufacturer stripped off as I2c name by default
>> and using an exception table. For now, the struct i2c_driver_device would currently only
>> need one entry ("dallas,ds1374", "rtc-ds1374").
> 
> You still need the translation table, you're just flattening the
> namespace to one string instead of two, the same information still has
> to be encoded. I can't see what the benefit of this approach compared to
> the other one is. "dallas,ds1374" already only has one translation entry
> in the table?

As soon as http://lists.lm-sensors.org/pipermail/i2c/2008-January/002752.html has been
applied, one could get rid of all entries where the I2c (alias) name can be obtained from
the OF name just by stripping the manufacturer.

Thanks,
Jochen
