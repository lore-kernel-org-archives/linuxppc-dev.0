Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYCDt3pZwzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:00:46 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5KDxWTl110182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 10:00:44 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23pe028uyy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 10:00:44 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 08:00:43 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EFB7C3E40048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 08:00:41 -0600 (MDT)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5KE0aBM49217770
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 14:00:41 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 729D9AE06B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 10:00:41 -0400 (EDT)
Received: from [9.41.92.173] (unknown [9.41.92.173])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 51C89AE05F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 10:00:41 -0400 (EDT)
Subject: [PATCH 1/2] powerpc/pseries: Move property cloning into its own
 routine
To: linuxppc-dev@lists.ozlabs.org
References: <5767F684.9090802@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 20 Jun 2016 09:00:39 -0500
MIME-Version: 1.0
In-Reply-To: <5767F684.9090802@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5767F707.3050707@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move property cloning code into its own routine

Split the pieces of dlpar_clone_drconf_property() that create a copy of
the property struct into its own routine. This allows for creating
clones of more than just the ibm,dynamic-memory property used in memory
hotplug.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |   38 ++++++++++++++++-------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 03f6169..b10f2ef 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -69,13 +69,36 @@ unsigned long pseries_memory_block_size(void)
 	return memblock_size;
 }
 
-static void dlpar_free_drconf_property(struct property *prop)
+static void dlpar_free_property(struct property *prop)
 {
 	kfree(prop->name);
 	kfree(prop->value);
 	kfree(prop);
 }
 
+static struct property *dlpar_clone_property(struct property *prop,
+					     u32 prop_size)
+{
+	struct property *new_prop;
+
+	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
+	if (!new_prop)
+		return NULL;
+
+	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
+	new_prop->value = kzalloc(prop_size, GFP_KERNEL);
+	if (!new_prop->name || !new_prop->value) {
+		dlpar_free_property(new_prop);
+		return NULL;
+	}
+
+	memcpy(new_prop->value, prop->value, prop->length);
+	new_prop->length = prop_size;
+
+	of_property_set_flag(new_prop, OF_DYNAMIC);
+	return new_prop;
+}
+
 static struct property *dlpar_clone_drconf_property(struct device_node *dn)
 {
 	struct property *prop, *new_prop;
@@ -87,19 +110,10 @@ static struct property *dlpar_clone_drconf_property(struct device_node *dn)
 	if (!prop)
 		return NULL;
 
-	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
+	new_prop = dlpar_clone_property(prop, prop->length);
 	if (!new_prop)
 		return NULL;
 
-	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
-	new_prop->value = kmemdup(prop->value, prop->length, GFP_KERNEL);
-	if (!new_prop->name || !new_prop->value) {
-		dlpar_free_drconf_property(new_prop);
-		return NULL;
-	}
-
-	new_prop->length = prop->length;
-
 	/* Convert the property to cpu endian-ness */
 	p = new_prop->value;
 	*p = be32_to_cpu(*p);
@@ -718,7 +732,7 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		break;
 	}
 
-	dlpar_free_drconf_property(prop);
+	dlpar_free_property(prop);
 
 dlpar_memory_out:
 	of_node_put(dn);
