Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C4C3DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 02:32:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: gdb & kgdb in MPC85xx
Date: Sun, 15 Apr 2007 09:32:09 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B74@MERCURY.inside.istor.com>
References: <3C02138692C13C4BB675FE7EA24095293284D7@bluefin.Soneticom.local>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a question relating to stepping with gdb connected to a remote =
target. I can connect to the target with its ttyS1 and 'list', 'break' =
just fine. This is with a Linux-2.6.17.11 kernel and gdb 6.5.
=20
A 'cont' begets a message, and a step fails to return. I am hoping =
someone can offer a suggestion or two.
As an example, I start from uboot with the kernel command line =
containing 'kgdbwait kgdb=3DttyS1,115200' and the target stops at =
'setup_arch: kgdb breakpoint' as I would expect. I am using a USB serial =
dongle, which has worked well for this type of debugging on other =
targets.
=20
$ .../linux
$ ppc-gdb vmlinux [its version 6.5 cross from ultsol]
(gdb) show architeture   [its powerpc:common]
(gdb) show verbose       [its on]=20
(gdb) target remote /dev/ttyUSB0=20
(gdb) list               [works fine]=20
(gdb) break do_fork      [sets fine]=20
(gdb) cont
[some problem here as gdb says=20
"Can't send signals to this remote system. SIGILL not sent."
but the breakpoint is taken and the target stops at the beginning of =
do_fork]
(gdb) step
[big problem now as the step never returns]
=20
=20
Charles Krinke
