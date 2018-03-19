Return-Path: <oohall@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404PQJ6MxPzF1dw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 16:15:04 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id w15-v6so9583597plq.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 22:15:04 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 4/5] powerpc/zImage: Rework serial driver probing
Date: Mon, 19 Mar 2018 16:14:02 +1100
Message-Id: <20180319051403.23275-4-oohall@gmail.com>
In-Reply-To: <20180319051403.23275-1-oohall@gmail.com>
References: <20180319051403.23275-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rather than checking the compatible string in serial_driver_init()
we call into the driver's init function and wait for a driver to
inidicate it bound to the device by returning zero.

The pointers to each driver probe functions are stored in the
".serialdrv" section of the zImage, similar to how initcalls and
whatnot are handled inside Linux. This structure allows us to
conditionally compile specific driver files based on the KConfig
settings. This is needed because we don't have access to the
KConfig #defines in the zImage source files (it's a giant #include
headache) so conditional compilation is the only way to eliminate
unnecessary code.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/boot/cpm-serial.c      |  1 +
 arch/powerpc/boot/mpc52xx-psc.c     |  1 +
 arch/powerpc/boot/mpsc.c            |  1 +
 arch/powerpc/boot/ns16550.c         |  2 ++
 arch/powerpc/boot/opal.c            |  1 +
 arch/powerpc/boot/ops.h             | 16 +++++++++------
 arch/powerpc/boot/serial.c          | 41 +++++++++++--------------------------
 arch/powerpc/boot/uartlite.c        |  1 +
 arch/powerpc/boot/wrapper           |  2 +-
 arch/powerpc/boot/zImage.coff.lds.S |  4 ++++
 arch/powerpc/boot/zImage.lds.S      |  8 ++++++++
 11 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/boot/cpm-serial.c b/arch/powerpc/boot/cpm-serial.c
index f6b1cf23946e..5ebf3dfd810a 100644
--- a/arch/powerpc/boot/cpm-serial.c
+++ b/arch/powerpc/boot/cpm-serial.c
@@ -295,3 +295,4 @@ int cpm_console_init(void *devp, struct serial_console_data *scdp)
 
 	return 0;
 }
+SERIAL_DRIVER(cpm_console_init);
diff --git a/arch/powerpc/boot/mpc52xx-psc.c b/arch/powerpc/boot/mpc52xx-psc.c
index 75470936e661..c09e82eaf006 100644
--- a/arch/powerpc/boot/mpc52xx-psc.c
+++ b/arch/powerpc/boot/mpc52xx-psc.c
@@ -66,3 +66,4 @@ int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp)
 
 	return 0;
 }
+SERIAL_DRIVER(mpc5200_psc_console_init);
diff --git a/arch/powerpc/boot/mpsc.c b/arch/powerpc/boot/mpsc.c
index 59e23e886440..2d0a72522b3c 100644
--- a/arch/powerpc/boot/mpsc.c
+++ b/arch/powerpc/boot/mpsc.c
@@ -170,3 +170,4 @@ int mpsc_console_init(void *devp, struct serial_console_data *scdp)
 err_out:
 	return -1;
 }
+SERIAL_DRIVER(mpsc_console_init);
diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
index 0e7bd5284255..49e8c299b829 100644
--- a/arch/powerpc/boot/ns16550.c
+++ b/arch/powerpc/boot/ns16550.c
@@ -81,3 +81,5 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
 
 	return 0;
 }
+
+SERIAL_DRIVER(ns16550_console_init);
diff --git a/arch/powerpc/boot/opal.c b/arch/powerpc/boot/opal.c
index 0e92537536b9..dc345ff63422 100644
--- a/arch/powerpc/boot/opal.c
+++ b/arch/powerpc/boot/opal.c
@@ -102,3 +102,4 @@ int opal_console_init(void *devp, struct serial_console_data *scdp)
 
 	return 0;
 }
+SERIAL_DRIVER(opal_console_init);
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index fad1862f4b2d..06151ecb2f45 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -84,13 +84,17 @@ extern struct loader_info loader_info;
 
 void start(void);
 void fdt_init(void *blob);
+
+struct driver_ptr {
+	int (*ptr)(void *node, struct serial_console_data *scdp);
+};
+
+#define SERIAL_DRIVER(init_function) static const struct driver_ptr \
+	__attribute__((__section__(".serialdrv"))) __attribute__((used)) \
+	init_function##_ptr = { .ptr = &init_function, }
+
 int serial_console_init(void);
-int ns16550_console_init(void *devp, struct serial_console_data *scdp);
-int mpsc_console_init(void *devp, struct serial_console_data *scdp);
-int cpm_console_init(void *devp, struct serial_console_data *scdp);
-int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp);
-int uartlite_console_init(void *devp, struct serial_console_data *scdp);
-int opal_console_init(void *devp, struct serial_console_data *scdp);
+
 void *simple_alloc_init(char *base, unsigned long heap_size,
 			unsigned long granularity, unsigned long max_allocs);
 extern void flush_cache(void *, unsigned long);
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 88955095ec07..a7f9ac9a27b5 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -105,11 +105,15 @@ static void *serial_get_stdout_devp(void)
 	return NULL;
 }
 
+extern unsigned long _serial_drv_start;
+extern unsigned long _serial_drv_end;
+
 static struct serial_console_data serial_cd;
 
 /* Node's "compatible" property determines which serial driver to use */
 int serial_console_init(void)
 {
+	struct driver_ptr *start, *end, *probe;
 	void *devp;
 	int rc = -1;
 
@@ -117,35 +121,14 @@ int serial_console_init(void)
 	if (devp == NULL)
 		goto err_out;
 
-	if (dt_is_compatible(devp, "ns16550") ||
-	    dt_is_compatible(devp, "pnpPNP,501"))
-		rc = ns16550_console_init(devp, &serial_cd);
-#ifdef CONFIG_EMBEDDED6xx
-	else if (dt_is_compatible(devp, "marvell,mv64360-mpsc"))
-		rc = mpsc_console_init(devp, &serial_cd);
-#endif
-#ifdef CONFIG_CPM
-	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
-	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
-	         dt_is_compatible(devp, "fsl,cpm2-scc-uart") ||
-	         dt_is_compatible(devp, "fsl,cpm2-smc-uart"))
-		rc = cpm_console_init(devp, &serial_cd);
-#endif
-#ifdef CONFIG_PPC_MPC52XX
-	else if (dt_is_compatible(devp, "fsl,mpc5200-psc-uart"))
-		rc = mpc5200_psc_console_init(devp, &serial_cd);
-#endif
-#ifdef CONFIG_XILINX_VIRTEX
-	else if (dt_is_compatible(devp, "xlnx,opb-uartlite-1.00.b") ||
-		 dt_is_compatible(devp, "xlnx,xps-uartlite-1.00.a"))
-		rc = uartlite_console_init(devp, &serial_cd);
-#endif
-#ifdef CONFIG_PPC64_BOOT_WRAPPER
-	else if (dt_is_compatible(devp, "ibm,opal-console-raw"))
-		rc = opal_console_init(devp, &serial_cd);
-#endif
-
-	/* Add other serial console driver calls here */
+	start = (void *) &_serial_drv_start;
+	end = (void *) &_serial_drv_end;
+
+	for (probe = start; probe < end; probe++) {
+		rc = probe->ptr(devp, &serial_cd);
+		if (rc <= 0)
+			break;
+	}
 
 	if (!rc) {
 		console_ops.open = serial_open;
diff --git a/arch/powerpc/boot/uartlite.c b/arch/powerpc/boot/uartlite.c
index fc66a5fcea66..92d4f00bf626 100644
--- a/arch/powerpc/boot/uartlite.c
+++ b/arch/powerpc/boot/uartlite.c
@@ -82,3 +82,4 @@ int uartlite_console_init(void *devp, struct serial_console_data *scdp)
 	scdp->close = NULL;
 	return 0;
 }
+SERIAL_DRIVER(uartlite_console_init);
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 76fe3ccfd381..b5c887ae729d 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -469,7 +469,7 @@ if [ "$platform" != "miboot" ]; then
     fi
 #link everything
     ${CROSS}ld -m $format -T $lds $text_start $pie $nodl -o "$ofile" \
-	$platformo $tmp $object/wrapper.a
+	$platformo $tmp --whole-archive $object/wrapper.a
     rm $tmp
 fi
 
diff --git a/arch/powerpc/boot/zImage.coff.lds.S b/arch/powerpc/boot/zImage.coff.lds.S
index 117951295117..d667fe3f5999 100644
--- a/arch/powerpc/boot/zImage.coff.lds.S
+++ b/arch/powerpc/boot/zImage.coff.lds.S
@@ -20,6 +20,10 @@ SECTIONS
     *(.sdata*)
     *(.got2)
 
+    _serial_drv_start = .;
+    *(.serialdrv)
+    _serial_drv_end = .;
+
     _dtb_start = .;
     *(.kernel:dtb)
     _dtb_end = .;
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index 4ac1e36edfe7..9dda24bcee00 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -45,6 +45,14 @@ SECTIONS
   }
 
   . = ALIGN(8);
+  .serialdrv :
+  {
+    _serial_drv_start = .;
+    KEEP(*(.serialdrv));
+    _serial_drv_end = .;
+  }
+
+  . = ALIGN(8);
   .kernel:dtb :
   {
     _dtb_start = .;
-- 
2.9.5
