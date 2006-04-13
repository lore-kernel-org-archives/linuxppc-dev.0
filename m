Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 11238679E0
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 06:45:41 +1000 (EST)
In-Reply-To: <1144923633.4935.11.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
Date: Thu, 13 Apr 2006 15:46:41 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 13, 2006, at 5:20 AM, Benjamin Herrenschmidt wrote:

> (For those who haven't followed the beginning, current git locks up at
> boot on most recent powermacs. It was tracked down to a weird problem
> with the idle code. My latest experiments seem to show something dodgy
> with MSR_POW). Help from Freescale folks would be appreciated.
>

Ben, I think I know what the problem is - comments below.

> On Sat, 2006-04-08 at 12:55 +1000, Paul Mackerras wrote:
>
>> This patch fixes it for me on my powerbook (1.5GHz albook).  The  
>> issue
>> seems to be that the cpu objects to HID0_NAP being cleared in HID0.
>> If I have this code power_save_6xx_restore, it hangs:
>>
>> _GLOBAL(power_save_6xx_restore)
>> 	mfspr	r11,SPRN_HID0
>> 	rlwinm	r11,r11,0,10,8		/* Clear NAP */
>> 	mtspr	SPRN_HID0,r11
>> 	b	transfer_to_handler_cont
>>
>> If I take out that rlwinm, it boots.  Bizaare.
>
> If you do that, you cause the transfer_to_handler to always call
> power_save_6xx_restore even when not coming back from idle.
>
> I did a bit more tracking and it's very strange.... At first, I
> discovered that adding a printk after the call to power_save fixed  
> it. I
> did all sort of tests and if my memory serves me well, a simple mb()
> there will fix it too. In fact, what I noticed is that if I do
>
>  if (mfmsr() & MSR_POW)
> 	printk("GACK !\n");
>
> After calling ppc_md.power_save() and before local_irq_enable(), it  
> does
> trigger ! But with an mb() just before, it doesn't. In fact, you don't
> need an mb()... all you need is another mfmsr(). Thus a dummy msmsr()
> "fixes" the stale MSR_POW in there.
>
> That is very dodgy. Looks like we get a stale MSR_POW upon return from
> the exception that interrupted sleep, causing the next
> local_irq_enable() to block forever.

Actually, I think the problem is that the code linux is using to turn  
on nap mode is not guaranteed to put the processor in nap mode by the  
time the blr in ppc6xx_idle occurs.

This is at the bottom of ppc6xx_idle:

         mfmsr   r7
         ori     r7,r7,MSR_EE
         oris    r7,r7,MSR_POW@h
         sync
         isync
         mtmsr   r7
         isync
         sync
         blr

Unfortunately, NAP mode does not necessarily fully take effect for  
some number of cycles after the mtmsr, and the sync isn't enough to  
guarantee this.  So it's entirely possible that you execute the blr  
and carry on with the next function, which is local_irq_enable (or  
perhaps a MSR read in the case of your test code) which is going see  
the MSR value with POW set because you haven't started napping yet.

The above code should really look like this:

         mfmsr   r7
         ori     r7,r7,MSR_EE
         oris    r7,r7,MSR_POW@h
         sync
         isync
         mtmsr   r7
         isync
label:
         b label
	blr

>
> The next question is how does it get there... my idea at first was  
> that
> we get MSR_POW in SRR1 in that exception and put it back in with rfi
> (and the CPU gets it that way instead of ignoring it). Sounds like a
> lovely explanation if we also add that a sync or an mfmsr "clears"  
> this
> weird condition. However, I added clearing of MSR_POW in r9 in
> EXCEPTION_PROLOG_2() and it didn't fix it (but maybe I did something
> wrong, I was tired).

This wouldn't help - MSR[POW] is cleared on exception and is not a  
bit that is saved in SRR1.

Hope this helps - I don't have hardware to test this on, so I can't  
be sure, but it seems to explain the behavior you're seeing if I'm  
understanding the problem correctly.

Cheers,
Becky
