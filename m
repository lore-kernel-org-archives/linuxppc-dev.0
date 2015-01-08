Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0107.outbound.protection.outlook.com [157.56.110.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 982491A0F8E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 20:32:29 +1100 (AEDT)
Message-ID: <54AE4E81.4040507@Freescale.com>
Date: Thu, 8 Jan 2015 03:31:45 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>
Subject: Re: [PATCH] [v3] power/fsl: add MDIO dt binding for FMan
References: <1419321466-5575-1-git-send-email-shh.xie@gmail.com>
 <DM2PR0301MB08640979E5088618D1395CFAE2580@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1420590520.4961.38.camel@freescale.com>
 <DM2PR0301MB08645ABD93708FFE011EF362E2460@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1420653934.4961.58.camel@freescale.com> <54AD8C8A.8070100@Freescale.com>
 <1420679558.4961.64.camel@freescale.com>
In-Reply-To: <1420679558.4961.64.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <Shaohui.Xie@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 01/07/2015 07:12 PM, Scott Wood wrote:
> On Wed, 2015-01-07 at 13:44 -0600, Emil Medve wrote:
>> Hello Scott,
>>
>>
>> On 01/07/2015 12:05 PM, Scott Wood wrote:
>>> On Tue, 2015-01-06 at 23:29 -0600, Xie Shaohui-B21989 wrote:
>>>>>>> +- interrupts
>>>>>>> +		Usage: optional
>>>>>>> +		Value type: <prop-encoded-array>
>>>>>>> +		Definition: Event interrupt of external MDIO controller.
>>>>>>> +		1 Gb/s MDIO and 10 Gb/s MDIO has one interrupt respectively.
>>>>>
>>>>> I'm confused by "respectively" here.  Does fsl,fman-memac-mdio have two
>>>>> interrupts (one for 1 Gb/s and one for 10 Gb/s)?
>>>> [S.H] We use two MDIO controllers for external PHY management. One for 1 Gb/s,
>>>> One for 10 Gb/s, and two MDIO interrupts connected to MPIC.
>>>
>>> If there can be two interrupts you need to make that clear and specify
>>> the order.
>>>
>>> Is it possible for one MDIO controller to have an interrupt connected
>>> but not the other, on the same system?  How would you represent that in
>>> the device tree?  If there are two MDIO controllers why are they in the
>>> same node?
>>
>> Historically (FMan v2 and even before/legacy) we've had each MAC include
>> an MDIO controller, but only one MDIO controller per MAC type/speed (1
>> Gb/s vs 10 Gb/s) is pinned out and all the same speed PHY(s) are
>> connected to the respective MDIO controllers. As such the first 1 Gb/s
>> MAC/MDIO controller is used to manage all the 1 Gb/s PHY(s) and the
>> first 10 Gb/s MAC/MDIO controller is used to manage all the 10 Gb/s
>> PHY(s). Each MDIO controller has the ability to generate interrupts but
>> only pinned out MDIO controllers are hooked up to the MPIC (as such the
>> talk about two interrupts)
>>
>> (Each MAC has also integrated a SERDES/TBI/"internal" PHY that is
>> connected to the "local" MDIO controller)
>>
>> As you can imagine this creates a number of problems in a partitioning
>> scenario (and not just, imagine RCWs where the first MAC is not
>> used/enabled). In order to help a bit (but not quite enough), in FMan
>> v3, two additional MDIO controllers (one for 1 the Gb/s PHY(s) and one
>> for 1 the 10 Gb/s PHY(s)) have been integrated that are not associated
>> with any MAC and these are the pinned out MDIO controllers on such
>> SoC(s) (chassis v2)
> 
> I'm happy to hear that.  Is that what is meant by "external" here?

"External" doesn't mean external to the MAC nodes. "External" doesn't
even properly apply to the MDIO controller(s) at all but to the PHY(s).

> I thought it meant external to the SoC.  Is this the term used by
> hardware documentation?

The documentation (mostly chip errata documents) refers to
external/internal MDIO accesses and as on FMan v3 external PHY accesses
are always made via these extra MDIO controllers (pinned oud) and the
internal SERDES PHY accesses are always made via the in-MAC MDIO
controllers some level of confusion is easy to be achieved. All the MDIO
controllers are identical whether they are in-MAC or standalone

> I'd have called it "independent" or similar.

To make things even more confusing, some documents call these extra MDIO
controllers "dedicated"


Cheers,


>>>>   Does "optional" mean it's used if and
>>>>> only if external MDIO is used, or is it optional even with external MDIO?  I see
>>>>> it's not present in the example -- do we not have a real example that has the
>>>>> interrupt?
>>>> [S.H] "optional" means it's available on hardware, but MDIO driver does not use interrupt. 
>>>> So we don't have a real example.
>>>
>>> <record type="broken">The device tree describes the hardware, not the
>>> driver</record>
>>
>> Anyway, only two MDIO nodes (out of 4 to 14) would have an interrupt
>> property describing exactly one interrupt. What language should we use
>> to convey this situation
> 
> So the answer is that there will not be more than one MDIO controller
> per MDIO node, or more than one interrupt per MDIO node?  In that case
> just get rid of the confusing "respectively" sentence -- and always
> describe the interrupt if it exists in hardware.
> 
> -Scott
> 
> 
> .
> 
