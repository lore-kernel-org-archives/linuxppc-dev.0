Return-Path: <nacc@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17C89B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:06:42 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FHlhS3029036
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 13:47:43 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FI6ZtQ1970430
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:06:35 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8FI6Y5n019819
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 15:06:35 -0300
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 03/15] ppc64 iommu: fix check for direct DMA support
Date: Wed, 15 Sep 2010 11:05:46 -0700
Message-Id: <1284573958-8397-4-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: Milton Miller <miltonm@bga.com>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current check is wrong because it does not take the DMA offset intot
account, and in the case of a driver which doesn't actually support
64bits would falsely report that device as working.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/kernel/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 84d6367..494ab12 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -89,7 +89,7 @@ static int dma_direct_dma_supported(struct device *dev, u64 mask)
 	/* Could be improved so platforms can set the limit in case
 	 * they have limited DMA windows
 	 */
-	return mask >= (memblock_end_of_DRAM() - 1);
+	return mask >= get_dma_offset(dev) + (memblock_end_of_DRAM() - 1);
 #else
 	return 1;
 #endif
-- 
1.7.0.4
