Message-ID: <3B7815BC.8F2F180C@mvista.com>
Date: Mon, 13 Aug 2001 11:00:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
Cc: Andrew Johnson <anj@aps.anl.gov>, Dan Malek <dan@mvista.com>,
	James F Dougherty <jfd@GigabitNetworks.COM>,
	linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
	jfd@cs.stanford.edu
Subject: Re: MPC8240 EPIC Driver (Attached)
References: <200108110718.AAA01730@krakatoa.gigabitnetworks.com> <3B75C40B.8BCDDD2B@mvista.com> <3B77F899.5964F88F@aps.anl.gov> <20010813055451.A22232@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

> On Mon, Aug 13, 2001 at 10:56:09AM -0500, Andrew Johnson wrote:

> > Then there's the problem of accessing the 8240's interrupts for I2C, 2 DMA
> > channels and Message Unit, which are highly dis-contiguous with the other
> > interrupts; these would appear at IRQs 129, 130, 131 and 134 in the
> > current scheme (needing a rather large and sparse interrupt senses
> > table).  Oh, and the 4 Global timer interrupts would have to appear at
> > negative IRQ numbers, so it's a good thing Linux doesn't need to use
> > these.
> >
> > I haven't looked at James' code, but the OpenPIC stuff certainly does need
> > some changes to be truly universal.
>
> There's a hack in the OpenPIC code for HHL 2.0 to allow for some of
> the above situations.  The hack was rejected in the public tree in
> favor of a not yet implemented clean way to handle this stuff.
>
> If somebody has time to abstract the OpenPIC code for EPIC correctly,
> it will get in the tree.

Yes, there should be better support for 8240/107 interrupt ctlrs in the openpic code.
However, as long as they are used in direct interrupt mode, the openpic code will work
as is for the most part (except for the negative irq's :).  Note that to use the
openpic_init()/initsenses table as it is, you need to skip the first 16 irq's no
matter what (i.e., even if you don't have an 8259).  DO NOT set the offset to anything
but 0 in the openpic_init() call.

The changes to the openpic code for supporting serial interrupt mode are very minor.

I sent out an email many moons ago about expanding the "initsenses" table but I never
really had to time to follow thru on it...I should have.  I still think that's the way
to go.

What I mean is a table where you specify the irq, the offset fo the regs from the base
address, the sensitivity, and the polarity all separately.  Also the appropriate
extensions to support serial interrupt mode (e.g., MVME2100 uses that).  With a table
format something like that, you can avoid the sparse and negative irq's on the
8240/107 and still keep things pretty clean looking.

Anyway, someone needs to take the time to do it...

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
