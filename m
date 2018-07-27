Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cHkc42LBzDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 15:36:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	frowand.list@gmail.com
Cc: paulus@samba.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] of/fdt: Remove PPC32 longtrail hack in memory scan
Date: Fri, 27 Jul 2018 15:35:55 +1000
Message-Id: <20180727053555.26596-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the OF code was originally made common by Grant in commit
51975db0b733 ("of/flattree: merge early_init_dt_scan_memory() common
code") (Feb 2010), the common code inherited a hack to handle
PPC "longtrail" machines, which had a "memory@0" node with no
device_type.

That check was then made to only apply to PPC32 in b44aa25d20e2 ("of:
Handle memory@0 node on PPC32 only") (May 2014).

But according to Paul Mackerras the "longtrail" machines are long
dead, if they were ever seen in the wild at all. If someone does still
have one, we can handle this firmware wart in powerpc platform code.

So remove the hack once and for all.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/of/fdt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6da20b9688f7..800ad252cf9c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1034,14 +1034,7 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 	bool hotpluggable;
 
 	/* We are scanning "memory" nodes only */
-	if (type == NULL) {
-		/*
-		 * The longtrail doesn't have a device_type on the
-		 * /memory node, so look for the node called /memory@0.
-		 */
-		if (!IS_ENABLED(CONFIG_PPC32) || depth != 1 || strcmp(uname, "memory@0") != 0)
-			return 0;
-	} else if (strcmp(type, "memory") != 0)
+	if (type == NULL || strcmp(type, "memory") != 0)
 		return 0;
 
 	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
-- 
2.14.1
