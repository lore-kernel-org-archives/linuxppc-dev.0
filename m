Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38CB1DE0F1
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 06:09:42 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0EJ89UZ004712
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 14:08:09 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0EJ9d0f168672
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 14:09:39 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0EJ9cgC024440
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 14:09:39 -0500
Subject: [PATCH] powerpc: is_hugepage_only_range() must account for both
	4kB and 64kB slices
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 14 Jan 2009 13:09:34 -0600
Message-Id: <1231960174.31244.8.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: is_hugepage_only_range() must account for both 4kB and 64kB slices

The subpage_prot syscall fails on second and subsequent calls for a given
region, because is_hugepage_only_range() is mis-identifying the 4 kB
slices when the process has a 64 kB page size.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index db44e02..ba51948 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -710,9 +710,18 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 			   unsigned long len)
 {
 	struct slice_mask mask, available;
+	unsigned int psize = mm->context.user_psize;
 
 	mask = slice_range_to_mask(addr, len);
-	available = slice_mask_for_size(mm, mm->context.user_psize);
+	available = slice_mask_for_size(mm, psize);
+#ifdef CONFIG_PPC_64K_PAGES
+	/* We need to account for 4k slices too */
+	if (psize == MMU_PAGE_64K) {
+		struct slice_mask compat_mask;
+		compat_mask = slice_mask_for_size(mm, MMU_PAGE_4K);
+		or_mask(available, compat_mask);
+	}
+#endif
 
 #if 0 /* too verbose */
 	slice_dbg("is_hugepage_only_range(mm=%p, addr=%lx, len=%lx)\n",

-- 
David Kleikamp
IBM Linux Technology Center
