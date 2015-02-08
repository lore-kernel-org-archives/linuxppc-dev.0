Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0120.outbound.protection.outlook.com [207.46.100.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F3561A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 00:28:58 +1100 (AEDT)
Message-ID: <54D76435.9060206@Freescale.com>
Date: Sun, 8 Feb 2015 07:27:17 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>, Liberman Igal-B31950
 <Igal.Liberman@Freescale.com>
Subject: Re: [PATCH] powerpc/dts: Update platform PLL node
References: <1421042407-13921-1-git-send-email-igal.liberman@freescale.com>
 <1421739810.4961.207.camel@freescale.com>
 <DM2PR03MB3835E56F8A4080CB764E1FDE64B0@DM2PR03MB383.namprd03.prod.outlook.com>
 <1422591130.10544.150.camel@freescale.com>
In-Reply-To: <1422591130.10544.150.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 01/29/2015 10:12 PM, Scott Wood wrote:
>>>> From: Igal Liberman <Igal.Liberman@freescale.com>
>>>>
>>>> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
>>>> Change-Id: I92d020651237041d3767aa35e9345439714f9831
>>>> ---
>>>>  arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi |    6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> Please explain this more.  Was it just wrong before?  Is this for a new chip?  If
>>> the latter, what effect does this have on existing chips?
>>
>> It wasn't wrong, however it was missing some clocking options which
>> might be used by some hardware accelerators available in T/B devices.
>> I need this options for FMan, however it might be used for other
>> accelerators too.
> 
> If the PLL had a div3 option and it wasn't described by the PLL node,
> the node was wrong.

Somewhere between early versions of the RM and the cores not using this
PLL output, yes the node is incomplete/wrong

> Do all chips that use this file have a div3?

Yup. T1/2/4, B4, etc. It's used as an input clock to the various IP
blocks on said SoC(es), FMan, eSDHC, PME, etc.

>>>> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
>>>> b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
>>>> index 48e0b6e..7e1f074 100644
>>>> --- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
>>>> +++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
>>>> @@ -49,14 +49,16 @@ global-utilities@e1000 {
>>>>  		reg = <0x800 0x4>;
>>>>  		compatible = "fsl,qoriq-core-pll-2.0";
>>>>  		clocks = <&sysclk>;
>>>> -		clock-output-names = "pll0", "pll0-div2", "pll0-div4";
>>>> +		clock-output-names = "pll0", "pll0-div2", "pll0-div3",
>>>> +				      "pll0-div4";
>>>
>>> You're changing the meaning of existing clock index 2.
>>
>> Yes, however this platform PLL is a new work which is not yet
>> used, so we aren't breaking any functionality.
> 
> No, it's the core PLL node which is already in use.  However, it looks
> like the driver already interprets clock index 2 differently based on
> whether clock index 3 exists.  None of this is mentioned in the binding
> document...

Yes, it's a bit fishy and that clock registration (code) ends up
working. However, I think we ought to key that code on the chassis
version and not on the number of clock outputs in some (in/complete)
node instance

That being said, there are two outstanding issues:

1. The core mux nodes need to be updated to get pllX-div4 from index 3
not 2. Currently things work because our RCW(s) don't use pllX-div4 so
the inconsistency goes unnoticed

2. Chassis v2 supports frequency scaling for the HW accelerators (FMan
in this particular case) much like it's supported for the cores (both
chassis v1/2). This patch doesn't cover that


Cheers,
