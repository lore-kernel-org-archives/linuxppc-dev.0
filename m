Date: Wed, 14 Jun 2000 22:40:10 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Interrupt hick ups
In-Reply-To: <Pine.LNX.4.05.10006132314240.18002-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10006142236120.5007-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 13 Jun 2000, Geert Uytterhoeven wrote:
> Since a few kernel versions (late 2.3.x), I see interrupt hick ups when doing
> disk access on my Sym53c875. I.e. when I'm typing something and the disk
> shows a lot of activity, keystrokes and mouse moves happen in burst with some
> delay (ca. 2 seconds).
>
> Anyone seeing a similar thing? This is on a CHRP LongTrail.
>
>            CPU0
>   1:       3232   i8259         keyboard
>   2:          0   i8259         82c59 secondary cascade
>   3:      33331   i8259         serial
>   4:          9   i8259         serial
>   8:          0   i8259         rtc
>  16:          0   OpenPIC       82c59 cascade
>  22:     385557   OpenPIC       MESH
>  29:      30531   OpenPIC       eth0
>  31:     218039   OpenPIC       sym53c8xx
> BAD:          8

It doesn't seem to happen with the 2.4.0-test1 I compiled on june 4, while
2.4.0-test1-ac7 suffers from the problem.

I suspect the changes in open_pic.c that replaced the calls to unmask_irq()
by something different?

The hick ups seem to cause temporary complete system lock ups for ca. 1.75
seconds (repeated wrist watch timing).

Gr{oetje,eeting}s,

				    Geert (in a `guessing' mood today)

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
