Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A00CDDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 25 Feb 2007 08:17:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: using gdb/kgdb
Date: Sat, 24 Feb 2007 13:17:24 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069AEA@MERCURY.inside.istor.com>
References: <OFA2B855F5.8FEEC16C-ON8825728C.000C6AC9-8825728C.000C740E@selinc.com>
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

I am having a little trouble with kgdb in an 8541 kernel.=20

The kernel is compiled with CONFIG_DEBUG_KERNEL, CONFIG_KGDB, =
CONFIG_KGDB_TTYS1 all defined and I can boot it to the point where it is =
waiting for a gdb connection and it does make a connection. I have =
kernel command line that contains "kgdb=3DttyS1,115200,halt kgdbwait" in =
it and this appears to be working fine and the output looks like this.

MMU:enterJCSSU'=EB=81init
MMU:mapin
MMU:setio
MMU:exit
begin start_kernel
setup_arch: enter
setup_arch: kgdb breakpoint

At this point, from the cross-compiled gdb on a host, if I invoke gdb =
with vmlinux as an argument, the PC is zero.

$ ppc-gdb vmlinux

(gdb)set remotebaud 115200

(gdb)target remote /dev/ttyUSB0

(gdb)0x00000000 in ?? ()

If I invoke the cross-compiled gdb without vmlinux as an argument, I get =
a better looking pc, like this

$ ppc-gdb=20

(gdb)set remotebaud 115200

(gdb)target remote /dev/ttyUSB0

(gdb)0xc00071f4 in ?? ()

But in neither case can I 'step' or 'next' as gdb merely replies

Cannot find bounds of current function.

Can someone offer a spot of advice to this despicable condition?

Charles

p.s. I apologize if this comes out html as I am using the companies =
webmail interface from home.

=20

=20
