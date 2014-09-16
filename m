Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00C2A1A00FE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 06:15:57 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Tue, 16 Sep 2014 14:15:55 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 022983E40041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 14:15:54 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8GKFrAM29687980
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 22:15:53 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8GKFrOA015167
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 14:15:53 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] pseries: Make CPU hotplug path endian safe
Date: Tue, 16 Sep 2014 15:15:45 -0500
Message-Id: <1410898547-12296-2-git-send-email-tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1410898547-12296-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1410898547-12296-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
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
index a2450b8..5acbe59 100644
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
@@ -411,7 +411,7 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	if (!parent)
 		return -ENODEV;
 
-	dn = dlpar_configure_connector(drc_index, parent);
+	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
 	if (!dn)
 		return -EINVAL;
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 20d6297..447f8c6 100644
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
1.8.5.2
