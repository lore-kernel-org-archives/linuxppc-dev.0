Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F16BCB7BCA
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 13:10:55 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id nAD2Asxh017103
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 13:10:54 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAD27cHj1179784
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 13:07:38 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAD2ArL3025661
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 13:10:53 +1100
Date: Fri, 13 Nov 2009 13:10:48 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Sachin Sant <sachinp@in.ibm.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [powerpc] Next tree Nov 2 : kernel BUG at mm/mmap.c:2135!
Message-ID: <20091113021048.GA4865@yookeroo.seuss>
References: <20091102173845.210d1c57.sfr@canb.auug.org.au>
	<4AEEA279.4040106@in.ibm.com> <4AF175D4.7030507@in.ibm.com>
	<20091105001650.GD3613@yookeroo.seuss>
	<4AFBEE98.2070208@in.ibm.com>
	<20091113013729.GB18848@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091113013729.GB18848@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 13, 2009 at 12:37:29PM +1100, David Gibson wrote:
> On Thu, Nov 12, 2009 at 04:46:40PM +0530, Sachin Sant wrote:
> > David Gibson wrote:
> > >On Wed, Nov 04, 2009 at 06:08:44PM +0530, Sachin Sant wrote:
> > >>Sachin Sant wrote:
> > >>>Today's next tree failed to boot on a POWER 6 box with :
> > >>>
> > >>>------------[ cut here ]------------
> > >>>kernel BUG at mm/mmap.c:2135!
> > >>>Oops: Exception in kernel mode, sig: 5 [#2]
> > >>>SMP NR_CPUS=1024 NUMA pSeries
> > >>Problem exists with today's next as well.
> > >>
> > >>Likely cause for this problem seems to the following commit.
> > >>If i revert this patch the machine boots fine.
> > >>
> > >>commit a0668cdc154e54bf0c85182e0535eea237d53146
> > >>powerpc/mm: Cleanup management of kmem_caches for pagetables
> > >
> > >Ugh.  Ok, it's not at all obvious how my patch could cause this bug.
> > >Can you send your .config?
> > >
> > Still present in today's next.
> 
> Sorry, I've been sidetracked by other issues and have only managed to
> look into this today.  My initial attempts to reproduce the bug with
> your config on both POWER6 and POWER5+ have failed though.
> 
> Is it possible to get the complete boot log from this system - not
> just the [cut here] section around the BUG()?  This should help to
> determine exactly when during boot the bug is being triggered.

Also, could you try booting the kernel with the patch below, which
should give a bit more information about the problem.

Index: working-2.6/mm/mmap.c
===================================================================
--- working-2.6.orig/mm/mmap.c	2009-11-13 13:08:29.000000000 +1100
+++ working-2.6/mm/mmap.c	2009-11-13 13:09:26.000000000 +1100
@@ -2136,6 +2136,8 @@ void exit_mmap(struct mm_struct *mm)
 	while (vma)
 		vma = remove_vma(vma);
 
+	if (nr_ptes != 0)
+		printk("exit_mmap(): mm %p nr_ptes %d\n", mm, mm->nr_ptes);
 	BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
 }
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
