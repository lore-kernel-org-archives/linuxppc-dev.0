Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 66777DDEB9
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 08:23:01 +1100 (EST)
Message-ID: <477C0092.3010304@freescale.com>
Date: Wed, 02 Jan 2008 15:22:26 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFC] powerpc: DBox2 Board Support
References: <476D61DB.2090201@scram.de>
	<20080102180655.GB4398@loki.buserror.net>
	<477BF446.9070401@scram.de>
In-Reply-To: <477BF446.9070401@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
>>> +            ovpartition@20000 {
>>> +                label = "Flash without bootloader";
>>> +                reg = <20000 7e0000>;
>>> +            };
>>> +            ovpartition@0 {
>>> +                label = "Complete Flash";
>>> +                reg = <0 800000>;
>>> +                read-only;
>>> +            };
>>
>> What is "ovpartition"?
> 
> Overlay partition. Is there a better way to specify this?

Not sure... what will the mtd code do with this?

>>> +            lcd@970 {
>>> +                reg = <970 10>;
>>> +                compatible = "samsung,ks0713";
>>> +            };
>>
>> So some driver that matches on samsung,ks0713 has to know the details 
>> of the
>> mpc8xx GPIO registers?
> 
> The GPIO API only has an accessor for 1bit I/O. The LCD, however has for 
> 1bit
> control lines and an 8bit port. The GPIO API currently is unable to 
> handle this.

Right, but we shouldn't weird up the device tree because of Linux's 
weaknesses.  Ideally, the GPIO API should support wider I/O; in the 
meantime, there should be something in the board file that tells the 
ks0713 driver what to do.

>> I'd use separate device trees (I only did this kind of thing in mpc885ads
>> because it's dip-switchable), but whatever...
> 
> I don't really like having to use different images on different DBoxes. 
> It's
> already too much to have two images (there are two different flash 
> layouts).
> People tend to brick their box by flashing the wrong image.

Fair enough.

> localbus@8000000 {
>     cam@3,0 {
>         compatible = "betaresearch,dbox2-cam";
>         reg = <3 0 20000 6 0 20000>;
>         interrupts = <6 2>;
>         interrupt-parent = <&PIC>;
>         gpios = <1 1c 1 1d 1 1e 1 1f>;
>         gpio-parent = <&CPM1_PIO>;
>     };
> };
> soc@ff000000 {
>     cpm@9c0 {
>         CPM1_PIO: pio@950 {
>             fp@0,0 {
>                 compatible = "betaresearch,dbox2-fp";
>                 interrupts = <4 2>;
>                 interrupt-parent = <&PIC>;
>                 gpios = <0 e>;
>                 gpio-parent = <&CPM1_PIO>;
>             };
>         };
>         i2c@860 {
>             fp@30 {
>                 compatible = "betaresearch,dbox2-fp";
>                 reg = <30>;
>             };
>             cam@37 {
>                 compatible = "betaresearch,dbox2-cam";
>                 reg = <37>;
>             };           
>         };
>     };
> };

I'd make the compatible name specific to the interface (e.g. 
"betaresearch,dbox2-cam-mmio", "betaresearch,dbox2-fp-i2c"), use reg 
rather than gpios/gpio-parent, and use phandle linkage between the 
different inteferfaces of a device.  But yes, multiple nodes is the 
sanest way to do it.

-Scott
