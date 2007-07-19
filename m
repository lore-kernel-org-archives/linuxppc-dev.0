Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 48E0ADDEA3
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 15:45:30 +1000 (EST)
In-Reply-To: <469E6241.5090604@freescale.com>
References: <9b26986bc99c74c5e17e08191eb07d67@bga.com>
	<469E6241.5090604@freescale.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d385cb2ef0d915731d915efc3a8e6dff@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 10/61] bootwrapper: flatdevtree fixes
Date: Thu, 19 Jul 2007 00:45:18 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jul 18, 2007, at 1:56 PM, Scott Wood wrote:
> Milton Miller wrote:
>> In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
>> On Wed Jul 18 11:33:08 EST 2007, Scott Wood wrote:
>>> 1. ft_create_node was returning the internal pointer rather than a 
>>> phandle.
>>> 2. ft_find_device_rel was treating lookups relative to root as an 
>>> error.
>> No, it is treating lookups relative to NULL as an error.
>> Your patch changes it to treat lookups relative to the NULL phandle 
>> as relative to root.
>
> Other parts of the code (such as ft_create_node) already do that. 
> What's wrong with it?

Well, that behavior may be ok, but the change log should say that is 
the behavior you are changing.

Ie I would record 2 as:

When ft_find_device_rel is asked to find relative to NULL, find 
realative to root instead of returning an error.

or:

ft_find_device_rel now treats lookups relative to NULL as relative to 
the root instead of erroring out.


My reading would say that lookups relative to the phandle of root would 
have workied before, no?

>
>> I've no objections to the other part, can you split these?
>
> No, because change #1 won't work without change #2.

Huh?

I can see how changing a routine to return an external not internal 
pointer is necessary before changing a caller creates a dependancy for 
2 on 1, but why does it require lookups relative to the phandle NULL be 
treated as lookups relative to the root?

milton
