Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 950671A066A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 21:12:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 6/6] powerpc/pseries: Add firmware details to dump stack arch
 description
Date: Tue,  5 May 2015 21:12:17 +1000
Message-Id: <1430824337-15339-6-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1430824337-15339-1-git-send-email-mpe@ellerman.id.au>
References: <1430824337-15339-1-git-send-email-mpe@ellerman.id.au>
Cc: tj@kernel.org, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once we have unflattened the device tree we can easily grab these
firmware version details and add them to dump stack arch description,
which is printed in case of an oops.

Currently /hypervisor only exists on KVM, so if we don't find that look
for something that suggests we're on phyp and if so that's probably a
good guess. The actual content of the ibm,fw-net-version seems to be
a full path so is too long to add to the description.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index df6a7041922b..e89282c4f799 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -680,6 +680,39 @@ static void pSeries_cmo_feature_init(void)
 	pr_debug(" <- fw_cmo_feature_init()\n");
 }
 
+static void __init pseries_add_dump_stack_arch_desc(void)
+{
+	struct device_node *dn;
+	const char *prop;
+
+	dn = of_find_node_by_path("/openprom");
+	if (dn) {
+		prop = of_get_property(dn, "model", NULL);
+		if (prop)
+			dump_stack_add_arch_desc("prom:%s", prop);
+
+		of_node_put(dn);
+	}
+
+	dn = of_find_node_by_path("/hypervisor");
+	if (dn) {
+		prop = of_get_property(dn, "compatible", NULL);
+		if (prop)
+			dump_stack_add_arch_desc("hv:%s", prop);
+
+		of_node_put(dn);
+	} else {
+		dn = of_find_node_by_path("/");
+		if (dn) {
+			prop = of_get_property(dn, "ibm,fw-net-version", NULL);
+			if (prop)
+				dump_stack_add_arch_desc("hv:phyp");
+
+			of_node_put(dn);
+		}
+	}
+}
+
 /*
  * Early initialization.  Relocation is on but do not reference unbolted pages
  */
@@ -687,6 +720,8 @@ static void __init pSeries_init_early(void)
 {
 	pr_debug(" -> pSeries_init_early()\n");
 
+	pseries_add_dump_stack_arch_desc();
+
 #ifdef CONFIG_HVC_CONSOLE
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hvc_vio_init_early();
-- 
2.1.0
