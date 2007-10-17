Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4F23FDDEDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 05:20:54 +1000 (EST)
Message-ID: <47166085.1010608@scram.de>
Date: Wed, 17 Oct 2007 21:20:37 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH take2] [POWERPC] i2c: adds support for i2c bus on 8xx
References: <47134A94.60606@scram.de> <20071015183107.GA4361@loki.buserror.net>
In-Reply-To: <20071015183107.GA4361@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Carsten Juttner <carjay@gmx.net>, linux-kernel@vger.kernel.org,
	i2c@lm-sensors.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Scott,

> Do we really need to be adding features for arch/ppc at this point?  It'll
> be going away in June.  arch/ppc-specific things outside of arch/ppc itself
> will also be more likely to be missed in the removal.
>
> Also, please post inline rather than as an attachment; attachments are
> harder to quote in a reply.
>   

OK. I'll remove the ARC=ppc parts.

>> diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
>> index 8848e63..a526c02 100644
>> --- a/arch/powerpc/boot/dts/mpc885ads.dts
>> +++ b/arch/powerpc/boot/dts/mpc885ads.dts
>> @@ -213,6 +213,15 @@
>>  				fsl,cpm-command = <0080>;
>>  				linux,network-index = <2>;
>>  			};
>> +
>> +			i2c@860 {
>> +				device_type = "i2c";
>>     
>
> No device_type.
>   

Why? Documentation/powerpc/booting-without-of.txt says for I2C interfaces
device_type is required and should be "i2c". Is this no longer true?

> Should be fsl,cpm-i2c.  Is cpm2 i2c the same?  If not, it should be
> fsl,cpm1-i2c.  It's probably best to specify it anyway, along with
> fsl,mpc885-i2c.
>   

CPM2 i2c seems to be the same. However, i have no way to test this.

>> +#ifdef CONFIG_I2C_8XX
>> +	setbits32(&mpc8xx_immr->im_cpm.cp_pbpar, 0x00000030);
>> +	setbits32(&mpc8xx_immr->im_cpm.cp_pbdir, 0x00000030);
>> +	setbits16(&mpc8xx_immr->im_cpm.cp_pbodr, 0x0030);
>> +#endif
>>     
>
> Please add this to mpc885ads_pins, rather than poking the registers
> directly.  The relevant lines are:
>
> 	{CPM_PORTB, 26, CPM_PIN_OUTPUT},
> 	{CPM_PORTB, 27, CPM_PIN_OUTPUT},
>   

I noticed cpm1_set_pin32, but this function don't seem to set the
odr register. Will this be added? Then it would be:

	{CPM_PORTB, 26, CPM_PIN_OUTPUT | CPM_PIN_OPENDRAIN},
	{CPM_PORTB, 27, CPM_PIN_OUTPUT | CPM_PIN_OPENDRAIN},


>> +	/* Select an arbitrary address.  Just make sure it is unique.
>> +	 */
>> +	out_8(&i2c->i2c_i2add, 0xfe);
>>     
>
> It's a 7-bit address...  and are you sure that 0x7e is unique?  Does this
> driver even support slave operation?
>   

It's in fact 0x7F << 1. The same value is used in the 2.4 driver and
in u-boot, as well. Slave operation is not supported.

> Why is an 8xx driver matching all i2c cpm (i.e. what about cpm2)?
>   

With the suggested change to use fsl,cpm-command, the driver should
be able to use  both cpm1 and cpm2. The operation and structs for i2c
are identical. The only difference might be the hack^wsupport for
relocation.

Thanks,
Jochen
