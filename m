Return-Path: <daniel.ng1234@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 98E0FDDE26
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 12:19:55 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so805985rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 18:19:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <547eba1b0903190132pfd11ad5ld4b1bffb6dc22758@mail.gmail.com>
References: <547eba1b0903180036m46f6ffc0g521a5081924a2613@mail.gmail.com>
	<4206182445660643B9AEB8D4E55BBD0A02B9DDEEB3@HERMES2>
	<547eba1b0903190132pfd11ad5ld4b1bffb6dc22758@mail.gmail.com>
Date: Fri, 20 Mar 2009 12:19:54 +1100
Message-ID: <547eba1b0903191819v5b03d38ci7a60839873e5bd66@mail.gmail.com>
Subject: Re: spidev.c driver on the ppc8247 (kernel 2.6.27.19)
From: Daniel Ng <daniel.ng1234@gmail.com>
To: "Stepanov, Sergej" <Sergej.Stepanov@ids.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 19, 2009 at 7:32 PM, Daniel Ng <daniel.ng1234@gmail.com> wrote:
>
> So, I tried to call spidev_probe() directly from the probe() function
> of my SPI Controller driver. However in this case spidev_probe()
> failed because its call to device_create_drvdata() failed with error
> code ENODEV. Why would this be?
>
> This is how I make the call from my SPI Controller driver:
>
> spidev_probe(to_spi_device(&ofdev->dev));
>
> And this is the relevant code in spidev_probe():
>
> dev =3D device_create_drvdata(spidev_class, &spi->dev, spidev->devt,
> spidev, "spidev%d.%d",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*spi->master=
->bus_num*/0, spi->chip_select);

It looks like spidev_class was uninitialised because spidev_init() had
not yet been called. To force spidev_init() to be called before my SPI
Controller's driver initialisation, I just used:

subsys_initcall(spidev_init);

This seems to do the job...
