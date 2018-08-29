Return-Path: <peda@axentia.se>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0117.outbound.protection.outlook.com [104.47.0.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420x9b0RhBzF31f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 05:52:34 +1000 (AEST)
Subject: Re: [PATCH] i2c: Convert to using %pOFn instead of device_node.name
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Linux I2C <linux-i2c@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-21-robh@kernel.org>
 <3fa33583-f748-1708-2274-0a6f4e81004b@axentia.se>
 <CAL_JsqJcDdntsi3D=neU=Dhx0Xku_XPFC_OCLRb8V==HTtviBQ@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <d2736c07-d653-a855-401d-120b0650ae79@axentia.se>
Date: Wed, 29 Aug 2018 21:52:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJcDdntsi3D=neU=Dhx0Xku_XPFC_OCLRb8V==HTtviBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018-08-29 20:42, Rob Herring wrote:
> On Wed, Aug 29, 2018 at 1:03 PM Peter Rosin <peda@axentia.se> wrote:
>>
>> On 2018-08-28 03:52, Rob Herring wrote:
>>> In preparation to remove the node name pointer from struct device_node,
>>> convert printf users to use the %pOFn format specifier.
>>>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Peter Rosin <peda@axentia.se>
>>> Cc: linux-i2c@vger.kernel.org
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  drivers/i2c/busses/i2c-powermac.c | 15 ++++++++-------
>>>  drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
>>>  2 files changed, 10 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
>>> index f2a2067525ef..b706fd136ca5 100644
>>> --- a/drivers/i2c/busses/i2c-powermac.c
>>> +++ b/drivers/i2c/busses/i2c-powermac.c
>>> @@ -390,7 +390,6 @@ static int i2c_powermac_probe(struct platform_device *dev)
>>>       struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
>>>       struct device_node *parent = NULL;
>>
>> Lose the initializer...
> 
> That's pretty much unrelated though.

I disagree. If you remove the need for the initializer, it's very much
related to also remove the initializer.

> I'd have to write "Also, remove
> the unnecessary parent pointer init" in the commit message and we all
> know "Also" is a clue for belongs in a separate patch.

How about: "This makes the parent pointer initializer redundant, lose it."

See, no "Also" in there, and no separate patch needed. Or don't mention it
at all.

Cheers,
Peter
