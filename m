Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B0EF668394
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2005 02:04:26 +1000 (EST)
In-Reply-To: <1127599811.27674.47.camel@gaston>
References: <Pine.LNX.4.61.0509221450190.30738@nylon.am.freescale.net>
	<1127599811.27674.47.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AFEB186E-99B9-4BE8-9AE3-315C74277483@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 26 Sep 2005 11:04:48 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: make sure we have an L3 before touch its control
	register
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 24, 2005, at 5:10 PM, Benjamin Herrenschmidt wrote:

> On Thu, 2005-09-22 at 14:51 -0500, Kumar Gala wrote:
>
>> Ben,
>>
>> Can you take a look at this.  I think its pretty straight forward and
>>
> if
>
>> your ok with it please forward on to linus.
>>
>
> We usually haven't dong the fixup of cpu features yet at the point
> setup() is run, thus your change will have no effect. You need to
> actually go look at the CPU feature bits. (You can look a bit below in
> that same code how it does for CPU_FTR_L3_DISABLE_NAP and
> CCPU_FTR_CAN_NAP.

Dope, you're right.  I notice that we apparent do this for BTIC and  
DPM in this function though?

> Also, it's 745x, those CPUs so far always existed in their 744x  
> version
> without L3 and no way to recongnize them via PVR afaik (until before
> 7447A). I would expect L3CR to just return 0. Is this not the case on
> 7447/7448 ? If yes, then there is no need to change the code...

Need to check.  I was lead to believe on 7448 they may have gotten  
ride of L3CR and thus my patch.  I do some digging internally to see  
what's happening with L3CR on 7448.

>
> Ben.
>
>
>> - kumar
>>
>> --
>>
>> Some variants of 745x may not actually have the L3CR register.  Since
>> we mark which variants of 745x have L3CRs in the cputable we can
>> use that information to ensure that the mfspr L3CR will not cause
>> an exception in the processors that don't have the register.
>>
>> Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>
>>
>> ---
>> commit f706b6046f1fee29bdf3081dd783f7e482012165
>> tree 6d42ee61458ec94ac7d4567e3f0383dd1e47a537
>> parent d8ac10639b6a1ed900efbee38c18baaca31e64dc
>> author Kumar K. Gala <kumar.gala@freescale.com> Thu, 22 Sep 2005
>>
> 14:47:52 -0500
>
>> committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 22 Sep 2005
>>
> 14:47:52 -0500
>
>>
>>  arch/ppc/kernel/cpu_setup_6xx.S |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/ppc/kernel/cpu_setup_6xx.S
>>
> b/arch/ppc/kernel/cpu_setup_6xx.S
>
>> --- a/arch/ppc/kernel/cpu_setup_6xx.S
>> +++ b/arch/ppc/kernel/cpu_setup_6xx.S
>> @@ -212,9 +212,11 @@ setup_745x_specifics:
>>       * the firmware. If any, we disable NAP capability as
>>       * it's known to be bogus on rev 2.1 and earlier
>>       */
>> +BEGIN_FTR_SECTION
>>      mfspr    r11,SPRN_L3CR
>>      andis.    r11,r11,L3CR_L3E@h
>>      beq    1f
>> +END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
>>      lwz    r6,CPU_SPEC_FEATURES(r5)
>>      andi.    r0,r6,CPU_FTR_L3_DISABLE_NAP
>>      beq    1f
>
