Return-Path: <Bjorn.Ostby@combitechsystems.com>
Received: from ms-101.aerotechtelub.se (ms-101.aerotechtelub.se
	[192.176.33.163]) by ozlabs.org (Postfix) with ESMTP id 125F2679F5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 22:23:38 +1000 (EST)
Received: from ratatosk.combitechsystems.com (unverified) by
	ms-101.aerotechtelub.se (Clearswift SMTPRS 5.0.9) with ESMTP id
	<T7101bf3c54c0b021a1d70@ms-101.aerotechtelub.se> for
	<linuxppc-embedded@ozlabs.org>; Thu, 19 May 2005 14:23:34 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C55C6D.92661DB3"
Date: Thu, 19 May 2005 14:23:32 +0200
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED0178CC0C@ratatosk.combitechsystems.com>
From: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitechsystems.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux 2.6 and mpc823 compile error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

------_=_NextPart_001_01C55C6D.92661DB3
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
I'm trying to get Linux 2.6.11 up and running on mpc823e. I'm using the =
cross compiler
Supplied in ELDK (3.0) and u-boot. The problem is when enabling:

[ ] CPM SCC/SMC serial port support
and/or
[ ] CPM SCC Ethernet

The kernel compiles fine having these option disabled, but =
otherwise..see below

make arch=3Dppc CROSS_COMPILE=3D${CROSS_COMPILE}
.
.
.
CC      drivers/serial/serial_core.o
CC      drivers/serial/cpm_uart/cpm_uart_core.o
In file included from drivers/serial/cpm_uart/cpm_uart_cpm1.h:13,
                  from drivers/serial/cpm_uart/cpm_uart.h:17,
                  from drivers/serial/cpm_uart/cpm_uart_core.c:55:
include/asm/commproc.h:564:1: warning: "PA_ENET_RCLK" redefined In file =
included from include/asm/mpc8xx.h:36,
                  from include/asm/processor.h:16,
                  from include/linux/spinlock.h:16,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from include/linux/module.h:10,
                  from drivers/serial/cpm_uart/cpm_uart_core.c:33:
arch/ppc/platforms/tqm8xx.h:91:1: warning: this is the location of the=20
previous definition
In file included from drivers/serial/cpm_uart/cpm_uart_cpm1.h:13,
                  from drivers/serial/cpm_uart/cpm_uart.h:17,
                  from drivers/serial/cpm_uart/cpm_uart_core.c:55:
include/asm/commproc.h:576:1: warning: "SICR_ENET_CLKRT" redefined In =
file included from include/asm/mpc8xx.h:36,
                  from include/asm/processor.h:16,
                  from include/linux/spinlock.h:16,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from include/linux/module.h:10,
                  from drivers/serial/cpm_uart/cpm_uart_core.c:33:
arch/ppc/platforms/tqm8xx.h:103:1: warning: this is the location of the=20
previous definition
In file included from drivers/serial/cpm_uart/cpm_uart.h:17,
                  from drivers/serial/cpm_uart/cpm_uart_core.c:55:
drivers/serial/cpm_uart/cpm_uart_cpm1.h: In function `cpm_set_brg':
drivers/serial/cpm_uart/cpm_uart_cpm1.h:28: warning: implicit =
declaration=20
of function `cpm_setbrg'
drivers/serial/cpm_uart/cpm_uart_core.c: In function =
`cpm_uart_set_termios':
drivers/serial/cpm_uart/cpm_uart_core.c:460: `SCU_PSMR_SL' undeclared=20
(first use in this function)
drivers/serial/cpm_uart/cpm_uart_core.c:460: (Each undeclared identifier =
is reported only once
drivers/serial/cpm_uart/cpm_uart_core.c:460: for each function it =
appears in.)
drivers/serial/cpm_uart/cpm_uart_core.c:466: `SCU_PSMR_PEN' undeclared=20
(first use in this function)
drivers/serial/cpm_uart/cpm_uart_core.c:470: `SCU_PSMR_REVP' undeclared=20
(first use in this function)
drivers/serial/cpm_uart/cpm_uart_core.c:470: `SCU_PSMR_TEVP' undeclared=20
(first use in this function)
drivers/serial/cpm_uart/cpm_uart_cpm1.h: At top level:
drivers/serial/cpm_uart/cpm_uart_core.c:732: warning: =
`cpm_uart_init_smc'=20
defined but not used
drivers/serial/cpm_uart/cpm_uart_core.c:671: warning: =
`cpm_uart_init_scc'=20
defined but not used
make[3]: *** [drivers/serial/cpm_uart/cpm_uart_core.o] Error 1
make[2]: *** [drivers/serial/cpm_uart] Error 2
make[1]: *** [drivers/serial] Error 2
make: *** [drivers] Error 2


There it is. Any ideas?=20

Regards,
Bjorn Ostby






------_=_NextPart_001_01C55C6D.92661DB3
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6249.1">
<TITLE>Linux 2.6 and mpc823 compile error</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Courier New">Hi,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I'm trying to get Linux 2.6.11 =
up and running on mpc823e. I'm using the cross compiler</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Supplied in ELDK (3.0) and =
u-boot. The problem is when enabling:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">[ ] CPM SCC/SMC serial port =
support</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">and/or</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[ ] CPM SCC Ethernet</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">The kernel compiles fine having =
these option disabled, but otherwise..see below</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">make arch=3Dppc =
CROSS_COMPILE=3D${CROSS_COMPILE}</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
drivers/serial/serial_core.o</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
drivers/serial/cpm_uart/cpm_uart_core.o</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">In file included from =
drivers/serial/cpm_uart/cpm_uart_cpm1.h:13,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
drivers/serial/cpm_uart/cpm_uart.h:17,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
drivers/serial/cpm_uart/cpm_uart_core.c:55:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">include/asm/commproc.h:564:1: =
warning: &quot;PA_ENET_RCLK&quot; redefined In file included from =
include/asm/mpc8xx.h:36,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
include/asm/processor.h:16,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
include/linux/spinlock.h:16,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
include/linux/capability.h:45,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/sched.h:7,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
include/linux/module.h:10,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
drivers/serial/cpm_uart/cpm_uart_core.c:33:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">arch/ppc/platforms/tqm8xx.h:91:1: warning: this is the location of =
the </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">previous definition</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">In file included from =
drivers/serial/cpm_uart/cpm_uart_cpm1.h:13,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
drivers/serial/cpm_uart/cpm_uart.h:17,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
drivers/serial/cpm_uart/cpm_uart_core.c:55:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">include/asm/commproc.h:576:1: =
warning: &quot;SICR_ENET_CLKRT&quot; redefined In file included from =
include/asm/mpc8xx.h:36,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
include/asm/processor.h:16,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
include/linux/spinlock.h:16,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
include/linux/capability.h:45,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from include/linux/sched.h:7,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
include/linux/module.h:10,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
drivers/serial/cpm_uart/cpm_uart_core.c:33:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">arch/ppc/platforms/tqm8xx.h:103:1: warning: this is the location of =
the </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">previous definition</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">In file included from =
drivers/serial/cpm_uart/cpm_uart.h:17,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =
drivers/serial/cpm_uart/cpm_uart_core.c:55:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_cpm1.h: In function =
`cpm_set_brg':</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_cpm1.h:28: warning: implicit =
declaration </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">of function `cpm_setbrg'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_core.c: In function =
`cpm_uart_set_termios':</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_core.c:460: `SCU_PSMR_SL' =
undeclared </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">(first use in this =
function)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_core.c:460: (Each undeclared =
identifier is reported only once</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_core.c:460: for each function it =
appears in.)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_core.c:466: `SCU_PSMR_PEN' =
undeclared </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">(first use in this =
function)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_core.c:470: `SCU_PSMR_REVP' =
undeclared </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">(first use in this =
function)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_core.c:470: `SCU_PSMR_TEVP' =
undeclared </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">(first use in this =
function)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_cpm1.h: At top level:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_core.c:732: warning: =
`cpm_uart_init_smc' </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">defined but not used</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">drivers/serial/cpm_uart/cpm_uart_core.c:671: warning: =
`cpm_uart_init_scc' </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">defined but not used</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">make[3]: *** =
[drivers/serial/cpm_uart/cpm_uart_core.o] Error 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">make[2]: *** =
[drivers/serial/cpm_uart] Error 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">make[1]: *** [drivers/serial] =
Error 2</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">make: *** [drivers] Error =
2</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">There it is. Any ideas? </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Regards,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Bjorn Ostby</FONT>
</P>
<BR>
<BR>
<BR>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C55C6D.92661DB3--
