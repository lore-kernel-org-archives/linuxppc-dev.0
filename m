Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 829651007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 05:18:45 +1100 (EST)
Received: by ywh17 with SMTP id 17so904431ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 10:18:43 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200911261827.38405.to-fleischer@t-online.de>
References: <200911161742.46663.to-fleischer@t-online.de>
	<fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
	<20091126121204.GA3558@oksana.dev.rtsoft.ru>
	<200911261827.38405.to-fleischer@t-online.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 26 Nov 2009 11:18:23 -0700
Message-ID: <fa686aa40911261018u6c1624a7i636140707c4c0b61@mail.gmail.com>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
To: Torsten Fleischer <to-fleischer@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 26, 2009 at 10:27 AM, Torsten Fleischer
<to-fleischer@t-online.de> wrote:
> On Thu, Nov 26, 2009 at 13:12:04 Anton Vorontsov wrote:
> [...]
>> > Ah. =A0I understand what you're doing now. =A0 Hmmm. =A0This approach
>> > concerns me because it relies on firmware or platform code to get CS
>> > gpios set up properly before the driver is probed.
>>
>> Yes, that was said at the very beginning of this thread.
>>
>> > =A0Firmware doesn't
>> > always get it right, and I prefer to avoid platform specific setups as
>> > much as possible. =A0Why can't the CS polarity be encoded into the
>> > device tree so the driver *does* have the polarity data at probe time?
>>
>> We have the spi-cs-high property, but it duplicates compatible
>> property. 'compatible' is enough to tell whether some device has
>> cs-high or cs-low (device's driver knows that already).
>>
>> The problem is that SPI bus master doesn't know all the devices,
>> so it can't extract that information from the compatible string.
>> To workaround that we can use 'spi-cs-high', but that's ugly
>> workaround.
>>
>> SPI modes (0,1,2,3) is another matter, some devices can work in
>> several modes, so 'spi-cpol' and 'spi-cpha' are actually useful.
>>
> To get a sane initial state the needed GPIOs can be set to be inputs duri=
ng
> the driver's initialization.
> This requires pull-up/pull-down resistors connected to the chip select
> lines. I think we can assume that they exist, because the GPIOs are all i=
nputs
> after the controller's hardware reset and the resistors are needed to hav=
e a
> well-defined voltage level on the chip select lines. Normally the level i=
s set
> so that the devices are disabled.
>
> Therefore, it doesn't matter if the firmware sets the GPIOs wrong.

No, that's just shifting responsibility from firmware to hardware.
There is just as much broken hardware out there as broken firmware.
The assumption cannot be made that the initial state of the pin is the
inactive state of the CS line.  Plus, some GPIO pins are output only
and the inital state cannot be read.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
