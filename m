Return-Path: <geliangtang@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP58D452YzDvMX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 01:59:08 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id p66so1268105pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:59:07 -0800 (PST)
From: Geliang Tang <geliangtang@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/eeh/of: use builtin_platform_driver
Date: Wed, 23 Nov 2016 22:58:56 +0800
Message-Id: <5f8659707d87126507e163dcada64c6f8923933e.1479913108.git.geliangtang@gmail.com>
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
 arch/powerpc/kernel/of_platform.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index b60a67d..34aeac5 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -114,11 +114,6 @@ static struct platform_driver of_pci_phb_driver = {
 	},
 };
 
-static __init int of_pci_phb_init(void)
-{
-	return platform_driver_register(&of_pci_phb_driver);
-}
-
-device_initcall(of_pci_phb_init);
+builtin_platform_driver(of_pci_phb_driver);
 
 #endif /* CONFIG_PPC_OF_PLATFORM_PCI */
-- 
2.9.3
