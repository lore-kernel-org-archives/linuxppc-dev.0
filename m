Message-ID: <D73A25AA6E54D511AD74009027B1110F3C09E8@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Laurent Mohin'" <laurent.mohin@acterna.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: hang up after start_here
Date: Mon, 18 Aug 2003 08:55:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had the same problem with a 405GPr processor.  I was using the
linuxppc_2_4_devel tree and an Abatron BDI 2000.  The work around I found
was to do the following steps.

1.  Connect the board to the abatron.
2.  Apply power to the board.
3.  Wait for the Abatron to finish it's init.
4.  Give the go command in the Abatron to boot the firmware.
5.  Perform a hard reset on the board.
6.  Allow the firmware to boot a second time.

After performing the following steps I was able to get past the start_here.

Also, make sure you invalidate data cache.



-----Original Message-----
From: Laurent Mohin [mailto:laurent.mohin@acterna.com]
Sent: Monday, August 18, 2003 3:55 AM
To: linuxppc-embedded@lists.linuxppc.org
Cc: u-boot-users@lists.sourceforge.net
Subject: hang up after start_here



Hello all,

I'm designing a custom board build around a 405GPr processor. I'm in my
third prototype phase, and I've problem with one board which hang during
Linux booting.
I've debugged and found that the board hangs in start_here function and
doesn't reach the early_init function.

Because the problem appears on only one of my boards out of 16, I suspect
a hardware problem, and because it occurs just after mmu initialisation
and caches enabling, I suspect more especially sdram accesses.

I want to know if anybody has encountered a similar problem and if the
diagnostic was the same.

Kernel version is 2.4.18 from Montavista.

Thanks for help,

Laurent


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
