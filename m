Date: Tue, 14 Mar 2000 11:03:14 +0100
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        linux-fbdev@vuser.vu.union.edu, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [linux-fbdev] [PATCH 2.3.x] fbdev reversion
Message-Id: <20000314110314.016060@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 14, 2000, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
wrote:

>... which they can easily find out by combining /proc/bus/pci with
>fix.{smem,mmio}_{start,len}.
>
>Since XFree86 4.0 already has resource handling, it should be a piece of cake
>to remove all devices corresponding to any fix.{smem,mmio}_{start,len} from
>their list.

Well, while we are at it, we could also work on fixing the PCI problems:
Instead of relying on XFree knowing the host bridge and deducing the
iobase, I beleive we should export from the kernel either one iobase per
PCI device (there can be different busses with different iobases, that's
the case on the new macs and they have the same bus number), or we can
have /proc/bus/pci export "fixed'up" IO addresses (already including the
iobase).

I can code those fixes, but I'm not sure what solution has most chances
of beeing accepted (especially changing /poc/bus/pci semantics). The
problem is that exporting an IO address alone (without the iobase) has
really no meaning on arch that don't have a x86-like separate IO space at
the CPU level.

Back to the subject of fbdev vs. XFree, it would be easy to add an
optional ioctl returning the PCI bus:dev:fn from the fbdev (would be
PCI-specific however). Eventually, it could be a generic ioctl that returns

  - A constant indicating the bus type
  - A string containing a bus-specific identification

I beleive it's cleaner that relying on resource removal, and may be
useful for other things too (like board-specific userland setup tools
that would want to issue some config space accesses to the card, etc...).

Note that I'd love to see this mecanism of a bus-type/id-string extended
to all devices in the kernel (using /proc/ instead of ioctls) since it
would help solving our problem of configuring OF boot path too. But
that's another story...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
