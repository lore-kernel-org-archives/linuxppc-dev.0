Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3049DDF36
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 06:43:26 +1100 (EST)
Date: Tue, 5 Feb 2008 13:43:26 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] update_mmu_cache: Don't dcbst non-readable pages.
Message-ID: <20080205194326.GA13047@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, update_mmu_cache will crash if given a no-access PTE.  There's no
need to synchronize dcache/icache unless it's an exec mapping -- however,
due to the existence of older glibc versions that execute out of a
read-but-no-exec page, readability is tested instead.

This assumes no exec-only mappings; if such mappings become supported, they
will need to go through the kmap_atomic() version of dcache/icache
synchronization.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This fixes the following bug:
http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051080.html

 arch/powerpc/mm/mem.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index e812244..c7d7bd4 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -483,7 +483,12 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		 */
 		_tlbie(address, 0 /* 8xx doesn't care about PID */);
 #endif
-		if (!PageReserved(page)
+		/* The _PAGE_USER test should really be _PAGE_EXEC, but
+		 * older glibc versions execute some code from no-exec
+		 * pages, which for now we are supporting.  If exec-only
+		 * pages are ever implemented, this will have to change.
+		 */
+		if (!PageReserved(page) && (pte_val(pte) & _PAGE_USER)
 		    && !test_bit(PG_arch_1, &page->flags)) {
 			if (vma->vm_mm == current->active_mm) {
 				__flush_dcache_icache((void *) address);
-- 
1.5.3.8
