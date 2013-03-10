Return-Path: <valentina.manea.m@gmail.com>
Received: from mail-wi0-x229.google.com (mail-wi0-x229.google.com
 [IPv6:2a00:1450:400c:c05::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C7B62C030A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2013 00:22:57 +1100 (EST)
Received: by mail-wi0-f169.google.com with SMTP id l13so503653wie.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Mar 2013 06:22:53 -0700 (PDT)
From: Valentina Manea <valentina.manea.m@gmail.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: place EXPORT_SYMBOL macro right after declaration
Date: Sun, 10 Mar 2013 15:22:39 +0200
Message-Id: <1362921759-23498-1-git-send-email-valentina.manea.m@gmail.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>, agraf@suse.de,
 linux-kernel@vger.kernel.org, suzuki@in.ibm.com, paulus@samba.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the following checkpatch.pl warnings:

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
+EXPORT_SYMBOL(kmap_prot);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
+EXPORT_SYMBOL(kmap_pte);

Signed-off-by: Valentina Manea <valentina.manea.m@gmail.com>
---
 arch/powerpc/mm/mem.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index f1f7409..056732e 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -66,10 +66,9 @@ unsigned long long memory_limit;
 
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
+EXPORT_SYMBOL(kmap_pte);
 pgprot_t kmap_prot;
-
 EXPORT_SYMBOL(kmap_prot);
-EXPORT_SYMBOL(kmap_pte);
 
 static inline pte_t *virt_to_kpte(unsigned long vaddr)
 {
-- 
1.7.9.5
