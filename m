Date: Tue, 14 Mar 2000 22:22:48 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        linux-fbdev@vuser.vu.union.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-fbdev] [PATCH 2.3.x] fbdev reversion
In-Reply-To: <20000314110314.016060@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10003142219180.18470-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >... which they can easily find out by combining /proc/bus/pci with
> >fix.{smem,mmio}_{start,len}.
> >
> >Since XFree86 4.0 already has resource handling, it should be a piece of cake
> >to remove all devices corresponding to any fix.{smem,mmio}_{start,len} from
> >their list.
>
> Well, while we are at it, we could also work on fixing the PCI problems:
> Instead of relying on XFree knowing the host bridge and deducing the
> iobase, I beleive we should export from the kernel either one iobase per
> PCI device (there can be different busses with different iobases, that's
> the case on the new macs and they have the same bus number), or we can
> have /proc/bus/pci export "fixed'up" IO addresses (already including the
> iobase).

I'd like to see something like this for instance atyfb knows about the
structure of the devices' mem region (wich memory aperture to use for vram
or mmio) but the X server messes up because it only knows the full
aperture, and detects a conflict between MMIO and vram.

If the X server uses /proc/bus/pci to work it's magic, this would be the
place to fix it.

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
