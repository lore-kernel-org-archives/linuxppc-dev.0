Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id CF308DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 03:31:11 +1100 (EST)
Message-ID: <4926DA98.4060401@matrix-vision.de>
Date: Fri, 21 Nov 2008 16:58:16 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: MPC5200B: Trouble with config pins
References: <200811211336.41159.jbe@pengutronix.de>
In-Reply-To: <200811211336.41159.jbe@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org, u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

J=FCrgen,

Have a look at the manual chapter 4 (=3DReset + Config).
SRESET (issued by gpt0 - watchdog) isn't supposed to do a full hardware=20
reset.
Looks like you should make use of the SRESET and trigger HRESET according=
ly.

I could solve this with _not_ using the internal watchdog but an=20
external one (TPS3828),
i.e. watchdog timeouts and reboots are always issued by PORESET.



regards,
Andre


Juergen Beisert schrieb:
> Hi all,
>
> we have trouble with the eth based config pins (ETH0...ETH6) of the MPC=
5200B=20
> CPU. These pins act as the interface to an external phy and also act as=
=20
> configurations pins to configure the size of the flash and other things=
.=20
> While the reset is active these pins should be in their high impedance =
state=20
> and the externally connected pull down resistors should define wire's v=
oltage=20
> level. With the rising edge of the reset signal these levels will be la=
tched=20
> into internal config registers.
> We are in trouble when we want to reboot the system (also watchdog base=
d) or=20
> the internal watchdog barks and generates the CPU internal reset signal=
. In=20
> these cases these config pins will not change their level! So the wrong=
=20
> settings are latched in and our CPU is dead (misconfigured), sometimes =
a=20
> second reset helps, but most of the time only power cycling helps.
>
> What we see is:
>  - at the pins ETH_0 and ETH_3 (both are output only, when used for
>    ethernet)
>
>  * With an external 10k pulldown these lines never change their 3.3V le=
vel
>    even if the reset is active!
>  * With an external 1k pulldown these lines change their 3.3V level dow=
n to
>    something about 2.5V when the falling edge of the reset signal occur=
s.
>  * This level decreases slowly to 1.2V in about 1.2ms and than a fallin=
g edge
>    to 0V occures. Problem here is, the internal watchdog's generated re=
set
>    signal is much shorter, so the rising edge of this reset signal also
>    latches in the wrong settings and the CPU is dead.
>
> Some other things we see. A reset while:
>  - a running tftp command in U-Boot with disconnected network
>     -> system is always dead
>  - a running tftp command in U-Boot with connected network
>     -> system restarts
>    We can see in this case, the ETH_0 and ETH_3 are switching to low
>    level *immediatly* with the falling edge of the reset signal
>  - an activated interface ("ifconfig up") in Linux with *disconnected* =
network
>     -> system is always dead
>  - an activated interface ("ifconfig up") in Linux with *connected* net=
work
>     -> system is always dead
>
> Does anybody see a behaviour like ours on his/her MPC5200B based system=
?
> Does anybody have an idea what the difference between U-Boot und Linux =
could=20
> be? Bug? Feature?
>
> Regards,
> Juergen
>
>  =20


MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
