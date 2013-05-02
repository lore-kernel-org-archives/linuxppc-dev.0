Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/powernv: defer OPAL exception handler registration
Message-Id: <1367483510.656290.229684042158.1.gpush@pablo>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 02 May 2013 16:31:50 +0800
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the OPAL exception vectors are registered before the feature
fixups are processed. This means that the now-firmware-owned vectors
will likely be overwritten by the kernel.

This change moves the exception registration code to an early initcall,
rather than at machine_init time.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/powernv/opal.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index aaa0dba..ade4463 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -34,7 +34,6 @@ int __init early_init_dt_scan_opal(unsigned long node,
 {
 	const void *basep, *entryp;
 	unsigned long basesz, entrysz;
-	u64 glue;
 
 	if (depth != 1 || strcmp(uname, "ibm,opal") != 0)
 		return 0;
@@ -61,6 +60,16 @@ int __init early_init_dt_scan_opal(unsigned long node,
 		printk("OPAL V1 detected !\n");
 	}
 
+	return 1;
+}
+
+static int __init opal_register_exception_handlers(void)
+{
+	u64 glue;
+
+	if (!(powerpc_firmware_features & FW_FEATURE_OPAL))
+		return -ENODEV;
+
 	/* Hookup some exception handlers. We use the fwnmi area at 0x7000
 	 * to provide the glue space to OPAL
 	 */
@@ -74,9 +83,11 @@ int __init early_init_dt_scan_opal(unsigned long node,
 	glue += 128;
 	opal_register_exception_handler(OPAL_SOFTPATCH_HANDLER, 0, glue);
 
-	return 1;
+	return 0;
 }
 
+early_initcall(opal_register_exception_handlers);
+
 int opal_get_chars(uint32_t vtermno, char *buf, int count)
 {
 	s64 len, rc;
