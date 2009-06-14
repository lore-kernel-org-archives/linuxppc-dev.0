Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0CAA1B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 21:38:34 +1000 (EST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E052DDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 21:38:32 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp08.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5EAmncp011065
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 16:18:49 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5EBcKZj757848
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 17:08:20 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5EBcKa0030975
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 17:08:20 +0530
Message-ID: <4A34E12B.4010000@in.ibm.com>
Date: Sun, 14 Jun 2009 17:08:19 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [OOPS] hugetlbfs tests with 2.6.30-rc8-git1
References: <4A290195.3080807@in.ibm.com> <1244233062.31984.6.camel@pasglop>
In-Reply-To: <1244233062.31984.6.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2009-06-05 at 16:59 +0530, Sachin Sant wrote:
>   
>> While executing Hugetlbfs tests against 2.6.30-rc8-git1 on a
>> Power 6 box observed the following OOPS message.
I was able to recreate this with 2.6.30-git7.
Here is the supporting data.

 cpu 0x1: Vector: 300 (Data Access) at [c0000000fe9b3220]
    pc: c00000000003d620: .hpte_need_flush+0x1bc/0x2d8
    lr: c00000000003d4d0: .hpte_need_flush+0x6c/0x2d8
    sp: c0000000fe9b34a0
   msr: 8000000000009032
   dar: c0000000283b0d78
 dsisr: 40000000
  current = 0xc0000000feb54700
  paca    = 0xc000000000c02600
    pid   = 6116, comm = stack_grow_into
enter ? for help
[c0000000fe9b34a0] c0000000fc6c0d80 (unreliable)
[c0000000fe9b3560] c00000000003f384 .huge_ptep_get_and_clear+0x40/0x5c
[c0000000fe9b35e0] c000000000149ea0 .__unmap_hugepage_range+0x178/0x2b8
[c0000000fe9b36d0] c00000000014a034 .unmap_hugepage_range+0x54/0x88
[c0000000fe9b3770] c000000000133db0 .unmap_vmas+0x178/0x8f4
[c0000000fe9b38c0] c0000000001396ec .exit_mmap+0xf4/0x1d0
[c0000000fe9b3960] c00000000008cf4c .mmput+0x68/0x14c
[c0000000fe9b39f0] c000000000091dc0 .exit_mm+0x16c/0x190
[c0000000fe9b3aa0] c0000000000941c4 .do_exit+0x204/0x748
[c0000000fe9b3b80] c00000000009479c .do_group_exit+0x94/0xc8
[c0000000fe9b3c10] c0000000000a321c .get_signal_to_deliver+0x384/0x3e4
[c0000000fe9b3cf0] c000000000013d48 .do_signal+0x6c/0x2f8
[c0000000fe9b3e30] c000000000008afc do_work+0x24/0x28
--- Exception: 300 (Data Access) at 0000000010002154
SP (ef8b8820) is in userspace
1:mon> r
R00 = 0000000000000000   R16 = 0000000040040000
R01 = c0000000fe9b34a0   R17 = 0000000040040000
R02 = c000000000b07610   R18 = ffffffffffffffff
R03 = 0000000000000004   R19 = 0000000000000000
R04 = 00000000ef000000   R20 = c0000000fc070000
R05 = c0000000283a8d78   R21 = 00000000f0000000
R06 = 00001b4008001393   R22 = c0000000283a8d78
R07 = 0000000000000001   R23 = 00000000007a0000
R08 = 0000000000000004   R24 = 0000000000000000
R09 = c0000000283b8d78   R25 = 00001b4008001393
R10 = 00000000000000ef   R26 = c0000000fc070000
R11 = 0000000000250000   R27 = 0000000000000004
R12 = 0000000024022422   R28 = c0000000008e0518
R13 = c000000000c02600   R29 = 0000000000000000
R14 = c00000001bed0f00   R30 = c000000001080518
R15 = c0000000db0c0020   R31 = fe967b124f000000
pc  = c00000000003d620 .hpte_need_flush+0x1bc/0x2d8
lr  = c00000000003d4d0 .hpte_need_flush+0x6c/0x2d8
msr = 8000000000009032   cr  = 44022422
ctr = 000000000000bba4   xer = 0000000000000001   trap =  300
dar = c0000000283b0d78   dsisr = 40000000
1:mon> di $.hpte_need_flush
....... snip .......
c00000000003d604  4800000c      b       c00000000003d610        # .hpte_need_flush+0x1ac/0x2d8
c00000000003d608  792945c6      rldicr  r9,r9,40,23
c00000000003d60c  7be00600      clrldi  r0,r31,24
c00000000003d610  7d3f0378      or      r31,r9,r0
c00000000003d614  7c1cb82e      lwzx    r0,r28,r23
c00000000003d618  3d360001      addis   r9,r22,1
c00000000003d61c  2f800000      cmpwi   cr7,r0,0
c00000000003d620  eb898000      ld      r28,-32768(r9)
c00000000003d624  409e0028      bne     cr7,c00000000003d64c    # .hpte_need_flush+0x1e8/0x2d8
c00000000003d628  7fe3fb78      mr      r3,r31
c00000000003d62c  7f24cb78      mr      r4,r25
c00000000003d630  7f85e378      mr      r5,r28
c00000000003d634  7f6607b4      extsw   r6,r27
c00000000003d638  7fa7eb78      mr      r7,r29
c00000000003d63c  39000000      li      r8,0
....... snip .......

This is on a power6 box with 2.4 hugetlbfs tests.
hugetlb test run log ...

truncate_above_4GB (16M: 32):   PASS
truncate_above_4GB (16M: 64):   PASS
brk_near_huge (16M: 32):        PASS
brk_near_huge (16M: 64):        PASS
task-size-overrun (16M: 32):    PASS
task-size-overrun (16M: 64):    PASS
stack_grow_into_huge (16M: 32):  ==> fails here


Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
