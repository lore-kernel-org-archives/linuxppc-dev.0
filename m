Date: Fri, 25 Oct 2002 17:44:26 +0200
Subject: Re: PrPMC800 interrupt problem
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
To: Tom Rini <trini@kernel.crashing.org>
From: Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <A347A662-E82C-11D6-A4F1-0003931C2BFA@control.lth.se>
Message-Id: <A4463702-E830-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> A very hacky solution to this is to modify 'prpmc800_init_IRQ' to:
> <snip>

A better solution is perhaps to change openpic_init from

	if (NumSources == 0)
		openpic_set_sources(0,
				    ((t & OPENPIC_FEATURE_LAST_SOURCE_MASK) >>
				     OPENPIC_FEATURE_LAST_SOURCE_SHIFT) + 1,
				    NULL);

to

	if (NumSources == 0) {
   		int irqs;
	    irqs = ((t & OPENPIC_FEATURE_LAST_SOURCE_MASK) >>
				     OPENPIC_FEATURE_LAST_SOURCE_SHIFT) + 1;
	    if (irqs < OpenPIC_NumInitSenses) {
	      // Some internal interrupt is defined, init it's vector as well
		  irqs = OpenPIC_NumInitSenses;
        }
		openpic_set_sources(0, irqs, NULL);
     }

Any insight is welcome! As far as I can see, open_pic.c does not handle
timer, ipi, uart or any other internal interrupt sources (as they are not
reported in the feature register).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
