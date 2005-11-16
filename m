Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ECF5868713
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 00:50:00 +1100 (EST)
Date: Wed, 16 Nov 2005 06:36:09 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Florian Schirmer <jolt@tuxbox.org>
Message-ID: <20051116083609.GC4441@logos.cnet>
References: <20051114143821.GA28852@logos.cnet> <43798327.70305@tuxbox.org>
	<20051115054216.GB29963@logos.cnet>
	<20051115142147.GD32373@logos.cnet> <437B1C53.1060004@tuxbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437B1C53.1060004@tuxbox.org>
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

On Wed, Nov 16, 2005 at 12:47:31PM +0100, Florian Schirmer wrote:
> Hi,
> 
> >>The SYPCR register can be set only _once_ at machine startup and the
> >>bootloader in question does not have an option to change the mode. Many
> >>bootloaders probably dont.
> 
> Okay, i was asuming you have control over the bootloader.
> 
> >Updated patch addresses code duplication issue you mentioned and also 
> >adds an error message in case timer interrupt frequency is higher
> >than the watchdog frequency.
> >
> >Can I add your Signed-off-by in case you're OK with it?
> 
> Maybe i'm missing something obvious, but why is the interrupt driven 
> reaming code not working for your configuration. Are you using the PIT 
> for something else?

Nope.

Anyway, the SWRI bit selects interrupt (0) or reset mode (1) for the watchdog.  

On reset mode no interrupt is sent to the kernel - the watchdog logic resets
the system with HRESET.

So, the timer in m8xx_wdt is _required_ for reset mode.

Does that make sense?

> Otherwise i'm fine with the patch. Feel free to add my Signed-off-by line.

Ok, lets sort this out first. 

I wonder how interrupt mode is supposed to work, because the manual states
that in interrupt mode (SWRI == 0) an NMI (IRQ0) is triggered, which jumps
to 0x100 exception vector (SW reset).

Maybe I'm misunderstanding the interrupt mode?

Folks who wrote the patch claim it works on their 8xx's (as can be found
on mailing list archives).
