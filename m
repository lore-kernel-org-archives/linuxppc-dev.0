Return-Path: <scott.wood@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0070.outbound.protection.outlook.com [104.47.2.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvDbW1VHwzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 17:04:06 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Yangbo Lu <yangbo.lu@nxp.com>, Scott Wood <oss@buserror.net>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Rob Herring
 <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] powerpc/85xx: adapt QorIQ eSDHC to the new clocking
 model
Date: Tue, 26 Apr 2016 06:31:14 +0000
Message-ID: <DB5PR0401MB1928ABB01CEAF524071C851591630@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1461147644-18041-1-git-send-email-yangbo.lu@nxp.com>
 <1461280096.32510.213.camel@buserror.net>
 <HE1PR04MB0889A9EA3955E0723146A2A9F8630@HE1PR04MB0889.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/26/2016 01:29 AM, Yangbo Lu wrote:=0A=
> =0A=
> =0A=
>> -----Original Message-----=0A=
>> From: Yangbo Lu=0A=
>> Sent: Tuesday, April 26, 2016 2:19 PM=0A=
>> To: 'Scott Wood'; linux-mmc@vger.kernel.org; linuxppc-=0A=
>> dev@lists.ozlabs.org; devicetree@vger.kernel.org=0A=
>> Cc: ulf.hansson@linaro.org; Rob Herring; Scott Wood=0A=
>> Subject: RE: [PATCH 1/2] powerpc/85xx: adapt QorIQ eSDHC to the new=0A=
>> clocking model=0A=
>>=0A=
>>> -----Original Message-----=0A=
>>> From: Scott Wood [mailto:oss@buserror.net]=0A=
>>> Sent: Friday, April 22, 2016 7:08 AM=0A=
>>> To: Yangbo Lu; linux-mmc@vger.kernel.org;=0A=
>>> linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org=0A=
>>> Cc: ulf.hansson@linaro.org; Rob Herring; Scott Wood=0A=
>>> Subject: Re: [PATCH 1/2] powerpc/85xx: adapt QorIQ eSDHC to the new=0A=
>>> clocking model=0A=
>>>=0A=
>>> On Wed, 2016-04-20 at 18:20 +0800, Yangbo Lu wrote:=0A=
>>>> Provide clocks property instead of clock-frequency for QorIQ eSDHC=0A=
>>>> dts node to adapt to the new clocking model, so that the driver=0A=
>>>> could get clock value by the common clk API and the u-boot could=0A=
>>>> remove the clock fixup.=0A=
>>>>=0A=
>>>> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>=0A=
>>>> ---=0A=
>>>>  arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi | 2 +-=0A=
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>>>=0A=
>>>> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi=0A=
>>>> b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi=0A=
>>>> index 20835ae..ddbe562 100644=0A=
>>>> --- a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi=0A=
>>>> +++ b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi=0A=
>>>> @@ -36,5 +36,5 @@ sdhc: sdhc@114000 {=0A=
>>>>  	compatible =3D "fsl,esdhc";=0A=
>>>>  	reg =3D <0x114000 0x1000>;=0A=
>>>>  	interrupts =3D <48 2 0 0>;=0A=
>>>> -	clock-frequency =3D <0>;=0A=
>>>> +	clocks =3D <&clockgen 4 1>;=0A=
>>>>  };=0A=
>>>=0A=
>>> Binding update?=0A=
>>>=0A=
>>> -Scott=0A=
>>=0A=
>> [Lu Yangbo-B47093] Sorry, did you mean the doc update? ...=0A=
>> It has already had a description in=0A=
>> Documentation/devicetree/bindings/clock/qoriq-clock.txt=0A=
>>=0A=
>> - clock-frequency: Input system clock frequency (SYSCLK)=0A=
>> - clocks: If clock-frequency is not specified, sysclk may be provided=0A=
>>         as an input clock.  Either clock-frequency or clocks must be=0A=
>>         provided.=0A=
> =0A=
> [Lu Yangbo-B47093] Or update mmc doc?=0A=
=0A=
Yes, mmc.  This patch has nothing to do with the clockgen node's input=0A=
clock...=0A=
=0A=
-Scott=0A=
=0A=
