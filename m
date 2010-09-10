Return-Path: <nfont@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1492B70A9
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Sep 2010 05:40:37 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8AJUq38015466
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 13:30:52 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8AJeXiV167478
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 13:40:33 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8AJeXkl001394
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 13:40:33 -0600
Received: from [9.53.40.150] (dyn95340150.austin.ibm.com [9.53.40.150])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o8AJeXRS001383
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 13:40:33 -0600
Message-ID: <4C8A89B0.9050102@austin.ibm.com>
Date: Fri, 10 Sep 2010 14:40:32 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] Export pseries device tree updating routines
References: <4C8A8937.9000005@austin.ibm.com>
In-Reply-To: <4C8A8937.9000005@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export routines associated with adding and removing device tree nodes on
pseries needed for device tree updating.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c   |    4 ++--
 arch/powerpc/platforms/pseries/pseries.h |    9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/dlpar.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/dlpar.c	2010-08-31 08:58:45.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/dlpar.c	2010-08-31 08:58:54.000000000 -0500
@@ -33,7 +33,7 @@ struct cc_workarea {
 	u32	prop_offset;
 };
 
-static void dlpar_free_cc_property(struct property *prop)
+void dlpar_free_cc_property(struct property *prop)
 {
 	kfree(prop->name);
 	kfree(prop->value);
@@ -102,7 +102,7 @@ static void dlpar_free_one_cc_node(struc
 	kfree(dn);
 }
 
-static void dlpar_free_cc_nodes(struct device_node *dn)
+void dlpar_free_cc_nodes(struct device_node *dn)
 {
 	if (dn->child)
 		dlpar_free_cc_nodes(dn->child);
Index: powerpc/arch/powerpc/platforms/pseries/pseries.h
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/pseries.h	2010-08-31 08:55:30.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/pseries.h	2010-08-31 08:58:54.000000000 -0500
@@ -17,6 +17,8 @@ struct device_node;
 extern void request_event_sources_irqs(struct device_node *np,
 				       irq_handler_t handler, const char *name);
 
+#include <linux/of.h>
+
 extern void __init fw_feature_init(const char *hypertas, unsigned long len);
 
 struct pt_regs;
@@ -47,4 +49,11 @@ extern unsigned long rtas_poweron_auto;
 
 extern void find_udbg_vterm(void);
 
+/* Dynamic logical Partitioning/Mobility */
+extern void dlpar_free_cc_nodes(struct device_node *);
+extern void dlpar_free_cc_property(struct property *);
+extern struct device_node *dlpar_configure_connector(u32);
+extern int dlpar_attach_node(struct device_node *);
+extern int dlpar_detach_node(struct device_node *);
+
 #endif /* _PSERIES_PSERIES_H */
