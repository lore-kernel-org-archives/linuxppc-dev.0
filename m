Return-Path: <srinivas.kandagatla@st.com>
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: benh@kernel.crashing.org
Subject: [PATCH v4 2/5] dt/powerpc/powernv: Use of_get_child_by_name to get a
 named child
Date: Tue, 18 Sep 2012 08:10:36 +0100
Message-Id: <1347952236-24603-1-git-send-email-srinivas.kandagatla@st.com>
Cc: kgene.kim@samsung.com, srinivas.kandagatla@st.com,
 devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com,
 robherring2@gmail.com, ben-linux@fluff.org, linuxppc-dev@lists.ozlabs.org
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
 arch/powerpc/platforms/powernv/opal.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index aaa0dba..f4a5567 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -294,10 +294,10 @@ static int __init opal_init(void)
 		consoles = of_node_get(opal_node);
 
 	/* Register serial ports */
-	for_each_child_of_node(consoles, np) {
-		if (strcmp(np->name, "serial"))
-			continue;
+	np = of_get_child_by_name(consoles, "serial");
+	if (np) {
 		of_platform_device_create(np, NULL, NULL);
+		of_node_put(np);
 	}
 	of_node_put(consoles);
 
-- 
1.7.0.4
