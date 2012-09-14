Return-Path: <srinivas.kandagatla@st.com>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
 [207.126.144.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DAE0E2C008B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 18:50:35 +1000 (EST)
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: benh@kernel.crashing.org, bergner@us.ibm.com
Subject: [PATCH v2 2/7] dt/powerpc: Use of_get_child_by_name to get a named
 child.
Date: Fri, 14 Sep 2012 09:18:44 +0100
Message-Id: <1347610724-20152-1-git-send-email-srinivas.kandagatla@st.com>
Cc: robherring2@gmail.com, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, srinivas.kandagatla@st.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

As follow-up to "dt: introduce of_get_child_by_name to get child node by
name." patch, This patch removes some of the code duplication in the
driver by replacing it with of_get_child_by_name instead.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/powerpc/kernel/prom.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f191bf0..80e5b6c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -735,7 +735,6 @@ void __init early_init_devtree(void *params)
  */
 struct device_node *of_find_next_cache_node(struct device_node *np)
 {
-	struct device_node *child;
 	const phandle *handle;
 
 	handle = of_get_property(np, "l2-cache", NULL);
@@ -749,9 +748,7 @@ struct device_node *of_find_next_cache_node(struct device_node *np)
 	 * beneath CPU nodes.
 	 */
 	if (!strcmp(np->type, "cpu"))
-		for_each_child_of_node(np, child)
-			if (!strcmp(child->type, "cache"))
-				return child;
+		return of_get_child_by_name(np, "cache");
 
 	return NULL;
 }
-- 
1.7.0.4
