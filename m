Message-Id: <200012121901.UAA00875@piglet.grunz.lu>
Date: Tue, 12 Dec 2000 20:01:07 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: AW: Sound on an iBook?
To: iain@sandoe.co.uk
cc: barrow_dj@yahoo.com, linuxppc-dev@lists.linuxppc.org,
        schmitz@opal.biophys.uni-duesseldorf.de, khalfmann@libra.de
In-Reply-To: <200012081959.TAA30962@hyperion.valhalla.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   8 Dec, this message from Iain Sandoe echoed through cyberspace:
> we are all quite familiar with i2c.
>
> the new thing here is the particular Apple hardware, registers etc. used to
> implement the bus interface... another set of stuff we may have to deduce
> the hard way.
>
> it's not the cuda - the iBook doesn't have a cuda - AFAIK.  (PMU, I expect).

You might want to look for the aproach Apple used when implementing I2C
in the planb ASIC (that was in the 7500/8500 machines, back around
'94-'95). This I2C interface talks to a single chip on the bus (the
SAA7196 video decoder), and it goes like this: write the target device
register subaddress into some register, wait a bit, write the data into
another register, and off it goes into the target device.

There is a third register that monitors the SAA7196's only readable
register, a status register.

FWIW, register address is at 0x200, data is at 0x204, and status at
0x208 into planb's address space.

Of course, KeyLargo might work in an entirely different way...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
