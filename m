Date: Tue, 6 Jan 2004 22:51:51 -0900
From: Ethan Benson <erbenson@alaska.net>
To: debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel	on your machine ?
Message-ID: <20040107075151.GH14918@plato.local.lan>
References: <20031217165608.GA11653@iliana> <20031217170620.GS11761@stop.crashing.org> <20031219114050.GA5650@iliana> <20031219162800.GE29266@stop.crashing.org> <20031222134504.GA5964@iliana> <20031222161042.GB10841@stop.crashing.org> <20031222162601.GA9021@iliana> <20031222163315.GC10841@stop.crashing.org> <20040107065458.GA20228@iliana> <1073460144.784.79.camel@gaston>
Mime-Version: 1.0
In-Reply-To: <1073460144.784.79.camel@gaston>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 07, 2004 at 06:22:25PM +1100, Benjamin Herrenschmidt wrote:
>
> > BTW, i didn't manage to get the generic RTC code working on my
> > pegasos, and i am actually a bit pressed for time.
> >
> > Do you think a workaround, for the debian powerpc packages, would be
> > to add a test for the presence of a pmac in the CONFIG_RTC code, and
> > abort if one is found ?
> >
> > If so, what would be the best way to test for a pmac subarch in the
> > drivers/char/rtc.c code ?
>
> will the kernel let you build both drivers in ?

yes, which will cause all powermacs to hang on bootup when hwclock is run.

> then you can do, in 2.4, something ugly like that:
>
> #ifdef CONFIG_ALL_PPC
> if (_machine == _MACH_Pmac)
> 	return -ENODEV;
> #endif

which im betting will instead cause hwclock to fail on all powermacs
with: hwclock: /dev/rtc: No such device

but i could be missing something obvious with your suggestion.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
