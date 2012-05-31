Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B660B6FE0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 05:51:50 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 31 May 2012 19:41:31 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4VJifR734472102
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 05:44:41 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4VJpjZt017828
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 05:51:45 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 anton@samba.org
Subject: [Early RFC 1/6] arch/powerpc: Use hpt_va to compute virtual address
Date: Fri,  1 Jun 2012 01:20:36 +0530
Message-Id: <1338493841-9926-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1338493841-9926-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1338493841-9926-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Don't open code the same

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
