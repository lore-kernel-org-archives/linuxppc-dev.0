Return-Path: <B29983@freescale.com>
From: <Yuantian.Tang@freescale.com>
To: <grant.likely@secretlab.ca>
Subject: [PATCH v2] of/base: release the node correctly in
 of_parse_phandle_with_args()
Date: Wed, 10 Apr 2013 11:36:39 +0800
Message-ID: <1365564999-24427-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rob.herring@calxeda.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <yuantian.tang@freescale.com>

Call of_node_put() only when the out_args is NULL on success,
or the node's reference count will not be correct because the caller
will call of_node_put() again.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
v2:
	- modified the title and description. the 1st patch title is:
	  of: remove the unnecessary of_node_put for of_parse_phandle_with_args()
	  the 1st patch is not good enough.

 drivers/of/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 321d3ef..ee94f64 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1158,6 +1158,7 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 			if (!phandle)
 				goto err;
 
+			/* Found it! return success */
 			if (out_args) {
 				int i;
 				if (WARN_ON(count > MAX_PHANDLE_ARGS))
@@ -1166,11 +1167,10 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 				out_args->args_count = count;
 				for (i = 0; i < count; i++)
 					out_args->args[i] = be32_to_cpup(list++);
+			} else if (node) {
+				of_node_put(node);
 			}
 
-			/* Found it! return success */
-			if (node)
-				of_node_put(node);
 			return 0;
 		}
 
-- 
1.8.0
