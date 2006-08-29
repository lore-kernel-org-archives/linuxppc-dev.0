Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B8FC67B57
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 16:43:49 +1000 (EST)
In-Reply-To: <1156788215.5959.25.camel@localhost>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
	<50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
	<200608192219.03178.arnd@arndb.de>
	<37280.84.105.60.119.1156030372.squirrel@gate.crashing.org>
	<1156190965.9659.41.camel@farscape.rchland.ibm.com>
	<17645.18647.720814.903612@cargo.ozlabs.ibm.com>
	<1156788215.5959.25.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6DCD2C4D-BB97-487D-A094-7F288970F3F3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
Date: Tue, 29 Aug 2006 08:43:38 +0200
To: Willschm <will_schmidt@vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	segher@gate.crashing.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I just did a patch to fix the existing masks.

Thanks Paul.

>> Could you do a new
>> version of this patch that doesn't include the unrelated mask fixes
>> please?  Also it would be really nice if you could figure out a  
>> way to
>> avoid doing the unnecessary 64-bit logical operations on 32-bit
>> machines - i.e. using an unsigned long for tmp, but then the  
>> constants
>> become problematic.  Maybe you need something like
>>
>> #define LCONST(x)	((unsigned long)(x##ULL))
>
> Ok, how about this..

Hrm.  The LCONST() thing is butt ugly though; you can just write
0x3333333333333333ULL etc. and GCC will do the right thing (i.e.
efficient code), and not warn (don't need the "ULL" even when in
C99/gnu99 mode, as we should be but aren't, heh).

You want to make tmp and unsigned long instead of an u64...


Segher
