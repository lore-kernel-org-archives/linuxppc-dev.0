Date: Wed, 7 Jan 2004 07:54:58 +0100
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Lee Braiden <jel@ntlworld.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20040107065458.GA20228@iliana>
References: <20031217095139.GC2283@iliana> <20031217164740.GR11761@stop.crashing.org> <20031217165608.GA11653@iliana> <20031217170620.GS11761@stop.crashing.org> <20031219114050.GA5650@iliana> <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana> <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20031222163315.GC10841@stop.crashing.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 22, 2003 at 09:33:15AM -0700, Tom Rini wrote:
>
> On Mon, Dec 22, 2003 at 05:26:01PM +0100, Sven Luther wrote:
>
> > On Mon, Dec 22, 2003 at 09:10:42AM -0700, Tom Rini wrote:
> > > > Also, the todc code knows about many RTC chips, among them, the MC146818
> > > > seems to be the one used by the rtc.h stuff, and seems to be a generic
> > > > legacy RTC chip or something. he one i have, builtin the VIA VT8231
> > > > southbridge is said to be called VT82887, altough i have no docs of
> > > > those, but the header files found in 2.6 concord. But i seem to have
> > > > some additional DATE_ALARM, MONTH_ALARM and CENTURY_FIELD registers not
> > > > found int the MC146818 header file.
> > >
> > > I appologize since I ramble a bit too much.  For 2.4, the best fix is
> > > (1) above.  For 2.6 however, it should be possible to remove chrp_time.c
> > > and use todc_time.c instead (it is self-contained, wrt nvram read/write,
> > > iirc) and do some sub-casing to pick the right RTC chip code to use.
> > > For example on PReP we still case between the two different chips, and
> > > just call todc_init (iirc) with a different param.  Or something along
> > > those lines.
> >
> > Ok, i have looked more, and the MC146818 is ok for my box. don't know
> > about other chrp boxes though.
> >
> > There is also the todc code in the 2.4 tree though, so it should also be
> > possible to do it this way, or would it not ?
>
> It would be possible, but it would be more intrusive for a stable
> series.

BTW, i didn't manage to get the generic RTC code working on my pegasos,
and i am actually a bit pressed for time.

Do you think a workaround, for the debian powerpc packages, would be to
add a test for the presence of a pmac in the CONFIG_RTC code, and abort
if one is found ?

If so, what would be the best way to test for a pmac subarch in the
drivers/char/rtc.c code ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
