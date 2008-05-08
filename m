Return-Path: <Nick.Spence@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DDB01DDE00
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 15:27:38 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m485RW6R010142
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 22:27:32 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m485RWqh019774
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 00:27:32 -0500 (CDT)
From: nick.spence@freescale.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Reintroduce O_SYNC flag to make DRAM non-cached.
Date: Wed,  7 May 2008 22:26:32 -0700
Message-Id: <1210224392246-git-send-email-nick.spence@freescale.com>
Cc: Nick Spence <nick.spence@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Nick Spence <nick.spence@freescale.com>

This patch re-introduces the O_SYNC flag to make DRAM non-cached, which is the default behavior
for non PowerPC architectures in /drivers/char/mem.c

Signed-off-by: Nick Spence <nick.spence@freescale.com>
---
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5ccb579..f994b0a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -101,7 +101,7 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 	if (ppc_md.phys_mem_access_prot)
 		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);
 
-	if (!page_is_ram(pfn))
+	if ((file->f_flags & O_SYNC) || (!page_is_ram(pfn)))
 		vma_prot = __pgprot(pgprot_val(vma_prot)
 				    | _PAGE_GUARDED | _PAGE_NO_CACHE);
 	return vma_prot;
-- 
1.5.5
