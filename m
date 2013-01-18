Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C73C92C007B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2013 06:17:01 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 18 Jan 2013 14:16:58 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5E6796E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 14:16:54 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0IJGdkL60096638
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 14:16:39 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0IJGcUE018401
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 14:16:39 -0500
Date: Fri, 18 Jan 2013 11:16:24 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] pseries/iommu: Fix iteration in DDW TCE clearrange
Message-ID: <20130118191624.GB25500@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nfont@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 miltonm@bga.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tce_clearrange_multi_pSeriesLP is attempting to iterate over all TCEs in
a given range. However, is it not advancing the dma_offset value passed
to plpar_tce_stuff via the next value. This prevents DLPAR from
completing, because TCEs are still present at slot isolation time.
    
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index e2685ba..a55b685 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -382,6 +382,7 @@ static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
 		rc = plpar_tce_stuff((u64)be32_to_cpu(maprange->liobn),
 					     dma_offset,
 					     0, limit);
+		next += limit * tce_size;
 		num_tce -= limit;
 	} while (num_tce > 0 && !rc);
 
