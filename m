Return-Path: <geliangtang@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP5DR3668zDwLl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 02:02:47 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id p66so1274378pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 07:02:47 -0800 (PST)
From: Geliang Tang <geliangtang@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: sysdev: use builtin_platform_driver
Date: Wed, 23 Nov 2016 23:02:35 +0800
Message-Id: <79465ece0412529970feaf21d602d2f90fd7be0c.1479913329.git.geliangtang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/powerpc/sysdev/fsl_pmc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pmc.c b/arch/powerpc/sysdev/fsl_pmc.c
index 1d6fd7c..232225e 100644
--- a/arch/powerpc/sysdev/fsl_pmc.c
+++ b/arch/powerpc/sysdev/fsl_pmc.c
@@ -85,8 +85,4 @@ static struct platform_driver pmc_driver = {
 	.probe = pmc_probe,
 };
 
-static int __init pmc_init(void)
-{
-	return platform_driver_register(&pmc_driver);
-}
-device_initcall(pmc_init);
+builtin_platform_driver(pmc_driver);
-- 
2.9.3
