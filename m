Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF01C67DB5
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 20:22:45 +1000 (EST)
Subject: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17463.9759.442768.685153@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 20:20:33 +1000
Message-Id: <1144923633.4935.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(For those who haven't followed the beginning, current git locks up at
boot on most recent powermacs. It was tracked down to a weird problem
with the idle code. My latest experiments seem to show something dodgy
with MSR_POW). Help from Freescale folks would be appreciated.

On Sat, 2006-04-08 at 12:55 +1000, Paul Mackerras wrote: 

> This patch fixes it for me on my powerbook (1.5GHz albook).  The issue
> seems to be that the cpu objects to HID0_NAP being cleared in HID0.
> If I have this code power_save_6xx_restore, it hangs:
> 
> _GLOBAL(power_save_6xx_restore)
> 	mfspr	r11,SPRN_HID0
> 	rlwinm	r11,r11,0,10,8		/* Clear NAP */
> 	mtspr	SPRN_HID0,r11
> 	b	transfer_to_handler_cont
> 
> If I take out that rlwinm, it boots.  Bizaare.

If you do that, you cause the transfer_to_handler to always call
power_save_6xx_restore even when not coming back from idle.

I did a bit more tracking and it's very strange.... At first, I
discovered that adding a printk after the call to power_save fixed it. I
did all sort of tests and if my memory serves me well, a simple mb()
there will fix it too. In fact, what I noticed is that if I do

 if (mfmsr() & MSR_POW)
	printk("GACK !\n");

After calling ppc_md.power_save() and before local_irq_enable(), it does
trigger ! But with an mb() just before, it doesn't. In fact, you don't
need an mb()... all you need is another mfmsr(). Thus a dummy msmsr()
"fixes" the stale MSR_POW in there.

That is very dodgy. Looks like we get a stale MSR_POW upon return from
the exception that interrupted sleep, causing the next
local_irq_enable() to block forever.

The next question is how does it get there... my idea at first was that
we get MSR_POW in SRR1 in that exception and put it back in with rfi
(and the CPU gets it that way instead of ignoring it). Sounds like a
lovely explanation if we also add that a sync or an mfmsr "clears" this
weird condition. However, I added clearing of MSR_POW in r9 in
EXCEPTION_PROLOG_2() and it didn't fix it (but maybe I did something
wrong, I was tired).

I can't see right now why your hack to the restore code seems to fix it
as well... it should only cause us to do dodgy things on every exception
return path.

I have to go to bed now, maybe somebody will have found more useful data
by the time I wakeup ;) In the meantime, adding an mfmsr at the end of
idle_6xx might do the trick. Paul, we should check if MSR_POW is
supposed to be mirrored in SRR1... if it is, we can simplify/optimize
the code in transfer_to_handler to not load HID0 all the time. Also, we
should merge some of your other cleanups of the restore from idle in all
cases.

Ben.
