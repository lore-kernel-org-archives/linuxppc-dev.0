Message-ID: <3B784B06.48962C88@mvista.com>
Date: Mon, 13 Aug 2001 14:47:50 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Andrew Johnson <anj@aps.anl.gov>
Cc: Matt Porter <mporter@mvista.com>, Dan Malek <dan@mvista.com>,
	James F Dougherty <jfd@GigabitNetworks.COM>,
	linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
	jfd@cs.stanford.edu
Subject: Re: MPC8240 EPIC Driver (Attached)
References: <200108110718.AAA01730@krakatoa.gigabitnetworks.com> <3B75C40B.8BCDDD2B@mvista.com> <3B77F899.5964F88F@aps.anl.gov> <20010813055451.A22232@cx258813-a.chnd1.az.home.com> <3B7815BC.8F2F180C@mvista.com> <3B7830D8.3D9E4C45@aps.anl.gov> <3B783AD3.9F94B06C@mvista.com> <3B78470B.6017A2D1@aps.anl.gov>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andrew Johnson wrote:

> "Mark A. Greer" wrote:
> >
> > Well, there is no _explicit_ support for serial mode but there was an 'if' stmt added that
> > adjusts NumSources if it is less than OpenPIC_NumInitSenses.  That let's you proceed with
> > an initsenses with more irq's than the pic tells you it has.  Its not a complete, long-term
> > solution.
>
> There was something present that switches the chip between serial and
> discrete mode.  Other than that and the actual location of the config
> registers for each IRQ I don't think there's anything more needed to
> distinguish the two in software.

That is correct in the code that I gave you.  Those particular pieces were not put in official
hhl2.0

>
> > The NIRQ field is a part of the problem in serial mode.  You can have 16 lines hooked up in
> > serial mode and the NIRQ still tells you that there should only be 5, IIRC.
>
> Actually it doesn't tell you that at all - from the EPIC documentation in
> the 8240 manual, NIRQ provides the (fixed) maximum number of interrupt
> sources supported by the EPIC.  On the 8240 the NIRQ value is 0x17=23
> which corresponds to 24 interrupt sources (NIRQ=0 means 1 source),

> comprising 16 serial IRQs, 4 timers, I2C, 2*DMA channels and the Mesage
> Unit.

All of this is correct, the problem is you have to put in 16 dummy entries at the beginning of
initsenses to get the registers to line up correctly.  When you add 16 serial external inputs to
the 16 dummies you end up with more than what NIRQ allows.

We're wasting bandwidth here, the real problem is that the current openpic_init interface isn't
quite flexible enough to suit the epic in anything but a vanilla, direct mode, external IRQ-only
set up.  That interface should be extended.

Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
