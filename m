Date: Fri, 28 Jul 2000 20:47:50 -0400 (EDT)
From: James Simmons <jsimmons@acsu.buffalo.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Takashi Oe <toe@unlserve.unl.edu>, Benjamin Herrenschmidt <bh40@calva.net>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>
Subject: Re: [linux-fbdev] Re: [ANN] IRQ Latency tool 0.1.3 release.
In-Reply-To: <Pine.LNX.4.10.10007281606400.423-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10007282043200.681-100000@maxwell.futurevision.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Would it be difficult to make the lock per fbdev thing?  If the
> > CPU/accelerator clash is the only reason for the global lock, we can
> > certainly remove that for hardware which doesn't have that kind of
> > problem, can't we?
>
> There could indeed be separate locks per fbdev. But the global console lock
> (console_lock) would still be there. It is needed because the console subsystem
> is not re-entrant (yet). Since fbdev is called from the console subsystem, it
> runs under the same lock (i.e. with interrupts disabled).

I will be testing for re-entrant ability next week with code I have in
CVS. Their should be a semaphore for each struct console. Also their
should be a semaphore for each VT where on semephore is shared between the
VT console and struct console. Why a semephore. Eventually we will run
into hardware that runs only by interrupts. So a hardware independent why
to lock the console system is needed.

Q: Why did they deprecate a.out support in linux?
A: Because a nasty coff is bad for your elf.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
