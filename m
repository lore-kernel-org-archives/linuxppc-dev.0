Date: Fri, 31 May 2002 13:21:24 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bill Fincke <willy@synergymicro.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: GT64260 ethernet driver - long term stability?
In-Reply-To: <3CF6C96E.BD1DAA3A@synergymicro.com>
Message-ID: <Pine.GSO.4.21.0205311320010.1147-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 30 May 2002, Bill Fincke wrote:
> Has anyone exercised the gt64260_eth.c driver (from the MontaVista
> BK tree) for any length of time?  I ported it and have been using
> it successfully for several weeks, but find that it can't sustain
> continuous file transfers for more than a few hours.
>
> I'm running a loop with ftp putting/getting a 24-MB file to a remote
> Linux system, and find that after a few hours, the "put" times out.
> It happens on any of the 3 ports, and to/from several different
> systems (G4 Mac or PC).  I run the test on the same system through
> a I82559 chip and it runs all weekend.
>
> The only clue I have it that the driver reports a flurry of RX CRC
> errors when the timeout occurs.  After ftp quits, I can ping the
> remote system, but the RX packets seem to be mismatched with the
> TX (ping reports once a second, but instead of ~100 usec transit
> time, it reports 1.000 sec, or 2.000 sec, or 3.000 sec, as if it's
> getting RX packets that are 1, 2, 3 seconds old).

The n-seconds ping times mean that the driver and the hardware got out-of-sync
w.r.t. the current entry in the ring buffer.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
