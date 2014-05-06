Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3CFA5140F9B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 16:01:52 +1000 (EST)
Message-ID: <53687913.70900@Freescale.com>
Date: Tue, 6 May 2014 00:54:27 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH 4/6] powerpc/corenet: Create the dts components for the
 DPAA FMan
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
 <1397823693-27977-4-git-send-email-Shruti@Freescale.com>
 <1398118262.1694.188.camel__8135.6513932862$1398128944$gmane$org@snotra.buserror.net>
 <5364BEB3.6000904@Freescale.com>
 <1399332359.15726.154.camel@snotra.buserror.net>
In-Reply-To: <1399332359.15726.154.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Shruti Kanetkar <Shruti@Freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 05/05/2014 06:25 PM, Scott Wood wrote:
> On Sat, 2014-05-03 at 05:02 -0500, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> On 04/21/2014 05:11 PM, Scott Wood wrote:
>>> On Fri, 2014-04-18 at 07:21 -0500, Shruti Kanetkar wrote:
>>>> +fman@400000 {
>>>> +	mdio@f1000 {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +		compatible = "fsl,fman-xmdio";
>>>> +		reg = <0xf1000 0x1000>;
>>>> +	};
>>>> +};
>>>
>>> I'd like to see a complete fman binding before we start adding pieces.
>>
>> The driver for the FMan 10 Gb/s MDIO has upstreamed a couple of years
>> ago: '9f35a73 net/fsl: introduce Freescale 10G MDIO driver', granted
>> without a binding writeup.
> 
> Pushing driver code through the netdev tree does not establish device
> tree ABI.  Binding documents and dts files do.

Sure, ideally and formally. But upstreaming a driver represents, if
nothing else, a statement of intent to observe a device tree ABI. Via
the SDK, FSL customers are using the device tree ABI the driver de facto
establishes. I guess a driver that makes it upstream can establish an
device tree ABI

We'll re-spin adding the binding document

>> This patch series should probably include a
>> binding blurb. However, let's not gate this patchset on a complete
>> binding for the FMan
> 
> I at least want to see enough of the FMan binding to have confidence
> that what we're adding now is correct.

I'm not sure what you're looking for. The nodes we're adding are
describing a very common CCSR space interface for quite common device blocks

>> As you know we don't own the FMan work and the FMan work is... not ready
>> for upstreaming.
> 
> I'm not asking for a driver, just a binding that describes hardware.  Is
> there any reason why the fman node needs to be anywhere near as
> complicated as it is in the SDK, if we're limiting it to actual hardware
> description?

Is this a trick question? :-) Of course it doesn't need to be more
complicated than actual hardware. But, to repeat myself, said
description is not... ready and I don't know when it will be. Somebody
else owns pushing the bulk of FMan upstream and I'd rather not step on
their turf quite like this

> Do we really need to have nodes for all the sub-blocks?

Definitely no, and internally I'm pushing to clean that up. However, you
surely remember we've been pushing from the early days of P4080 and it's
been, to put it optimistically, slow

>> In an attempt to make some sort of progress we've
>> decided to upstream the pieces that are less controversial and MDIO is
>> an obvious candidate
>>
>>>> +fman@400000 {
>>>> +	mdio0: mdio@e1120 {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +		compatible = "fsl,fman-mdio";
>>>> +		reg = <0xe1120 0xee0>;
>>>> +	};
>>>> +};
>>>
>>> What is the difference between "fsl,fman-mdio" and "fsl,fman-xmdio"?  I
>>> don't see the latter on the list of compatibles in patch 3/6.
>>
>> 'fsl,fman-mdio' is the 1 Gb/s MDIO (Clause 22 only). 'fsl,fman-xmdio' is
>> the 10 Gb/s MDIO (Clause 45 only). We can respin this patch wi
>>
> 
> "respin this patch wi..."?

Not sure where the end of that sentence went. I meant we'll re-spin with
a binding for the 10 Gb/s MDIO block

>> I believe 'fsl,fman-mdio' (and others on that list) was added
>> gratuitously as the FMan MDIO is completely compatible with the
>> eTSEC/gianfar MDIO driver, but we can deal with that later
> 
> It's still good to identify the specific device, even if it's believed
> to be 100% compatible.

You suggesting we create new compatibles for every instance/integration
of a hardware block even though is identical with an earlier hardware
integration? Well, I guess that's been done that and now we have about 8
different compatibles that convey no real difference at all

> Plus, IIRC there's been enough badness in the
> eTSEC MDIO binding that it'd be good to steer clear of it.

Hmm... I guess we can leave things as they are. I wasn't going to touch
this just now anyway

>>> Within each category, is the exact fman version discoverable from the
>>> mdio registers?
>>
>> No, but that's irrelevant as that's not the difference between the two
>> compatibles
> 
> It's relevant because it means the compatible string should have a block
> version number in it, or at least some other way in the MDIO node to
> indicate the block version.

The 1 Gb/s MDIO block doesn't track a version of its own and from a
programming interface perspective it has no visible difference since
eTSEC. The 10 Gb/s MDIO doesn't track a version of its own either and
across the existing FMan versions is identical from a programming
interface perspective

I guess we can append a 'v1.0' to the MDIO compatible(s). However, given
the SDK we'll have to support the compatibles the (already upstream)
drivers support. Dealing with all that legacy is going to be so tedious

>>>> +fman@500000 {
>>>> +	#address-cells = <1>;
>>>> +	#size-cells = <1>;
>>>> +	compatible = "simple-bus";
>>>
>>> Why is this simple-bus?
>>
>> Because that's the translation type for the FMan sub-nodes.
> 
> What do you mean by "translation type"?

I mean address translation across buses

>> We need it now to get the MDIO nodes probed
> 
> No.  "simple-bus" is stating an attribute of the hardware, that the
> child nodes represent simple memory-mapped devices that can be used
> without special bus knowledge.  I don't think that applies here.

Yes it does. The FMan sub-nodes are "simple memory-mapped devices that
can be used without special bus knowledge". Perhaps you're thinking
about the PHY devices on the MDIO bus

> You can get the MDIO node probed without misusing simple-bus by adding
> the fman node's compatible to the probe list in the kernel code.

I think that's gratuitous and it's been done gratuitously in the past
for CCSR space (sub-)nodes

> This sort of thing is why I want to see what the rest of the fman
> binding will look like.
> 
>>  and we'll needed later to probe other nodes/devices that will have
>> standalone drivers: MAC, MURAM. etc. 
> 
> How are they truly standalone?

I meant that they have individual drivers and they are not handled by
the high-level FMan driver

> The exist in service to the greater
> entity that is fman.  They presumably work together in some fashion.

Some blocks can work independently. The MURAM is an example and it seems
the existing CPM/QE MURAM code allows it to be used as regular memory.
The MDIO block could handle PHY(s) for other MACs in the system.

>>>> +	/* mdio nodes for fman v3 @ 0x500000 */
>>>> +	mdio@fc000 {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +		reg = <0xfc000 0x1000>;
>>>> +	};
>>>> +
>>>> +	mdio@fd000 {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +		reg = <0xfd000 0x1000>;
>>>> +	};
>>>> +};
>>>
>>> Where's the compatible?  Why is this file different from all the others?
>>
>> The FMan v3 MDIO block (supports both Clause 22/45) is compatible with
>> the FMan v2 10 Gb/s MDIO (the xgmac-mdio driver). However, the driver
>> needs a small clean-up patch (still in internal review) that will get it
>> working for FMan v3 MDIO.
> 
> This suggests that it is not 100% backwards compatible.

It is. The code is just not everything it should be


Cheers,


>>  With that patch will add the compatible to these nodes. However, we
>> need these nodes now for the board level MDIO bus muxing support
>> (included in this patchset)
> 
> If you need these nodes now then add the compatible property now.
> 
> -Scott
