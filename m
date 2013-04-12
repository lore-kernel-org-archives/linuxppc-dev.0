Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA0B82C014C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:18:07 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 12 Apr 2013 12:10:40 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7998E2CE8053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:17:34 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3C2HTwf12321186
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:17:29 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3C2HXbq019331
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 12:17:34 +1000
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 3/4] powerpc: Don't bolt the hpte in
 kernel_map_linear_page()
Date: Fri, 12 Apr 2013 10:16:59 +0800
Message-Id: <1365733021-28912-4-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: paulus@samba.org, Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems that in kernel_unmap_linear_page(), it only checks whether there
is a map in the linear_map_hash_slots array, so seems we don't need bolt
the hpte.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 716f42b..a7f54f0 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1281,7 +1281,7 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 	if (!vsid)
 		return;
 	ret = ppc_md.hpte_insert(hpteg, vpn, __pa(vaddr),
-				 mode, HPTE_V_BOLTED,
+				 mode, 0,
 				 mmu_linear_psize, mmu_kernel_ssize);
 	BUG_ON (ret < 0);
 	spin_lock(&linear_map_hash_lock);
-- 
1.7.9.5
