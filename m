Date: Fri, 12 Apr 02 12:02:19 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204121902.AA01888@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras <paulus@samba.org> wrote:

> > So how about pushing it into 2_4_devel?
>
> When I'm happy with the implementation, sure.

OK, so let's review that's left to be done in order to get there: eliminate the
per-machine lines from setup.c and replace them with ELF section magic, settle
the bi_recs issue, and serial stuff. Did I miss anything else?

Now the extra bi_recs I've added in 2_4_alt are currently only used by my
GT-64260 stuff, which I see will take its own mortal battle, and just the
CONFIG_GENERIC_PPC32 framework without the GT-64260 stuff can do without them.
So perhaps we could get CONFIG_GENERIC_PPC32 into 2_4_devel just like this,
I'll do the ELF section magic and address the serial concerns below, but
without touching bi_recs at all for now?

> I think there are two tenable positions: the first is to have very
> simple bi_recs, i.e. basically what we have at the moment, that convey
> a small number of global pieces of information about the system.

This is what I prefer.

> If
> we really need to convey information about individual devices then I
> think we want something approaching the OF device tree, which is a
> flexible and extensible structure that conveys arbitrary information
> about the devices and their relationships very well.

Well, since you like OF and you are the Linux/PPC dictator, I think the path of
least resistance to getting HEC machines supported by Linux/PPC would be for me
to construct a real OF device tree and pass it to Linux. Now it would be a lot
easier for me to just pass you a static tree rather than pass you a "PROM"
pointer in R5 for you to call to construct it. Would you accept a patch that
allows the entire OF device tree to be passed to the kernel in a single bi_rec?
I'm not going to rip out the prom_init code, I'll just make it skip over that
if the device tree has been passed in a bi_rec, effectively giving the user two
ways to get the OF device tree. Would that be acceptable for 2_4_devel?

And where can I find a spec for the OF device tree and a few examples?

> One solution to the problem of the serial driver as a module is to
> have the serial.o module have an empty rs_table (so it assumes no
> ports when it loads),

This is exactly what will happen in 2_4_alt if you build the serial driver as a
module for CONFIG_GENERIC_PPC32.

> and then have a ppc_serial module which does
> whatever magic is needed to find out about the serial ports on the
> system and calls register_serial for each one.

How about making it prepchrp_serial instead? I would say that only a few
systems would want that and it shouldn't be imposed on the rest of the PPC
world. PMacs wouldn't need anything in rs_table at all, as they have no
built-in NS16550 serial ports, the ISA serial port definitions currently given
by <asm/serial.h> for CONFIG_ALL_PPC are for PReP and CHRP. And for all the
systems I'm working with the point is moot as the serial driver must be
compiled in for the console. So I think having the serial driver as a module
and having it access hard-wired serial ports would be a very rare need, perhaps
only for PRePs and CHRPs with video consoles. Therefore I would suggest having
such a special module only for those rare cases where it's needed, and letting
the rest not worry about supporting it.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
