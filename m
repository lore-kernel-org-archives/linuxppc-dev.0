Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23A6ADDE28
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 03:32:15 +1100 (EST)
Date: Mon, 14 Jan 2008 10:29:35 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] fsl_soc: Fix get_immrbase() to use ranges, rather than reg.
Message-ID: <20080114162935.GA27862@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The reg property in fsl soc nodes should be removed.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ace747..7502e03 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -54,10 +54,18 @@ phys_addr_t get_immrbase(void)
 	soc = of_find_node_by_type(NULL, "soc");
 	if (soc) {
 		int size;
-		const void *prop = of_get_property(soc, "reg", &size);
+		u32 naddr;
+		const u32 *prop = of_get_property(soc, "#address-cells", &size);
+
+		if (prop && size == 4)
+			naddr = *prop;
+		else
+			naddr = 2;
+
+		prop = of_get_property(soc, "ranges", &size);
+		if (prop && size == 12)
+			immrbase = of_translate_address(soc, prop + naddr);
 
-		if (prop)
-			immrbase = of_translate_address(soc, prop);
 		of_node_put(soc);
 	}
 
-- 
1.5.3
