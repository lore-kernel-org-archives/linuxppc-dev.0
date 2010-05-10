Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79984B7D4C
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 13:39:13 +1000 (EST)
Date: Mon, 10 May 2010 12:39:05 +0900
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: remove unused 'protect4gb' boot parameter
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20100510123903M.fujita.tomonori@lab.ntt.co.jp>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'protect4gb' boot parameter was introduced to avoid allocating dma
space acrossing 4GB boundary in 2007 (the commit
569975591c5530fdc9c7a3c45122e5e46f075a74).

In 2008, the IOMMU was fixed to use the boundary_mask parameter per
device properly. So 'protect4gb' workaround was removed (the
383af9525bb27f927511874f6306247ec13f1c28). But somehow I messed the
'protect4gb' boot parameter that was used to enable the
workaround. 

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/powerpc/kernel/iommu.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index ec94f90..d583917 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -43,20 +43,9 @@
 #define DBG(...)
 
 static int novmerge;
-static int protect4gb = 1;
 
 static void __iommu_free(struct iommu_table *, dma_addr_t, unsigned int);
 
-static int __init setup_protect4gb(char *str)
-{
-	if (strcmp(str, "on") == 0)
-		protect4gb = 1;
-	else if (strcmp(str, "off") == 0)
-		protect4gb = 0;
-
-	return 1;
-}
-
 static int __init setup_iommu(char *str)
 {
 	if (!strcmp(str, "novmerge"))
@@ -66,7 +55,6 @@ static int __init setup_iommu(char *str)
 	return 1;
 }
 
-__setup("protect4gb=", setup_protect4gb);
 __setup("iommu=", setup_iommu);
 
 static unsigned long iommu_range_alloc(struct device *dev,
-- 
1.6.5
