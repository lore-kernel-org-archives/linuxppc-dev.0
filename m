Date: Mon, 14 Oct 2002 07:37:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with linuxppc_2_4_devel
Message-ID: <20021014143718.GD695@opus.bloom.county>
References: <16403444-DC64-11D6-99DE-0003931C2BFA@control.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16403444-DC64-11D6-99DE-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 10, 2002 at 05:22:28PM +0200, Anders Blomdell wrote:

> I'm still unsuccessful with running linux on my prpmc800 card (and my 2600
> card as well)
>
> 1. The 2600 does its thing up to the
>      Uncompressing Linux...done.
>      Now booting the kernel
>    point, then it changes the console speed to some (yet) undetermined
> value, how
>    do I change that?

What are you running it in the firmware?  It defaults to 9600 8n1,
unless you pass it another speed (console=ttyS0,38400 for example).

> 2. The prpmc800 is just quiet (and unresponsive) after
>      Network Boot File load in progress... To abort hit <BREAK>
>
>      Bytes Received =&694852, Bytes Loaded =&694852
>      Bytes/Second   =&694852, Elapsed Time =1 Second(s)
>
>      Residual-Data Located at: $07EBE4FC
>
> Anybody that has a clue (or a working .config to share?)

make prpmc800_config

And then fixup
arch/ppc/platforms/prpmc800_setup.c::prpmc800_openpic_initsenses
(iirc, '1' -> IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE.  But grab the
prpmc800 manual and update the IRQ table occordingly) and submit a
patch.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
