Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F2F75DDEF4
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:58:16 +1000 (EST)
Date: Mon, 17 Sep 2007 11:57:37 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 08/28] bootwrapper: Use fsl_get_immr() in cuboot-pq2.c.
Message-ID: <20070917165737.GH6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165643.GA6545@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/cuboot-pq2.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-pq2.c b/arch/powerpc/boot/cuboot-pq2.c
index d78e943..61574f3 100644
--- a/arch/powerpc/boot/cuboot-pq2.c
+++ b/arch/powerpc/boot/cuboot-pq2.c
@@ -15,6 +15,7 @@
 #include "stdio.h"
 #include "cuboot.h"
 #include "io.h"
+#include "fsl-soc.h"
 
 #define TARGET_CPM2
 #define TARGET_HAS_ETH1
@@ -126,23 +127,20 @@ static void fixup_pci(void)
 	u32 *pci_regs[3];
 	u8 *soc_regs;
 	int i, len;
-	void *node, *parent_node, *soc_node;
+	void *node, *parent_node;
 	u32 naddr, nsize, mem_log2;
 
 	node = finddevice("/pci");
 	if (!node || !dt_is_compatible(node, "fsl,pq2-pci"))
 		return;
 
-	soc_node = finddevice("/soc");
-	if (!soc_node || !dt_is_compatible(soc_node, "fsl,pq2-soc"))
-		goto err;
-
 	for (i = 0; i < 3; i++)
 		if (!dt_xlate_reg(node, i,
 		                  (unsigned long *)&pci_regs[i], NULL))
 			goto err;
 
-	if (!dt_xlate_reg(soc_node, 0, (unsigned long *)&soc_regs, NULL))
+	soc_regs = (u8 *)fsl_get_immr();
+	if (!soc_regs)
 		goto err;
 
 	dt_get_reg_format(node, &naddr, &nsize);
-- 
1.5.3.1
