Return-Path: <jolt@tuxbox.org>
Received: from fiebig.biz (loadbalancer1.core.taytron.net [80.190.249.152])
	by ozlabs.org (Postfix) with ESMTP id C149E68757
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 20:13:16 +1100 (EST)
Message-ID: <437C499C.6090002@tuxbox.org>
Date: Thu, 17 Nov 2005 10:13:00 +0100
From: Florian Schirmer <jolt@tuxbox.org>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20051114143821.GA28852@logos.cnet> <43798327.70305@tuxbox.org>
	<20051115054216.GB29963@logos.cnet>
	<20051115142147.GD32373@logos.cnet> <437B1C53.1060004@tuxbox.org>
	<20051116083609.GC4441@logos.cnet>
In-Reply-To: <20051116083609.GC4441@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: obi@saftware.de, carjay@gmx.de,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] m8xx_wdt: software watchdog reset/interrupt select
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

okay here is what the current driver does:

During startup it installs a timer irq (PIT) handler and sets the 
frequency to half of the watchdog timeout. As soon as this timer irq 
triggers we reset the watchdog inside the irq handler.

If a userspace handler takes over the watchdog we deinstall the timer 
irq handler and let the userspace daemon handle the watchdog resets.

Please not that we're talking about the timer irq, not the watchdog 
interrupt.

I don't see why it should make a difference wether the watchdog 
generates a IRQ0/HRESET or a system reset directly since it should never 
trigger anyway.

All the patch does is to use a kernel timer instead of the hardware 
timer. So i'm little confused.

And yes you should be right about the watchdog irq. It doesn't make 
sense to install a watchdog irq handler. It doesn't make any sense to 
put the watchdog into irq mode. As far as i know nobody ever tried to 
use that mode.

If you're bound to irq mode because the bootloader activates it the 
whole code should still work out of the box as long as the irq causes a 
system reset. But maybe i'm missing something obvious or the docs are 
incorrect/incomplete?

Best,
   Florian

> Anyway, the SWRI bit selects interrupt (0) or reset mode (1) for the watchdog.  
> 
> On reset mode no interrupt is sent to the kernel - the watchdog logic resets
> the system with HRESET.
> 
> So, the timer in m8xx_wdt is _required_ for reset mode.
> 
> Does that make sense?
> 
>> Otherwise i'm fine with the patch. Feel free to add my Signed-off-by line.
> 
> Ok, lets sort this out first. 
> 
> I wonder how interrupt mode is supposed to work, because the manual states
> that in interrupt mode (SWRI == 0) an NMI (IRQ0) is triggered, which jumps
> to 0x100 exception vector (SW reset).
> 
> Maybe I'm misunderstanding the interrupt mode?
> 
> Folks who wrote the patch claim it works on their 8xx's (as can be found
> on mailing list archives).
