Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.176]) by ozlabs.org (Postfix) with ESMTP id 218EB67A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 22:21:45 +1100 (EST)
Received: from [212.227.126.207] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CraNj-0006dr-00
	for linuxppc-embedded@ozlabs.org; Thu, 20 Jan 2005 12:21:43 +0100
Received: from [217.228.220.126] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CraNi-0006XV-00
	for linuxppc-embedded@ozlabs.org; Thu, 20 Jan 2005 12:21:42 +0100
Message-ID: <41EF94DB.4090604@anagramm.de>
Date: Thu, 20 Jan 2005 12:24:11 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Instruction Cache Parity Error / 2.6.10 on MPC8540
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

Well, I made good progress with Kernel 2.6.10 on my target (PM854, 
Microsys) which is very similar to the MPC8540_ads configuration.
But now, after working for several minutes, I ran into the following
Oops:

-----8<-------------------------------------------------------------
root@PM854:~/openssh-3.9p1$ Machine check in kernel mode.
Caused by (from MCSR=40000000): Instruction Cache Parity Error
Oops: machine check, sig: 7 [#1]
PREEMPT
NIP: C00054F8 LR: C01F8348 SP: C0263E70 REGS: c0232f50 TRAP: 0202    Not 
tainted
MSR: 00021000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0233720[0] 'swapper' THREAD: c0262000
Last syscall: 120
GPR00: C01F8348 C0263E70 C0233720 C0233720 C054C400 00000000 00000351 
00000000
GPR08: 00000000 00000003 C054C400 0000473A 0000AE53 00000000 10000700 
007FFF93
GPR16: 00000000 00000001 007FFF00 C02B0000 C02C0000 C0233884 3B9ACA00 
C02B5C78
GPR24: 000000F4 C02B5C78 C0233720 C054C400 C02AED00 00000000 00000000 
C0263E90
NIP [c00054f8] __switch_to+0x14/0x9c
LR [c01f8348] schedule+0x318/0x704
Call trace:
  [c01f8348] schedule+0x318/0x704
  [c00026c8] resume_kernel+0x38/0x5c
  [c00039f8] cpu_idle+0x28/0x40
  [c0001afc] rest_init+0x28/0x38
  [c0264804] start_kernel+0x16c/0x1a4
  [c0000364] skpinv+0x294/0x2d0
Kernel panic - not syncing: Attempted to kill the idle task!
  <0>Rebooting in 180 seconds..
-----8<-------------------------------------------------------------

Does this look familiar to anybody? Any ideas where to start
debugging?

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
