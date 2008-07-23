Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id C2D35DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 17:22:29 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KLYg6-0004sA-A8
	for linuxppc-embedded@ozlabs.org; Wed, 23 Jul 2008 00:22:26 -0700
Message-ID: <18605311.post@talk.nabble.com>
Date: Wed, 23 Jul 2008 00:22:26 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: kernel panic while using alloc_bootmem()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all ,

I am getting kernel panic while allocating memory at boottime in my driver
which is linked to the kernel following is the code snapshort from driver
init module .

 buf_area = alloc_bootmem_low(0x900000);
 if(buf_area == NULL)
 {
      printk(" ################## Memory allocation failed \n");
       return -1;

  }

following is the error message :-

###################### bootmem driver init call start #################
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0
PC is at _find_first_zero_bit_le+0xc/0x2c
LR is at __alloc_bootmem_core+0x138/0x334
pc : [<c0152b58>]    lr : [<c00132d0>]    Not tainted
sp : c043df38  ip : 00000000  fp : c043df74
r10: 00000000  r9 : 00000900  r8 : 00900000
r7 : 00000001  r6 : 00000020  r5 : c02fa9e0  r4 : 000fffff
r3 : 00007700  r2 : 00000000  r1 : 00007700  r0 : 00000000
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F
Table: 80004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc043c250)
Stack: (0xc043df38 to 0xc043e000)
df20:                                                       c018195c
ffffffe0
df40: 00007700 00000000 c043df84 c02fa9e0 00900000 00000000 00000020
00000000
df60: 00000000 00000000 c043df9c c043df78 c0013538 c00131a4 ffffffff
c043df94
df80: c001e504 c001dfd8 c043c000 00000001 c043dfac c043dfa0 c001ae98
c0013500
dfa0: c043dff4 c043dfb0 c00200c8 c001ae80 00000000 00000000 c002002c
c0041eb8
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
dfe0: 00000000 00000000 00000000 c043dff8 c0041eb8 c0020038 c021c9dc
c021cb50
Backtrace:
[<c0013198>] (__alloc_bootmem_core+0x0/0x334) from [<c0013538>]
(__alloc_bootmem_low+0x44/0x94)
[<c00134f4>] (__alloc_bootmem_low+0x0/0x94) from [<c001ae98>]
(FlukeDriverInit+0x24/0x7c)
 r7 = 00000001  r6 = C043C000  r5 = C001DFD8  r4 = C001E504
[<c001ae74>] (FlukeDriverInit+0x0/0x7c) from [<c00200c8>] (init+0x9c/0x27c)
[<c002002c>] (init+0x0/0x27c) from [<c0041eb8>] (do_exit+0x0/0x93c)
 r7 = 00000000  r6 = 00000000  r5 = 00000000  r4 = 00000000
Code: e49df008 e3310000 0a000006 e3a02000 (e7d031a2)
 <0>Kernel panic - not syncing: Attempted to kill init!

---Misbah <><

-- 
View this message in context: http://www.nabble.com/kernel-panic-while-using-alloc_bootmem%28%29-tp18605311p18605311.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
