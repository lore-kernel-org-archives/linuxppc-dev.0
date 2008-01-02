Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8BB72DDED0
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 07:29:01 +1100 (EST)
Message-ID: <477BF446.9070401@scram.de>
Date: Wed, 02 Jan 2008 21:29:58 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH/RFC] powerpc: DBox2 Board Support
References: <476D61DB.2090201@scram.de>
	<20080102180655.GB4398@loki.buserror.net>
In-Reply-To: <20080102180655.GB4398@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

> These unit addresses look wrong.

I know. These have (hopefully) been fixed in v3.

> What does dbox2-config mean?

I used it to search for the vendor info byte in the flash. It has been moved to the boot wrapper in v3.
Later this should all be moved to u-boot, IMHO.

>> +			ovpartition@20000 {
>> +				label = "Flash without bootloader";
>> +				reg = <20000 7e0000>;
>> +			};
>> +			ovpartition@0 {
>> +				label = "Complete Flash";
>> +				reg = <0 800000>;
>> +				read-only;
>> +			};
> 
> What is "ovpartition"?

Overlay partition. Is there a better way to specify this?

>> +			// Port D is LCD exclusive. Don't export as GPIO
>> +			CPM1_PIO: pio@970 {
>> +				compatible = "fsl,cpm1-pario";
>> +				reg = <970 180>;
>> +				num-ports = <3>;
>> +				#gpio-cells = <2>;
>> +			};
> 
> Why are we doing things differently just because all of the pins on this
> port happen to be directed to one device?  If it's because the Linux GPIO
> API sucks, then either fix the API, or work around the suckage in software,
> not the device tree.
> 
>> +			lcd@970 {
>> +				reg = <970 10>;
>> +				compatible = "samsung,ks0713";
>> +			};
> 
> So some driver that matches on samsung,ks0713 has to know the details of the
> mpc8xx GPIO registers?

The GPIO API only has an accessor for 1bit I/O. The LCD, however has for 1bit
control lines and an 8bit port. The GPIO API currently is unable to handle this.

>> +			i2c@860 {
>> +				compatible = "fsl,mpc823-i2c",
>> +					     "fsl,cpm1-i2c",
>> +					     "fsl,cpm-i2c";
>> +				reg = <860 20 3c80 30>;
>> +				interrupts = <10 3>;
>> +				interrupt-parent = <&CPM_PIC>;
>> +				fsl,cpm-command = <0010>;
>> +			};
> 
> Should have #address-cells and #size-cells.

In the meantime, i use the i2c patches from Jon Smirl and have added
these parameters.

> 
>> +enum dbox2_mid dbox2_get_mid(void)
>> +{
>> +	return dbox2_manuf_id;
>> +}
>> +EXPORT_SYMBOL_GPL(dbox2_get_mid);
> 
> Honestly, you're claiming derived-work status by calling a function that
> returns an integer, that was read directly from hardware?

Nope. It was a big fat hint not to use this value :). It has been moved to the
device tree in the mean time.

> I'd use separate device trees (I only did this kind of thing in mpc885ads
> because it's dip-switchable), but whatever...

I don't really like having to use different images on different DBoxes. It's
already too much to have two images (there are two different flash layouts).
People tend to brick their box by flashing the wrong image.

>> --- a/include/asm-powerpc/mpc8xx.h
>> +++ b/include/asm-powerpc/mpc8xx.h
>> @@ -23,6 +23,10 @@
>> #include <platforms/8xx/mpc885ads.h>
>> #endif
>>
>> +#if defined(CONFIG_DBOX2)
>> +#include <platforms/8xx/dbox2.h>
>> +#endif
> 
> This shouldn't be needed.

Already gone in v3.

> What happens if a device sits on two different gpio-parents?

On the dbox2, there are even stranger devices. One is using iomaped address spaces, GPIO and an i2c control interface.
Another one uses GPIO and an i2c control interface. For now, they appear twice in the device tree (once under i2c and 
once under localbus or pio). Is there a better way to do this?

localbus@8000000 {
	cam@3,0 {
		compatible = "betaresearch,dbox2-cam";
		reg = <3 0 20000 6 0 20000>;
		interrupts = <6 2>;
		interrupt-parent = <&PIC>;
		gpios = <1 1c 1 1d 1 1e 1 1f>;
		gpio-parent = <&CPM1_PIO>;
	};
};
soc@ff000000 {
	cpm@9c0 {
		CPM1_PIO: pio@950 {
			fp@0,0 {
				compatible = "betaresearch,dbox2-fp";
				interrupts = <4 2>;
				interrupt-parent = <&PIC>;
				gpios = <0 e>;
				gpio-parent = <&CPM1_PIO>;
			};
		};
		i2c@860 {
			fp@30 {
				compatible = "betaresearch,dbox2-fp";
				reg = <30>;
			};
			cam@37 {
				compatible = "betaresearch,dbox2-cam";
				reg = <37>;
			};			
		};
	};
};

Thanks,
Jochen
