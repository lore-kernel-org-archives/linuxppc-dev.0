Date: Fri, 16 Feb 2001 08:57:12 -0700
From: Matt Porter <mporter@mvista.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Matt Porter <mporter@mvista.com>,
	Stefano Coluccini <s.coluccini@caen.it>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME5100: kernel hangs in dcache_init
Message-ID: <20010216085712.C20336@beef.az.mvista.com>
References: <20010216044002.B8737@cx258813-a.chnd1.az.home.com> <Pine.HPX.4.10.10102161624210.3471-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10102161624210.3471-100000@gra-ux1.iram.es>; from paubert@iram.es on Fri, Feb 16, 2001 at 04:27:22PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 16, 2001 at 04:27:22PM +0100, Gabriel Paubert wrote:
>
>
> On Fri, 16 Feb 2001, Matt Porter wrote:
>
> >
> > On Fri, Feb 16, 2001 at 12:45:49PM +0100, Stefano Coluccini wrote:
> > >
> > > Hi everyone,
> > >
> > >   I'm trying to run Debian linux 2.2.18 on a MVME5100 board. I've done some
> > > change:
> > >  - changed addresses of UART registers in arch/ppc/boot/ns16550.h
> > >  - changed BAT settings in arch/ppc/mm/init.c to map IO region 0xf0000000 to
> > > 0xffffffff
> > > and some other things.
> > > Now the kernel hangs in the dcache_init routine in init/main.c and it seems
> > > to me that the problem is related to memory management, but I'm not sure.
> > > If I comment out the the routine calls from dcache_init to check_bugs(), the
> > > kernel go on a little showing me some infos about PCI devices.
> > >
> > > Anyone of you can help me ?
> >
> > Did you make sure it's getting the correct memory size?  Assuming you're
> > trying to port into the existing prep_* framework, it does use residual
> > data to determine memory size.  That used to be reasonable but the
> > newer MCG boards are not providing any useful information in
> > residual data, I'd imagine this is also the case with the 5100.  That's
> > why the new MCG ports in the development tree no longer rely on residual
> > data.
>
> Don't tell me that the residual data can no moree be used even for this !
> So ok, residual data is 100% useless and should be thrown away. At least I
> expected this kind of basic information to be available.
>
> At this point, let us get rid of PPCBUG and flash our firmware !

:)

I've taken the approach that PPCBUG is just a glorified tool to load
a linear array of bits into memory and light them up. :)

One personal project of mine is to pull all of the MCG board support
out of prep_*.c into it's own option.  The major reason is that they
are nearly unmaintainable with all the hacks in there.

You might want to see the MCPN765 and PrPMC750 ports that are in
in the 2_5 tree.  They're examples of what I'm working on with the
2300/2400/2600/2700/3600/4600, MTX variants, and MCP(N)750.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
