Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 88563B70CF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 16:31:22 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id nAH5SNXg017236
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 16:28:23 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAH5VKxv1667072
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 16:31:20 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAH5VKo4014516
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 16:31:20 +1100
Date: Tue, 17 Nov 2009 16:25:42 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [powerpc] Next tree Nov 2 : kernel BUG at mm/mmap.c:2135!
Message-ID: <20091117052542.GB2576@yookeroo>
References: <20091102173845.210d1c57.sfr@canb.auug.org.au>
	<4AEEA279.4040106@in.ibm.com> <4AF175D4.7030507@in.ibm.com>
	<20091105001650.GD3613@yookeroo.seuss>
	<4AFBEE98.2070208@in.ibm.com>
	<20091113013729.GB18848@yookeroo.seuss>
	<20091113021048.GA4865@yookeroo.seuss>
	<4AFD2865.5090503@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AFD2865.5090503@in.ibm.com>
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

On Fri, Nov 13, 2009 at 03:05:33PM +0530, Sachin Sant wrote:
> David Gibson wrote:
> >so, could you try booting the kernel with the patch below, which
> >should give a bit more information about the problem.
> >
> >Index: working-2.6/mm/mmap.c
> >===================================================================
> >--- working-2.6.orig/mm/mmap.c	2009-11-13 13:08:29.000000000 +1100
> >+++ working-2.6/mm/mmap.c	2009-11-13 13:09:26.000000000 +1100
> >@@ -2136,6 +2136,8 @@ void exit_mmap(struct mm_struct *mm)
> > 	while (vma)
> > 		vma = remove_vma(vma);
> >
> >+	if (nr_ptes != 0)
> >+		printk("exit_mmap(): mm %p nr_ptes %d\n", mm, mm->nr_ptes);
> > 	BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
> > }
> Here is the information collected with today's next.
> (2.6.32-rc7-20091113)
> 
> ------------[ cut here ]------------
> kernel BUG at mm/mmap.c:2139!
> cpu 0x3: Vector: 700 (Program Check) at [c0000000fae1b7e0]
>    pc: c000000000150e88: .exit_mmap+0x1ac/0x1d4
>    lr: c000000000150e78: .exit_mmap+0x19c/0x1d4
>    sp: c0000000fae1ba60
>   msr: 8000000000029032
>  current = 0xc0000000fada8be0
>  paca    = 0xc000000000bb2c00
>    pid   = 84, comm = cat
> kernel BUG at mm/mmap.c:2139!
> enter ? for help
> [c0000000fae1bb10] c000000000093d24 .mmput+0x54/0x164
> [c0000000fae1bba0] c000000000098f30 .exit_mm+0x17c/0x1a0
> [c0000000fae1bc50] c00000000009b310 .do_exit+0x248/0x784
> [c0000000fae1bd30] c00000000009b900 .do_group_exit+0xb4/0xe8
> [c0000000fae1bdc0] c00000000009b948 .SyS_exit_group+0x14/0x28
> [c0000000fae1be30] c0000000000085b4 syscall_exit+0x0/0x40
> --- Exception: c01 (System Call) at 00000fff89a8ff40
> SP (fffdf8a2460) is in userspace
> 
> Have attached the complete boot log.
> 
> At the time of crash values of mm and mm->nr_ptes were
> 
> <7>exit_mmap(): mm c0000000fa9f9580 nr_ptes 1

Hrm.  Ok.  I am truly baffled.  Well, below is a revised debug patch
which I hope will shed some sort of light on things.  I do also notice
from your full log that it looks like the bug is happening shortly
after we start userspace.  So it may be differences in my userspace
set up that meant I haven't been able to reproduce it.  I'll have
another look at that when I get a chance.

Index: working-2.6/mm/mmap.c
===================================================================
--- working-2.6.orig/mm/mmap.c	2009-11-17 11:55:23.000000000 +1100
+++ working-2.6/mm/mmap.c	2009-11-17 16:04:48.182600029 +1100
@@ -2136,6 +2136,9 @@ void exit_mmap(struct mm_struct *mm)
 	while (vma)
 		vma = remove_vma(vma);
 
+	if (mm->nr_ptes != 0)
+		printk("exit_mmap(): mm %p nr_ptes %d current %p pid %d comm \"%s\"\n",
+		       mm, mm->nr_ptes, current, current->pid, current->comm);
 	BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
 }
 
Index: working-2.6/mm/memory.c
===================================================================
--- working-2.6.orig/mm/memory.c	2009-11-17 11:55:23.000000000 +1100
+++ working-2.6/mm/memory.c	2009-11-17 14:57:49.881603609 +1100
@@ -156,6 +156,8 @@ static void free_pte_range(struct mmu_ga
 	pmd_clear(pmd);
 	pte_free_tlb(tlb, token, addr);
 	tlb->mm->nr_ptes--;
+	printk("free_pte_range() -> mm %p addr 0x%lx nr_ptes %d\n", tlb->mm,
+	       addr, tlb->mm->nr_ptes);
 }
 
 static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
@@ -348,6 +350,8 @@ int __pte_alloc(struct mm_struct *mm, pm
 	spin_lock(&mm->page_table_lock);
 	if (!pmd_present(*pmd)) {	/* Has another populated it ? */
 		mm->nr_ptes++;
+		printk("__pte_alloc() -> mm %p addr 0x%lx nr_ptes %d\n", mm,
+		       address, mm->nr_ptes);
 		pmd_populate(mm, pmd, new);
 		new = NULL;
 	}


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
