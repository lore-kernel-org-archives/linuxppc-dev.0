Date: Fri, 25 Oct 2002 09:00:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PrPMC800 interrupt problem
Message-ID: <20021025160001.GB30713@opus.bloom.county>
References: <A347A662-E82C-11D6-A4F1-0003931C2BFA@control.lth.se> <A4463702-E830-11D6-A4F1-0003931C2BFA@control.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A4463702-E830-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 25, 2002 at 05:44:26PM +0200, Anders Blomdell wrote:
> >A very hacky solution to this is to modify 'prpmc800_init_IRQ' to:
> ><snip>
>
> A better solution is perhaps to change openpic_init from
>
> 	if (NumSources == 0)
> 		openpic_set_sources(0,
> 				    ((t & OPENPIC_FEATURE_LAST_SOURCE_MASK)
> 				    >>
> 				     OPENPIC_FEATURE_LAST_SOURCE_SHIFT) + 1,
> 				    NULL);
>
> to
>
> 	if (NumSources == 0) {
>   		int irqs;
> 	    irqs = ((t & OPENPIC_FEATURE_LAST_SOURCE_MASK) >>
> 				     OPENPIC_FEATURE_LAST_SOURCE_SHIFT) + 1;
> 	    if (irqs < OpenPIC_NumInitSenses) {
> 	      // Some internal interrupt is defined, init it's vector as well
> 		  irqs = OpenPIC_NumInitSenses;
>        }
> 		openpic_set_sources(0, irqs, NULL);
>     }
>
> Any insight is welcome! As far as I can see, open_pic.c does not handle
> timer, ipi, uart or any other internal interrupt sources (as they are not
> reported in the feature register).

What you're suggesting brings back the old hacking behavior.  Again I
say, look at what lopec_setup.c does for handling interrupts, look at
the manual for the prpmc800 (and the MPC107 (OpenPIC/EPIC related bits)
or MPC8240 (again, OpenPIC/EPIC)) manuals.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
