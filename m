Message-Id: <200102061429.f16ETTr19200@denx.denx.de>
To: wn.jacobs@signaal.nl
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet in PPCBOOT on STK860L does not work 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 06 Feb 2001 14:22:11 +0100."
             <Pine.GSO.4.21.0102061419290.3125-100000@hatert.nijmegen.inter.nl.net>
Date: Tue, 06 Feb 2001 15:29:29 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Willy,

in message <Pine.GSO.4.21.0102061419290.3125-100000@hatert.nijmegen.inter.nl.net> you wrote:
>
> We bought recently several TQC STK860L starter kits.

You know that we ship these  systems  with  PPCBoot  and  Linux  pre-
installed, and tested?

> The STK860L is equipped with a 80 MHz MPC860T.
...
> In ppcboot I added manually:

Everything looks OK so far.

> setenv ethaddr 0:40:2f:0:4c:08

This is NOT ok, at least from the administrative point of view: TQ is
using 00:D0:93... ethernet addresses for their products. You can read
the correct setting from the label on the module (it might be on  the
bottom side, so you have to unplug the module from the STK).

> => tftp
> ARP broadcast 1
> TX timeout
> ARP broadcast 2
> TX not ready
> TX timeout
> ARP broadcast 4
> TX not ready
> etc.
...
> Any idea what is going wrong?

Check the jumpers on the STK8xxL  board;  the  relevant  jumpers  are
X.12, X.13, X.14 and X.32. With X.12, X.13 and X.14 you can select if
you  are  using  SCC1  or  SCC2;  for  the  MPC860,  SCC1 is used for
ethernet, so you must set a jumper on positions 1-3 and 2-4  for  all
of  these.  X.32 connects some port pins with the USB interface; when
you want to use SCC1 for ethernet, NO jumper must be set on X.32.


I guess it's the jumpers on X.32. Remove them.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
