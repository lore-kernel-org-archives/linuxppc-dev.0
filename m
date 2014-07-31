Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4EEC1A0222
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 15:56:43 +1000 (EST)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EB6D6140129
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2014 15:56:42 +1000 (EST)
Message-ID: <53D9D893.8090105@Freescale.com>
Date: Thu, 31 Jul 2014 00:48:03 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH v2 5/7] powerpc/corenet: Add MDIO bus muxing support to
 the board device tree(s)
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <1405541831-1277-5-git-send-email-Shruti@Freescale.com>
 <1405982754.29414.33.camel@snotra.buserror.net>
 <loom.20140728T081519-636@post.gmane.org>
 <1406663895.29414.240.camel@snotra.buserror.net>
 <53D96906.1040407@Freescale.com>
 <1406773805.29414.302.camel@snotra.buserror.net>
 <53D9C77D.8070203@Freescale.com>
 <1406784487.29414.328.camel@snotra.buserror.net>
In-Reply-To: <1406784487.29414.328.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 07/31/2014 12:28 AM, Scott Wood wrote:
> On Wed, 2014-07-30 at 23:35 -0500, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> On 07/30/2014 09:30 PM, Scott Wood wrote:
>>> On Wed, 2014-07-30 at 16:52 -0500, Emil Medve wrote:
>>>>>>>> +			mdio0: mdio <at> fc000 {
>>>>>>>> +			};
>>>>>>>
>>>>>>> Why is the empty node needed?
>>>>>>
>>>>>> For the label
>>>>>
>>>>> For mdio-parent-bus, or is there some other dts layer that makes this
>>>>> node non-empty?
>>>>
>>>> 'powerpc/corenet: Create the dts components for the DPAA FMan' -
>>>> http://patchwork.ozlabs.org/patch/370872
>>>
>>> Why does this patch define the mdio0 label for mdio@e1120, but not
>>> define a label for any other node?
>>
>> Only MDIO controllers that are pinned out have these labels. Only pinned
>> out MDIO(s) are capable of controlling external PHY(s) via these board
>> level MDIO buses
> 
> Is there any reason to describe non-pinned-out MDIO controllers at all?

Yes. For the internal TBI PHY(s). Each MAC supporting SGMII has a TBI
PHY that is attached to the MDIO controller of the respective MAC

> Is the lack of pinning out inherent to the silicon, or is it board
> design/config?

It's a silicon level decision

> Is the answer different for different MDIO controllers?

You mean non-FSL MDIO controllers? Dunno. All FSL SoC have the same MDIO
pin-out decision

> I'm just curious why mdio@e1120 is labelled in a non-board dtsi while
> others are labelled elsewhere.

Labels are relevant only in the context of 'powerpc/corenet: Add MDIO
bus muxing support to the board device tree(s)' -
http://patchwork.ozlabs.org/patch/370866. Most labels are created and
used in the board .dts file except b4qds.dtsi which is shared between
b4420qds.dts and b4860qds.dts


Cheers,
