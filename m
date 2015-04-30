Return-Path: <joel@jms.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C692D1A0406
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 13:50:37 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 475441402BD
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2015 13:50:34 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so46972610pab.2
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2015 20:50:32 -0700 (PDT)
Received: from icarus.ozlabs.ibm.com. ([122.99.82.10])
 by mx.google.com with ESMTPSA id pu1sm633650pdb.33.2015.04.29.20.50.29
 for <linuxppc-dev@ozlabs.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 29 Apr 2015 20:50:31 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: Silence SYSPARAM warning on boot
Date: Thu, 30 Apr 2015 13:50:07 +1000
Message-Id: <1430365807-14493-1-git-send-email-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OpenPower BMC machines do not place any sysparams in the device tree, so
at every boot we get a warning:

 [    0.437176] SYSPARAM: Opal sysparam node not found

Remove the warning, and reorder the init so we don't peform allocations
when there is no sysparam node in the device tree.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/platforms/powernv/opal-sysparam.c | 31 +++++++++++++-------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-sysparam.c b/arch/powerpc/platforms/powernv/opal-sysparam.c
index 9d1acf2..2e52b47 100644
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -162,10 +162,20 @@ void __init opal_sys_param_init(void)
 		goto out;
 	}
 
+	/* Some systems do not use sysparams; this is not an error */
+	sysparam = of_find_node_by_path("/ibm,opal/sysparams");
+	if (!sysparam)
+		goto out;
+
+	if (!of_device_is_compatible(sysparam, "ibm,opal-sysparams")) {
+		pr_err("SYSPARAM: Opal sysparam node not compatible\n");
+		goto out_node_put;
+	}
+
 	sysparam_kobj = kobject_create_and_add("sysparams", opal_kobj);
 	if (!sysparam_kobj) {
 		pr_err("SYSPARAM: Failed to create sysparam kobject\n");
-		goto out;
+		goto out_node_put;
 	}
 
 	/* Allocate big enough buffer for any get/set transactions */
@@ -176,30 +186,19 @@ void __init opal_sys_param_init(void)
 		goto out_kobj_put;
 	}
 
-	sysparam = of_find_node_by_path("/ibm,opal/sysparams");
-	if (!sysparam) {
-		pr_err("SYSPARAM: Opal sysparam node not found\n");
-		goto out_param_buf;
-	}
-
-	if (!of_device_is_compatible(sysparam, "ibm,opal-sysparams")) {
-		pr_err("SYSPARAM: Opal sysparam node not compatible\n");
-		goto out_node_put;
-	}
-
 	/* Number of parameters exposed through DT */
 	count = of_property_count_strings(sysparam, "param-name");
 	if (count < 0) {
 		pr_err("SYSPARAM: No string found of property param-name in "
 				"the node %s\n", sysparam->name);
-		goto out_node_put;
+		goto out_param_buf;
 	}
 
 	id = kzalloc(sizeof(*id) * count, GFP_KERNEL);
 	if (!id) {
 		pr_err("SYSPARAM: Failed to allocate memory to read parameter "
 				"id\n");
-		goto out_node_put;
+		goto out_param_buf;
 	}
 
 	size = kzalloc(sizeof(*size) * count, GFP_KERNEL);
@@ -293,12 +292,12 @@ out_free_size:
 	kfree(size);
 out_free_id:
 	kfree(id);
-out_node_put:
-	of_node_put(sysparam);
 out_param_buf:
 	kfree(param_data_buf);
 out_kobj_put:
 	kobject_put(sysparam_kobj);
+out_node_put:
+	of_node_put(sysparam);
 out:
 	return;
 }
-- 
2.1.4
