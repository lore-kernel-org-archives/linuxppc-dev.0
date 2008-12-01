Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EFBB2DDF03
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 09:09:14 +1100 (EST)
Date: Mon, 1 Dec 2008 14:07:51 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <Andre.Schwarz@matrix-vision.de>
Subject: Re: i2c-mpc clocking scheme
In-Reply-To: <49343DC2.3070601@matrix-vision.de>
Message-ID: <Pine.LNX.4.64.0812011347450.10176@t2.domain.actdsltmp>
References: <492EB606.9020703@matrix-vision.de>
	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
	<492EC031.9000802@matrix-vision.de>
	<Pine.LNX.4.64.0811281255001.12483@t2.domain.actdsltmp>
	<4933FBC6.50100@freescale.com> <49343DC2.3070601@matrix-vision.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463811584-760670571-1228169271=:10176"
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-760670571-1228169271=:10176
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 1 Dec 2008, Andr=E9 Schwarz wrote:
> Timur Tabi wrote:
>>  Trent Piepho wrote:
>>
>>=20
>> >  Seems like it should keep the clock registers at what u-boot set them=
=20
>> >  too.
>> >=20
>>
>>  Or we could have U-Boot put the i2c clock frequency into the I2C node, =
and
>>  let
>>  the driver program the hardware again.  That would keep the ugliness in
>>  U-Boot.
>>
>>=20
> Wouldn't it be easier to omit frequency re-programming at all ?
> Maybe configurable for non U-Boot users ...

That's what I'm thinking too.  Calculating the settings for a given bus
frequency, even with the system specific source clock provided by u-boot,
involves either a complex algorithm or a big ugly black box table that's
even larger than the algorithm.  I also think it's different for 8xxx and
52xx.

On the other hand just keeping the clock the same doesn't require any code
at all.

U-boot could pass in "bus-frequency" to let software know the speed of the
I2C bus from Linux.  Seems like a standard property for bus nodes.

There could be a "current-speed" property that tells linux to keep the
registers the same, in case we have to worry about u-boot not programming
the i2c clock.  I think the serial drivers have something like this.
---1463811584-760670571-1228169271=:10176--
