Return-Path: <nfont@austin.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D9E8BB70FD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 03:45:29 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0KGVH6I014780
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 09:31:17 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p0KGjNaF129332
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 09:45:23 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0KGjLWi006057
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 09:45:22 -0700
Message-ID: <4D3866A0.6010803@austin.ibm.com>
Date: Thu, 20 Jan 2011 10:45:20 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: [PATCH 3/4]Define memory_block_size_bytes for powerpc/pseries
References: <4D386498.9080201@austin.ibm.com>
In-Reply-To: <4D386498.9080201@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Robin Holt <holt@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define a version of memory_block_size_bytes() for powerpc/pseries such that
a memory block spans an entire lmb.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Reviewed-by: Robin Holt <holt@sgi.com>

---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   66 +++++++++++++++++++-----
 1 file changed, 53 insertions(+), 13 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2011-01-20 08:18:21.000000000 -0600
+++ linux-2.6/arch/powerpc/platforms/pseries/hotplug-memory.c	2011-01-20 08:21:07.000000000 -0600
@@ -17,6 +17,54 @@
 #include <asm/pSeries_reconfig.h>
 #include <asm/sparsemem.h>
 
+static unsigned long get_memblock_size(void)
+{
+	struct device_node *np;
+	unsigned int memblock_size = 0;
+
+	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (np) {
+		const unsigned long *size;
+
+		size = of_get_property(np, "ibm,lmb-size", NULL);
+		memblock_size = size ? *size : 0;
+
+		of_node_put(np);
+	} else {
+		unsigned int memzero_size = 0;
+		const unsigned int *regs;
+
+		np = of_find_node_by_path("/memory@0");
+		if (np) {
+			regs = of_get_property(np, "reg", NULL);
+			memzero_size = regs ? regs[3] : 0;
+			of_node_put(np);
+		}
+
+		if (memzero_size) {
+			/* We now know the size of memory@0, use this to find
+			 * the first memoryblock and get its size.
+			 */
+			char buf[64];
+
+			sprintf(buf, "/memory@%x", memzero_size);
+			np = of_find_node_by_path(buf);
+			if (np) {
+				regs = of_get_property(np, "reg", NULL);
+				memblock_size = regs ? regs[3] : 0;
+				of_node_put(np);
+			}
+		}
+	}
+
+	return memblock_size;
+}
+
+unsigned long memory_block_size_bytes(void)
+{
+	return get_memblock_size();
+}
+
 static int pseries_remove_memblock(unsigned long base, unsigned int memblock_size)
 {
 	unsigned long start, start_pfn;
@@ -127,30 +175,22 @@ static int pseries_add_memory(struct dev
 
 static int pseries_drconf_memory(unsigned long *base, unsigned int action)
 {
-	struct device_node *np;
-	const unsigned long *lmb_size;
+	unsigned long memblock_size;
 	int rc;
 
-	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (!np)
+	memblock_size = get_memblock_size();
+	if (!memblock_size)
 		return -EINVAL;
 
-	lmb_size = of_get_property(np, "ibm,lmb-size", NULL);
-	if (!lmb_size) {
-		of_node_put(np);
-		return -EINVAL;
-	}
-
 	if (action == PSERIES_DRCONF_MEM_ADD) {
-		rc = memblock_add(*base, *lmb_size);
+		rc = memblock_add(*base, memblock_size);
 		rc = (rc < 0) ? -EINVAL : 0;
 	} else if (action == PSERIES_DRCONF_MEM_REMOVE) {
-		rc = pseries_remove_memblock(*base, *lmb_size);
+		rc = pseries_remove_memblock(*base, memblock_size);
 	} else {
 		rc = -EINVAL;
 	}
 
-	of_node_put(np);
 	return rc;
 }
 
