Date: Fri, 25 Oct 2002 08:40:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PrPMC800 interrupt problem
Message-ID: <20021025154020.GA30713@opus.bloom.county>
References: <20021024172642.GL669@opus.bloom.county> <A347A662-E82C-11D6-A4F1-0003931C2BFA@control.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A347A662-E82C-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 25, 2002 at 05:15:46PM +0200, Anders Blomdell wrote:

> The problem seems to be that the UART generates an Harrier internal
> interrupt. This should be handled as any other MPIC interrupt, but it isn'
> t. This lack of an appropriate handler (irq_desc[16].handler == 0) makes
> the Harrier chip wait forever for an EOI.
>
> A very hacky solution to this is to modify 'prpmc800_init_IRQ' to:

Did you update the initsenses table as well?  And are you sure you are
calling openpic_set_sources() correctly?  That only maps OpenPIC source
16 to be Linux interrupt 16, and doesn't catch any of the other sources
('tho I don't have the prpmc800 manual in front of me)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
