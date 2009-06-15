Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A4720B712A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 03:33:15 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id CBFB4DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 03:33:13 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1689226ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 10:33:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A3678A3.1050802@marel.com>
References: <fa686aa40902130719k1d16f936o4776cff371db16ae@mail.gmail.com>
	<4A3678A3.1050802@marel.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 15 Jun 2009 11:31:48 -0600
Message-ID: <fa686aa40906151031p74636557oc1ab173236d0a81b@mail.gmail.com>
Subject: Re: Chipselect in SPI binding with mpc5200-psc-spi
To: =?ISO-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 15, 2009 at 10:36 AM, K=E1ri
Dav=ED=F0sson<kari.davidsson@marel.com> wrote:
> Is this true?
>
> Grant Likely wrote:
>>
>> Yes, this is right. =A0The psc_spi driver automatically registers all
>> spi children that it finds in the device tree onto the SPI bus.
>> Therefore registering an spi_driver() is the right thing to do.
>
> I am writing an SPI protocol driver and I find that my driver
> is never probed.
>
> I tried to add and call to of_register_spi_devices() in the
> drivers/spi/mpc52xx_psc_spi.c::mpc52xx_psc_spi_of_probe() function,
> without much effect besided that the DTS node is parsed but the driver pr=
obe
> is not called, actually it complains about a modalias for my node is
> missing.

What do you see when you look in /sys/bus/spi/devices?  You should see
a directory for your device.  What do you see in /sys/bus/spi/drivers?
 In here you should see your driver.  If they are both there, then you
just have a problem matching your driver name to the device name.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
