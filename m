Date: Mon, 1 Feb 1999 16:55:38 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: matroxfb, anybody? (More details...)
Message-Id: <19990201165538.009774@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 1, 1999, Geert Uytterhoeven
<Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

>Since BootX creates a fake OF device tree, I suspect it to appear in the
tree.
>Can you use your Mystique under MacOS? This is of course a prerequisite for
>BootX seeing your board.

OF in the machine's ROM (not the card's ROM) should make _any_ PCI board
visible provided that it contains correct config-space registers with a
vendorID and a deviceID, which is required for all PCI cards anyway. The
board itself can optionally contain OF code which can then change things
in the device-tree but you will (should) always at least have a device
tree entry, even if you have no OF code on the board.

BootX will make the fake OF tree from MacOS Name Registry, which is
itself a translated version of OF tree (plus or minus a couple of things
since MacOS drivers can change it).

However, I've read somewhere that there is actually a difference between
Matrox boards with and without OF code: the OF code will set the board to
use big-endian pixels. It may also change a couple of other things, so
you can not rely on the state of the board at driver initialisation. You
will probably also have differences with or without Gabriel PReP
bootloader since it will be able to run any x86 bios code that lives here.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
