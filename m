Message-Id: <m112AYH-0000WZC@tri-yann.crf.canon.fr>
Date: Thu, 8 Jul 1999 11:33:09 +0200 (CEST)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: ppc/kernel/prep_pci.c is badly designed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Months ago I posted a mail on the mailling list saying
that PREP machines code was badly lacking some board identification
routine and also support for Raven. As a result, allthough
I had code for MCP750 that runs perfectly for months (thanks again
Gabriel) I wasn't able to submit anything better than horrible kludges...

Since then things have positively evolved as the RAVEN is now supported
and there is a table that enables to identify PREP boards.
However the handling of the identification only serves
for interupt routing and cannot be used for anything else 
afterward (except if you want to use Motherboard_map_name!!!)

Why the hell a kind of machine ID is not recorded so that it can
be used latter to add machine specific code? Thanks to motorola
the MCP750 has two major incompatible revision regarding ISA interrupt 
routing EDGE/LEVEL settings and the actual code does not boot on recent
MCP750 board and I cannot add cleanly the necessary code...

So here is a proposal :

   1) PREP Machine identification  should only record a PREP_machine_ID
   (the code may be moved in prep_setup BTW),
   2) PREP_machine_ID could then be used in prep_pci.c to find
   the correct IRQ routing procedure (and not a simple table
   as it is today (empty for MCP750 although quite of bit
   of VIA 82596 programming must be done !!!)

What do you think of that?


-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF - Communication Dept
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
