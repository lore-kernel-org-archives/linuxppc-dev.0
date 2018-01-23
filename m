Return-Path: <chrisadr@gentoo.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR0fm6C9hzDr07
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 07:45:04 +1100 (AEDT)
From: =?UTF-8?q?Christopher=20D=C3=ADaz=20Riveros?= <chrisadr@gentoo.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joe@perches.com, christian.koenig@amd.com, tyreld@linux.vnet.ibm.com,
 konrad.wilk@oracle.com, robh@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH-next] powerpc/fsl_pci: Use PTR_ERR_OR_ZERO
Date: Tue, 23 Jan 2018 15:37:52 -0500
Message-Id: <20180123203752.15057-1-chrisadr@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

This issue was detected by using the Coccinelle software.

Signed-off-by: Christopher Díaz Riveros <chrisadr@gentoo.org>
---
 arch/powerpc/sysdev/fsl_pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index cc20d2255d7f..142184635c81 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1304,10 +1304,7 @@ static int add_err_dev(struct platform_device *pdev)
 						   pdev->resource,
 						   pdev->num_resources,
 						   &pd, sizeof(pd));
-	if (IS_ERR(errdev))
-		return PTR_ERR(errdev);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(errdev);
 }
 
 static int fsl_pci_probe(struct platform_device *pdev)
-- 
2.16.0
