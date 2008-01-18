Return-Path: <mpm@selenic.com>
Received: from waste.org (waste.org [66.93.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "waste.org", Issuer "waste.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AFED7DDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 11:47:40 +1100 (EST)
Subject: Re: 2.6.24-rc8-mm1: powerpc oopses
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080117162913.0323c517.akpm@linux-foundation.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<200801172315.28129.m.kozlowski@tuxland.pl>
	<20080117145105.ad968ea6.akpm@linux-foundation.org>
	<1200613194.3839.22.camel@cinder.waste.org>
	<20080117160513.3456b4eb.akpm@linux-foundation.org>
	<1200615168.3839.26.camel@cinder.waste.org>
	<20080117162913.0323c517.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 17 Jan 2008 18:47:17 -0600
Message-Id: <1200617237.3839.32.camel@cinder.waste.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, m.kozlowski@tuxland.pl, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-01-17 at 16:29 -0800, Andrew Morton wrote:
> Do we need `offset' at all?

Looks like no.

I wonder if there's a good argument for adding a pte_offset_val() which
would let us do:

pteval = pte_offset_val(pmd, addr);

and shrink the map/unmap window and overhead here and possibly
elsewhere?

Anyway, updated but still untested patch now with revealing comment:

diff -r 5595adaea70f fs/proc/task_mmu.c
--- a/fs/proc/task_mmu.c	Thu Jan 17 13:26:54 2008 -0600
+++ b/fs/proc/task_mmu.c	Thu Jan 17 18:45:57 2008 -0600
@@ -584,18 +585,19 @@
 	pte_t *pte;
 	int err = 0;
 
-	pte = pte_offset_map(pmd, addr);
-	for (; addr != end; pte++, addr += PAGE_SIZE) {
+	for (; addr != end; addr += PAGE_SIZE) {
 		u64 pfn = PM_NOT_PRESENT;
+		pte = pte_offset_map(pmd, addr);
 		if (is_swap_pte(*pte))
 			pfn = swap_pte_to_pagemap_entry(*pte);
 		else if (pte_present(*pte))
 			pfn = pte_pfn(*pte);
+		/* unmap so we're not in atomic when we copy to userspace */
+		pte_unmap(pte);
 		err = add_to_pagemap(addr, pfn, pm);
 		if (err)
 			return err;
 	}
-	pte_unmap(pte - 1);
 
 	cond_resched();
 


-- 
Mathematics is the supreme nostalgia of our time.
