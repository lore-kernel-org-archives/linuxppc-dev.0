Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id B6319DDED4
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 17:49:05 +1000 (EST)
Message-ID: <4871CA6E.9080805@matrix-vision.de>
Date: Mon, 07 Jul 2008 09:49:02 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Andre Schwarz <andre.schwarz@matrix-vision.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Add MPC5200B base board mvBC-P
References: <486E515B.80508@matrix-vision.de>
	<20080706235046.GA6267@yookeroo.seuss>
In-Reply-To: <20080706235046.GA6267@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David,

thanks - removed "device_type" from the DMA controller.

Which nodes actually require "device_type" and which don't ?

Is there some general rule ?


regards,
Andre

David Gibson schrieb:
> On Fri, Jul 04, 2008 at 06:35:39PM +0200, Andre Schwarz wrote:
>   
>> The mvBlueCOUGAR-P is a MPC5200B based camera system with Intel Gigabit ethernet
>> controller (using e1000). It's just another MPC5200_simple board.
>>
>> Signed-off-by: Andre Schwarz <andre.schwarz@matrix-vision.de>
>>     
> [snip]
>   
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/mvbc-p.dts
>> @@ -0,0 +1,206 @@
>>     
>
> [snip]
>   
>> +		dma-controller@1200 {
>> +			device_type = "dma-controller";
>>     
>
> No device_type here.
>
>   
>> +			compatible = "fsl,mpc5200-bestcomm";
>> +			reg = <0x1200 0x80>;
>> +			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
>> +				3 4 0  3 5 0  3 6 0  3 7 0
>> +				3 8 0  3 9 0  3 10 0  3 11 0
>> +				3 12 0  3 13 0  3 14 0  3 15 0>;
>> +			interrupt-parent = <&mpc5200_pic>;
>> +		};
>> +
>> +		xlb@1f00 {
>> +			compatible = "fsl,mpc5200-xlb";
>> +			reg = <0x1f00 0x100>;
>> +		};
>> +
>> +		serial0: serial@2000 {		// PSC1
>> +			device_type = "serial";
>> +			compatible = "fsl,mpc5200-psc-uart";
>> +			port-number = <0>;
>> +			reg = <0x2000 0x100>;
>> +			interrupts = <2 1 0>;
>> +			interrupt-parent = <&mpc5200_pic>;
>> +		};
>> +
>> +		i2c@3d00 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			compatible = "fsl,mpc5200-i2c","fsl-i2c";
>> +			reg = <0x3d00 0x40>;
>> +			interrupts = <2 15 0>;
>> +			interrupt-parent = <&mpc5200_pic>;
>> +			fsl5200-clocking;
>> +		};
>> +
>> +		i2c@3d40 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			compatible = "fsl,mpc5200-i2c","fsl-i2c";
>> +			reg = <0x3d40 0x40>;
>> +			interrupts = <2 16 0>;
>> +			interrupt-parent = <&mpc5200_pic>;
>> +			fsl5200-clocking;
>> +		};
>> +		sram@8000 {
>> +			compatible = "fsl,mpc5200-sram","sram";
>> +			reg = <0x8000 0x4000>;
>> +		};
>> +	};
>>     
>
>   


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
