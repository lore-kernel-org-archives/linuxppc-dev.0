Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BA7B1A003B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Aug 2014 00:11:57 +1000 (EST)
Message-ID: <53FDE6A3.3080303@freescale.com>
Date: Wed, 27 Aug 2014 17:09:39 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] of: make sure of_alias is initialized before accessing it
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Grant Likely <grant.likely@linaro.org>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simply swap of_alias and of_chosen initialization so
that of_alias ends up read first. This must be done
because it is accessed couple of lines below when
trying to initialize the of_stdout using the alias
based legacy method.

[Fixes a752ee5 - tty: Update hypervisor tty drivers to                          
use core stdout parsing code]

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Cc: Grant Likely <grant.likely@linaro.org>
---
 drivers/of/base.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d8574ad..52f8506 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1847,6 +1847,10 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 {
 	struct property *pp;
 
+	of_aliases = of_find_node_by_path("/aliases");
+	if (!of_aliases)
+		return;
+
 	of_chosen = of_find_node_by_path("/chosen");
 	if (of_chosen == NULL)
 		of_chosen = of_find_node_by_path("/chosen@0");
@@ -1862,10 +1866,6 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 			of_stdout = of_find_node_by_path(name);
 	}
 
-	of_aliases = of_find_node_by_path("/aliases");
-	if (!of_aliases)
-		return;
-
 	for_each_property_of_node(of_aliases, pp) {
 		const char *start = pp->name;
 		const char *end = start + strlen(start);
-- 
1.8.3.1
