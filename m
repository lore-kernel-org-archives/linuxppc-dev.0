Date: Mon, 15 Apr 2002 12:54:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020415195422.GA22996@opus.bloom.county>
References: <20020415154615.GH10015@opus.bloom.county> <0204151808.AA07971@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204151808.AA07971@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 15, 2002 at 11:08:31AM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Since pmac/chrp/prep haven't been ported over to CONFIG_GENERIC_PPC32
> > what are you planning on moving exactly?
>
> I was planning to convert CHRP, PMac, and PReP to CONFIG_GENERIC_PPC32 in
> 2_4_alt (blindly as I have no hardware to test on, just make it compile), then
> find some volunteers with the hardware to test the new 2_4_alt, and if it works
> make a patch for Paulus.

Why not let Ben do it in 2.5 like he said?

> > You said the GT-64260 work
> > would be its own 'moral battle'
>
> Mortal, not moral.

Sorry, not yet awake enough I guess.

Yes, and serial as a module doesn't quite work on GENERIC32 either. :)

> > I think what we can do is have the code which sets up the serial driver
> > work both when it's in a module and when it's compiled in.
>
> Yes, sort of. When you see the implementation you'll see what I mean.

No 'sort-of' about it.  x_init() calls x_serial_init and sets
ppc_md.serial_fixups to x_serial_init.  x_serial_init takes care of
early_serial_setup() and early_init or so calls ppc_md.serial_fixups (if
existant).  'ppc_serial' (built if SERIAL=m) just calls
ppc_md.serial_fixups (or setup, or whatever).

Or we do it even more generic than that so that we can add in a hook for
all ports to use for using serial as a module & early_serial_setup.
(arch_serial_init or somrething?)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
