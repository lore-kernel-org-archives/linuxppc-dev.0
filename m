Return-Path: <soniccat.liu@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77AE6B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2012 21:44:09 +1100 (EST)
Received: by iakh37 with SMTP id h37so7350936iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2012 03:44:06 -0700 (PDT)
From: soniccat.liu@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fsl_msi : return proper error value when ioremap
 failed.
Date: Thu,  8 Mar 2012 14:47:37 -0800
Message-Id: <1331246857-5622-1-git-send-email-soniccat.liu@gmail.com>
Cc: Liu Shuo <soniccat.liu@gmail.com>, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liu Shuo <soniccat.liu@gmail.com>

Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
---
 arch/powerpc/sysdev/fsl_msi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index ecb5c19..0bab156 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -410,6 +410,7 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 
 		msi->msi_regs = ioremap(res.start, resource_size(&res));
 		if (!msi->msi_regs) {
+			err = -ENOMEM;
 			dev_err(&dev->dev, "could not map node %s\n",
 				dev->dev.of_node->full_name);
 			goto error_out;
-- 
1.7.4.1
