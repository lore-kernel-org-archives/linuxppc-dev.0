Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34844DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 12:10:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: using gdb/kgdb
Date: Mon, 26 Feb 2007 17:10:30 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A179@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Clive

After all is said and done, it turns out your original architecture was
the issue. Given a new gdb-6.6, cross compiled for ppc, the incantations
are:

>From uboot

Uboot> setenv bootargs kgdb=3DttyS1,115200 kgdbwait <amongstOtherThings>
Uboot> tftp 1000000 uImage
Uboot> bootm 1000000


$ddd -debugger ppc_85xx-xgdb vmlinux
(gdb) set verbose on
(gdb) set architecture powerpc:common
(gdb) set remotebaud 115200
(gdb) target remote /dev/ttyS0
(gdb) break do_fork
(gdb) cont

Gdb does break at do_fork. It can break on the next line or continue to
the next line with no problem.

What it doesn't do is step. When I try to tell it to step, it looks like
it never completes the step function. But in any case, Clive, thank you
very much for getting me to this point. The next place is to figure out
the step command.

Charles
