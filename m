Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3AA481400E3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 13:31:07 +1000 (EST)
Message-ID: <536AF8C7.8080304@Freescale.com>
Date: Wed, 7 May 2014 22:23:51 -0500
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
 <53687913.70900@Freescale.com>
 <1399431248.15726.255.camel@snotra.buserror.net>
In-Reply-To: <1399431248.15726.255.camel@snotra.buserror.net>
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


At this point, I'm getting a bit lost in this thread and I feel we're
getting into more generic comments. I'll continue to answer to some of
your comments to make sure I understand them. However, one major comment
I feel you made was about seeing a full FMan binding. If that's a deal
breaker, please let me know and we'll just drop the patches


Cheers,


On 05/06/2014 09:54 PM, Scott Wood wrote:
> On Tue, 2014-05-06 at 00:54 -0500, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> On 05/05/2014 06:25 PM, Scott Wood wrote:
>>> On Sat, 2014-05-03 at 05:02 -0500, Emil Medve wrote:
>>>> Hello Scott,
>>>>
>>>>
>>>> On 04/21/2014 05:11 PM, Scott Wood wrote:
>>>>> On Fri, 2014-04-18 at 07:21 -0500, Shruti Kanetkar wrote:
>>>>>> +fman@400000 {
>>>>>> +	mdio@f1000 {
>>>>>> +		#address-cells = <1>;
>>>>>> +		#size-cells = <0>;
>>>>>> +		compatible = "fsl,fman-xmdio";
>>>>>> +		reg = <0xf1000 0x1000>;
>>>>>> +	};
>>>>>> +};
>>>>>
>>>>> I'd like to see a complete fman binding before we start adding pieces.
>>>>
>>>> The driver for the FMan 10 Gb/s MDIO has upstreamed a couple of years
>>>> ago: '9f35a73 net/fsl: introduce Freescale 10G MDIO driver', granted
>>>> without a binding writeup.
>>>
>>> Pushing driver code through the netdev tree does not establish device
>>> tree ABI.  Binding documents and dts files do.
>>
>> Sure, ideally and formally. But upstreaming a driver represents, if
>> nothing else, a statement of intent to observe a device tree ABI.
> 
> Ideally, yes (or rather, ideally the driver patch should have been
> rejected due to lack of a binding document).  But in practice it's way
> too easy for bad stuff to slip in via driver code, especially when it
> goes via a subsystem maintainer that is different from the one who would
> be reviewing the binding.
> 
>>  Via the SDK, FSL customers are using the device tree ABI the driver de
>> facto establishes.
> 
> ABI of any sort established by the SDK or other non-upstream trees is
> not binding on upstream.  Yes, it's a pain for customers, which is why
> ABI should go upstream ASAP.
> 
>>>> This patch series should probably include a
>>>> binding blurb. However, let's not gate this patchset on a complete
>>>> binding for the FMan
>>>
>>> I at least want to see enough of the FMan binding to have confidence
>>> that what we're adding now is correct.
>>
>> I'm not sure what you're looking for. The nodes we're adding are
>> describing a very common CCSR space interface for quite common device blocks
> 
> ...embedded in a variety of different blocks.
> 
> If the mdio can truly stand alone, then maybe just submit the mdio node
> without being enclosed in an fman node.
> 
>>>> As you know we don't own the FMan work and the FMan work is... not ready
>>>> for upstreaming.
>>>
>>> I'm not asking for a driver, just a binding that describes hardware.  Is
>>> there any reason why the fman node needs to be anywhere near as
>>> complicated as it is in the SDK, if we're limiting it to actual hardware
>>> description?
>>
>> Is this a trick question? :-) Of course it doesn't need to be more
>> complicated than actual hardware. But, to repeat myself, said
>> description is not... ready and I don't know when it will be. Somebody
>> else owns pushing the bulk of FMan upstream and I'd rather not step on
>> their turf quite like this
> 
> If they want to defend their "turf" they can submit a patch.  Now.  This
> has gone on long enough.
> 
> I'm tempted to submit a binding myself.  I don't know much about
> datapath, so I'll probably screw it up.  Please beat me to it. :-)
> 
>>> Do we really need to have nodes for all the sub-blocks?
>>
>> Definitely no, and internally I'm pushing to clean that up. However, you
>> surely remember we've been pushing from the early days of P4080 and it's
>> been, to put it optimistically, slow
> 
> Stop pushing them and start pushing patches.
> 
> Just do it in the right order. :-)
> 
>>>> In an attempt to make some sort of progress we've
>>>> decided to upstream the pieces that are less controversial and MDIO is
>>>> an obvious candidate
>>>>
>>>>>> +fman@400000 {
>>>>>> +	mdio0: mdio@e1120 {
>>>>>> +		#address-cells = <1>;
>>>>>> +		#size-cells = <0>;
>>>>>> +		compatible = "fsl,fman-mdio";
>>>>>> +		reg = <0xe1120 0xee0>;
>>>>>> +	};
>>>>>> +};
>>>>>
>>>>> What is the difference between "fsl,fman-mdio" and "fsl,fman-xmdio"?  I
>>>>> don't see the latter on the list of compatibles in patch 3/6.
>>>>
>>>> 'fsl,fman-mdio' is the 1 Gb/s MDIO (Clause 22 only). 'fsl,fman-xmdio' is
>>>> the 10 Gb/s MDIO (Clause 45 only). We can respin this patch wi
>>>>
>>>
>>> "respin this patch wi..."?
>>
>> Not sure where the end of that sentence went. I meant we'll re-spin with
>> a binding for the 10 Gb/s MDIO block
>>
>>>> I believe 'fsl,fman-mdio' (and others on that list) was added
>>>> gratuitously as the FMan MDIO is completely compatible with the
>>>> eTSEC/gianfar MDIO driver, but we can deal with that later
>>>
>>> It's still good to identify the specific device, even if it's believed
>>> to be 100% compatible.
>>
>> You suggesting we create new compatibles for every instance/integration
>> of a hardware block even though is identical with an earlier hardware
>> integration?
> 
> "100% compatible" is a different statement from actually being identical
> logic.  How do you know that absolutely nothing changed?
> 
>>  Well, I guess that's been done that and now we have about 8
>> different compatibles that convey no real difference at all
> 
> So?  Remember that a node can have multiple compatible strings.  After
> you identify the exact logic being used, you can list older instances
> that are believed to be compatible.
> 
>>>>> Within each category, is the exact fman version discoverable from the
>>>>> mdio registers?
>>>>
>>>> No, but that's irrelevant as that's not the difference between the two
>>>> compatibles
>>>
>>> It's relevant because it means the compatible string should have a block
>>> version number in it, or at least some other way in the MDIO node to
>>> indicate the block version.
>>
>> The 1 Gb/s MDIO block doesn't track a version of its own and from a
>> programming interface perspective it has no visible difference since
>> eTSEC. The 10 Gb/s MDIO doesn't track a version of its own either and
>> across the existing FMan versions is identical from a programming
>> interface perspective
>>
>> I guess we can append a 'v1.0' to the MDIO compatible(s). However, given
>> the SDK we'll have to support the compatibles the (already upstream)
>> drivers support. Dealing with all that legacy is going to be so tedious
> 
> I'm not going to insist that the drivers stop supporting what they
> currently support, but I don't agree with the statement that "given the
> SDK we'll have to...".
> 
>>>>>> +fman@500000 {
>>>>>> +	#address-cells = <1>;
>>>>>> +	#size-cells = <1>;
>>>>>> +	compatible = "simple-bus";
>>>>>
>>>>> Why is this simple-bus?
>>>>
>>>> Because that's the translation type for the FMan sub-nodes.
>>>
>>> What do you mean by "translation type"?
>>
>> I mean address translation across buses
> 
> What translation across buses?
> 
>>>> We need it now to get the MDIO nodes probed
>>>
>>> No.  "simple-bus" is stating an attribute of the hardware, that the
>>> child nodes represent simple memory-mapped devices that can be used
>>> without special bus knowledge.  I don't think that applies here.
>>
>> Yes it does. The FMan sub-nodes are "simple memory-mapped devices that
>> can be used without special bus knowledge". Perhaps you're thinking
>> about the PHY devices on the MDIO bus
> 
> No, I'm not thinking about that.
> 
> What I find particularly disturbing about putting simple-bus on the fman
> node is that it applies to whatever other subnodes get added in the
> future, and we don't yet have any idea what those nodes will be (or at
> least I don't).
> 
>>> You can get the MDIO node probed without misusing simple-bus by adding
>>> the fman node's compatible to the probe list in the kernel code.
>>
>> I think that's gratuitous and it's been done gratuitously in the past
>> for CCSR space (sub-)nodes
> 
> CCSR is a simple-bus, so I'm not sure what you're referring to.
> 
>>> This sort of thing is why I want to see what the rest of the fman
>>> binding will look like.
>>>
>>>>  and we'll needed later to probe other nodes/devices that will have
>>>> standalone drivers: MAC, MURAM. etc. 
>>>
>>> How are they truly standalone?
>>
>> I meant that they have individual drivers and they are not handled by
>> the high-level FMan driver
> 
> That's software description, not hardware description.  Surely those
> drivers cooperate in some manner.
> 
>>> The exist in service to the greater
>>> entity that is fman.  They presumably work together in some fashion.
>>
>> Some blocks can work independently. 
> 
> If any cannot, then simple-bus is wrong.
> 
>> The MURAM is an example and it seems the existing CPM/QE MURAM code
>> allows it to be used as regular memory.
> 
> But it's supposed to be used for CPM/QE/Fman.  If an OS chooses to
> ignore that and bind a generic driver to it, that's the OS's choice, but
> the device tree shouldn't pretend that this is an unrelated bag of
> devices.
> 
>>  The MDIO block could handle
>> PHY(s) for other MACs in the system.
> 
> That doesn't necessarily mean the MDIO is totally independent.  E.g.
> some versions of eTSEC have a TBIPA register that affects the operation
> of the MDIO controller, but is not in the MDIO register area.
> 
>>>>> Where's the compatible?  Why is this file different from all the others?
>>>>
>>>> The FMan v3 MDIO block (supports both Clause 22/45) is compatible with
>>>> the FMan v2 10 Gb/s MDIO (the xgmac-mdio driver). However, the driver
>>>> needs a small clean-up patch (still in internal review) that will get it
>>>> working for FMan v3 MDIO.
>>>
>>> This suggests that it is not 100% backwards compatible.
>>
>> It is. The code is just not everything it should be
> 
> The code works with one v2, and breaks with v3.  Thus, something is
> different.  Whether the difference is enough to prevent claiming
> compatibility depends on the detials (e.g. if the difference is
> parameterized through another DT property, or if the difference is
> within what is allowed by the specs of the original device), but it
> suggests they are not literally the same logic.  Unles the difference is
> not due to v2 versus v3 but some difference elsewhere in the system?
> 
> -Scott
