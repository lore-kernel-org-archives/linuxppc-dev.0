Message-ID: <3B783AD3.9F94B06C@mvista.com>
Date: Mon, 13 Aug 2001 13:38:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Andrew Johnson <anj@aps.anl.gov>
Cc: Matt Porter <mporter@mvista.com>, Dan Malek <dan@mvista.com>,
	James F Dougherty <jfd@GigabitNetworks.COM>,
	linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
	jfd@cs.stanford.edu
Subject: Re: MPC8240 EPIC Driver (Attached)
References: <200108110718.AAA01730@krakatoa.gigabitnetworks.com> <3B75C40B.8BCDDD2B@mvista.com> <3B77F899.5964F88F@aps.anl.gov> <20010813055451.A22232@cx258813-a.chnd1.az.home.com> <3B7815BC.8F2F180C@mvista.com> <3B7830D8.3D9E4C45@aps.anl.gov>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andrew Johnson wrote:

> "Mark A. Greer" wrote:
> >
> > The changes to the openpic code for supporting serial interrupt mode are very minor.
>
> Actually IIRC they're already present in the version shipped with
> HHL-2.0.  I don't remember making any changes for that at all on the
> MVME2100 support, but my memory has been known to be faulty.

Well, there is no _explicit_ support for serial mode but there was an 'if' stmt added that
adjusts NumSources if it is less than OpenPIC_NumInitSenses.  That let's you proceed with
an initsenses with more irq's than the pic tells you it has.  Its not a complete, long-term
solution.

Also, I'm trying to keep this discussion relative to 2_4_devel not hhlx.x

> > What I mean is a table where you specify the irq, the offset fo the regs from the base
> > address, the sensitivity, and the polarity all separately.  Also the appropriate
> > extensions to support serial interrupt mode (e.g., MVME2100 uses that).  With a table
> > format something like that, you can avoid the sparse and negative irq's on the
> > 8240/107 and still keep things pretty clean looking.
>
> That sounds right.  It could also use the NIRQ field of the Feature
> Reporting Register to cross-check that the table given is the correct size
> for the chip it's controlling, and have some way of specifying the
> presence or absensce of a cascaded i8259 (presumably with its own table).

The NIRQ field is a part of the problem in serial mode.  You can have 16 lines hooked up in
serial mode and the NIRQ still tells you that there should only be 5, IIRC.

The table changes are intended to solve more than just epic serial mode.  They're intended
to make explicit--and flexible--all the assumptions that are currently buried in the
initsenses table (irq #, the offset of corresponding reg in pic, sensifivity and
polarity).  These aren't extensive changes, I should just do them, post a patch for review
& shut up...  :)

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
