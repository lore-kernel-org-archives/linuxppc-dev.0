Return-Path: <dgibson@ozlabs.org>
Date: Fri, 24 Oct 2008 14:29:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081024032944.GE4267@yookeroo.seuss>
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49011C42.2020101@firmworks.com>
Cc: devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 23, 2008 at 02:52:18PM -1000, Mitch Bradley wrote:
>>
>>
>> Mitch Bradley wrote:
>> [snip]
>>
>>> You could adopt the convention that preassigned GPIOs must be  
>>> represented by subordinate nodes, and any GPIO that is not covered by 
>>> a subordinate node's "reg" property is implicitly available.  That's  
>>> the way it works for other address spaces.
>>
>> I like that idea except for the implicitly available bit.
>>
>> Just summarizing this in my head (also on the list), if we had an  
>> "available" property in the node marked as a gpio-controller, that  
>> would easily give gpiolib something to parse so that it only gives out  
>> allocations for pins that are really, really not being multiplexed for  
>> something else or just not being connected.
>>
>> There's a GPIO spec in booting-without-of.txt which basically defines  
>> a controller and a bank, and you can assign a bank of GPIO to some  
>> other device. Assigning specific GPIO pins should be possible.. umm..
>>
>> http://patchwork.ozlabs.org/patch/5478/
>>
>> With regards to this patch, how about device usage of pins being  
>> defined as a range of pins (reusing the standard-ish "ranges" property  
>> from PCI binding)?
>
>
> Okay, so it looks to me like your "bank" concept is sort of akin to a  
> "gpio-to-gpio bridge", with analogy to a pci-to-pci bridge.  Following  
> that model, the "name" of your "gpio-bank" would instead be  
> "gpio-controller", because its children are GPIO pin nodes that could  
> just as well be attached directly to the top-level gpio-controller node.  
> The "compatible" property would be different, reflecting the fact that it 
> is a "gpio-to-gpio bridge" instead of an "io-to-gpio bridge" (for 
> example).

No, no, no, no, no.  Making complex multi-level representations of
nested things for gpios is just insanity.  Just use the same encoded
format as we already use for gpio descriptors in 'gpios' properties
(which is gpio controller specific, with length defined by
#gpio-cells).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
