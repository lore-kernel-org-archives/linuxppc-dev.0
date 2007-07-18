Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AFF7CDDF24
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:32:22 +1000 (EST)
Message-ID: <469E408F.1080300@freescale.com>
Date: Wed, 18 Jul 2007 11:32:15 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 30/61] fsl_soc: Update the way get_brgfreq() finds things
	in the device tree.
References: <20070718013538.GB15238@ld0162-tx32.am.freescale.net>
	<8DC2DA02-3D10-4D14-AC91-E34AEA68E04F@kernel.crashing.org>
In-Reply-To: <8DC2DA02-3D10-4D14-AC91-E34AEA68E04F@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/ 
>> boot/dts/mpc8272ads.dts
>> index 4d09dca..16a77f4 100644
>> --- a/arch/powerpc/boot/dts/mpc8272ads.dts
>> +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
>> @@ -119,12 +119,11 @@
>>              #address-cells = <1>;
>>              #size-cells = <1>;
>>              #interrupt-cells = <2>;
>> -            device_type = "cpm";
>> -            model = "CPM2";
>> +            compatible = "fsl,mpc8272-cpm", "fsl,cpm2", "fsl,cpm";
> 
> Does 'fsl,cpm' really mean anything useful?

Yes.  It's can't be used on its own to show the complete programming 
model, but there are lots of common things that it does indicate.

get_brgfreq() uses it to locate nodes which have an fsl,brg-frequency 
property.

>>              ranges = <00000000 00000000 20000>;
>>              reg = <0 20000>;
>>              command-proc = <119c0>;
>> -            brg-frequency = <17D7840>;
>> +            fsl,brg-frequency = <d#25000000>;
> 
> Leave brg-frequency, and make a note about it being deprecated.

The CPM binding is changed in so many other ways that are much harder to 
make backward compatible that I don't really see much point in doing so 
here.

> Also, take a look at QE it has a similar concept.

It'd be nice to extend this binding to include QE (and at some point 
down the road, merge the code)...  I just didn't have time this time around.

-Scott
