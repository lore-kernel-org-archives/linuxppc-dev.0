Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2125DDDE2D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 18:51:12 +1000 (EST)
In-Reply-To: <1177035524.6890.7.camel@concordia.ozlabs.ibm.com>
References: <20070416062347.GA20196@lixom.net>
	<1177024678.7286.23.camel@localhost.localdomain>
	<1177035524.6890.7.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a3519d3b3474ab6530e6e1092e3d60d0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: save trap number in bad_stack
Date: Fri, 20 Apr 2007 10:51:06 +0200
To: michael@ellerman.id.au
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	u64 trap_save;			/* Used when bad stack is encountered */
>>
>> Can you put it elsewhere in the PACA (around less frequently used
>> bits) ? This is a pretty hot area of the PACA...
>
> It's only set in the bad_stack case though.
>
> You should put it after cpu_start, there's a bit hole there, and
> trap_save is readonly during normal operation, so it shouldn't be a
> performance hit.

That's not a performance hit compared to the current
state of the code, sure; but that "hot slot" could
be used for a hotter variable, instead.


Segher
