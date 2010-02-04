Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56F7CB7D4D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Feb 2010 14:37:40 +1100 (EST)
Subject: [PATCH] powerpc/pseries: Pass more accurate number of supported
	cores to firmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Feb 2010 14:35:22 +1100
Message-ID: <1265254522.8287.151.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The field containing the number of supported cores which we pass to
firmware via the ibm,client-architecture call was set by a previous
patch statically as high as is possible (NR_CPUS).

However, that value isn't quite right for a system that supports
multiple threads per core, thus permitting the firmware to assign
more cores to a Linux partition than it can really cope with.

This patch improves it by using the device-tree to determine the
number of threads supported by the processors in order to adjust
the value passed to firmware.

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c |   64 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 59d5bd1..5f306c4 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -710,7 +710,12 @@ static unsigned char ibm_architecture_vec[] = {
 	0,
 	0,
 	0,
-	W(NR_CPUS),			/* number of cores supported*/
+	/* WARNING: The offset of the "number of cores" field below
+	 * must match by the macro below. Update the definition if
+	 * the structure layout changes.
+	 */
+#define IBM_ARCH_VEC_NRCORES_OFFSET	100
+	W(NR_CPUS),			/* number of cores supported */
 
 	/* option vector 6: IBM PAPR hints */
 	4 - 2,				/* length */
@@ -807,13 +812,70 @@ static struct fake_elf {
 	}
 };
 
+static int __init prom_count_smt_threads(void)
+{
+	phandle node;
+	char type[64];
+	unsigned int plen;
+
+	/* Pick up th first CPU node we can find */
+	for (node = 0; prom_next_node(&node); ) {
+		type[0] = 0;
+		prom_getprop(node, "device_type", type, sizeof(type));
+
+		if (strcmp(type, RELOC("cpu")))
+			continue;
+		/*
+		 * There is an entry for each smt thread, each entry being
+		 * 4 bytes long.  All cpus should have the same number of
+		 * smt threads, so return after finding the first.
+		 */
+		plen = prom_getproplen(node, "ibm,ppc-interrupt-server#s");
+		if (plen == PROM_ERROR)
+			break;
+		plen >>= 2;
+		prom_debug("Found 0x%x smt threads per core\n", (unsigned long)plen);
+
+		/* Sanity check */
+		if (plen < 1 || plen > 64) {
+			prom_printf("Threads per core 0x%x out of bounds, assuming 1\n",
+				    (unsigned long)plen);
+			return 1;
+		}
+		return plen;
+	}
+	prom_debug("No threads found, assuming 1 per core\n");
+
+	return 1;
+
+}
+
+
 static void __init prom_send_capabilities(void)
 {
 	ihandle elfloader, root;
 	prom_arg_t ret;
+	u32 *cores;
 
 	root = call_prom("open", 1, 1, ADDR("/"));
 	if (root != 0) {
+		/* We need to tell the FW about the number of cores we support.
+		 *
+		 * To do that, we count the number of threads on the first core
+		 * (we assume this is the same for all cores) and use it to
+		 * divide NR_CPUS.
+		 */
+		cores = (u32 *)PTRRELOC(&ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET]);
+		if (*cores != NR_CPUS) {
+			prom_printf("WARNING ! "
+				    "ibm_architecture_vec structure inconsistent: 0x%x !\n",
+				    *cores);
+		} else {
+			*cores = NR_CPUS / prom_count_smt_threads();
+			prom_printf("Max number of cores passed to firmware: 0x%x\n",
+				    (unsigned long)*cores);
+		}
+
 		/* try calling the ibm,client-architecture-support method */
 		prom_printf("Calling ibm,client-architecture-support...");
 		if (call_prom_ret("call-method", 3, 2, &ret,
