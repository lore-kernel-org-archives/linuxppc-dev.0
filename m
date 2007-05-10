Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 10 May 2007 17:06:30 +1000
Subject: [PATCH] Split initrd logic out of early_init_dt_scan_chosen() to fix
	warning
Message-Id: <20070510070645.15973DDEFE@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If CONFIG_BLK_DEV_INITRD is not defined the prop variable in
early_init_dt_scan_chosen() is unused, causing a compiler warning.

So split the initrd logic into a separate function, allowing us to
declare prop only when we need it.

Built for both cases and booted with an initrd.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/prom.c |   48 ++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 16 deletions(-)

Index: powerpc/arch/powerpc/kernel/prom.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/prom.c
+++ powerpc/arch/powerpc/kernel/prom.c
@@ -716,11 +716,41 @@ static int __init early_init_dt_scan_cpu
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEV_INITRD
+static void __init early_init_dt_check_for_initrd(unsigned long node)
+{
+	unsigned long l;
+	u32 *prop;
+
+	DBG("Looking for initrd properties... ");
+
+	prop = of_get_flat_dt_prop(node, "linux,initrd-start", &l);
+	if (prop) {
+		initrd_start = (unsigned long)__va(of_read_ulong(prop, l/4));
+
+		prop = of_get_flat_dt_prop(node, "linux,initrd-end", &l);
+		if (prop) {
+			initrd_end = (unsigned long)
+					__va(of_read_ulong(prop, l/4));
+			initrd_below_start_ok = 1;
+		} else {
+			initrd_start = 0;
+		}
+	}
+
+	DBG("initrd_start=0x%lx  initrd_end=0x%lx\n", initrd_start, initrd_end);
+}
+#else
+static inline void early_init_dt_check_for_initrd(unsigned long node)
+{
+	return;
+}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
 static int __init early_init_dt_scan_chosen(unsigned long node,
 					    const char *uname, int depth, void *data)
 {
 	unsigned long *lprop;
-	u32 *prop;
 	unsigned long l;
 	char *p;
 
@@ -762,21 +792,7 @@ static int __init early_init_dt_scan_cho
                crashk_res.end = crashk_res.start + *lprop - 1;
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	DBG("Looking for initrd properties... ");
-	prop = of_get_flat_dt_prop(node, "linux,initrd-start", &l);
-	if (prop) {
-		initrd_start = (unsigned long)__va(of_read_ulong(prop, l/4));
-		prop = of_get_flat_dt_prop(node, "linux,initrd-end", &l);
-		if (prop) {
-			initrd_end = (unsigned long)__va(of_read_ulong(prop, l/4));
-			initrd_below_start_ok = 1;
-		} else {
-			initrd_start = 0;
-		}
-	}
-	DBG("initrd_start=0x%lx  initrd_end=0x%lx\n", initrd_start, initrd_end);
-#endif /* CONFIG_BLK_DEV_INITRD */
+	early_init_dt_check_for_initrd(node);
 
 	/* Retreive command line */
  	p = of_get_flat_dt_prop(node, "bootargs", &l);
