Date: Sun, 3 Nov 2002 22:40:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: IDE on LongTrail
Message-ID: <Pine.GSO.4.21.0211032047160.12607-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

Anyone using a LongTrail with IDE devices?

I just tried adding an IDE disk to mine. The disk is identified correctly, but
I always get `hda: lost interrupt' for any other operation. According to lspci
the sl82c105 uses IRQ 32 (OpenPIC), but /proc/interrupt shows no interrupts
coming in there.

However, if I hardcode the IRQ to be 14 in drivers/ide/sl82c105.c, IDE works
fine (and is even reasonably fast: when using DMA, I get ca. 17 MB from a new
low-end 5400 RPM disk, about the same as the old expensive U2W Viking II on the
Sym53c875).

Apparently other PPC platforms with a Winbond 83C553 (e.g. PowerPlus and PReP)
have some fixup code to disable legacy IRQ mode and route the IDE interrupt to
IRQ 14. But wouldn't it be better to route it directly to the OpenPIC, like the
PCI config space indicates? Guess I'll have to dive in the 83C553 docs...

I'm using 2.4.20-rc1 (from linuxppc_2_4).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
