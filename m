In-Reply-To: <Pine.LNX.4.10.10002071812050.1142-100000@cassiopeia.home>
Date: Mon, 7 Feb 2000 20:02:03 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
CC: linux-fbdev@vuser.vu.union.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [linux-fbdev] Retrace
Message-Id: <20000207200203.007111@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 7, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>And now the bad news: the address you have to mmap() depends on the machine
>type :-(

We need to find a solution for that one day or another. The iobase is not
only arch-dependant (PReP, PowerMac, CHRP...) but also machine dependant,
since it depends on the host bridge type.

Unfortunately, with weird host bridges like Apple Uni-N (that has 3
busses with 3 different io bases but the same bus number), it's almost
impossible to get it correct, or eventually by parsing /proc/device-tree.

That means that getting code that need to do io's from userland is a real
challenge. Even X is not completely correct in this regard. Ryuichi tried
to fix it at least for PowerMacs, but gave up for Uni-N based machines.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
