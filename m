Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D21EFB7D43
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jun 2010 01:39:29 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Li Yang <leoli@freescale.com>, Kumar Gala <galak@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix a compile error in fsl_msi.c
Date: Wed,  2 Jun 2010 20:07:12 +0800
Message-Id: <1275480432-22970-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit 061ca4ad still use the old style to refer to device
node, and cause the following compile error.
arch/powerpc/sysdev/fsl_msi.c: In function 'fsl_of_msi_probe':
arch/powerpc/sysdev/fsl_msi.c:350: error: 'struct of_device' has no member named 'node'

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/sysdev/fsl_msi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 0f5bee9..962c2d8 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -347,7 +347,7 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 		goto error_out;
 	}
 	offset = 0;
-	p = of_get_property(dev->node, "msi-available-ranges", &len);
+	p = of_get_property(dev->dev.of_node, "msi-available-ranges", &len);
 	if (p)
 		offset = *p / IRQS_PER_MSI_REG;
 
-- 
1.6.3.1
