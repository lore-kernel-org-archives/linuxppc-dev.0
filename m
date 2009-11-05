Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DFD4AB7BB3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 11:16:55 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id nA50Gr7h014602
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:16:53 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA50DmwV1667172
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:13:48 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA50GqUd013219
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:16:53 +1100
Date: Thu, 5 Nov 2009 11:16:50 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [powerpc] Next tree Nov 2 : kernel BUG at mm/mmap.c:2135!
Message-ID: <20091105001650.GD3613@yookeroo.seuss>
References: <20091102173845.210d1c57.sfr@canb.auug.org.au>
	<4AEEA279.4040106@in.ibm.com> <4AF175D4.7030507@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AF175D4.7030507@in.ibm.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 04, 2009 at 06:08:44PM +0530, Sachin Sant wrote:
> Sachin Sant wrote:
> >Today's next tree failed to boot on a POWER 6 box with :
> >
> >------------[ cut here ]------------
> >kernel BUG at mm/mmap.c:2135!
> >Oops: Exception in kernel mode, sig: 5 [#2]
> >SMP NR_CPUS=1024 NUMA pSeries
> Problem exists with today's next as well.
> 
> Likely cause for this problem seems to the following commit.
> If i revert this patch the machine boots fine.
> 
> commit a0668cdc154e54bf0c85182e0535eea237d53146
> powerpc/mm: Cleanup management of kmem_caches for pagetables

Ugh.  Ok, it's not at all obvious how my patch could cause this bug.
Can you send your .config?

> >Modules linked in: ibmvscsic scsi_transport_srp scsi_tgt scsi_mod
> >NIP: c00000000014e30c LR: c00000000014e2f8 CTR: c00000000014db88
> >REGS: c0000000db703620 TRAP: 0700   Tainted: G      D
> >(2.6.32-rc5-autotest-next-20091102)
> >MSR: 8000000000029032 <EE,ME,CE,IR,DR>  CR: 24022442  XER: 2000000c
> >TASK = c0000000db7f6fe0[76] 'init' THREAD: c0000000db700000 CPU: 1
> >GPR00: 0000000000000001 c0000000db7038a0 c000000000b19900
> >0000000000000000
> >GPR04: c0000000db406a40 000000000000000c c0000000fe10c370
> >c000000000bb2800
> >GPR08: 000000000000db40 0000000000000000 c0000000dfdc0e00
> >000000000000000c
> >GPR12: 0000000044022442 c000000000bb2800 00000000ffffffff
> >ffffffffffffffff
> >GPR16: 0000000008430000 00000000003c0000 c0000000db703ea0
> >c0000000db569108
> >GPR20: c0000000db568908 0000000000000000 c0000000db703d60
> >0000000000000000
> >GPR24: 0000000000000001 0000000000040100 c0000000fe503580
> >c0000000db1ac180
> >GPR28: 0000000000000000 c000000000f812d0 c000000000a84f00
> >0000000000000000
> >NIP [c00000000014e30c] .exit_mmap+0x190/0x1b8
> >LR [c00000000014e2f8] .exit_mmap+0x17c/0x1b8
> >Call Trace:
> >[c0000000db7038a0] [c00000000014e2f8] .exit_mmap+0x17c/0x1b8 (unreliable)
> >[c0000000db703950] [c0000000000916cc] .mmput+0x54/0x164
> >[c0000000db7039e0] [c0000000000968d8] .exit_mm+0x17c/0x1a0
> >[c0000000db703a90] [c000000000098cb8] .do_exit+0x248/0x784
> >[c0000000db703b70] [c0000000000992a8] .do_group_exit+0xb4/0xe8
> >[c0000000db703c00] [c0000000000aca2c] .get_signal_to_deliver+0x3ec/0x478
> >[c0000000db703cf0] [c0000000000134ac] .do_signal+0x6c/0x31c
> >[c0000000db703e30] [c000000000008b7c] do_work+0x24/0x28
> >Instruction dump:
> >7c8407b4 387d0018 4800ab11 60000000 939d0008 7fe3fb78 4bfffdbd 7c7f1b79
> >4082fff4 e81b00e8 3120ffff 7c090110 <0b000000> 382100b0 e8010010 eb61ffd8
> >---[ end trace ec052ac77a8e7cb4 ]---
> >Fixing recursive fault but reboot is needed!
> >
> >mm/mmap.c:2135 corresponds to :
> >
> >BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
> >
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
