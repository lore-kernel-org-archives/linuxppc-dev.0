Date: Fri, 24 Nov 2000 18:56:16 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: apmd and other archs
In-Reply-To: <19341019110249.29808@192.168.1.2>
Message-ID: <Pine.LNX.4.05.10011241855000.972-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Nov 2000, Benjamin Herrenschmidt wrote:
> >Ok, I don't see very much the point of saving fractions of watt on a
> >desktop but...
>
> It can be more than fraction of watts when you put it all together, especially
> in deep sleep. And multiply that by the number of machines out there...
>
> Also, the Cube is sensitive to heat problems, having some power
> management (and CPU temp control, but that's another issue) helps.

That's what I call `solving hardware problems by software'. Gives some bonus
points in the old Hackers' Test :-)

> >I'm lost. Can't power management be done by the idle task ? There is one
> >per CPU but it can't handle signala AFAIR. After all power management
> >seems better handled by a task which never does I/O and whose only purpose
> >is to sleep...
>
> That could be done this way too. Are there any guarantees that the idle
> task will run at all, however, if a process is using all the available
> CPU time ? If we need all processors to stop scheduling userland code and
> wait in a sleep loop (not doze nor nap in this case), we need to have a
> way to let the idle task know that we need it to enter this special sleep
> stage ASAP. It will have to flush all caches properly and go to sleep. On
> some boxes, the CPU(s) will be shut down and revived via ROM hooks.
>
> >What do you call a sleep loop ?
>
> An infinite loop where the CPU goes to sleep mode. It exists via an
> external reset or CPU shut down.

What about putting all CPUs except one to sleep at night?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
