Date: Fri, 10 Oct 2003 21:27:16 -0800
From: Ethan Benson <erbenson@alaska.net>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
Message-ID: <20031011052716.GB24569@plato.local.lan>
References: <20031011004541.5eda8953.billfink@mindspring.com>
Mime-Version: 1.0
In-Reply-To: <20031011004541.5eda8953.billfink@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Oct 11, 2003 at 12:45:41AM -0400, Bill Fink wrote:
>
> On Thu, 9 Oct 2003, Ethan Benson wrote:
>
> > On Fri, Oct 10, 2003 at 01:12:54AM -0400, Bill Fink wrote:
> > >
> > > This discussion prompted me to finally ask about another clock
> > > related problem I see on the 867 MHz G4 systems at work. The
> > > clocks on these systems continuously run 0.2% slow (about 3
> > > minutes per day). Apparently this is more than ntp can adjust for
> > > (using scaling), as I get many of these error messages in the log:
> >
> > is it a quicksilver G4? i maintain one of those and its time goes
> > off much faster then that (3 minutes within a couple hours).
>
> Yes I believe it's a quicksilver G4.
>
> clifford% cat /proc/cpuinfo
> cpu             : 7450, altivec supported
> clock           : 866MHz
> revision        : 2.1 (pvr 8000 0201)
> bogomips        : 865.07
> machine         : PowerMac3,5
> motherboard     : PowerMac3,5 MacRISC2 MacRISC Power Macintosh
> detected as     : 69 (PowerMac G4 Silver)
> pmac flags      : 00000000
> L2 cache        : 256K unified
> memory          : 640MB
> pmac-generation : NewWorld

thats a quicksilver alright.

> > the fix is rather simple:
> >
> > --- linux.old/arch/ppc/platforms/pmac_time.c.orig Sat Nov 30 02:33:49 2002
> > +++ linux/arch/ppc/platforms/pmac_time.c Sat Nov 30 02:33:22 2002
> > @@ -262,7 +262,9 @@
> > * calibration. That's better since the VIA itself seems
> > * to be slightly off. --BenH
> > */
> > +#if 0
> > if (!machine_is_compatible("MacRISC2"))
> > +#endif
> > if (via_calibrate_decr())
> > return;
>
> Thanks for the suggested fix. I'll give it a try when I get a chance.
>
> > in the case of the quicksilver VIA is FAR better then whatever it
> > inuses stead.
>
> Assuming the fix works, is there a simple way to test for the
> quickserver G4 model rather than doing the "#if 0", since I like to
> run a common kernel across a variety of different processor models.

i don't know, ive discussed it with benh, but he won't accept that VIA
is a better choice here.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
