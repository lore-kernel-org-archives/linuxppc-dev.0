Date: Mon, 22 Dec 2003 09:33:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Lee Braiden <jel@ntlworld.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20031222163315.GC10841@stop.crashing.org>
References: <1071646057.6370.482.camel@gaston> <20031217095139.GC2283@iliana> <20031217164740.GR11761@stop.crashing.org> <20031217165608.GA11653@iliana> <20031217170620.GS11761@stop.crashing.org> <20031219114050.GA5650@iliana> <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana> <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031222162601.GA9021@iliana>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 22, 2003 at 05:26:01PM +0100, Sven Luther wrote:

> On Mon, Dec 22, 2003 at 09:10:42AM -0700, Tom Rini wrote:
> > > Also, the todc code knows about many RTC chips, among them, the MC146818
> > > seems to be the one used by the rtc.h stuff, and seems to be a generic
> > > legacy RTC chip or something. he one i have, builtin the VIA VT8231
> > > southbridge is said to be called VT82887, altough i have no docs of
> > > those, but the header files found in 2.6 concord. But i seem to have
> > > some additional DATE_ALARM, MONTH_ALARM and CENTURY_FIELD registers not
> > > found int the MC146818 header file.
> >
> > I appologize since I ramble a bit too much.  For 2.4, the best fix is
> > (1) above.  For 2.6 however, it should be possible to remove chrp_time.c
> > and use todc_time.c instead (it is self-contained, wrt nvram read/write,
> > iirc) and do some sub-casing to pick the right RTC chip code to use.
> > For example on PReP we still case between the two different chips, and
> > just call todc_init (iirc) with a different param.  Or something along
> > those lines.
>
> Ok, i have looked more, and the MC146818 is ok for my box. don't know
> about other chrp boxes though.
>
> There is also the todc code in the 2.4 tree though, so it should also be
> possible to do it this way, or would it not ?

It would be possible, but it would be more intrusive for a stable
series.

> Anyway, i will submit a patch against 2.4.23 (from linuxppc_2_4, but it
> may also include the pegasos patches Ben has had no time to checkin)
> tomorrow.
>
> Next thing i need is a solution for builtin initrd's of bigger sizes.
> 1.4Mo seem to work, but 2.2Mo break somehow (no init found, but if the
> initrd is uncompressed to some partition, it work fine).

which code subset under arch/ppc/boot does pegasos use?  Does it really
have OpenFirmware?  I've booted large ramdisks in the past from the
arch/ppc/boot/simple/ stuff (And prep/) but I believe that chrp/pmac
place the initrd at a location high in memory, have holes to deal with,
etc, etc, while simple/ and prep/ (more or less) just ignore the
firmware once it's up.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
