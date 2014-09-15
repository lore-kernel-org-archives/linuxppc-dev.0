Return-Path: <bharata.rao@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 361111A0027
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 17:04:06 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id rd3so5698287pab.26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 00:04:03 -0700 (PDT)
From: bharata.rao@gmail.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] pseries: Make CPU hotplug path endian safe
Date: Mon, 15 Sep 2014 12:33:26 +0530
Message-Id: <1410764606-14746-1-git-send-email-bharata.rao@gmail.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

- ibm,rtas-configure-connector should treat the RTAS data as big endian.
- Treat ibm,ppc-interrupt-server#s as big-endian when setting
  smp_processor_id during hotplug.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---

Changes in v2:
- Don't convert drc_index to BE in dlpar_configure_connector() but instead
  convert in the caller dlpar_cpu_probe() so that migration path isn't
  affected.
- Mark members of cc_workarea struct as __be32 instead of u32 (Thomas)
- Based on top of Thomas Falcon's two patches.
  (http://patchwork.ozlabs.org/patch/388767/)

v1: http://patchwork.ozlabs.org/patch/386216/

 arch/powerpc/platforms/pseries/dlpar.c       | 22 +++++++++++-----------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  4 ++--
 arch/powerpc/platforms/pseries/pseries.h     |  3 ++-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 8718227..52aeb37 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -24,11 +24,11 @@
 #include <asm/rtas.h>
 
 struct cc_workarea {
-	u32	drc_index;
-	u32	zero;
-	u32	name_offset;
-	u32	prop_length;
-	u32	prop_offset;
+	__be32	drc_index;
+	__be32	zero;
+	__be32	name_offset;
+	__be32	prop_length;
+	__be32	prop_offset;
 };
 
 void dlpar_free_cc_property(struct property *prop)
@@ -48,11 +48,11 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
 	if (!prop)
 		return NULL;
 
-	name = (char *)ccwa + ccwa->name_offset;
+	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
 	prop->name = kstrdup(name, GFP_KERNEL);
 
-	prop->length = ccwa->prop_length;
-	value = (char *)ccwa + ccwa->prop_offset;
+	prop->length = be32_to_cpu(ccwa->prop_length);
+	value = (char *)ccwa + be32_to_cpu(ccwa->prop_offset);
 	prop->value = kmemdup(value, prop->length, GFP_KERNEL);
 	if (!prop->value) {
 		dlpar_free_cc_property(prop);
@@ -78,7 +78,7 @@ static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa,
 	if (!dn)
 		return NULL;
 
-	name = (char *)ccwa + ccwa->name_offset;
+	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
 	dn->full_name = kasprintf(GFP_KERNEL, "%s/%s", path, name);
 	if (!dn->full_name) {
 		kfree(dn);
@@ -125,7 +125,7 @@ void dlpar_free_cc_nodes(struct device_node *dn)
 #define CALL_AGAIN	-2
 #define ERR_CFG_USE     -9003
 
-struct device_node *dlpar_configure_connector(u32 drc_index,
+struct device_node *dlpar_configure_connector(__be32 drc_index,
 					      struct device_node *parent)
 {
 	struct device_node *dn;
@@ -413,7 +413,7 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	if (!parent)
 		return -ENODEV;
 
-	dn = dlpar_configure_connector(drc_index, parent);
+	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
 	if (!dn)
 		return -EINVAL;
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index b174fa7..5c375f9 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -247,7 +247,7 @@ static int pseries_add_processor(struct device_node *np)
 	unsigned int cpu;
 	cpumask_var_t candidate_mask, tmp;
 	int err = -ENOSPC, len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv;
 
 	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
@@ -293,7 +293,7 @@ static int pseries_add_processor(struct device_node *np)
 	for_each_cpu(cpu, tmp) {
 		BUG_ON(cpu_present(cpu));
 		set_cpu_present(cpu, true);
-		set_hard_smp_processor_id(cpu, *intserv++);
+		set_hard_smp_processor_id(cpu, be32_to_cpu(*intserv++));
 	}
 	err = 0;
 out_unlock:
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 361add6..1796c54 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -56,7 +56,8 @@ extern void hvc_vio_init_early(void);
 /* Dynamic logical Partitioning/Mobility */
 extern void dlpar_free_cc_nodes(struct device_node *);
 extern void dlpar_free_cc_property(struct property *);
-extern struct device_node *dlpar_configure_connector(u32, struct device_node *);
+extern struct device_node *dlpar_configure_connector(__be32,
+						struct device_node *);
 extern int dlpar_attach_node(struct device_node *);
 extern int dlpar_detach_node(struct device_node *);
 
-- 
1.7.11.7
