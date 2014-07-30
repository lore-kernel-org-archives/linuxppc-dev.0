Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F35821A01A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 08:16:34 +1000 (EST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 14E4D14017A
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2014 08:16:33 +1000 (EST)
Message-ID: <53D96906.1040407@Freescale.com>
Date: Wed, 30 Jul 2014 16:52:06 -0500
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
In-Reply-To: <1406663895.29414.240.camel@snotra.buserror.net>
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


On 07/29/2014 02:58 PM, Scott Wood wrote:
> On Mon, 2014-07-28 at 06:51 +0000, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> Scott Wood <scottwood <at> freescale.com> writes:
>>> On Wed, 2014-07-16 at 15:17 -0500, Shruti Kanetkar wrote:
>>>> +			mdio <at> fd000 {
>>>> +				/* For 10g interfaces */
>>>> +				phy_xaui_slot1: xaui-phy <at> slot1 {
>>>> +					status = "disabled";
>>>> +					compatible = "ethernet-phy-ieee802.3-c45";
>>>> +					reg = <0x7>; /* default switch setting on slot1 of AMC2PEX */
>>>> +				};
>>>
>>> Why xaui-phy and not ethernet-phy?
>>>
>>> As for the device_type discussion from v1, there is a generic binding
>>> that says device_type "should" be ethernet-phy.
>>
>> I have no strong feelings about this and we can use ethernet-phy, but:
>>
>> 1. The binding is old/stale (?) as it still uses device_type and the kernel
>> doesn't seem to use anymore the device_type for PHY(s)
> 
> Yes.
> 
>> 2. The binding asks "ethernet-phy" for the device_type property, not for the
>> name. As such TBI PHY(s) use (upstream) the tbi-phy@ node name
> 
> It shows ethernet-phy as the name in the example.  ePAPR urges generic
> node names (this was also a recommendation for IEEE1275), and has
> ethernet-phy on the preferred list.  Is a xaui-phy not an ethernet phy?

So you thinking somebody should cleanup all the sgmii-phy and tbi-phy
node names, huh?

It seems that a number of tbi-phy instances slipped by you:

1be62c6 powerpc/mpc85xx: Add BSC9132 QDS Support
bf57aeb powerpc/85xx: add the P1020RDB-PD DTS support
8a6be2b powerpc/85xx: Add TWR-P1025 board support

>>>> +			mdio0: mdio <at> fc000 {
>>>> +			};
>>>
>>> Why is the empty node needed?
>>
>> For the label
> 
> For mdio-parent-bus, or is there some other dts layer that makes this
> node non-empty?

'powerpc/corenet: Create the dts components for the DPAA FMan' -
http://patchwork.ozlabs.org/patch/370872 and 'powerpc/corenet: Add DPAA
FMan support to the SoC device tree(s)' -
http://patchwork.ozlabs.org/patch/370868 add content to said node


Cheers,
