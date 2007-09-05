Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 158E3DDF44
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:21:09 +1000 (EST)
Date: Wed, 5 Sep 2007 14:21:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 01/10] bootwrapper: Use fsl_get_immr() in cuboot-pq2.c.
Message-ID: <20070905192101.GA32113@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/boot/cuboot-pq2.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/cuboot-pq2.c b/arch/powerpc/boot/cuboot-pq2.c
index b150bd4..fef2d15 100644
--- a/arch/powerpc/boot/cuboot-pq2.c
+++ b/arch/powerpc/boot/cuboot-pq2.c
@@ -15,6 +15,7 @@
 #include "stdio.h"
 #include "cuboot.h"
 #include "io.h"
+#include "fsl-soc.h"
 
 #define TARGET_CPM2
 #define TARGET_HAS_ETH1
@@ -146,16 +147,13 @@ static void fixup_pci(void)
 	if (!ctrl_node || !dt_is_compatible(ctrl_node, "fsl,pq2-pci"))
 		return;
 
-	soc_node = finddevice("/soc");
-	if (!soc_node || !dt_is_compatible(soc_node, "fsl,pq2-soc"))
-		goto err;
-
 	for (i = 0; i < 3; i++)
 		if (!dt_xlate_reg(ctrl_node, i,
 		                  (unsigned long *)&pci_regs[i], NULL))
 			goto err;
 
-	if (!dt_xlate_reg(soc_node, 0, (unsigned long *)&soc_regs, NULL))
+	soc_regs = (u8 *)fsl_get_immr();
+	if (!soc_regs)
 		goto err;
 
 	len = getprop(ctrl_node, "fsl,bus", &bus_ph, 4);
-- 
1.5.3
