Date: Thu, 8 Jan 2004 08:53:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Volunteer needed : Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20040108155331.GB18481@stop.crashing.org>
References: <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana> <1073460144.784.79.camel@gaston> <20040107075151.GH14918@plato.local.lan> <20040107112726.GA26193@iliana> <20040107122828.GJ14918@plato.local.lan> <20040107144744.GA29449@iliana> <20040108072733.GM14918@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040108072733.GM14918@plato.local.lan>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 07, 2004 at 10:27:33PM -0900, Ethan Benson wrote:

> On Wed, Jan 07, 2004 at 03:47:44PM +0100, Sven Luther wrote:
> >
> > The worse that can happen is the GENERIC_RTC driver not being
> > initialized because linux believes the RTC driver should be ok.
>
> which breaks hwclock, not acceptable.

This is getting _much_ uglier, but how about:
1) Modify genrtc.c and rtc.c so that they do _not_ initalize on their
own.
2) Create a 'dummy_rtc.c' driver that just tests _machine and calls
rtc.c's init bits on chrp (or just pegasos) and genrtc's bits otherwise.

And again, this is ugly ugly ugly, and I disavow any knowledge of
typing the above.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
