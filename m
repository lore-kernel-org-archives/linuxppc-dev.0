Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9DF5DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 06:56:21 +1100 (EST)
Subject: RE: Exception in kernel mode
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 15 Mar 2007 12:56:19 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A19A@MERCURY.inside.istor.com>
In-Reply-To: <7691A67C-C3D9-4882-9BCC-E3AA617AD11E@kernel.crashing.org>
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




Can you post the oops that you are seeing, what you need to find out =20
is what instruction image that is causing the illegal instruction =20
exception.  Once you have that it will be easier to figure out what's =20
going on.

- k

Dear Kumar:

Here is the Oops, and thank you for looking at this. Things have come to
a halt here until I can figure this one out as about 6 engineers are
going "We cannot use an unreliable 2.6 kernel, fix it immediately, Mr.
Kernel Guy".

 Basically, what was happening was a 'tar -xvzf' was underway whose
source was an nfs mount (root =3D /dev/nfs) and whose destination was
formatted NAND flash (flash_eraseall -q -j /dev/mtd3, then mounted with
'mount -t jffs2 /dev/mtdblockx /mnt/mtdblockx').

Since I sent the last exchange, I see in the kernel source something
about ALTIVEC??. It isnt possible that ALTIVEC needs to be defined for
the 8241 is it?

Charles

rootfs/sbin/fsck.ext3
Oops: Exception in kernel mode, sig: 4 [#1]
PREEMPT
NIP: 00000900 LR: C00E579C CTR: 00003A55
REGS: c37f3b00 TRAP: 0700   Not tainted  (2.6.17.11)
MSR: 00081000 <ME>  CR: 24022484  XER: 00000000
TASK =3D c3eaf810[940] 'tar' THREAD: c37f2000
GPR00: 00003FFF C37F3BB0 C3EAF810 C40216BC 00000000 0000FFFE C4022D64
00008000
GPR08: C4000A74 C40316BC C4000980 C40216BC C4000000 10045C90 C37F3CE0
C01D3B68
GPR16: C3ECC5A0 C37F3C50 00002200 00000000 C2A9E000 C2000000 00000000
00001000
GPR24: 00000000 00000000 C01D0000 C2000000 C37F3C58 00000002 00000000
C4000000
Call Trace:
[C37F3BB0] [C00E5764]  (unreliable)
[C37F3BD0] [C00C93C4]
[C37F3BF0] [C00B988C]
[C37F3C40] [C00C0644]
[C37F3C90] [C00BBA94]
[C37F3CD0] [C003B8A8]
[C37F3D90] [C003C270]
[C37F3E20] [C003C320]
[C37F3EC0] [C003C470]
[C37F3EF0] [C0055F80]
[C37F3F10] [C00560C0]
[C37F3F40] [C00041A0]
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
