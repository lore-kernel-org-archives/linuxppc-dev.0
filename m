Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2743967A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 05:56:02 +1000 (EST)
Date: Thu, 16 Jun 2005 11:47:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050616144739.GA1559@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: map_page() and pinned TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dan,

So we've got rid of direct pte manipulators similar to what was done in v2.4.

Such patch for v2.6 is in the 8xx tree I posted previously, you've also seen 
it here in the list. 

Remaining problem is that map_page() is going to flush the TLB for the 
addresses being created. Obviously there is a collision with the 4kb 
PTE's, which thrases the 8Mbyte entry.

So what I have done internally is to simply comment out the 
flush_HPTE() call in map_page(), which does the trick.

What would be an elegant way of dealing with this? We can insert
a conditional there such that only addresses not covered 
by other mappings (in this case the 8Mbyte entry) get flushed.

Any better ideas?


diff -Nur --exclude-from=/home/marcelo/excl /mnt/test2/tslinux_mv21/linux-2.6/arch/ppc/mm/pgtable.c linux-2.6/arch/ppc/mm/pgtable.c
--- /mnt/test2/tslinux_mv21/linux-2.6/arch/ppc/mm/pgtable.c     2005-05-16 13:19:47.000000000 -0300
+++ linux-2.6/arch/ppc/mm/pgtable.c     2005-06-16 15:52:32.000000000 -0300
@@ -299,8 +299,8 @@
        if (pg != 0) {
                err = 0;
                set_pte(pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
-               if (mem_init_done)
-                       flush_HPTE(0, va, pmd_val(*pd));
+       //      if (mem_init_done)
+//                     flush_HPTE(0, va, pmd_val(*pd));
        }
        spin_unlock(&init_mm.page_table_lock);
        return err;
