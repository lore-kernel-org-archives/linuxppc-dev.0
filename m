Date: Mon, 17 Jul 2000 14:32:56 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alain RICHARD <alain.richard@equation.fr>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Paul Mackerras <paulus@linuxcare.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MacSerial and Serial driver cohabitation
In-Reply-To: <p04320400b59877f5cc70@[192.168.240.10]>
Message-ID: <Pine.LNX.4.10.10007171426170.449-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 17 Jul 2000, Alain RICHARD wrote:
> This is just a hack, but the problem is worst : macserial is a serial
> driver for Z8530 chipsets and serial is a serial driver for 16x50

One more reason to rename serial.c to ser16550.c and merge all Z8530 drivers
into one ser8530.c (BTW, it's left as an exercise for the reader to find
someone with enough fingers to count all AMD LANCE drivers and merge them into
one driver afterwards :-)

> UARTs. There are several cases where you may need the two drivers :
>
> a) in a powerbook when using a pcmcia modem : most, if not all, modem
> cards are based on a 16x50 UART and do need the serial.o driver.
> b) most PCI serial cards are using 16x50 UARTs

And CHRP boxes, which may have both 16550 and 8530 serial ports on the
motherboard. Never tried my 8530 ports, though.

To me it would sound logical to start counting serial ports from ttyS0 in one
driver, and continue counting in a second driver, and so on. We had that on
m68k, but the PC guys didn't like it and want to keep the current scheme (one
major device for 16550 serial, and one for each type of multiserial board on
the market).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
