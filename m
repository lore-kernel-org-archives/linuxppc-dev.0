Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B09A0B7BA5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 22:25:25 +1000 (EST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [59.145.155.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85EEDDDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 22:25:23 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp04.in.ibm.com (8.14.3/8.13.1) with ESMTP id n6UCPGGx029720
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 17:55:16 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UCPF5r880726
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 17:55:16 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n6UCPF33029943
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 22:25:15 +1000
Message-ID: <4A719129.5030302@in.ibm.com>
Date: Thu, 30 Jul 2009 17:55:13 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Next July 29 : Hugetlb test failure (OOPS free_hugepte_range)
References: <20090729173611.b82478cd.sfr@canb.auug.org.au>
	<4A706504.6040704@in.ibm.com>
In-Reply-To: <4A706504.6040704@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sachin Sant wrote:
> next-20090728 worked fine. Last commit that changed
> arch/powerpc/mm/hugetlbpage.c was 
> cb7f3f2d92d1b26c13e30e639b6ee4a78e9a3afa
>
> powerpc: Add memory management headers for new 64-bit BookE
>
> I will try reverting that commit and check if that helps.
Hi Ben,

Reverting the above patch helped. The tests ran fine against the
patched kernel. But ofcourse that's not the solution :-)

Here is some data from xmon that might help find the reason for
the failure. This is with today's next.

: ------------[ cut here ]------------
cpu 0x0: Vector: 700 (Program Check) at [c000000038923560]
    pc: c0000000000486d4: .free_hugepte_range+0x68/0xa0
    lr: c000000000048954: .hugetlb_free_pgd_range+0x248/0x38c
    sp: c0000000389237e0
   msr: 8000000000029032
  current = 0xc00000003b1d7780
  paca    = 0xc000000001002400
    pid   = 2839, comm = readback
kernel BUG at /home/linux-2.6.31-rc4/arch/powerpc/include/asm/pgalloc.h:36!
enter ? for help
[c000000038923880] c000000000048954 .hugetlb_free_pgd_range+0x248/0x38c
[c000000038923970] c000000000165a48 .free_pgtables+0xa0/0x154
[c000000038923a30] c000000000167f78 .exit_mmap+0x13c/0x1cc
[c000000038923ae0] c0000000000997ec .mmput+0x68/0x14c
[c000000038923b70] c00000000009f1d4 .exit_mm+0x190/0x1b8
[c000000038923c20] c0000000000a16e8 .do_exit+0x214/0x784
[c000000038923d00] c0000000000a1d1c .do_group_exit+0xc4/0xf8
[c000000038923da0] c0000000000a1d7c .SyS_exit_group+0x2c/0x48
[c000000038923e30] c0000000000085b4 syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000fe15038
SP (ffb8e030) is in userspace
0:mon> e
cpu 0x0: Vector: 700 (Program Check) at [c000000038923560]
    pc: c0000000000486d4: .free_hugepte_range+0x68/0xa0
    lr: c000000000048954: .hugetlb_free_pgd_range+0x248/0x38c
    sp: c0000000389237e0
   msr: 8000000000029032
  current = 0xc00000003b1d7780
  paca    = 0xc000000001002400
    pid   = 2839, comm = readback
kernel BUG at /home/linux-2.6.31-rc4/arch/powerpc/include/asm/pgalloc.h:36!
0:mon> r
R00 = 0000000000000001   R16 = 0000000000000000
R01 = c0000000389237e0   R17 = 0000000000000001
R02 = c000000000f165a8   R18 = 000000003fffffff
R03 = c0000000014504d0   R19 = 0000000000000000
R04 = c000000039390001   R20 = 0000000000000000
R05 = 0000000000000007   R21 = 0000010000000000
R06 = 0000000000000000   R22 = 0000000040000000
R07 = 0000000040000000   R23 = c0000000014504d0
R08 = c00000003d708188   R24 = 000000003fffffff
R09 = c00000003eb40000   R25 = 0000000000000007
R10 = c00000003d708188   R26 = c00000003ebd41b8
R11 = 0000000000000018   R27 = c0000000014504d0
R12 = 0000000040000448   R28 = c00000003eb40018
R13 = c000000001002400   R29 = 0000000000000008
R14 = 00000000ffffffff   R30 = 0000000040000000
R15 = 00000000ffffffff   R31 = c0000000389237e0
pc  = c0000000000486d4 .free_hugepte_range+0x68/0xa0
lr  = c000000000048954 .hugetlb_free_pgd_range+0x248/0x38c
msr = 8000000000029032   cr  = 20042444
ctr = 800000000000b6f4   xer = 0000000000000001   trap =  700
0:mon> 

Line 36 of arch/powerpc/include/asm/pgalloc.h corresponds to

BUG_ON(cachenum > PGF_CACHENUM_MASK);

May be something to do with number of elements in huge_pgtable_cache_name ??

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
