Date: Fri, 19 Dec 2003 09:28:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Lee Braiden <jel@ntlworld.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20031219162800.GE29266@stop.crashing.org>
References: <20031216105656.GA5291@iliana> <1071642293.753.414.camel@gaston> <200312170717.36564.jel@ntlworld.com> <1071646057.6370.482.camel@gaston> <20031217095139.GC2283@iliana> <20031217164740.GR11761@stop.crashing.org> <20031217165608.GA11653@iliana> <20031217170620.GS11761@stop.crashing.org> <20031219114050.GA5650@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031219114050.GA5650@iliana>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Dec 19, 2003 at 12:40:50PM +0100, Sven Luther wrote:
> On Wed, Dec 17, 2003 at 10:06:20AM -0700, Tom Rini wrote:
> >
> > On Wed, Dec 17, 2003 at 05:56:08PM +0100, Sven Luther wrote:
> > >
> > > On Wed, Dec 17, 2003 at 09:47:40AM -0700, Tom Rini wrote:
> > > > 4) Use CONFIG_GEN_RTC and be happy.  What _might_ be happening right now
> > > > is that chrp_get_rtc_time is 'funky' and not quite right for anything
> > > > other than an IBM OpenFirmeware'd CHRP box.  What I would suggest is
> > > > looking at include/asm-generic/rtc.h in 2.6 and moving much of that code
> > > > into 'chrp_get_rtc_time' and 'chrp_set_rtc_time'.
> > >
> > > Ok, thanks, i will look into it.
> > >
> > > But then, remember, this is for the debian powerpc kernel, and has to be
> > > 2.4.x still for now.
> >
> > Yes.  The code in <asm-generic/rtc.h> is taken right from
> > drivers/char/rtc.c.  It just didn't get sent to 2.4 for some reason.
>
> Ok, found the code, altough drivers/char/rtc.c doesn't seem to have a
> set_rtc_time function.

Nope, that's why I suggested 2.6's <asm-generic/rtc.h> :)

> BTW, what exactly should i do in 'chrp_get_rtc_time' and
> 'chrp_set_rtc_time' ? Just replace the existing code, or make a new
> function, and set it depending on machine type who needs it in
> chrp_setup.c ? I already do that for the pegasos irq stuff. I just would
> have to set ppc_md.set_rtc_time accordyingly.

My preferance would be to replace, and then see if it breaks some other
chrp machines (it really shouldn't).

Something that just dawned on me again (sorry) is that I've really really
intended to try and kill both prep_time.c and chrp_time.c (since both of
those machine subtypes have PC-style RTC chips) and make them use
todc_time.c (see arch/ppc/kernel/todc_time.c).  I've got patches to do
half of this, against 2.6 (which was a trivial forward port of older
2.4-based patches I had, there is nothing 2.6-specific about these
patches).  You would want to look at:
006-redo_inb_inw_inl_outb_outw_outl.patch
007-make_out_8_and_friends_synchronous.patch
008-todc_warning.patch
009-prep_time_death-GNU.patch
from http://stop.crashing.org:16080/~trini/

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
