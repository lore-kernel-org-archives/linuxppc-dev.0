Message-ID: <3DC79768.107@iram.es>
Date: Tue, 05 Nov 2002 11:03:20 +0100
From: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IDE on LongTrail
References: <Pine.GSO.4.21.0211032047160.12607-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> 	Hi,
>
> Anyone using a LongTrail with IDE devices?
>
> I just tried adding an IDE disk to mine. The disk is identified correctly, but
> I always get `hda: lost interrupt' for any other operation. According to lspci
> the sl82c105 uses IRQ 32 (OpenPIC), but /proc/interrupt shows no interrupts
> coming in there.
>
> However, if I hardcode the IRQ to be 14 in drivers/ide/sl82c105.c, IDE works
> fine (and is even reasonably fast: when using DMA, I get ca. 17 MB from a new
> low-end 5400 RPM disk, about the same as the old expensive U2W Viking II on the
> Sym53c875).
>
> Apparently other PPC platforms with a Winbond 83C553 (e.g. PowerPlus and PReP)
> have some fixup code to disable legacy IRQ mode and route the IDE interrupt to
> IRQ 14. But wouldn't it be better to route it directly to the OpenPIC, like the
> PCI config space indicates? Guess I'll have to dive in the 83C553 docs...
>

AFAIR, the 83C553 IDE interrupts documentation is muddy at best. To be
able to route directly to OpenPIC you would have to be able to connect
interrupt outputs from the 83C553 to the OpenPIC. The only hint that it
may be possible in the 83C553 documentation is that pins IRQC/IRQD are
documented as Input/OD (open drain outputs), while IRQA/IRQB are shown
as inputs only.

However to use this it would be necessary to have a connection from the
IRQC/IRQD to some OpenPIC inputs, which I believe is very unlikely. In
practice, you will have to go through the 8259 cascade. AFAIU the
datasheet and barring typos, native mode will use IRQ14/IRQ15, while
legacy mode gives you more choices. Look strange, but hey, it's based
on PC's so called architecture, so it's baroque by definition ;-)

However, take what I say with a pinch of salt, I don't know much about
the IDE interface since is not used at all on the MVME boards, only the
ISA bridge part oh the W83C553 (or 554).

> I'm using 2.4.20-rc1 (from linuxppc_2_4).

I'm fighting with 2.5 right now, and losing :-(

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
