Date: Fri, 16 Feb 2001 16:27:22 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mporter@mvista.com>
Cc: Stefano Coluccini <s.coluccini@caen.it>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME5100: kernel hangs in dcache_init
In-Reply-To: <20010216044002.B8737@cx258813-a.chnd1.az.home.com>
Message-ID: <Pine.HPX.4.10.10102161624210.3471-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 16 Feb 2001, Matt Porter wrote:

>
> On Fri, Feb 16, 2001 at 12:45:49PM +0100, Stefano Coluccini wrote:
> >
> > Hi everyone,
> >
> >   I'm trying to run Debian linux 2.2.18 on a MVME5100 board. I've done some
> > change:
> >  - changed addresses of UART registers in arch/ppc/boot/ns16550.h
> >  - changed BAT settings in arch/ppc/mm/init.c to map IO region 0xf0000000 to
> > 0xffffffff
> > and some other things.
> > Now the kernel hangs in the dcache_init routine in init/main.c and it seems
> > to me that the problem is related to memory management, but I'm not sure.
> > If I comment out the the routine calls from dcache_init to check_bugs(), the
> > kernel go on a little showing me some infos about PCI devices.
> >
> > Anyone of you can help me ?
>
> Did you make sure it's getting the correct memory size?  Assuming you're
> trying to port into the existing prep_* framework, it does use residual
> data to determine memory size.  That used to be reasonable but the
> newer MCG boards are not providing any useful information in
> residual data, I'd imagine this is also the case with the 5100.  That's
> why the new MCG ports in the development tree no longer rely on residual
> data.

Don't tell me that the residual data can no moree be used even for this !
So ok, residual data is 100% useless and should be thrown away. At least I
expected this kind of basic information to be available.

At this point, let us get rid of PPCBUG and flash our firmware !

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
