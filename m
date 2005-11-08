Return-Path: <Agostino.Sette@siemens.com>
Received: from MILVB95A.icn.siemens.it (milvb95a.icn.siemens.it
	[83.103.117.137]) by ozlabs.org (Postfix) with ESMTP id 4FE8B686A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 19:37:29 +1100 (EST)
Message-ID: <69DF49BE936F4441980EC1D59F0ADC2F0108C267@aqlby02a.siemens.it>
From: Sette Agostino <Agostino.Sette@siemens.com>
To: wd@denx.de
Date: Tue, 8 Nov 2005 09:37:07 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: PPCBoot 2.0.0 Errors 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Wolfgang,

Thanks for your answers.
I agree with you concerning the PPCBoot. In fact in other boards we are
using U-Boot.
We tried to use U-Boot for MPC859 but we had some problems we are =
trying to
solve.
As far as you know to change the boot or the kernel on cards in field =
is not
so easy :-(
Anyway, I would like to highlight I think the problem  is more related =
to
the
kernel because when it starts I see the following error

init started:  BusyBox v0.60.5 (2003.11.19-14:32+0000) multi-callmount:
Mounting devpts on /dev/pts failed: No su
ch file or directory
/opt/rc.project: /opt/bin/sinfo: No such file or directory


We check that slowing-down the UPM clock to 63 MHz (period=3D15.873ns) =
the
board showed a more stable behavior (no fault verified).
We start our investigation on the PPCBoot, but now we are moving on the
kernel.
No critical HW points have been found on the FLASH accesses, SDRAM =
accesses
and clocking circuitrty.
We found an unexpected beahviour regarding the Linux time tick.=20
Tracking with a HP16602 Bus Analyzer the bus activities of the faulty =
module
has been verified that the=20
interrupt service routine of the Decrementer timer, that I supposed to =
be
used to generate the OS time tick, it is not executed each 10ms.
Sometimes the period between 2 Decrementer interrupt service routines =
reach
hundreds of ms (but even as 10mS multiple)=20
such as some requests are missing.=20
Making the same tracking on a TQM866 module has been verified that the
interrupt service routines of the Decrementer timer are=20
all executed at the exact 10ms boundary.

Another interesting point is that the same kernel works well on other =
TQM8xx
modules, but not fot TQM859.
I will try to introduce the U-Boot, but I am not confident it will =
solve the
problem, what do you think about it?
Last question, which is the appropriate mailing list?

Thanks in advance for your support.

Best regards,
Agostino Sette


TechnoLabs
Department of Innovation Software3
S.S. 17 Localit=E0 Boschetto
67100 L' Aquila (Italy)
Tel: (+39)  0862 344.557
Fax: (+39)  0862 344.623
e-mail: Agostino.Sette@siemens.com =20
=20

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]=20
Sent: luned=EC 7 novembre 2005 23.10
To: Sette Agostino
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPCBoot 2.0.0 Errors=20

In message =
<69DF49BE936F4441980EC1D59F0ADC2F0108C12C@aqlby02a.siemens.it>
you wrote:
>=20
> I have the following problem at the PPCBoot startup:
>=20
> PPCBoot 2.0.0 (Oct 20 2005 - 12:28:22)

PPCBoot is a dead project. It was discontinued more than 3 years ago.
It is definitely a bad idea to  use  it  for  current  projects.  Use
U-Boot instead.

Also, this is completely off topic on this mailing list.

> CPU:   unknown MPC859 (0x08010004) at 133 MHz: 16 kB I-Cache 8 kB =
D-Cache

Use U-Boot instead.

> Board: Siemens CCM

And don't use a board configuration that does not match your hardware.

> ## Booting image at 40180000 ...
>    Image Name:   Linux-2.4.20-rthal5

Argh... Ancient stuff again. Forget it.

> Anybody experienced the same problem? Any suggestions about how to =
solve
it?

Use current software. Read the documentation. Post on the appropriate
mailing lists.

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
My challenge to the goto-less programmer  is  to  recode  tcp_input()
without any gotos ... without any loss of efficiency (there has to be
a catch).                                             - W. R. Stevens
