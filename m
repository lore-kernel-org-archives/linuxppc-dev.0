To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial console ports on systems with no console connected. 
In-Reply-To: Message from Arun Dharankar <ADharankar@ATTBI.Com>
   of "Tue, 09 Jul 2002 19:45:19 -0400." <200207091945.19620.ADharankar@ATTBI.Com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Jul 2002 16:47:28 +1000
Message-ID: <2088.1026283648@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 9 Jul 2002 19:45:19 -0400, Arun Dharankar <ADharankar@ATTBI.Com> writes:
>Also have the serial port speed set at 115200,  I
>dont believe this is buffer overrun issue.

If you want to go faster than about than about 38400, you need to get a
different clock source for your baud rate generators (Tom Rini has a patch
from me to add support for an external clock source for BRGs on the 8260
in linuxppc_2_4_devel). By default, the SCCs and SMCs use a clock source that
won't divide cleanly at the higher baud rates - the error becomes so large
that it simply stops working - which is what you are getting by the looks of it.

Try running the serial ports at 19200 and see if that works. Cheers!
								Murray...

PS: the patch Tom has is trivial - you still need to hack the 8260 uart driver
to use the new code (also trivial), plus your hardware needs an external clock
source (distinctly non-trivial if your board design doesn't include one already
- our hymod board has a 3686400Hz clock source wired appropriately, which allows
up to 230400bps if you use 16x oversampling)

PPS: ppcboot already has support for external BRG clock sources - see
include/config_hymod.h for an example of how to configure it.
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
