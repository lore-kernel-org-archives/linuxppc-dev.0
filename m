Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 763F11A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Aug 2014 18:40:51 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Check flat device tree version at boot
Date: Thu, 28 Aug 2014 18:40:47 +1000
Message-Id: <1409215247-10195-1-git-send-email-mpe@ellerman.id.au>
Cc: grant.likely@linaro.org, robh+dt@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit e6a6928c3ea1 "of/fdt: Convert FDT functions to use libfdt",
the kernel stopped supporting old flat device tree formats. The minimum
supported version is now 0x10.

There was a checking function added, early_init_dt_verify(), but it's
not called on powerpc.

The result is, if you boot with an old flat device tree, the kernel will
fail to parse it correctly, think you have no memory etc. and hilarity
ensues.

We can't really fix it, but we can at least catch the fact that the
device tree is in an unsupported format and panic(). We can't call
BUG(), it's too early.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4e139f8a69ef..bb777b255b1c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -641,6 +641,10 @@ void __init early_init_devtree(void *params)
 
 	DBG(" -> early_init_devtree(%p)\n", params);
 
+	/* Too early to BUG_ON(), do it by hand */
+	if (!early_init_dt_verify(params))
+		panic("BUG: Failed verifying flat device tree, bad version?");
+
 	/* Setup flat device-tree pointer */
 	initial_boot_params = params;
 
-- 
1.9.1
