Return-Path: <geliangtang@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP5BH0Z6pzDwHc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 02:00:55 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id p66so1271113pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 07:00:54 -0800 (PST)
From: Geliang Tang <geliangtang@gmail.com>
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: platforms: 83xx: use builtin_platform_driver
Date: Wed, 23 Nov 2016 23:00:45 +0800
Message-Id: <ef0ee6ed95fe3cf6943fb03e2a87bae9c6261c36.1479913207.git.geliangtang@gmail.com>
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
 arch/powerpc/platforms/83xx/suspend.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index 24717d0..08f92f6 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -441,8 +441,4 @@ static struct platform_driver pmc_driver = {
 	.remove = pmc_remove
 };
 
-static int pmc_init(void)
-{
-	return platform_driver_register(&pmc_driver);
-}
-device_initcall(pmc_init);
+builtin_platform_driver(pmc_driver);
-- 
2.9.3
