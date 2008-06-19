Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E9A1DDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 23:23:27 +1000 (EST)
Message-Id: <07FF95CF-C157-4258-8BF5-34CAD2CECDCA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1213858514.25483.1.camel@localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/6] Move code patching code into
	arch/powerpc/lib/code-patching.c
Date: Thu, 19 Jun 2008 08:23:13 -0500
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
	<5A31B777-6591-4AE9-BDE5-3B624AED10A4@kernel.crashing.org>
	<1213858514.25483.1.camel@localhost>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 19, 2008, at 1:55 AM, Michael Ellerman wrote:

> On Thu, 2008-06-19 at 01:15 -0500, Kumar Gala wrote:
>> On May 29, 2008, at 1:20 AM, Michael Ellerman wrote:
>>
>>> We currently have a few routines for patching code in asm/system.h,
>>> because
>>> they didn't fit anywhere else. I'd like to clean them up a little
>>> and add
>>> some more, so first move them into a dedicated C file - they don't
>>> need to
>>> be inlined.
>>>
>>> While we're moving the code, drop create_function_call(), it's
>>> intended
>>> caller never got merged and will be replaced in future with  
>>> something
>>> different.
>>>
>>> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>>> ---
>>> arch/powerpc/kernel/crash_dump.c          |    1 +
>>> arch/powerpc/lib/Makefile                 |    2 +
>>> arch/powerpc/lib/code-patching.c          |   33 ++++++++++++++++++ 
>>> ++
>>> arch/powerpc/platforms/86xx/mpc86xx_smp.c |    1 +
>>> arch/powerpc/platforms/powermac/smp.c     |    1 +
>>> include/asm-powerpc/code-patching.h       |   25 +++++++++++++++
>>> include/asm-powerpc/system.h              |   48
>>> -----------------------------
>>> 7 files changed, 63 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/crash_dum
>>
>> what's the state of these patches and getting them into powerpc-next?
>
> I think what I posted is reasonably solid, I've added some more  
> routines
> for the stuff I'm working on. I'll repost today or tommorrow.
>
>> I'm looking at some runtime fix ups that I was thinking of basing on
>> this code.
>
> What have you got in mind? I'm working on some runtime fixups too :)

I want to be able to run time fix up lwsync an remove it as compile  
time thing.

- k
