Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 190ECDDF6C
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 05:24:29 +1000 (EST)
In-Reply-To: <1176397856.6379.75.camel@zod.rchland.ibm.com>
References: <1176382146.6379.28.camel@zod.rchland.ibm.com>
	<aeef7937e978aec33074251c48dca389@kernel.crashing.org>
	<1176397856.6379.75.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2458171b1807b269bd490766be7aa2e9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix PowerPC 750CL CPU features
Date: Thu, 12 Apr 2007 21:24:26 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The difference between these two is
>>
>> #define CPU_FTRS_750GX  (CPU_FTR_DUAL_PLL_750FX | 
>> CPU_FTR_HAS_HIGH_BATS)
>> #define CPU_FTRS_750    (CPU_FTR_COMMON)
>>
>> 750GX excludes COMMON, which seems like a bug.  With
>
> CPU_FTR_COMMON is actually a nop in this case anyway.  It should
> probably be listed for "completeness", but it's defined to be 0 so it
> doesn't really do anything.

Well you *can* have SMP 750 systems.  Not that Linux can
handle them but...  ;-)

>> Either way, it seems a good idea to create a CPU_FTRS_750CL,
>> the CL is an evolution of the CX, not the FX/GX (in name
>> at least, dunno about the gory details).
>
> I can do that, or I can just do:
>
> CPU_FTRS_750 | CPU_FTR_HAS_HIGH_BATS

Yeah, you can #define CPU_FTRS_750CL that way too.
Most current defines should be like that if you ask me,
it's a whole lot of copy'n'waste right now.

>>> -		.cpu_setup		= __setup_cpu_750cx,
>>> +		.cpu_setup		= __setup_cpu_750fx,
>>
>> Same thing here.  Are you sure 750CL doesn't need
>> the NAP workaround?  [Is anyone sure the 750CX
>> actually needs it -- the comment in cpu_setup_6xx.S
>> doesn't instill much confidence.]
>
> This should be fine.

Okay.  The name isn't fine though.


Segher
