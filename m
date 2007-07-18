Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] fix future firmware feature fixups function failure
In-reply-to: <200707111329.51580.arnd@arndb.de> 
References: <9094.1181275235@neuling.org>
	<1184149691.6059.82.camel@localhost.localdomain>
	<200707111329.51580.arnd@arndb.de>
Date: Wed, 18 Jul 2007 16:56:32 -0500
Message-ID: <24414.1184795792@neuling.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move firmware feature initialisation from pSeries_init_early to the
earlier pSeries_probe_hypertas so they are initialised before firmware
feature fixups are applied.

Currently firmware feature sections are only used for iSeries which
initialises the these features much earlier.  This is a bug in waiting
on pSeries.

Also adds some whitespace fixups.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
> > There are two possibly solutions I see in the long run:
> >=20
> > =A0- We could set the FW features earlier on pseries, though that is a bit
> > annoying because that means doing it before the device-tree is
> > unflattened.
> >=20
> > =A0- We could constraint lmb_alloc to the first segment until the FW fixup
> > occurs, either within lmb_alloc itself, or fixup the callers such as
> > unflatten_device_tree, to pass an explicit limit.
> >=20
> > What do you think ?
> 
> If I'm understanding this right, the first solution should be something
> along the lines of the patch below (not tested), which even removes
> more lines than it adds. It doesn't seem that annoying to me, and it
> makes sense to assume that the fw_features are set up after returning
> from the ppc_md probe.

I've cleaned this up and got it booting.  Seems to be doing the right
things as I can see fw feature sections being correctly NOPed out now
after boot.  

I've booted with pseries_defconfig and ppc64_defconfig.

Arnd, I've added a signed off by me, but it but this probably needs an
explicit one from you also before it heads up.

Mikey

 arch/powerpc/platforms/pseries/firmware.c |   19 +++----------------
 arch/powerpc/platforms/pseries/pseries.h  |    2 +-
 arch/powerpc/platforms/pseries/setup.c    |   17 +++++++++++------
 3 files changed, 15 insertions(+), 23 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/firmware.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/firmware.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/firmware.c
@@ -66,24 +66,13 @@ firmware_features_table[FIRMWARE_MAX_FEA
  * device-tree/ibm,hypertas-functions.  Ultimately this functionality may
  * be moved into prom.c prom_init().
  */
-void __init fw_feature_init(void)
+void __init fw_feature_init(const char *hypertas, unsigned long len)
 {
-	struct device_node *dn;
-	const char *hypertas, *s;
-	int len, i;
+	const char *s;
+	int i;
 
 	DBG(" -> fw_feature_init()\n");
 
-	dn = of_find_node_by_path("/rtas");
-	if (dn == NULL) {
-		printk(KERN_ERR "WARNING! Cannot find RTAS in device-tree!\n");
-		goto out;
-	}
-
-	hypertas = of_get_property(dn, "ibm,hypertas-functions", &len);
-	if (hypertas == NULL)
-		goto out;
-
 	for (s = hypertas; s < hypertas + len; s += strlen(s) + 1) {
 		for (i = 0; i < FIRMWARE_MAX_FEATURES; i++) {
 			/* check value against table of strings */
@@ -98,7 +87,5 @@ void __init fw_feature_init(void)
 		}
 	}
 
-out:
-	of_node_put(dn);
 	DBG(" <- fw_feature_init()\n");
 }
Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/pseries.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/pseries.h
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/pseries.h
@@ -10,7 +10,7 @@
 #ifndef _PSERIES_PSERIES_H
 #define _PSERIES_PSERIES_H
 
-extern void __init fw_feature_init(void);
+extern void __init fw_feature_init(const char *hypertas, unsigned long len);
 
 struct pt_regs;
 
Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/setup.c
@@ -320,8 +320,6 @@ static void __init pSeries_init_early(vo
 {
 	DBG(" -> pSeries_init_early()\n");
 
-	fw_feature_init();
-
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		find_udbg_vterm();
 
@@ -343,14 +341,21 @@ static int __init pSeries_probe_hypertas
 					 const char *uname, int depth,
 					 void *data)
 {
+	const char *hypertas;
+	unsigned long len;
+
 	if (depth != 1 ||
 	    (strcmp(uname, "rtas") != 0 && strcmp(uname, "rtas@0") != 0))
- 		return 0;
+		return 0;
+
+	hypertas = of_get_flat_dt_prop(node, "ibm,hypertas-functions", &len);
+	if (!hypertas)
+		return 1;
 
-	if (of_get_flat_dt_prop(node, "ibm,hypertas-functions", NULL) != NULL)
- 		powerpc_firmware_features |= FW_FEATURE_LPAR;
+	powerpc_firmware_features |= FW_FEATURE_LPAR;
+	fw_feature_init(hypertas, len);
 
- 	return 1;
+	return 1;
 }
 
 static int __init pSeries_probe(void)
