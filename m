Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4B292C03C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 23:14:09 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 9 Jul 2012 12:54:12 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q69D5qMQ2228494
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 23:05:52 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q69DDo3G029854
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 23:13:51 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V3 01/11] arch/powerpc: Use hpt_va to compute virtual address
Date: Mon,  9 Jul 2012 18:43:31 +0530
Message-Id: <1341839621-28332-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
