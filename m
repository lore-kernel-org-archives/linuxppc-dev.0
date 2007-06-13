Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0362DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 17:26:37 +1000 (EST)
In-Reply-To: <1181718898.12936.6.camel@localhost.localdomain>
References: <1181717615.9397.40.camel@localhost.localdomain>
	<6dc1593b8ff8442f7b4cf7a01f69c07c@kernel.crashing.org>
	<1181718898.12936.6.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cad6a9b0bd58df6298cb5f8402e512e7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
Date: Wed, 13 Jun 2007 09:26:14 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +                             printk (KERN_EMERG "Error: reset
>> control \
>>> +                                     register not mapped,
>> spinning!\n");
>>
>> ...(... "bla bla bla "
>>         "bla bla bla\n");
>>
>> instead?  Or there'll be a lot of whitespace in your string.
> I just do not know the difference of these two style.

Your code puts a bunch of extra whitespace in the string (all
the tabs before "register not mapped").  Two strings after
each other (like in my example) are just pasted together.

There is no real reason to break the string in two anyway, it
is fine to have a more-than-80-char line in printk messages.

>> I don't see anything spinning like the warning says, btw (or
>> it must be something in abort()?)
> You can find the similar thing in 83xx/mis.c
> [snip]
> 	} else {
> 		printk (KERN_EMERG "Error: Restart registers not mapped,
> spinning!\n");
> 	}
> [snip]

You shouldn't have snipped, right after that it says

         for (;;) ;


Segher
