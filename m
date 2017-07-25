Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHBbb2J3gzDqn9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 07:44:43 +1000 (AEST)
Received: by mail-yw0-f193.google.com with SMTP id u207so3655672ywc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 14:44:43 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4/4] of/fdt: only store the device node basename in full_name
Date: Tue, 25 Jul 2017 16:44:27 -0500
Message-Id: <20170725214427.25768-5-robh@kernel.org>
In-Reply-To: <20170725214427.25768-1-robh@kernel.org>
References: <20170725214427.25768-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With dependencies on a statically allocated full path name converted to
use %pOF format specifier, we can store just the basename of node, and
the unflattening of the FDT can be simplified.

This commit will affect the remaining users of full_name. After
analyzing these users, the remaining cases should only change some print
messages. The main users of full_name are providing a name for struct
resource. The resource names shouldn't be important other than providing
/proc/iomem names.

We no longer distinguish between pre and post 0x10 dtb formats as either
a full path or basename will work. However, less than 0x10 formats have
been broken since the conversion to use libfdt (and no one has cared).
The conversion of the unflattening code to be non-recursive also broke
pre 0x10 formats as the populate_node function would return 0 in that
case.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c | 69 +++++++++-----------------------------------------------
 1 file changed, 11 insertions(+), 58 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ce30c9a588a4..27c535af0be8 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -266,74 +266,32 @@ static void populate_properties(const void *blob,
 		*pprev = NULL;
 }
 
-static unsigned int populate_node(const void *blob,
-				  int offset,
-				  void **mem,
-				  struct device_node *dad,
-				  unsigned int fpsize,
-				  struct device_node **pnp,
-				  bool dryrun)
+static bool populate_node(const void *blob,
+			  int offset,
+			  void **mem,
+			  struct device_node *dad,
+			  struct device_node **pnp,
+			  bool dryrun)
 {
 	struct device_node *np;
 	const char *pathp;
 	unsigned int l, allocl;
-	int new_format = 0;
 
 	pathp = fdt_get_name(blob, offset, &l);
 	if (!pathp) {
 		*pnp = NULL;
-		return 0;
+		return false;
 	}
 
 	allocl = ++l;
 
-	/* version 0x10 has a more compact unit name here instead of the full
-	 * path. we accumulate the full path size using "fpsize", we'll rebuild
-	 * it later. We detect this because the first character of the name is
-	 * not '/'.
-	 */
-	if ((*pathp) != '/') {
-		new_format = 1;
-		if (fpsize == 0) {
-			/* root node: special case. fpsize accounts for path
-			 * plus terminating zero. root node only has '/', so
-			 * fpsize should be 2, but we want to avoid the first
-			 * level nodes to have two '/' so we use fpsize 1 here
-			 */
-			fpsize = 1;
-			allocl = 2;
-			l = 1;
-			pathp = "";
-		} else {
-			/* account for '/' and path size minus terminal 0
-			 * already in 'l'
-			 */
-			fpsize += l;
-			allocl = fpsize;
-		}
-	}
-
 	np = unflatten_dt_alloc(mem, sizeof(struct device_node) + allocl,
 				__alignof__(struct device_node));
 	if (!dryrun) {
 		char *fn;
 		of_node_init(np);
 		np->full_name = fn = ((char *)np) + sizeof(*np);
-		if (new_format) {
-			/* rebuild full path for new format */
-			if (dad && dad->parent) {
-				strcpy(fn, dad->full_name);
-#ifdef DEBUG
-				if ((strlen(fn) + l + 1) != allocl) {
-					pr_debug("%s: p: %d, l: %d, a: %d\n",
-						pathp, (int)strlen(fn),
-						l, allocl);
-				}
-#endif
-				fn += strlen(fn);
-			}
-			*(fn++) = '/';
-		}
+
 		memcpy(fn, pathp, l);
 
 		if (dad != NULL) {
@@ -355,7 +313,7 @@ static unsigned int populate_node(const void *blob,
 	}
 
 	*pnp = np;
-	return fpsize;
+	return true;
 }
 
 static void reverse_nodes(struct device_node *parent)
@@ -399,7 +357,6 @@ static int unflatten_dt_nodes(const void *blob,
 	struct device_node *root;
 	int offset = 0, depth = 0, initial_depth = 0;
 #define FDT_MAX_DEPTH	64
-	unsigned int fpsizes[FDT_MAX_DEPTH];
 	struct device_node *nps[FDT_MAX_DEPTH];
 	void *base = mem;
 	bool dryrun = !base;
@@ -418,7 +375,6 @@ static int unflatten_dt_nodes(const void *blob,
 		depth = initial_depth = 1;
 
 	root = dad;
-	fpsizes[depth] = dad ? strlen(of_node_full_name(dad)) : 0;
 	nps[depth] = dad;
 
 	for (offset = 0;
@@ -427,11 +383,8 @@ static int unflatten_dt_nodes(const void *blob,
 		if (WARN_ON_ONCE(depth >= FDT_MAX_DEPTH))
 			continue;
 
-		fpsizes[depth+1] = populate_node(blob, offset, &mem,
-						 nps[depth],
-						 fpsizes[depth],
-						 &nps[depth+1], dryrun);
-		if (!fpsizes[depth+1])
+		if (!populate_node(blob, offset, &mem, nps[depth],
+				   &nps[depth+1], dryrun))
 			return mem - base;
 
 		if (!dryrun && nodepp && !*nodepp)
-- 
2.11.0
