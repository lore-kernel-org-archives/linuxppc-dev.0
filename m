Date: Mon, 15 Apr 02 11:08:31 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204151808.AA07971@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Since pmac/chrp/prep haven't been ported over to CONFIG_GENERIC_PPC32
> what are you planning on moving exactly?

I was planning to convert CHRP, PMac, and PReP to CONFIG_GENERIC_PPC32 in
2_4_alt (blindly as I have no hardware to test on, just make it compile), then
find some volunteers with the hardware to test the new 2_4_alt, and if it works
make a patch for Paulus.

> You said the GT-64260 work
> would be its own 'moral battle'

Mortal, not moral.

> and you don't 'own' K2 and Adirondack
> anymore either remember...

I'm not going to touch K2 outside of 2_4_alt. I would say Adirondack can be
moved to CONFIG_GENERIC_PPC32 as owned or not, the port currently in 2_4_devel
does not support any ROM other than StarMON anyway. But I really don't care,
I've got it in 2_4_alt to prove my generic config framework, and I couldn't
care less what happens to the SBS ports in the public tree as I have no loyalty
to them any more.

> If I'm reading this thread right, we would always need to do this since
> we would always give the serial driver an empty table (and have a very
> terse <asm/serial.h>.

We would only need a special ppc_serial module when the serial driver is a
module and the machine has hard-wired serial ports. This would be a rare case,
on most machines with hard-wired serial ports one of them is the console and
the serial driver must be compiled in. Those board ports will simply call
early_serial_setup() from <board>_arch_setup as I currently do in 2_4_alt.

> Again, if I'm following Paul correctly, <asm/serial.h> will just setup
> the space for things and not have any definitions at all for the ports.

Which is exactly what I have in 2_4_alt right now.

> I think what we can do is have the code which sets up the serial driver
> work both when it's in a module and when it's compiled in.

Yes, sort of. When you see the implementation you'll see what I mean.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
