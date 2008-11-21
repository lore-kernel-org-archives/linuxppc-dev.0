Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (port-92-198-50-35.dynamic.qsc.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 03F05DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 23:55:36 +1100 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Fri, 21 Nov 2008 13:36:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200811211336.41159.jbe@pengutronix.de>
Subject: MPC5200B: Trouble with config pins
Cc: u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

we have trouble with the eth based config pins (ETH0...ETH6) of the MPC5200=
B=20
CPU. These pins act as the interface to an external phy and also act as=20
configurations pins to configure the size of the flash and other things.=20
While the reset is active these pins should be in their high impedance stat=
e=20
and the externally connected pull down resistors should define wire's volta=
ge=20
level. With the rising edge of the reset signal these levels will be latche=
d=20
into internal config registers.
We are in trouble when we want to reboot the system (also watchdog based) o=
r=20
the internal watchdog barks and generates the CPU internal reset signal. In=
=20
these cases these config pins will not change their level! So the wrong=20
settings are latched in and our CPU is dead (misconfigured), sometimes a=20
second reset helps, but most of the time only power cycling helps.

What we see is:
 - at the pins ETH_0 and ETH_3 (both are output only, when used for
   ethernet)

 * With an external 10k pulldown these lines never change their 3.3V level
   even if the reset is active!
 * With an external 1k pulldown these lines change their 3.3V level down to
   something about 2.5V when the falling edge of the reset signal occurs.
 * This level decreases slowly to 1.2V in about 1.2ms and than a falling ed=
ge
   to 0V occures. Problem here is, the internal watchdog's generated reset
   signal is much shorter, so the rising edge of this reset signal also
   latches in the wrong settings and the CPU is dead.

Some other things we see. A reset while:
 - a running tftp command in U-Boot with disconnected network
    -> system is always dead
 - a running tftp command in U-Boot with connected network
    -> system restarts
   We can see in this case, the ETH_0 and ETH_3 are switching to low
   level *immediatly* with the falling edge of the reset signal
 - an activated interface ("ifconfig up") in Linux with *disconnected* netw=
ork
    -> system is always dead
 - an activated interface ("ifconfig up") in Linux with *connected* network
    -> system is always dead

Does anybody see a behaviour like ours on his/her MPC5200B based system?
Does anybody have an idea what the difference between U-Boot und Linux coul=
d=20
be? Bug? Feature?

Regards,
Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
