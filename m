Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7AF542C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 05:37:52 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Apr 2013 01:03:26 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E59DB125805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 01:09:25 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3SJbcKk60686504
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 01:07:39 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3SJbiNO003047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 05:37:44 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com,
 linux-mm@kvack.org
Subject: [PATCH -V7 04/18] powerpc: Use signed formatting when printing error
Date: Mon, 29 Apr 2013 01:07:25 +0530
Message-Id: <1367177859-7893-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

PAPR defines these errors as negative values. So print them accordingly
for easy debugging.

Acked-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 299731e..9b02ab1 100644
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
1.8.1.2
