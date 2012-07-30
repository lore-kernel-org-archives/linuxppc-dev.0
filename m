Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 339E62C032C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 21:22:42 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Jul 2012 16:52:38 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6UBMOlv21692556
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 16:52:24 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6UBMMxP027252
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 21:22:23 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V5 01/13] arch/powerpc: Use hpt_va to compute virtual address
Date: Mon, 30 Jul 2012 16:52:07 +0530
Message-Id: <1343647339-25576-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Don't open code the same

Reviewed-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/cell/beat_htab.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platforms/cell/beat_htab.c
index 943c9d3..b83077e 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -259,7 +259,7 @@ static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
 	u64 dummy0, dummy1;
 
 	vsid = get_kernel_vsid(ea, MMU_SEGSIZE_256M);
-	va = (vsid << 28) | (ea & 0x0fffffff);
+	va = hpt_va(ea, vsid, MMU_SEGSIZE_256M);
 
 	raw_spin_lock(&beat_htab_lock);
 	slot = beat_lpar_hpte_find(va, psize);
-- 
1.7.10
