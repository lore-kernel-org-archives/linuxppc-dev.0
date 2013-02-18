Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEAB12C029C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:48 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 15:55:25 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6D37C3940053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:38 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1IASaHb22872190
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 15:58:36 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1IASbQQ001237
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 21:28:38 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 15/17] powerpc: hypervisor require few WIMG bit set
Date: Mon, 18 Feb 2013 15:58:13 +0530
Message-Id: <1361183295-6958-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361183295-6958-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Without this insert will return H_PARAMETER error. Also use
the signed variant when printing error.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/largepage-hash64.c    |    2 ++
 arch/powerpc/platforms/pseries/lpar.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/largepage-hash64.c b/arch/powerpc/mm/largepage-hash64.c
index 2a5fc39..20a626e 100644
--- a/arch/powerpc/mm/largepage-hash64.c
+++ b/arch/powerpc/mm/largepage-hash64.c
@@ -123,6 +123,8 @@ repeat:
 		/* Add in WIMG bits. FIXME!! enabled by default */
 		rflags |= (new_pmd & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
 				      _PAGE_COHERENT | _PAGE_GUARDED));
+#else
+		rflags |= _PAGE_COHERENT;
 #endif
 		/* Insert into the hash table, primary slot */
 		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index ca9c2bb..3daced3 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -155,7 +155,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	 */
 	if (unlikely(lpar_rc != H_SUCCESS)) {
 		if (!(vflags & HPTE_V_BOLTED))
-			pr_devel(" lpar err %lu\n", lpar_rc);
+			pr_devel(" lpar err %ld\n", lpar_rc);
 		return -2;
 	}
 	if (!(vflags & HPTE_V_BOLTED))
-- 
1.7.10
