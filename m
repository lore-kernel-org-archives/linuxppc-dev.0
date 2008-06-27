Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79A0FDE134
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 07:08:28 +1000 (EST)
Message-Id: <E57F448A-7217-4893-A77B-6367B0C3118A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48654D6D.1090309@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc: Add dma nodes to 83xx, 85xx and 86xx boards
Date: Fri, 27 Jun 2008 16:08:13 -0500
References: <Pine.LNX.4.64.0806271449540.9071@blarg.am.freescale.net>
	<48654D6D.1090309@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 27, 2008, at 3:28 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/ 
>> powerpc/boot/dts/asp834x-redboot.dts
>> index 972cf78..d140031 100644
>> --- a/arch/powerpc/boot/dts/asp834x-redboot.dts
>> +++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
>> @@ -53,7 +53,7 @@
>> 			     "fsl,pq2pro-localbus",
>> 			     "simple-bus";
>> 		reg = <0xff005000 0x1000>;
>> -		interrupts = <77 0x8>;
>> +		interrupts = <47 0x8>;
>> 		interrupt-parent = <&ipic>;
>> 		ranges = <
>
> This is wrong (LBC is IRQ 77; IRQ 47 is reserved), and wasn't  
> mentioned in the patch description...

This was a search/replace mistake.

>> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/ 
>> boot/dts/mpc8313erdb.dts
>> index e1f0dca..ae2c4aa 100644
>> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
>> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
>> @@ -52,7 +52,7 @@
>> 		#size-cells = <1>;
>> 		compatible = "fsl,mpc8313-elbc", "fsl,elbc", "simple-bus";
>> 		reg = <0xe0005000 0x1000>;
>> -		interrupts = <77 0x8>;
>> +		interrupts = <13 0x8>;
>> 		interrupt-parent = <&ipic>;
>
> Likewise.  13 is the 1588 timer IRQ.
>
>> @@ -51,7 +51,7 @@
>> 		#size-cells = <1>;
>> 		compatible = "fsl,mpc8315-elbc", "fsl,elbc", "simple-bus";
>> 		reg = <0xe0005000 0x1000>;
>> -		interrupts = <77 0x8>;
>> +		interrupts = <15 0x8>;
>
> I2C this time. :-P

ditto, ditto.  thanks for catching them.

>> @@ -303,6 +268,41 @@
>> 			};
>> 		};
>> +		crypto@30000 {
>> +			model = "SEC3";
>> +			compatible = "talitos";
>> +			reg = <0x30000 0x10000>;
>> +			interrupts = <11 0x8>;
>> +			interrupt-parent = <&ipic>;
>> +			/* Rev. 3.0 geometry */
>> +			num-channels = <4>;
>> +			channel-fifo-len = <24>;
>> +			exec-units-mask = <0x000001fe>;
>> +			descriptor-types-mask = <0x03ab0ebf>;
>> +		};
>> +
>> +		sdhc@2e000 {
>> +			model = "eSDHC";
>> +			compatible = "fsl,esdhc";
>> +			reg = <0x2e000 0x1000>;
>> +			interrupts = <42 0x8>;
>> +			interrupt-parent = <&ipic>;
>> +		};
>> +
>> +		sata@18000 {
>> +			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
>> +			reg = <0x18000 0x1000>;
>> +			interrupts = <44 0x8>;
>> +			interrupt-parent = <&ipic>;
>> +		};
>> +
>> +		sata@19000 {
>> +			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
>> +			reg = <0x19000 0x1000>;
>> +			interrupts = <45 0x8>;
>> +			interrupt-parent = <&ipic>;
>> +		};
>
> Doesn't match the changelog, and the crypto binding is old.

Its because diff doesn't like the fact that I moved the dma node up.

>> diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/ 
>> boot/dts/mpc8378_mds.dts
>> index 1d6ea08..5d57f5d 100644
>> --- a/arch/powerpc/boot/dts/mpc8378_mds.dts
>> +++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
>> @@ -52,7 +52,7 @@
>> 		#size-cells = <1>;
>> 		compatible = "fsl,mpc8378-elbc", "fsl,elbc", "simple-bus";
>> 		reg = <0xe0005000 0x1000>;
>> -		interrupts = <77 0x8>;
>> +		interrupts = <78 0x8>;
>
> Another mangled localbus interrupt (and more after this).

I think I got them all.

- k
