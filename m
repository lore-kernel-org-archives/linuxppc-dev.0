Date: Mon, 13 Aug 2001 05:54:52 -0700
From: Matt Porter <mporter@mvista.com>
To: Andrew Johnson <anj@aps.anl.gov>
Cc: Dan Malek <dan@mvista.com>,
	James F Dougherty <jfd@GigabitNetworks.COM>,
	linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
	jfd@cs.stanford.edu
Subject: Re: MPC8240 EPIC Driver (Attached)
Message-ID: <20010813055451.A22232@cx258813-a.chnd1.az.home.com>
References: <200108110718.AAA01730@krakatoa.gigabitnetworks.com> <3B75C40B.8BCDDD2B@mvista.com> <3B77F899.5964F88F@aps.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B77F899.5964F88F@aps.anl.gov>; from anj@aps.anl.gov on Mon, Aug 13, 2001 at 10:56:09AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Aug 13, 2001 at 10:56:09AM -0500, Andrew Johnson wrote:
>
> Dan Malek wrote:
> >
> > James F Dougherty wrote:
> > >
> > > A while ago, I posted some questions on getting the OpenPIC driver working
> > > correctly for the EPIC (Embedded Programmable Interrupt Controller) internal
> > > to the MPC8240. After several attempts on open_pic.*, I gave up, and ported a
> > > an existing driver.
> >
> > Ummm, I'm confused.  The existing PowerPC OpenPIC works just fine with
> > the 8240/8245/MPC107 EPICs, at least on the Sandpoint.
>
> Not quite - the Sandpoint has an i8259 as well, and the OpenPic code as
> shipped with HHL-2.0 assumes that there is one present (at least you have
> to link in the i8259 code, although you can arrange that it is never
> called).  Not all 8240 systems have an 8259 such as the MVME2100, and I
> had to #if out some stuff from OpenPic.c to be able to omit the i8259.
>
> Then there's the problem of accessing the 8240's interrupts for I2C, 2 DMA
> channels and Message Unit, which are highly dis-contiguous with the other
> interrupts; these would appear at IRQs 129, 130, 131 and 134 in the
> current scheme (needing a rather large and sparse interrupt senses
> table).  Oh, and the 4 Global timer interrupts would have to appear at
> negative IRQ numbers, so it's a good thing Linux doesn't need to use
> these.
>
> I haven't looked at James' code, but the OpenPIC stuff certainly does need
> some changes to be truly universal.

There's a hack in the OpenPIC code for HHL 2.0 to allow for some of
the above situations.  The hack was rejected in the public tree in
favor of a not yet implemented clean way to handle this stuff.

If somebody has time to abstract the OpenPIC code for EPIC correctly,
it will get in the tree.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
