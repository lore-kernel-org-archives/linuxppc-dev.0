Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by lists.ozlabs.org (Postfix) with ESMTP id 8B4981A1DFE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 19:46:21 +1000 (AEST)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
 by winston.telenet-ops.be (Postfix) with ESMTP id 1E1671BF501
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 11:34:43 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of/dynamic: Fix test for PPC_PSERIES
Date: Thu,  4 Jun 2015 11:34:41 +0200
Message-Id: <1433410481-22611-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"IS_ENABLED(PPC_PSERIES)" always evaluates to false, as IS_ENABLED() is
supposed to be used with the full Kconfig symbol name, including the
"CONFIG_" prefix.

Add the missing "CONFIG_" prefix to fix this.

Fixes: a25095d451ece23b ("of: Move dynamic node fixups out of powerpc and into common code")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Did this bug cause any breakage?
If yes, the fix should go to stable (for v3.17 and later).
---
 drivers/of/dynamic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index dee658de72b3b221..1901f8870591fe30 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -226,7 +226,7 @@ void __of_attach_node(struct device_node *np)
 	phandle = __of_get_property(np, "phandle", &sz);
 	if (!phandle)
 		phandle = __of_get_property(np, "linux,phandle", &sz);
-	if (IS_ENABLED(PPC_PSERIES) && !phandle)
+	if (IS_ENABLED(CONFIG_PPC_PSERIES) && !phandle)
 		phandle = __of_get_property(np, "ibm,phandle", &sz);
 	np->phandle = (phandle && (sz >= 4)) ? be32_to_cpup(phandle) : 0;
 
-- 
1.9.1
