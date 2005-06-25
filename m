Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1E1267A5D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Jun 2005 07:16:47 +1000 (EST)
Date: Sat, 25 Jun 2005 12:11:05 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050625151105.GB32117@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Rini <trini@kernel.crashing.org>, Kumar Gala <galak@freescale.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: merge 8xx longstanding MM bug workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Lets agree on something and merge please

The proposed _tlbie call at update_mmu_cache() is safe because:

Addresses for which update_mmu_cache() gets invocated are never inside the 
static kernel virtual mapping, meaning that there is no risk for the _tlbie()
here to be thrashing the pinned entry, as Dan suspected.

The intermediate TLB state in which this bug can be triggered is not visible
by userspace or any other contexts, except the page fault handling path. 
So there is no need to worry about userspace dcbxxx users.

The other solution to this is to avoid dcbst misbehaviour in the first place, 
which  involves changing in-kernel "dcbst" callers to use 8xx specific SPR's 
instead, as noted by Dan. 
What are the arguments in favour of it? Is it worth doing that?


    [PATCH] 8xx: avoid "dcbst" misbehaviour with unpopulated TLB

     On 8xx, cache control instructions (particularly "dcbst" from
     flush_dcache_icache) fault as write operation if there is an
     unpopulated TLB entry for the address in question. To workaround
     that, we invalidate the TLB here, thus avoiding dcbst misbehaviour.

diff --git a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c
+++ b/arch/ppc/mm/init.c
@@ -622,6 +622,14 @@ void update_mmu_cache(struct vm_area_str
 		if (!PageReserved(page)
 		    && !test_bit(PG_arch_1, &page->flags)) {
 			if (vma->vm_mm == current->active_mm)
+#ifdef CONFIG_8xx
+/* On 8xx, cache control instructions (particularly "dcbst" from
+ * flush_dcache_icache) fault as write operation if there is an
+ * unpopulated TLB entry for the address in question. To workaround
+ * that, we invalidate the TLB here, thus avoiding dcbst misbehaviour.
+ */
+			_tlbie(address);
+#endif
 				__flush_dcache_icache((void *) address);
 			else
 				flush_dcache_icache_page(page);
