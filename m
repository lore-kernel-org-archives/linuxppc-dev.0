From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Hartmann <jhartmann@valinux.com>, Gareth Hughes <gareth@valinux.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
Date: Fri, 19 Jan 2001 18:11:14 +0100
Message-Id: <19341214104258.22601@mailhost.mipsys.com>
In-Reply-To: <3A686DFE.9030308@valinux.com>
References: <3A686DFE.9030308@valinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Since your running through klogd, this might not be 'exactly' where you
>die.  I would be TERRIBLY surprised if you died here.  One thing you
>have to remember about kernel debugging is that you can't always trust
>what is in the log.  Here is a technique that works for me when I'm
>unsure of a piece of code:

Additionally, on PPCs, you have another technique, which is to use
prom_print or xmon_printf() (the latest one support full printf semantics
while the first one only supports a simple string).

If you have compiled the kernel with early boot text support, then those
function will go to a small text rendering engine that blasts things
directly to the screen. For that to work, you must have:

 - The framebuffer reachable (depends on the state of the card)
 - The same video mode/depth current than the one you had when it booted.
If you are using an fbdev, the recent aty128fb should properly "update"
the screen informations of the early boot text engine on a mode switch.

When debugging kernel code on a G4 mac, the best thing to do is to have a
stealth serial port. This is a small device that replace the internal
modem and provides a real "Apple-SCC" serial port. With that, you can
then enable xmon to use it (arch/ppc/xmon/start.c) and benefit from the
in-kernel low level debugger and xmon_printf. Those can be used at any
time, interrupt level, etc... and rely on so few kernel resources that
they can usually still be used when the rest of the kernel is dead.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
