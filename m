Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id C8AF72BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Oct 2004 16:06:47 +1000 (EST)
Date: Mon, 18 Oct 2004 23:06:43 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20041018230643.A26497@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Remove bogus PPC44x prefetch workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch removes the bogus workaround for dcache prefetch
beyond the end of the physical memory.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net> 
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/mm/44x_mmu.c 1.5 vs edited =====
--- 1.5/arch/ppc/mm/44x_mmu.c	2004-10-05 23:05:22 -07:00
+++ edited/arch/ppc/mm/44x_mmu.c	2004-10-09 21:06:22 -07:00
@@ -55,10 +55,8 @@
 #include <asm/setup.h>
 
 #include "mmu_decl.h"
-#include "mem_pieces.h"
 
 extern char etext[], _stext[];
-extern struct mem_pieces phys_avail;
 
 /* Used by the 44x TLB replacement exception handler.
  * Just needed it declared someplace.
@@ -104,16 +102,6 @@
 {
 	unsigned int pinned_tlbs = 1;
 	int i;
-
-	/*
-	 * If lowmem is not on a pin tlb entry size boundary,
-	 * then reserve the last page of system memory. This
-	 * eliminates the possibility of a speculative dcache
-	 * fetch past the end of system memory that would
-	 * result in a machine check exception.
-	 */
-	if (total_lowmem | (PPC44x_PIN_SIZE - 1))
-		mem_pieces_remove(&phys_avail, total_lowmem - PAGE_SIZE, PAGE_SIZE, 1);
 
 	/* Determine number of entries necessary to cover lowmem */
 	pinned_tlbs = (unsigned int)
