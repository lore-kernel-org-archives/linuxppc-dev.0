Message-ID: <3B78470B.6017A2D1@aps.anl.gov>
Date: Mon, 13 Aug 2001 16:30:51 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Matt Porter <mporter@mvista.com>, Dan Malek <dan@mvista.com>,
	James F Dougherty <jfd@GigabitNetworks.COM>,
	linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
	jfd@cs.stanford.edu
Subject: Re: MPC8240 EPIC Driver (Attached)
References: <200108110718.AAA01730@krakatoa.gigabitnetworks.com> <3B75C40B.8BCDDD2B@mvista.com> <3B77F899.5964F88F@aps.anl.gov> <20010813055451.A22232@cx258813-a.chnd1.az.home.com> <3B7815BC.8F2F180C@mvista.com> <3B7830D8.3D9E4C45@aps.anl.gov> <3B783AD3.9F94B06C@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark A. Greer" wrote:
>
> Well, there is no _explicit_ support for serial mode but there was an 'if' stmt added that
> adjusts NumSources if it is less than OpenPIC_NumInitSenses.  That let's you proceed with
> an initsenses with more irq's than the pic tells you it has.  Its not a complete, long-term
> solution.

There was something present that switches the chip between serial and
discrete mode.  Other than that and the actual location of the config
registers for each IRQ I don't think there's anything more needed to
distinguish the two in software.

> Also, I'm trying to keep this discussion relative to 2_4_devel not hhlx.x

I'm only comparing to that as I'm not actively following 2_4_devel and
assume that those who need to know can relate hhl2.0 to some point in the
2_4_devel tree.

> The NIRQ field is a part of the problem in serial mode.  You can have 16 lines hooked up in
> serial mode and the NIRQ still tells you that there should only be 5, IIRC.

Actually it doesn't tell you that at all - from the EPIC documentation in
the 8240 manual, NIRQ provides the (fixed) maximum number of interrupt
sources supported by the EPIC.  On the 8240 the NIRQ value is 0x17=23
which corresponds to 24 interrupt sources (NIRQ=0 means 1 source),
comprising 16 serial IRQs, 4 timers, I2C, 2*DMA channels and the Mesage
Unit.  Nothing tells you where to find the config registers for those IRQs
though, hence the problems we're discussing.  The offset to the first
Serial or Direct IRQ config register is not accounted for in the NIRQ
number; it's only by chance that a discrete-mode EPIC works with the
OpenPic driver (check for off-by-1 errors BTW, see the above definition
for NIRQ).

> The table changes are intended to solve more than just epic serial mode.  They're intended
> to make explicit--and flexible--all the assumptions that are currently buried in the
> initsenses table (irq #, the offset of corresponding reg in pic, sensifivity and
> polarity).

As I understood, and I encourage you to implement them.  It looks like the
NIRQ check would have to be a maximum test only though, warn if the table
contains more than NIRQ-1 entries.

- Andrew
--
The world is such a cheerful place when viewed from upside-down
It makes a rise of every fall, a smile of every frown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
