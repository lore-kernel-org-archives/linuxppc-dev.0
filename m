Return-Path: <hsaito.ppc@gmail.com>
Received: from densangw.densan.co.jp (densangw.densan.co.jp [218.222.200.50])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC404DE137
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 12:12:41 +1000 (EST)
Date: Mon, 25 May 2009 10:33:34 +0900 (JST)
Message-Id: <20090525.103334.68564567.saito@densan.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: can't flush tlb on e500
From: Hideo Saito <hsaito.ppc@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: hsaito.ppc@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

This report came from LKML, although I should post it here first,
the report said that there is a regression in linux-2.6.29 as to flushing a TLB entry that was going to be re-used when a context overflowed from the TLB.

On Fri, May 22, 2009 at 6:27 PM, Benjamin Herrenschmidt wrote:
> Have you verified that this change fixes your problem ?

I tested using "hackbench 100" and it was done successfully on my platform with e500(MPC8548).

>
> Can you re-submit to linuxppc-dev@ozlabs.org mailing list, along with
> proper changeset comment and signed-off-by: line ?

I am sorry I don't know as to the proper changeset comment.

Signed-off-by: Hideo Saito <hsaito.ppc@gmail.com>
---
--- arch/powerpc/mm/mmu_context_nohash.c.orig	2009-03-24 08:12:14.000000000 +0900
+++ arch/powerpc/mm/mmu_context_nohash.c	2009-05-20 18:33:53.000000000 +0900
@@ -122,22 +122,22 @@ static unsigned int steal_context_up(uns
 	struct mm_struct *mm;
 	int cpu = smp_processor_id();
 
 	/* Pick up the victim mm */
 	mm = context_mm[id];
 
 	pr_debug("[%d] steal context %d from mm @%p\n", cpu, id, mm);
 
-	/* Mark this mm has having no context anymore */
-	mm->context.id = MMU_NO_CONTEXT;
-
 	/* Flush the TLB for that context */
 	local_flush_tlb_mm(mm);
 
+	/* Mark this mm has having no context anymore */
+	mm->context.id = MMU_NO_CONTEXT;
+
 	/* XXX This clear should ultimately be part of local_flush_tlb_mm */
 	__clear_bit(id, stale_map[cpu]);
 
 	return id;
 }
 
 #ifdef DEBUG_MAP_CONSISTENCY
 static void context_check_map(void)
