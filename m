Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08B7D1A0509
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 04:13:36 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 12:13:34 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5D90B6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:00:23 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1AHDVKD33423542
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:13:31 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1AHDVnl004618
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:13:31 -0500
Received: from [9.41.105.104] ([9.41.105.104])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1AHDTc9004391
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:13:29 -0500
Subject: [PATCH 3/3] powerpc/pseries: Cleanup property cloning in memory dlpar
To: linuxppc-dev@lists.ozlabs.org
References: <56BB6EA5.9090405@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <56BB6FB9.2020701@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 11:13:29 -0600
MIME-Version: 1.0
In-Reply-To: <56BB6EA5.9090405@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that the DLPAR add/remove flow updates the ibm,dynamic-memory device
tree property each time we add or remove a LMB the work needed to clone
this property can be reduced.

Prior to performing any memory DLPAR operation we now clone the device
tree property once and convert it to cpu format. This copy is then used
to walk through LMBs as we process them and is thrown away when we
are finished. There is no longer a need to convert the entire property to
cpu format and then back to BE every time we update it, we can just parse
it in its native BE format and update the one LMB we need to modify
before updating the property.

This patch removes the BE => cpu conversion step in the clone routine and
creates a drconf_property_to_cpu() routine to make this conversion for the
one time we need to convert the entire property. This then allows us
to remove dlpar_update_drconf_property() since we can now do everything
in dlpar_update_device_tree_lmb().

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   79 +++++++++--------------
 1 file changed, 32 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2ce1385..4e0cde9 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -79,9 +79,6 @@ static void dlpar_free_drconf_property(struct property *prop)
 static struct property *dlpar_clone_drconf_property(struct device_node *dn)
 {
 	struct property *prop, *new_prop;
-	struct of_drconf_cell *lmbs;
-	u32 num_lmbs, *p;
-	int i;
 
 	prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
 	if (!prop)
@@ -99,48 +96,9 @@ static struct property *dlpar_clone_drconf_property(struct device_node *dn)
 	}
 
 	new_prop->length = prop->length;
-
-	/* Convert the property to cpu endian-ness */
-	p = new_prop->value;
-	*p = be32_to_cpu(*p);
-
-	num_lmbs = *p++;
-	lmbs = (struct of_drconf_cell *)p;
-
-	for (i = 0; i < num_lmbs; i++) {
-		lmbs[i].base_addr = be64_to_cpu(lmbs[i].base_addr);
-		lmbs[i].drc_index = be32_to_cpu(lmbs[i].drc_index);
-		lmbs[i].flags = be32_to_cpu(lmbs[i].flags);
-	}
-
 	return new_prop;
 }
 
-static void dlpar_update_drconf_property(struct device_node *dn,
-					 struct property *prop)
-{
-	struct of_drconf_cell *lmbs;
-	u32 num_lmbs, *p;
-	int i;
-
-	/* Convert the property back to BE */
-	p = prop->value;
-	num_lmbs = *p;
-	*p = cpu_to_be32(*p);
-	p++;
-
-	lmbs = (struct of_drconf_cell *)p;
-	for (i = 0; i < num_lmbs; i++) {
-		lmbs[i].base_addr = cpu_to_be64(lmbs[i].base_addr);
-		lmbs[i].drc_index = cpu_to_be32(lmbs[i].drc_index);
-		lmbs[i].flags = cpu_to_be32(lmbs[i].flags);
-	}
-
-	rtas_hp_event = true;
-	of_update_property(dn, prop);
-	rtas_hp_event = false;
-}
-
 static int dlpar_update_device_tree_lmb(struct of_drconf_cell *lmb)
 {
 	struct device_node *dn;
@@ -160,19 +118,24 @@ static int dlpar_update_device_tree_lmb(struct of_drconf_cell *lmb)
 	}
 
 	p = prop->value;
-	num_lmbs = *p++;
+	num_lmbs = be32_to_cpu(*p);
+	p++;
 	lmbs = (struct of_drconf_cell *)p;
 
 	for (i = 0; i < num_lmbs; i++) {
-		if (lmbs[i].drc_index == lmb->drc_index) {
-			lmbs[i].flags = lmb->flags;
-			lmbs[i].aa_index = lmb->aa_index;
+		u32 this_drc_index = be32_to_cpu(lmbs[i].drc_index);
 
-			dlpar_update_drconf_property(dn, prop);
+		if (this_drc_index == lmb->drc_index) {
+			lmbs[i].flags = cpu_to_be32(lmb->flags);
+			lmbs[i].aa_index = cpu_to_be32(lmb->aa_index);
 			break;
 		}
 	}
 
+	rtas_hp_event = true;
+	of_update_property(dn, prop);
+	rtas_hp_event = false;
+
 	of_node_put(dn);
 	return 0;
 }
@@ -701,6 +664,26 @@ static int dlpar_memory_add_by_index(u32 drc_index, struct property *prop)
 	return rc;
 }
 
+static void drconf_property_to_cpu(struct property *prop)
+{
+	struct of_drconf_cell *lmbs;
+	int i, num_lmbs;
+	u32 *p;
+
+	/* Convert the property to cpu endian-ness */
+	p = prop->value;
+	*p = be32_to_cpu(*p);
+
+	num_lmbs = *p++;
+	lmbs = (struct of_drconf_cell *)p;
+
+	for (i = 0; i < num_lmbs; i++) {
+		lmbs[i].base_addr = be64_to_cpu(lmbs[i].base_addr);
+		lmbs[i].drc_index = be32_to_cpu(lmbs[i].drc_index);
+		lmbs[i].flags = be32_to_cpu(lmbs[i].flags);
+	}
+}
+
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
 	struct device_node *dn;
@@ -725,6 +708,8 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		goto dlpar_memory_out;
 	}
 
+	drconf_property_to_cpu(prop);
+
 	switch (hp_elog->action) {
 	case PSERIES_HP_ELOG_ACTION_ADD:
 		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
