Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRZY3g4WzDqnm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:30:45 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 21/38] powerpc/pmac: Remove spurrious machine type test
Date: Mon, 27 Jun 2016 21:29:19 +1000
Message-Id: <1467026976-7974-22-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pmac_declare_of_platform_devices() is already a machine initcall, thus
it won't be called on a non-powermac machine. Testing for chrp there
is pointless.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 5801889..1e42104 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -482,9 +482,6 @@ static int __init pmac_declare_of_platform_devices(void)
 {
 	struct device_node *np;
 
-	if (machine_is(chrp))
-		return -1;
-
 	np = of_find_node_by_name(NULL, "valkyrie");
 	if (np) {
 		of_platform_device_create(np, "valkyrie", NULL);
-- 
2.7.4
