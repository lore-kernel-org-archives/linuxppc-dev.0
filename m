Date: Fri, 4 Aug 2000 15:20:19 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gabriel Paubert <paubert@iram.es>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org,
        Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again...
In-Reply-To: <Pine.HPX.4.10.10008031133480.9070-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.10.10008041515510.879-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Gabriel Paubert wrote:
> On Thu, 3 Aug 2000, Benjamin Herrenschmidt wrote:
> > >I am using it as module both for 2.2.17-bk and for 2.4.0-test5. They
> > >don't give the same time, and I think it is the one in 2.4.0 that is
> > >right. I am at GMT+2:00, and the time in 2.2.17 is 2 hours early. When I
> > >change /etc/sysconfig/clock from "UTC=false" to "UTC=true", both times
> > >shift by 2 hours, but the discrepancy remains.
> > >
> > >The following patch for bitkeeper linuxppc_2_2 fixes this problem for
> > >me. It brings 2.2.17pre13 in line with 2.4.0-test5 (and MacOS). I cannot
> > >test the VIAPMU part, so maybe there the offset is necessary, but for
> > >the VIACUDA part, it seems wrong.
> >
> > You patch reverts a fix I made some time ago. Basially, what probably
> > happens is that your RTC is in UTC time, not in local time. The Mac RTC
> > is supposed to be in local time, the offset corrects the kernel time on
> > boot to account for this. Previously, without that fix, the kernel used
> > to boot with a bogus UTC time until userland fixes it.
>
> Actually given the problems with RTC being UTC or local time, the offset
> might perhaps better be setup as a kernel parameter so that th system
> start up in a known good state. It seems that it is in RAM for Macs, but
> what about other machines (I have no problems since all my machines are
> UTC and I simply refuse to use an OS which requires anything else) ?

Why do you want to handle the offset in the kernel???

Any decent distro (e.g. Debian) allows to configure the time system for a
hardware clock running in either UTC or local time, so the correction will be
done on boot up.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
