Date: Thu, 8 Jan 2004 18:47:40 +0100
To: Tom Rini <trini@kernel.crashing.org>
Cc: debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Volunteer needed : Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20040108174740.GA19931@iliana>
References: <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana> <1073460144.784.79.camel@gaston> <20040107075151.GH14918@plato.local.lan> <20040107112726.GA26193@iliana> <20040107122828.GJ14918@plato.local.lan> <20040107144744.GA29449@iliana> <20040108072733.GM14918@plato.local.lan> <20040108155331.GB18481@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040108155331.GB18481@stop.crashing.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 08, 2004 at 08:53:31AM -0700, Tom Rini wrote:
>
> On Wed, Jan 07, 2004 at 10:27:33PM -0900, Ethan Benson wrote:
>
> > On Wed, Jan 07, 2004 at 03:47:44PM +0100, Sven Luther wrote:
> > >
> > > The worse that can happen is the GENERIC_RTC driver not being
> > > initialized because linux believes the RTC driver should be ok.

This doesn't work anyway, it stops pmacs from hanging but still there is
a long wait, which you can ^C interrupt.

I believe this is because since there is the RTC clock, the GENERIC_RTC
code will not be called or something.

> > which breaks hwclock, not acceptable.
>
> This is getting _much_ uglier, but how about:
> 1) Modify genrtc.c and rtc.c so that they do _not_ initalize on their
> own.
> 2) Create a 'dummy_rtc.c' driver that just tests _machine and calls
> rtc.c's init bits on chrp (or just pegasos) and genrtc's bits otherwise.
>
> And again, this is ugly ugly ugly, and I disavow any knowledge of
> typing the above.

That would be a solution, but i think i will look again at my previous
effort.

Anyway, on pegasos 2, i have the problem that CONFIG_RTC works fine, and
the clock is set, but only _later_. This has as result that the clock is
wrong when it is the time for filesystem checks, and thus filesystems
are checked each time.

Strange.

Friendly,

Sven Luther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
