Date: Mon, 22 Dec 2003 09:10:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Lee Braiden <jel@ntlworld.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20031222161042.GB10841@stop.crashing.org>
References: <1071642293.753.414.camel@gaston> <200312170717.36564.jel@ntlworld.com> <1071646057.6370.482.camel@gaston> <20031217095139.GC2283@iliana> <20031217164740.GR11761@stop.crashing.org> <20031217165608.GA11653@iliana> <20031217170620.GS11761@stop.crashing.org> <20031219114050.GA5650@iliana> <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031222134504.GA5964@iliana>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 22, 2003 at 02:45:04PM +0100, Sven Luther wrote:

> On Fri, Dec 19, 2003 at 09:28:00AM -0700, Tom Rini wrote:
> >
> > On Fri, Dec 19, 2003 at 12:40:50PM +0100, Sven Luther wrote:
> > > On Wed, Dec 17, 2003 at 10:06:20AM -0700, Tom Rini wrote:
> > > >
> > > > On Wed, Dec 17, 2003 at 05:56:08PM +0100, Sven Luther wrote:
> > > > >
> > > > > On Wed, Dec 17, 2003 at 09:47:40AM -0700, Tom Rini wrote:
> > > > > > 4) Use CONFIG_GEN_RTC and be happy.  What _might_ be happening right now
> > > > > > is that chrp_get_rtc_time is 'funky' and not quite right for anything
> > > > > > other than an IBM OpenFirmeware'd CHRP box.  What I would suggest is
> > > > > > looking at include/asm-generic/rtc.h in 2.6 and moving much of that code
> > > > > > into 'chrp_get_rtc_time' and 'chrp_set_rtc_time'.
> > > > >
> > > > > Ok, thanks, i will look into it.
> > > > >
> > > > > But then, remember, this is for the debian powerpc kernel, and has to be
> > > > > 2.4.x still for now.
> > > >
> > > > Yes.  The code in <asm-generic/rtc.h> is taken right from
> > > > drivers/char/rtc.c.  It just didn't get sent to 2.4 for some reason.
> > >
> > > Ok, found the code, altough drivers/char/rtc.c doesn't seem to have a
> > > set_rtc_time function.
> >
> > Nope, that's why I suggested 2.6's <asm-generic/rtc.h> :)
>
> Ok.
>
> > > BTW, what exactly should i do in 'chrp_get_rtc_time' and
> > > 'chrp_set_rtc_time' ? Just replace the existing code, or make a new
> > > function, and set it depending on machine type who needs it in
> > > chrp_setup.c ? I already do that for the pegasos irq stuff. I just would
> > > have to set ppc_md.set_rtc_time accordyingly.
> >
> > My preferance would be to replace, and then see if it breaks some other
> > chrp machines (it really shouldn't).
>
> Ok, fine, altough i don't have an idea about the other chrp machine
> types out there. From what i know from Geert, generic RTC is already not working
> for its box anyway.
>
> > Something that just dawned on me again (sorry) is that I've really really
> > intended to try and kill both prep_time.c and chrp_time.c (since both of
> > those machine subtypes have PC-style RTC chips) and make them use
> > todc_time.c (see arch/ppc/kernel/todc_time.c).  I've got patches to do
> > half of this, against 2.6 (which was a trivial forward port of older
> > 2.4-based patches I had, there is nothing 2.6-specific about these
> > patches).  You would want to look at:
> > 006-redo_inb_inw_inl_outb_outw_outl.patch
> > 007-make_out_8_and_friends_synchronous.patch
> > 008-todc_warning.patch
> > 009-prep_time_death-GNU.patch
> > from http://stop.crashing.org:16080/~trini/
>
> Mmm, i am somewhat confused now on what to do.
>
> If i understood things tight, you either want to :
>
>   1) replace ppc.md chrp time stuff with similar code than what
>   asm-generic/rtc.h is doing.
>
>   2) use todc.h for all of prep/chrp.
>
> In the first case, i guess that is easy, and may break some chrp boxes
> not using a compatible clock, which may or may not exist.
>
> In the second case, well, the todc code makes use of nvram_write, which
> unless i am wrong, is not defined on chrp. the RTC code uses CMOS_WRITE,
> so maybe i should define a chrp_write wrapping this one.
>
> Also, the todc code knows about many RTC chips, among them, the MC146818
> seems to be the one used by the rtc.h stuff, and seems to be a generic
> legacy RTC chip or something. he one i have, builtin the VIA VT8231
> southbridge is said to be called VT82887, altough i have no docs of
> those, but the header files found in 2.6 concord. But i seem to have
> some additional DATE_ALARM, MONTH_ALARM and CENTURY_FIELD registers not
> found int the MC146818 header file.

I appologize since I ramble a bit too much.  For 2.4, the best fix is
(1) above.  For 2.6 however, it should be possible to remove chrp_time.c
and use todc_time.c instead (it is self-contained, wrt nvram read/write,
iirc) and do some sub-casing to pick the right RTC chip code to use.
For example on PReP we still case between the two different chips, and
just call todc_init (iirc) with a different param.  Or something along
those lines.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
