Date: Mon, 15 Apr 2002 08:46:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020415154615.GH10015@opus.bloom.county>
References: <15542.55726.605404.888541@argo.ozlabs.ibm.com> <0204121902.AA01888@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204121902.AA01888@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 12, 2002 at 12:02:19PM -0700, Michael Sokolov wrote:

> So perhaps we could get CONFIG_GENERIC_PPC32 into 2_4_devel just like this,
> I'll do the ELF section magic and address the serial concerns below, but
> without touching bi_recs at all for now?

Since pmac/chrp/prep haven't been ported over to CONFIG_GENERIC_PPC32
what are you planning on moving exactly?   You said the GT-64260 work
would be its own 'moral battle' and you don't 'own' K2 and Adirondack
anymore either remember...

> > One solution to the problem of the serial driver as a module is to
> > have the serial.o module have an empty rs_table (so it assumes no
> > ports when it loads),
>
> This is exactly what will happen in 2_4_alt if you build the serial driver as a
> module for CONFIG_GENERIC_PPC32.
>
> > and then have a ppc_serial module which does
> > whatever magic is needed to find out about the serial ports on the
> > system and calls register_serial for each one.
>
> How about making it prepchrp_serial instead?

If I'm reading this thread right, we would always need to do this since
we would always give the serial driver an empty table (and have a very
terse <asm/serial.h>.

> I would say that only a few
> systems would want that and it shouldn't be imposed on the rest of the PPC
> world. PMacs wouldn't need anything in rs_table at all, as they have no
> built-in NS16550 serial ports, the ISA serial port definitions currently given
> by <asm/serial.h> for CONFIG_ALL_PPC are for PReP and CHRP.

Again, if I'm following Paul correctly, <asm/serial.h> will just setup
the space for things and not have any definitions at all for the ports.

> And for all the
> systems I'm working with the point is moot as the serial driver must be
> compiled in for the console. So I think having the serial driver as a module
> and having it access hard-wired serial ports would be a very rare need, perhaps
> only for PRePs and CHRPs with video consoles. Therefore I would suggest having
> such a special module only for those rare cases where it's needed, and letting
> the rest not worry about supporting it.

I think what we can do is have the code which sets up the serial driver
work both when it's in a module and when it's compiled in.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
