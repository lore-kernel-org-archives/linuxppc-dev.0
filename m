Return-Path: <henk.stegeman@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EE74CB6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 23:07:26 +1000 (EST)
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225]) by ozlabs.org (Postfix) with ESMTP id 9ACDBDDDB2
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 23:07:24 +1000 (EST)
Received: by ewy25 with SMTP id 25so1631401ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Jul 2009 06:07:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40907070857m5b604f6fk9bd9301997938b37@mail.gmail.com>
References: <ae4f76fd0810290643o27c357d7k2ccde459d9e52a7b@mail.gmail.com>
	<fa686aa40810290745k5c34c5e1m835351837e39248e@mail.gmail.com>
	<ae4f76fd0902130240g72b3cdf1l21b8f7ec8ad17e76@mail.gmail.com>
	<fa686aa40902130719k1d16f936o4776cff371db16ae@mail.gmail.com>
	<ae4f76fd0907070731p473fef56wdd410db43f6c4c8a@mail.gmail.com>
	<fa686aa40907070857m5b604f6fk9bd9301997938b37@mail.gmail.com>
Date: Wed, 8 Jul 2009 15:07:21 +0200
Message-ID: <ae4f76fd0907080607v3d1d8cd1s1f108edfdb2bbc40@mail.gmail.com>
Subject: Re: Chipselect in SPI binding with mpc5200-psc-spi
From: Henk Stegeman <henk.stegeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It now works, in the dts

interrupt-controller =3D < &gpt6 >;     // Use GPT6 as

should have been

interrupt-parent =3D < &gpt6 >;     // Use GPT6 as

On Tue, Jul 7, 2009 at 5:57 PM, Grant Likely<grant.likely@secretlab.ca> wro=
te:
> On Tue, Jul 7, 2009 at 8:31 AM, Henk Stegeman<henk.stegeman@gmail.com> wr=
ote:
>> I tried to make use of the irq-controller mode of the GPT as
>> suggested, however I'm not getting the IRQ.
>> Does anyone have an idea what I could be missing? (I've been testing
>> with 2.6.30).
>
> Make sure the 5200 general purpose timer driver is compiled in (not a mod=
ule).
>
>>
>>
>> The driver reports from it's probe:
>> [ =A0 =A01.502853] spi_master spi32766.0 Unable to get sample IRQ from o=
f
>>
>> My driver has:
>> =A0 =A0 =A0 =A0pdata->sample_irq =3D irq_of_parse_and_map(np, 0);
>> =A0 =A0 =A0 =A0if (pdata->sample_irq =3D=3D NO_IRQ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D pdata->sample_irq;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Unable to get sample IRQ fr=
om of\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0..
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>>
>> My dts has:
>> =A0 =A0 =A0 =A0gpt6: timer@660 { =A0 =A0 =A0 // General Purpose Timer GP=
T6 in GPIO mode for
>> SMC4000IO sample irq.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-controller;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc5200b-gpt","fsl,mp=
c5200-gpt";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x660 0x10>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <1 15 0>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&mpc5200_pic>;
>> =A0 =A0 =A0 =A0};
>>
>>
>> =A0 =A0 =A0 =A0io-controller@0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "microkey,smc4000io";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0linux,modalias =3D "of_smc4000io";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi-max-frequency =3D <800000>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi-cpha;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0word-delay-us =3D <30>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-controller =3D <&gpt6>; // Use =
GPT6 as the IRQ controller
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2>; // And make it edge f=
alling
>> =A0 =A0 =A0 =A0};
>>
>>
>> Thanks in advance,
>>
>> Henk.
>>
>> On Fri, Feb 13, 2009 at 5:19 PM, Grant Likely<grant.likely@secretlab.ca>=
 wrote:
>>> On Fri, Feb 13, 2009 at 3:40 AM, Henk Stegeman <henk.stegeman@gmail.com=
> wrote:
>>>> I'm busy adding support for slave deviced behind mpc52xx-psc-spi.
>>>> One complication I have is that my SPI slave device has an interrupt o=
utput
>>>> to the CPU.
>>>> My idea is to add it as a gpios property in the slave device's
>>>> configuration:
>>>>
>>>> =A0 =A0 =A0 =A0 spi@2400 { =A0 =A0 =A0 =A0// PSC3 (SPI IF to the IO-co=
ntroller )
>>>> =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "spi";
>>>> =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5200-psc-spi","fsl,mpc5=
200b-psc-spi";
>>>> =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2400 0x100>;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <2 3 0>;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpc5200_pic>;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 gpios =3D <&gpt4 0 0>;
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 io-controller@0 {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "microkey,smc4000io";
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi-max-frequency =3D <1000000>;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 // gpios: first is IRQ to cpu
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpios =3D <&gpt6 0 0>;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 };
>>>
>>> There is a better way to do this, and driver support for it is
>>> currently merged into Ben Herrenschmidt's -next tree.
>>>
>>> Do this instead:
>>> =A0 =A0 =A0 =A0io-controller@0 {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "microkey,smc4000io";
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi-max-frequency =3D <1000000>;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0>;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-controller =3D < &gpt6 >; =A0 =
=A0 // Use GPT6 as
>>> the IRQ controller
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D < 1 >; =A0 =A0// And make=
 it rising edge.
>>> =A0 =A0 =A0 =A0};
>>>
>>> Then add these two properties to the GPT node:
>>>
>>> =A0 =A0 =A0 =A0interrupt-controller;
>>> =A0 =A0 =A0 =A0#interrupt-cells =3D <1>;
>>>
>>> Then you can use normal irq_of_parse_and_map() to set up your handler.
>>>
>>>> How should I then register my spi slave driver? My smc4000io_probe fun=
ction
>>>> gets called correctly by of_spi support but when I register as follows=
:
>>>>
>>>> static struct spi_driver smc4000io_driver =3D {
>>>> =A0 =A0 .driver =3D {
>>>> =A0 =A0 =A0 =A0 .name =A0 =A0=3D "smc4000io",
>>>> =A0 =A0 =A0 =A0 .bus =A0 =A0=3D &spi_bus_type,
>>>> =A0 =A0 =A0 =A0 .owner =A0 =A0=3D THIS_MODULE,
>>>> =A0 =A0 },
>>>> =A0 =A0 .probe =A0 =A0 =A0 =A0=3D smc4000io_probe,
>>>> =A0 =A0 .remove =A0 =A0 =A0 =A0=3D __devexit_p(smc4000io_remove),
>>>> };
>>>>
>>>> static int __init smc4000io_init(void)
>>>> {
>>>> =A0 =A0 return spi_register_driver(&smc4000io_driver);
>>>> }
>>>>
>>>> static void __exit smc4000io_exit(void)
>>>> {
>>>> =A0 =A0 spi_unregister_driver(&smc4000io_driver);
>>>> }
>>>>
>>>> module_init(smc4000io_init);
>>>
>>> Yes, this is right. =A0The psc_spi driver automatically registers all
>>> spi children that it finds in the device tree onto the SPI bus.
>>> Therefore registering an spi_driver() is the right thing to do.
>>>
>>>> But when I do:
>>>>
>>>> static struct of_platform_driver smc4000_spi_of_driver =3D {
>>>> =A0 =A0 .name =3D "smc4000io",
>>>> =A0 =A0 .match_table =3D smc4000io_of_match,
>>>> =A0 =A0 .probe =3D smc4000io_of_probe,
>>>> =A0 =A0 .remove =A0 =A0 =A0 =A0=3D __devexit_p(smc4000io_of_remove),
>>>> };
>>>>
>>>> static int __init smc4000io_init(void)
>>>> {
>>>> =A0 =A0 return of_register_platform_driver(&smc4000_spi_of_driver);
>>>> }
>>>> module_init(smc4000io_init);
>>>>
>>>> Then my smc4000io_of_probe function never gets called.
>>>
>>> Correct. =A0of_platform_driver isn't useful in this case because the
>>> device cannot exist independently of the SPI bus. =A0Plus an
>>> of_platform_device doesn't provide any information about the SPI bus
>>> itself.
>>>
>>> g.
>>>
>>> --
>>> Grant Likely, B.Sc., P.Eng.
>>> Secret Lab Technologies Ltd.
>>>
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>
