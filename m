Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.kontron-modular.com
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id 4BB1C67BF3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 03:23:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: memory corruption after MMU turned on
Date: Thu, 16 Nov 2006 17:11:46 +0100
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E2699@kom-mailsrv1.kontron-modular.com>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
To: "Lei Sun" <leisun124@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Lei,

if you are trying to step over RFI using the BDI2000-probe (propably =
also with other probes), this problem could be caused by the probe.

I had similar problems in an early phase of an 8270 project. It is not =
possible to step over RFI; and it is always dangerous to debug through =
MMU initialization code with the probe.

You could work around this by setting a Breakpoint instruction after =
MMU-initialization, hoping, that the code will reach this point.
If also this doesnt help, i could only recommend to set some HW-signals, =
in the best case a register with LED's behind to see, whether your =
system reaches particular code areas.

--=20
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com

-----BEGIN GEEK CODE BLOCK-----
  Version: 3.1
  GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
  K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
  D-- G e++> h--- !r x+++
------END GEEK CODE BLOCK------
=20


-----Original Message-----
From: linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+claus.gindhart=3Dkontron.com@ozlabs.org=
]
On Behalf Of Lei Sun
Sent: Donnerstag, 16. November 2006 16:45
To: linuxppc-embedded@ozlabs.org
Subject: memory corruption after MMU turned on


Hi all:
   I am trying to bring up customized board based on MPC8270, the
kernel version is 2.4.30, it works fine on one of the Eval board
(PQ2FADS-VR, which use MPC8275).
   The kernel hangs after uncompressing is done, further debug shows
that it hangs right after "rfi " instruction of the turn_on_mmu:
function in head.S

 turn_on_mmu:
    240     mfmsr   r0
    241     ori r0,r0,MSR_DR|MSR_IR
    242     mtspr   SRR1,r0
    243     lis r0,start_here@h
    244     ori r0,r0,start_here@l
    245     mtspr   SRR0,r0
    246     SYNC
    247     RFI             /* enables MMU */

After i step over the RFI instruction, the PC points to C000XXX , but
all memory content is 0 by then.
my BATU0 is 0xC000FFE0  BATL0 is 0x00000002, I have 128MB RAM. The
u-boot works fine, without MMU turned on. We do have some hardware
problem, such that i have to lower the bus frequency to make the SDRAM
stable. What physical parameter could cause the board not working with
MMU on?

Any suggestion?

Thanks
lei
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
