Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 718A91007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 08:58:33 +1100 (EST)
In-Reply-To: <4B0D7047.3000803@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-se! nd-email-albert_herranz@yahoo.es>
	<1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-19-git-send-email-albert_herranz@yahoo.es>
	<89DF2875-BF4F-4DE1-AB18-C09DFFABCA00@kernel.crashing.org>
	<4B0D7047.3000803@yah! oo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <45DF235B-AE84-4333-BE06-8BE7FFAE3ECC@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 18/19] powerpc: wii: platform support
Date: Thu, 26 Nov 2009 23:05:29 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +#ifdef CONFIG_STARLET_MINI
>>> +
>>> +#define HW_RESETS_OF_COMPATIBLE    "nintendo,hollywood-resets"
>>> +#define HW_GPIO_ALIAS        "hw_gpio
>>
>> This should be unconditional now I think?  You access the hardware
>> directly.
>
> Yes, at this stage direct hardware should be possible, but only if  
> 'mini' support is compiled-in (which will be the default option at  
> this stage).
> We can either leave the conditionals as is now, or remove them and  
> add them later if we support more than one firmware flavour.
>
> I'm fine with both options.

Removing all superfluous code is best in my opinion.

>>> +    np = of_find_node_by_name(NULL, "aliases");
>>> +    if (!np) {
>>> +        pr_err("unable to find node %s\n", "aliases");
>>> +        goto out;
>>> +    }
>>> +
>>> +    path = of_get_property(np, HW_GPIO_ALIAS, NULL);
>>> +    of_node_put(np);
>>> +    if (!path) {
>>> +        pr_err("alias %s unknown\n", HW_GPIO_ALIAS);
>>> +        goto out;
>>> +    }
>>
>> Don't use an alias here, search for e.g. a matching "compatible"  
>> instead.
>
> I used an alias because I wanted explicitly the second GPIO word.
>
> Is there another way to select a specific instance of repeated  
> identical hardware?

Yes, probe for it with its address.  There is no guarantee in which  
order
you will get them.

> We have two instances of gpios here, matching the same "compatible".

It's a pain in the behind that the GPIO binding will not allow you to
show the two GPIO regs as one controller, which it is.  Or can it
actually do that?


Segher
