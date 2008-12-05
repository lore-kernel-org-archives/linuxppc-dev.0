Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CCE4FDDDF0
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 05:15:47 +1100 (EST)
Date: Fri, 5 Dec 2008 21:15:46 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3] of: of_parse_phandles_with_args() learns to
	differentiate 'hole' cells
Message-ID: <20081205181546.GB23666@oksana.dev.rtsoft.ru>
References: <20081205181503.GA9855@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081205181503.GA9855@oksana.dev.rtsoft.ru>
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Given this list (contains three gpio specifiers, one of which is a hole):

gpios = <&phandle1 1 2 3
         0 /* a hole */
         &phandle2 4 5 6>;

of_parse_phandles_with_args() would report -ENOENT for the `hole'
specifier item, the same error value is used to report the end of the
list, for example.

Sometimes we want to differentiate holes from real errors -- for
example when we want to count all the [syntax correct] specifiers.

With this patch of_parse_phandles_with_args() will report -EEXITS when
somebody requested to parse a hole.

Also, make the out_{node,args} arguments optional, when counting we
don't really need the out values.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/base.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index cf04d4d..cd17092 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -499,8 +499,8 @@ EXPORT_SYMBOL_GPL(of_modalias_node);
  * @list_name:	property name that contains a list
  * @cells_name:	property name that specifies phandles' arguments count
  * @index:	index of a phandle to parse out
- * @out_node:	pointer to device_node struct pointer (will be filled)
- * @out_args:	pointer to arguments pointer (will be filled)
+ * @out_node:	optional pointer to device_node struct pointer (will be filled)
+ * @out_args:	optional pointer to arguments pointer (will be filled)
  *
  * This function is useful to parse lists of phandles and their arguments.
  * Returns 0 on success and fills out_node and out_args, on error returns
@@ -534,7 +534,7 @@ int of_parse_phandles_with_args(struct device_node *np, const char *list_name,
 	int size;
 	int cur_index = 0;
 	struct device_node *node = NULL;
-	const void *args;
+	const void *args = NULL;
 
 	list = of_get_property(np, list_name, &size);
 	if (!list) {
@@ -580,16 +580,26 @@ next:
 
 		of_node_put(node);
 		node = NULL;
+		args = NULL;
 		cur_index++;
 	}
 
 	if (!node) {
-		ret = -ENOENT;
+		/*
+		 * args w/o node indicates that the loop above has stopped at
+		 * the 'hole' cell. Report this differently.
+		 */
+		if (args)
+			ret = -EEXIST;
+		else
+			ret = -ENOENT;
 		goto err0;
 	}
 
-	*out_node = node;
-	*out_args = args;
+	if (out_node)
+		*out_node = node;
+	if (out_args)
+		*out_args = args;
 
 	return 0;
 err1:
-- 
1.5.6.5
