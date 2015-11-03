Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48FF81A0932
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 10:17:17 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 09:17:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id ACAD43578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 10:17:12 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA3NH3uX60358896
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 10:17:12 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA3NGcqe002860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 10:16:39 +1100
Date: Wed, 4 Nov 2015 10:16:13 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, bhelgaas@google.com, grant.likely@linaro.org,
 robherring2@gmail.com, panto@antoniou-consulting.com, aik@ozlabs.ru
Subject: Re: [PATCH v6 38/42] drivers/of: Unflatten subordinate nodes after
 specified level
Message-ID: <20151103231613.GA7126@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-39-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438834307-26960-39-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 06, 2015 at 02:11:43PM +1000, Gavin Shan wrote:
>unflatten_dt_node() is called recursively to unflatten FDT nodes
>with the assumption that FDT blob has only one root node, which
>isn't true when the FDT blob represents device sub-tree. This
>improves the function to supporting device sub-tree that have
>multiple nodes in the first level:
>
>   * Rename original unflatten_dt_node() to __unflatten_dt_node().
>   * Wrapper unflatten_dt_node() calls __unflatten_dt_node() with
>     adjusted current node depth to 1 to avoid underflow.
>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---
> drivers/of/fdt.c | 53 ++++++++++++++++++++++++++++++++++++++++-------------
> 1 file changed, 40 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>index 0749656..a18a2ce 100644
>--- a/drivers/of/fdt.c
>+++ b/drivers/of/fdt.c
>@@ -161,7 +161,7 @@ static void *unflatten_dt_alloc(void **mem, unsigned long size,
> }
>
> /**
>- * unflatten_dt_node - Alloc and populate a device_node from the flat tree
>+ * __unflatten_dt_node - Alloc and populate a device_node from the flat tree
>  * @blob: The parent device tree blob
>  * @mem: Memory chunk to use for allocating device nodes and properties
>  * @poffset: pointer to node in flat tree
>@@ -171,20 +171,20 @@ static void *unflatten_dt_alloc(void **mem, unsigned long size,
>  * @dryrun: If true, do not allocate device nodes but still calculate needed
>  * memory size
>  */
>-static void * unflatten_dt_node(const void *blob,
>+static void *__unflatten_dt_node(const void *blob,
> 				void *mem,
> 				int *poffset,
> 				struct device_node *dad,
> 				struct device_node **nodepp,
> 				unsigned long fpsize,
>-				bool dryrun)
>+				bool dryrun,
>+				int *depth)
> {
> 	const __be32 *p;
> 	struct device_node *np;
> 	struct property *pp, **prev_pp = NULL;
> 	const char *pathp;
> 	unsigned int l, allocl;
>-	static int depth = 0;
> 	int old_depth;
> 	int offset;
> 	int has_name = 0;
>@@ -337,13 +337,25 @@ static void * unflatten_dt_node(const void *blob,
> 			np->type = "<NULL>";
> 	}
>
>-	old_depth = depth;
>-	*poffset = fdt_next_node(blob, *poffset, &depth);
>-	if (depth < 0)
>-		depth = 0;
>-	while (*poffset > 0 && depth > old_depth)
>-		mem = unflatten_dt_node(blob, mem, poffset, np, NULL,
>-					fpsize, dryrun);
>+	/* Multiple nodes might be in the first depth level if
>+	 * the device tree is sub-tree. All nodes in current
>+	 * or deeper depth are unflattened after it returns.
>+	 */
>+	old_depth = *depth;
>+	*poffset = fdt_next_node(blob, *poffset, depth);
>+	while (*poffset > 0) {
>+		if (*depth < old_depth)
>+			break;
>+
>+		if (*depth == old_depth)
>+			mem = __unflatten_dt_node(blob, mem, poffset,
>+						  dad, NULL, fpsize,
>+						  dryrun, depth);
>+		else if (*depth > old_depth)
>+			mem = __unflatten_dt_node(blob, mem, poffset,
>+						  np, NULL, fpsize,
>+						  dryrun, depth);
>+	}
>

Sorry for the delay. I'm afraid this one has to be reworked. With current
code and changes, the nodes in the FDT blob are scanned in recursive fasion.
That would cause exhausted stack when this function is called at early stage
of system boot to unflatten the device tree that have too much levels and nodes.
In next revision, I'll rework it to avoid recursive calls on this function.

So there're more time needed to post next revision. This issue was observed in
recent testing with 4.3.rc6 and the patchset. On P7 box, the bad stack is reported
directly. On P8 box, the /bin/init in the initram image can't be started properly.
I run "git bisect" and this patch is located in both case.

> 	if (*poffset < 0 && *poffset != -FDT_ERR_NOTFOUND)
> 		pr_err("unflatten: error %d processing FDT\n", *poffset);
>@@ -369,6 +381,20 @@ static void * unflatten_dt_node(const void *blob,
> 	return mem;
> }
>
>+static void *unflatten_dt_node(const void *blob,
>+			       void *mem,
>+			       int *poffset,
>+			       struct device_node *dad,
>+			       struct device_node **nodepp,
>+			       bool dryrun)
>+{
>+	int depth = 1;
>+
>+	return __unflatten_dt_node(blob, mem, poffset,
>+				   dad, nodepp, 0,
>+				   dryrun, &depth);
>+}
>+
> /**
>  * __unflatten_device_tree - create tree of device_nodes from flat blob
>  *
>@@ -408,7 +434,8 @@ static void __unflatten_device_tree(const void *blob,
>
> 	/* First pass, scan for size */
> 	start = 0;
>-	size = (unsigned long)unflatten_dt_node(blob, NULL, &start, NULL, NULL, 0, true);
>+	size = (unsigned long)unflatten_dt_node(blob, NULL, &start,
>+						NULL, NULL, true);
> 	size = ALIGN(size, 4);
>
> 	pr_debug("  size is %lx, allocating...\n", size);
>@@ -423,7 +450,7 @@ static void __unflatten_device_tree(const void *blob,
>
> 	/* Second pass, do actual unflattening */
> 	start = 0;
>-	unflatten_dt_node(blob, mem, &start, NULL, mynodes, 0, false);
>+	unflatten_dt_node(blob, mem, &start, NULL, mynodes, false);
> 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
> 		pr_warning("End of tree marker overwritten: %08x\n",
> 			   be32_to_cpup(mem + size));
>-- 
>2.1.0
>
