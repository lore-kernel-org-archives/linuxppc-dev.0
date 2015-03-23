Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51EB51A2AD2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 14:16:48 +1100 (AEDT)
Message-ID: <1427080598.4770.214.camel@kernel.crashing.org>
Subject: [PATCH] drivers/of: Add empty ranges quirk for PA-Semi
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 23 Mar 2015 14:16:38 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "sdc" node is missing the ranges property, it needs to be treated
as having an empty one otherwise translation fails for its children.

Tested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/of/address.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index ad29069..78a7dcb 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -450,12 +450,17 @@ static struct of_bus *of_match_bus(struct device_node *np)
 	return NULL;
 }
 
-static int of_empty_ranges_quirk(void)
+static int of_empty_ranges_quirk(struct device_node *np)
 {
 	if (IS_ENABLED(CONFIG_PPC)) {
-		/* To save cycles, we cache the result */
+		/* To save cycles, we cache the result for global "Mac" setting */
 		static int quirk_state = -1;
 
+		/* PA-SEMI sdc DT bug */
+		if (of_device_is_compatible(np, "1682m-sdc"))
+			return true;
+
+		/* Make quirk cached */
 		if (quirk_state < 0)
 			quirk_state =
 				of_machine_is_compatible("Power Macintosh") ||
@@ -490,7 +495,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	 * This code is only enabled on powerpc. --gcl
 	 */
 	ranges = of_get_property(parent, rprop, &rlen);
-	if (ranges == NULL && !of_empty_ranges_quirk()) {
+	if (ranges == NULL && !of_empty_ranges_quirk(parent)) {
 		pr_debug("OF: no ranges; cannot translate\n");
 		return 1;
 	}
