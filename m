Date: Fri, 16 Nov 2001 16:46:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: Organisation of 4xx initialization code
Message-ID: <20011116164625.K673@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At the moment the initialization for each of the 4xx boards goes
through the platform_init() in arch/ppc/kernel/ppc4xx_setup.c, which
in turns calls a board_init() function for the specific board.

It seems to me that it would make more sense to put platform_init() in
the board specific files, and these functions could then call back,
where appropriate, to generic 4xx setup functions.  This would mean:
	- It would be easier to support wierd and wacky boards which
have non-standard address setups.
	- Some ugly #ifdefs in ppc4xx_setup.c could be done away with.
	- We should be able to remove some inconvenient header
dependencies - at present lots of things are recompiled when board
local defines are changed because walnut.h/ep405.h/etc are included
indirectly in serial.h and some other unexpected places.

Thoughts?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
