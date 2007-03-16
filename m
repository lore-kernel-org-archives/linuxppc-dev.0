Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD694DDED6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Mar 2007 01:45:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Exception in kernel mode
Date: Fri, 16 Mar 2007 07:45:27 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B3C@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A19B@MERCURY.inside.istor.com>
	<653893AD-CB60-4123-B4FC-FB9B886BD895@kernel.crashing.org>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: Chris Carlson <ccarlson@istor.com>, Kevin Smith <ksmith@istor.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It this a system you are just bringing up or one that's been running=20
for a while.  It really seems like memory corruption of some form. =20
I'd suggest checking memory controller settings.

Also, what happens if you disassemble the kernel image and look at=20
the addresses pointed to by NIP:
C00DEE18 & C002CE68.

- k
Dear Kumar:
=20
We have two systems. One based on an 8241, and one based on an 8541. The =
8241 has been running for some time with Linux 2.4 and the 8541 is =
coming up. Both are using the 2.6.17.11 kernel from kernel.org with =
modifications for our hardware.
=20
In the case of the 8241, I started out with the 2.4 modifications, which =
were originally based on the 8260 and ported them to 2.6. In the case of =
the 8541, I started out with the embedded planet 8555EP 2.6 kernel =
source and added that to the 2.6.
=20
I dont see this exception in the 8541, although extensive testing has =
not yet been completed. The 8241 exhibits this exception on three =
different 8241 boards, so I dont suspect the hardware.
=20
We are using the Montavista toolchain and their root filesystem =
including 'tar' and 'cp' which are the programs that currently exhibit =
the fault.
=20
Yesterday, when I saw an NIP at 0x900, I was ready to jump on the =
interrupts not being setup correctly, but after a few hours of going =
through that, I am now convinced the interrupts are setup correctly, so =
it is something more subtle.
=20
Certainly, memory corruption is the next thing to be concerned with.=20
=20
One thing that has concerned me a bit is that we have no swap space =
available at all. This is an embedded system with 64MByte of RAM and =
JFFS2 NAND flash with no swap partitions.
=20
I suspect auditing the MMU setup differences between the original 2.4 =
kernel and the new 2.6 kernel for the 8241 board is the next step.
=20
The three exceptions I saw yesterday were 1)0x900 in the =
timer_interrupt, 2) C00DEE18 (inside the tar program) and 3) C002CE68 =
(in one of the kernel routines).=20
=20
I suspect the actual addresses are red-herrings and this exception can =
occur at any address. This certainly would tend to indicate some sort of =
memory setup issue.
=20
Changing the Oops logic to printout the NextInstruction as well as the =
NIP might be helpful so I could discern the difference between what the =
program is trying to do and what it is really doing.
=20
Are there any other thoughts you might have on diagnosis techniques at =
this point?
=20
Charles
=20
=20
In the meantime, any thoughts you might have on methods to di
