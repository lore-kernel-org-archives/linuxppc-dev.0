Return-Path: <Grant.Likely@arm.com>
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x42f6NZxzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 22:48:10 +1000 (AEST)
Subject: Re: DT case sensitivity
To: Rob Herring <robh@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>, Kumar Gala <kumar.gala@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Frank Rowand <frowand.list@gmail.com>, devicetree-spec@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
 <CAL_JsqKqkO31ekVMFKs+osLvKdZyDzRowF1thWXn5=tWhrJgvw@mail.gmail.com>
 <18175413a0148f7859ab36ed9715dce7a598f318.camel@kernel.crashing.org>
 <13bf5b39-0461-351e-57e3-60264eaa374d@arm.com>
 <CAL_Jsq+1T8k5mtc-DgDBtX3Qco9sQG9RWv6FTZ8NXppNbNg3Ww@mail.gmail.com>
 <e9009f6dd3aded2b9aa735973f4eed8386dd9afb.camel@kernel.crashing.org>
 <CAL_JsqKnbFAydf7ets0=KySm3P3b_7np-EVWz3Gh6qO+imJ+eg@mail.gmail.com>
From: Grant Likely <grant.likely@arm.com>
Message-ID: <d0e8b2f1-788e-2ad8-10de-7bbc412c301d@arm.com>
Date: Thu, 23 Aug 2018 13:48:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKnbFAydf7ets0=KySm3P3b_7np-EVWz3Gh6qO+imJ+eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/08/2018 13:08, Rob Herring wrote:
> On Thu, Aug 23, 2018 at 6:48 AM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>>
>> On Thu, 2018-08-23 at 06:43 -0500, Rob Herring wrote:
>>> On Thu, Aug 23, 2018 at 4:02 AM Grant Likely <grant.likely@arm.com> wro=
te:
>>>>
>>>>
>>>> What problem are you trying to solve?
>>>
>>> I'm looking at removing device_node.name and using full_name instead
>>> (which now is only the local node name plus unit-address). This means
>>> replacing of_node_cmp() (and still some strcmp) calls in a lot of
>>> places. I need to use either strncmp or strncasecmp instead.
>>>
>>>> I would think making everything
>>>> case insensitive would be the direction to go if you do anything. Leas=
t
>>>> possibility of breaking existing platforms in that scenario.
>>>
>>> Really? Even if all the "new" arches are effectively case sensitive?
>>> Anything using dtc and libfdt are (and json-schema certainly will be).
>>> But I frequently say the kernel's job is not DT validation, so you
>>> pass crap in, you get undefined results.
>>
>> I tend to agree with Grant. Let's put it this way:
>>
>> What is the drawback of being case insensitive ?
>
> It's a more expensive comparison. I don't think it's a hot path, but
> we do do a lot of string compares.

I'd hazard to argue that the cost of the string compare will not be a
source of performance problems when compared to doing a linear search
everytime a DT lookup is performed. The search algorithm is far more
problematic.

> Property names are case sensitive already. It would be nice if
> everything was treated the same way.
>
> If we're case sensitive then it is well defined which node we'll match
> and which one will be ignored. Otherwise, it is whichever one we
> happen to match first.

If case-insensitive-always is chosen, then the kernel should probably
complain at add node time if another matching node name already exists.
That's a relatively easy thing to test.

You are right however that in the FDT world we're case-sensitive now and
if it is relaxed then we're never going back. You could try switching
everyone over to case-sensitive and see if anything falls out in
linux-next for a few cycles. I would not touch the PPC or SPARC
behaviour. I don't think it is worth the risk to make the kernel more
strict when we cannot test the result. Only if everything was changed to
case-insensitive would it make sense to touch PPC and SPARC at the same
time because it reduces the number of platform variations.

If you do change compatible matches to be case sensitive, then you
should be prepared to fix bugs where the driver uses a different case
from the DTS. In which case drivers will need to be modified to accept
the deviant property names.

g.

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
