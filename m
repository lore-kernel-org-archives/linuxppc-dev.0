Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F8E@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 - Spurious interrupt when calling __sti()
Date: Tue, 9 Apr 2002 10:53:45 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a custom board that uses an 8260 (rev. A.1 1K22A).
We've had for a long time a problem of spurious interrupt.
On kernel 2.4.10, at boot up, the following message was written to the
console:

  Unhandled interrupt 0, disabled

This message did not appear on kernel 2.4.18 (I don't know why),
but in /proc/interrupts, the number at the right of BAD was increasing
slowly.

When flooding the board through the network, thus generating a lot of
interrupts,
the number of BAD increased faster (but not as fast as the fenet).

[root@10.20.125.254 /]# cat /proc/interrupts
           CPU0
  4:        290   8260 SIU   Edge      uart
 33:     192388   8260 SIU   Edge      fenet
BAD:        738

Putting traces in the interrupt handler, it appeared that the interrupt
happened in '__sti()' (arch/ppc/kernel/misc.S), just after calling 'mtmsr'
to turn on the 'EE' bit.

I added a 'sync', between 'ori r3,r3,MSR_EE' and 'mtmsr r3',
and it has fixed the problem.

My questions are:
 - Did anybody encountered the same problem on that core?
 - Did anybody seen something about that in the user's manual and/or the
errata?
 - Is my fix correct, and should it be brought to other calls to 'mtmsr' ?



--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
