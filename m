Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwQXQ3TlKzDqB9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 15:35:34 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id p185so8733933pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:35:34 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: robh+dt@kernel.org, frowand.list@gmail.com, grant.likely@linaro.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 2/2] powerpc: Update of_remove_property() call sites to remove
 null checking
Date: Thu, 28 Apr 2016 15:34:55 +1000
Message-Id: <1461821695-19204-2-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1461821695-19204-1-git-send-email-sjitindarsingh@gmail.com>
References: <1461821695-19204-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After obtaining a property from of_find_property() and before calling
of_remove_property() most code checks to ensure that the property
returned from of_find_property() is not null. The previous patch
moved this check to the start of the function of_remove_property() in
order to avoid the case where this check isn't done and a null value is
passed. This ensures the check is always conducted before taking locks
and attempting to remove the property. Thus it is no longer necessary
to perform a check for null values before invoking of_remove_property().

Update of_remove_property() call sites in order to remove redundant
checking for null property value as check is now performed within the
of_remove_property function().

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kernel/machine_kexec.c       | 19 ++++++-------------
 arch/powerpc/kernel/machine_kexec_64.c    | 11 ++++-------
 arch/powerpc/platforms/pseries/mobility.c |  4 ++--
 arch/powerpc/platforms/pseries/reconfig.c |  5 +----
 4 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 015ae55..55744a8 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -228,17 +228,12 @@ static struct property memory_limit_prop = {
 
 static void __init export_crashk_values(struct device_node *node)
 {
-	struct property *prop;
-
 	/* There might be existing crash kernel properties, but we can't
 	 * be sure what's in them, so remove them. */
-	prop = of_find_property(node, "linux,crashkernel-base", NULL);
-	if (prop)
-		of_remove_property(node, prop);
-
-	prop = of_find_property(node, "linux,crashkernel-size", NULL);
-	if (prop)
-		of_remove_property(node, prop);
+	of_remove_property(node, of_find_property(node,
+				"linux,crashkernel-base", NULL));
+	of_remove_property(node, of_find_property(node,
+				"linux,crashkernel-size", NULL));
 
 	if (crashk_res.start != 0) {
 		crashk_base = cpu_to_be_ulong(crashk_res.start),
@@ -258,16 +253,14 @@ static void __init export_crashk_values(struct device_node *node)
 static int __init kexec_setup(void)
 {
 	struct device_node *node;
-	struct property *prop;
 
 	node = of_find_node_by_path("/chosen");
 	if (!node)
 		return -ENOENT;
 
 	/* remove any stale properties so ours can be found */
-	prop = of_find_property(node, kernel_end_prop.name, NULL);
-	if (prop)
-		of_remove_property(node, prop);
+	of_remove_property(node, of_find_property(node, kernel_end_prop.name,
+				NULL));
 
 	/* information needed by userspace when using default_machine_kexec */
 	kernel_end = cpu_to_be_ulong(__pa(_end));
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 0fbd75d..2608192 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -401,7 +401,6 @@ static struct property htab_size_prop = {
 static int __init export_htab_values(void)
 {
 	struct device_node *node;
-	struct property *prop;
 
 	/* On machines with no htab htab_address is NULL */
 	if (!htab_address)
@@ -412,12 +411,10 @@ static int __init export_htab_values(void)
 		return -ENODEV;
 
 	/* remove any stale propertys so ours can be found */
-	prop = of_find_property(node, htab_base_prop.name, NULL);
-	if (prop)
-		of_remove_property(node, prop);
-	prop = of_find_property(node, htab_size_prop.name, NULL);
-	if (prop)
-		of_remove_property(node, prop);
+	of_remove_property(node, of_find_property(node, htab_base_prop.name,
+				NULL));
+	of_remove_property(node, of_find_property(node, htab_size_prop.name,
+				NULL));
 
 	htab_base = cpu_to_be64(__pa(htab_address));
 	of_add_property(node, &htab_base_prop);
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index ceb18d3..a560a98 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -191,8 +191,8 @@ static int update_dt_node(__be32 phandle, s32 scope)
 				break;
 
 			case 0x80000000:
-				prop = of_find_property(dn, prop_name, NULL);
-				of_remove_property(dn, prop);
+				of_remove_property(dn, of_find_property(dn,
+							prop_name, NULL));
 				prop = NULL;
 				break;
 
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 7c7fcc0..cc66c49 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -303,7 +303,6 @@ static int do_remove_property(char *buf, size_t bufsize)
 {
 	struct device_node *np;
 	char *tmp;
-	struct property *prop;
 	buf = parse_node(buf, bufsize, &np);
 
 	if (!np)
@@ -316,9 +315,7 @@ static int do_remove_property(char *buf, size_t bufsize)
 	if (strlen(buf) == 0)
 		return -EINVAL;
 
-	prop = of_find_property(np, buf, NULL);
-
-	return of_remove_property(np, prop);
+	return of_remove_property(np, of_find_property(np, buf, NULL));
 }
 
 static int do_update_property(char *buf, size_t bufsize)
-- 
2.5.0
