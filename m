Date: Fri, 25 Oct 2002 09:04:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PrPMC800 interrupt problem
Message-ID: <20021025160433.GC30713@opus.bloom.county>
References: <20021025154020.GA30713@opus.bloom.county> <805E3F14-E831-11D6-A4F1-0003931C2BFA@control.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <805E3F14-E831-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 25, 2002 at 05:50:35PM +0200, Anders Blomdell wrote:
>
> On fredag, oktober 25, 2002, at 05:40 , Tom Rini wrote:
>
> >On Fri, Oct 25, 2002 at 05:15:46PM +0200, Anders Blomdell wrote:
> >
> >>The problem seems to be that the UART generates an Harrier internal
> >>interrupt. This should be handled as any other MPIC interrupt, but it isn'
> >>t. This lack of an appropriate handler (irq_desc[16].handler == 0) makes
> >>the Harrier chip wait forever for an EOI.
> >>
> >>A very hacky solution to this is to modify 'prpmc800_init_IRQ' to:
> >
> >Did you update the initsenses table as well?  And are you sure you are
> >calling openpic_set_sources() correctly?  That only maps OpenPIC source
> >16 to be Linux interrupt 16, and doesn't catch any of the other sources
> >('tho I don't have the prpmc800 manual in front of me)
> The initsenses table was correct already, but open_pic.c relies on the
> number of interrupt sources returned from the feature reporting register,
> that excludes the internal sources (in Harrier, Hawk and Raven chips at
> least). Thus these interrupts are not correctly setup. I posted a possible
> (==untested) solution a few minutes ago.

If they are correct, change them from '1' / '0' to IRQ_SENSE_LEVEL |
IRQ_POLARITY_NEGATIVE.  I think the problem is that you are not calling
openpic_set_sources(...) correctly, or enough times.  openpic_init() can
only be called without calling openpic_set_sources() if the default call
in openpic_init() will work correctly, as is.

> BTW: Is there any documentation on the OpenPIC controllers, the AMD link
> seems to have disappeared.

The MPC107 manual or the MPC8240 manual, iirc.

>
> Regards
>
> Anders Blomdell

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
