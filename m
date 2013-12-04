Return-Path: <kernelfans@gmail.com>
Received: from mail-ie0-x230.google.com (mail-ie0-x230.google.com
 [IPv6:2607:f8b0:4001:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 713A62C012D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 17:58:18 +1100 (EST)
Received: by mail-ie0-f176.google.com with SMTP id at1so26153952iec.35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Dec 2013 22:58:15 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc: mm: make _PAGE_NUMA take effect
Date: Wed,  4 Dec 2013 14:59:06 +0800
Message-Id: <1386140348-7854-2-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To enable the do_numa_page(), we should not fix _PAGE_NUMA in
hash_page(), so bail out for the case of pte_numa().

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index fb176e9..9bf1195 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1033,7 +1033,7 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 
 	/* Get PTE and page size from page tables */
 	ptep = find_linux_pte_or_hugepte(pgdir, ea, &hugeshift);
-	if (ptep == NULL || !pte_present(*ptep)) {
+	if (ptep == NULL || !pte_present(*ptep) || pte_numa(*ptep)) {
 		DBG_LOW(" no PTE !\n");
 		rc = 1;
 		goto bail;
-- 
1.8.1.4
