Date: Sat, 19 Dec 1998 18:05:41 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Cort Dougan <cort@cs.nmt.edu>
cc: Cc: ;
Subject: Starting second CPU on Dual MTX
Message-ID: <Pine.LNX.4.04.9812191754510.17803-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've finally gotten to playing around with SMP, and I have managed to
start the second processor, which then seems to insist on executing the
PPCBug init code.

I am trying to do this by soft-resetting the second CPU via the OpenPIC.
I figured I'd just change the soft-reset exeception vector in head.S to:

	.0x100
	bl __secondary_start

However, I don't seem to be able to make the second CPU use the Linux
reset vectors (which are loaded at 0x0, etc) instead of the ones in flash
ROM at 0xFFF00000.

There are functions provided by PPCbug (.forkmpu, .forkmpur, .idlempu)
which would allow me to do this, but since PPCbug isn't used for anything,
I decided against it at first.

My next idea is to use the PPCbug functions in the bootloader to set the
IP bit in the MSR of CPU1 to 0, so as to use the Linux reset vectors when
reset.

Does anyone have any ideas/suggestions what would be the best way to do
this? Thanks.

--------------------------------------------------------------------------
| Troy Benjegerdes    |        troy@microux.com    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
