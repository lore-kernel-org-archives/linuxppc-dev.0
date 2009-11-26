Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 564DAB6F14
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 19:09:20 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAQ89G3x025806
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 01:09:17 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAQ8DXKX001115
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 02:13:34 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: honor O_SYNC flag for memory mapping
Date: Thu, 26 Nov 2009 16:02:09 +0800
Message-Id: <1259222529-27645-1-git-send-email-leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There was no way to set mapped memory as cacheable if the memory
is not managed by Linux kernel.  It's not rare in real system to
allocate some dedicated memory to a certain application which is not
managed by kernel and then mmap'ed the memory to the application.
The memory should be cacheable but we can't map it to be cacheable
due to the intelligent setting of cacheability.

The patch makes the cacheability depend on O_SYNC flag of the file
mapped for non-kernel managed memory.  Also prints a deprecation
warning for mmap users without using O_SYNC.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/mm/mem.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 579382c..b9ef77a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -101,8 +101,17 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 	if (ppc_md.phys_mem_access_prot)
 		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);
 
-	if (!page_is_ram(pfn))
-		vma_prot = pgprot_noncached(vma_prot);
+	/* kernel managed memory is always cacheable, otherwise is controlled
+	 * by O_SYNC flag of open() */
+	if (!page_is_ram(pfn)) {
+		if (file->f_flags & O_SYNC)
+			vma_prot = pgprot_noncached(vma_prot);
+		else
+			printk(KERN_WARNING
+				"Warning: mmap on file without O_SYNC will be "
+				"mapped as cacheable.  Make sure it is desired."
+				"\n");
+	}
 
 	return vma_prot;
 }
-- 
1.6.4
