Return-Path: <benh@au1.ibm.com>
Received: from ausmtp02.au.ibm.com (ausmtp02.au.ibm.com [202.81.18.187])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "Sam Waja", Issuer "Sam Waja" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D78D167AB7
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Feb 2005 19:03:11 +1100 (EST)
Received: from sd0112e0.au.ibm.com (d23rh903.au.ibm.com [202.81.18.201])
	by ausmtp02.au.ibm.com (8.12.10/8.12.10) with ESMTP id j1N808hI055904
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Feb 2005 19:00:08 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0112e0.au.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j1N85R1P103028
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Feb 2005 19:05:27 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11/8.12.11) with ESMTP id j1N836m5005091
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Feb 2005 19:03:06 +1100
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 19:02:09 +1100
Message-Id: <1109145729.5412.213.camel@gaston>
Mime-Version: 1.0
Cc: "David S. Miller" <davem@redhat.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc32: Wrong vaddr in flush_hash_one_pte()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

Reworking the ppc32 mm helps me find interesting bugs in the existing bug,
well, brown paper bag for me, I made this one a while ago. The routine
flush_hash_one_pte() used by ptep_test_and_clear_young() wasn't properly
recaclulating the vaddr from the pte pointer & page->index. This fixes
it. The result is that we probably never flushed things from the hash,
so that's at least the _second_ bug affecting ptep_test_and_clear_young(),
swap on ppc32 must have been really broken :(

Please, apply to 2.6.11...

(I hope by early 2.6.12, we'll have David's patch that removes the need for
those hacks though, and just pass us the vaddr (and mm or vma) to all the
PTE accessors...)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/mm/tlb.c
===================================================================
--- linux-work.orig/arch/ppc/mm/tlb.c	2005-01-24 17:09:23.000000000 +1100
+++ linux-work/arch/ppc/mm/tlb.c	2005-02-23 18:53:49.000000000 +1100
@@ -62,7 +62,7 @@
 	ptepage = virt_to_page(ptep);
 	mm = (struct mm_struct *) ptepage->mapping;
 	ptephys = __pa(ptep) & PAGE_MASK;
-	addr = ptepage->index + (((unsigned long)ptep & ~PAGE_MASK) << 9);
+	addr = ptepage->index + (((unsigned long)ptep & ~PAGE_MASK) << 10);
 	flush_hash_pages(mm->context, addr, ptephys, 1);
 }
 
