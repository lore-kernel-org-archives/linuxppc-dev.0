Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F5EA67C7D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 08:05:01 +1100 (EST)
In-Reply-To: <Pine.LNX.4.60.0611141956070.5542@poirot.grange>
References: <Pine.LNX.4.60.0611011844570.3736@poirot.grange>
	<Pine.LNX.4.60.0611051526510.4214@poirot.grange>
	<4EC85F22-99A9-4B0F-987C-25B715235320@kernel.crashing.org>
	<Pine.LNX.4.60.0611062048080.6091@poirot.grange>
	<Pine.LNX.4.60.0611132312430.3789@poirot.grange>
	<C14DE3DB-D490-4473-A625-CA71058A1C9E@kernel.crashing.org>
	<Pine.LNX.4.60.0611141956070.5542@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3CC50148-9122-4133-A304-E2723077EE1D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFC (take 3)] linkstation / kurobox support under
	arch/powerpc
Date: Tue, 14 Nov 2006 15:05:11 -0600
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 14, 2006, at 1:09 PM, Guennadi Liakhovetski wrote:

> On Tue, 14 Nov 2006, Kumar Gala wrote:
>
>> Out of interest how are you booting this kernel build & dts on the
>> linkstation/kurobox? u-boot or wrapper?
>
> u-boot.
>
>>> diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/ 
>>> boot/dts/kuroboxHG.dts
>>> new file mode 100644
>>> index 0000000..6c76ef6
>>> --- /dev/null
>>> +++ b/arch/powerpc/boot/dts/kuroboxHG.dts
>>
>> would make more sense if this file was called linkstation.dts to  
>> match the
>> Kconfig
>
> Well, as I wrote in the patch description, there are several NAS  
> devices
> which can be hopefully made to run one kernel with just different  
> fdts.
> The systems are LinkStation-I (I think, there are 2 variants thereof:
> HDLAN and HGLAN), Kurobox (normal and HG version), Terastation  
> (several
> variations). You can see them and other non-powerpc devices, e.g.,  
> here:
> http://linkstationwiki.net/index.php?title=Main_Page
> The kernel patch traditionally was called "linkstation", that's  
> where the
> CONFIG name comes from too. However, the device I have is a KuroboxHG,
> therefore the dts file is called kuroboxHG.dts, as it is indeed system
> specific. Makes sense?
>

Ok that makes sense, then KuroboxHG for the dts makes sense (lets  
just add a comment in the header saying it uses the linkstation  
kernel config)

>>> +		dma@80001100 {
>>> +			linux,phandle = <4100>;
>>> +			#interrupt-cells = <1>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			device_type = "dma";
>>> +			compatible = "fsl-dma";
>>> +			clock-frequency = <0>;
>>> +			reg = <80001100 24>;
>>> +			interrupts = <6 0>;
>>> +			interrupt-parent = <4400>;
>>> +		};
>>> +
>>> +		dma@80001200 {
>>> +			linux,phandle = <4200>;
>>> +			#interrupt-cells = <1>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			device_type = "dma";
>>> +			compatible = "fsl-dma";
>>> +			clock-frequency = <0>;
>>> +			reg = <80001200 24>;
>>> +			interrupts = <7 0>;
>>> +			interrupt-parent = <4400>;
>>> +		};
>>
>> Can we drop the dma nodes?  are you using them for something.  I'd  
>> prefer not
>> to specify what they look like until we figure out how to handle  
>> the various
>> "features" between the families of FSL PPC's that share the DMA  
>> controller
>> (10x, 824x, 83xx, 85xx)
>
> Sure, will do.
>
>>> +		i2c@80003000 {
>>> +			linux,phandle = <4300>;
>>> +			device_type = "i2c";
>>> +			compatible = "fsl-i2c";
>>> +			clock-frequency = <0>;
>>
>> Any reason for adding this clock-frequency property?
>
> Copy-paste:-)

from where?

>>> +		pic@80040000 {
>>> +			linux,phandle = <4400>;
>>> +			#interrupt-cells = <2>;
>>> +			#address-cells = <0>;
>>> +			device_type = "open-pic";
>>> +			compatible = "chrp,open-pic";
>>> +			interrupt-controller;
>>> +			reg = <80040000 40000>;
>>> +			clock-frequency = <0>;		/* ??? */
>>
>> Any reason for adding this clock-frequency property?
>
> Ditto.
>
>>> diff --git a/arch/powerpc/configs/kuroboxhg_defconfig b/arch/ 
>>> powerpc/configs/kuroboxhg_defconfig
>>> new file mode 100644
>>> index 0000000..136632f
>>> --- /dev/null
>>> +++ b/arch/powerpc/configs/kuroboxhg_defconfig
>>
>> similar file rename comment linkstation_defconfig
>
> Well, it should eventually be linkstation_defconfig, but so far it  
> only
> has drivers for kuroboxhg, but, perhaps, you're right. As the goal  
> is to
> have 1 kernel for all with one defconfig, I can rename it now and just
> hope it will be extended in the future as the patch is used /  
> tested on
> more systems. Will rename, thanks.
>
> So, I would leave most parts with "linkstation" notation, apart  
> from the
> .dts, will throw unneeded entries from the .dts, rename the  
> defconfig, but
> keep the .dts name. Agree?

Agreed, also update the comment/help in the Kconfig to make it clear  
that Kurobox and KuroboxHG are two different things.  The Kurobox(HG)  
was a bit confusing to me at first glance, and since its help, no  
reason not be more specific :)

- k
