Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C09BB70CF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 18:16:49 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAH7GkX9008368
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 00:16:46 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAH7KGkB009805
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 01:20:16 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Subject: [RFC] powerpc/mm: honor O_SYNC flag for memory map
Date: Tue, 17 Nov 2009 15:10:32 +0800
Message-Id: <1258441832-20133-1-git-send-email-leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rather than the original intelligent way, we grant user more freedom.
This enables user to map cacheable memory not managed by Linux.

Signed-off-by: Li Yang <leoli@freescale.com>
---
The only direct users of this function is fb_mmap() and /dev/mem mmap.
Although I'm not sure if anything is depending on the intelligent setting of
cacheability.

 arch/powerpc/mm/mem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 579382c..0fd267e 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -101,7 +101,7 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 	if (ppc_md.phys_mem_access_prot)
 		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);
 
-	if (!page_is_ram(pfn))
+	if (file->f_flags & O_SYNC)
 		vma_prot = pgprot_noncached(vma_prot);
 
 	return vma_prot;
-- 
1.6.4
