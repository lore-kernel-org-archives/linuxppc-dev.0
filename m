From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David A. Gatwood" <dgatwood@apple.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problem serial.c on module
Date: Sat, 29 Sep 2001 13:50:59 +0200
Message-Id: <20010929115059.28787@smtp.wanadoo.fr>
In-Reply-To: <08F1F38A-B438-11D5-9814-003065B90BBC@apple.com>
References: <08F1F38A-B438-11D5-9814-003065B90BBC@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>That's disgusting.  This should be doing the Linux equivalent of setjmp
>and trapping the machine check and returning 0.  Hardware probes
>shouldn't need hacks like this.  Just my $0.02.

I definitely don't like it neither.

Currently, we have a "feature" if inb/outb (IO macros), Machine Checks
caused by these are caught, and inb returns 0xff when the IO fails.

However, we don't do that for MMIO (readb/writeb & friends, in_le32/be32,
..).

For one thing, I beleive we could add explicit "probe" verions of these
functions that return an error code and can be used in the "probe" part
of those drivers.

But that wouldn't help in all cases. Things like legacy drivers (serial.c
is one) will try to tweak "legacy" x86 IO ports. The above workaround will
help not crashing immediately. But you are not protected against having
a real PCI device mapping IOs in this location. In this case, you'll end
up writing to this card's IOs, possibily causing all sorts of bad things.

One workaround here would be to hack in the pmac PCI code to mark the
first 64k of IO space reserved and remap any PCI device that was mapped
in this location by OF.

Another one (I'd prefer) would be for such drivers to be dynamically
configured by the arch code instead of relying on a compile-time table
of known IO ports. There is a facility to hack into the compile-time
table from arch in serial.c, but I'm not sure it completely match
our needs. Other legacy drivers (like floppy.c) would need the same
tweak.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
