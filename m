Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 14/14] powerpc: Disable relocation on exceptions when kexecing
Date: Fri,  9 Nov 2012 17:19:13 +1100
Message-Id: <1352441953-29096-16-git-send-email-mikey@neuling.org>
In-Reply-To: <1352441953-29096-1-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Since we don't know if they new kernel we are kexecing into has been
built to support relocation on exceptions, we disable them before we
kexec.

We do NOT disable them if we are execing a kdump kernel, because we
want to change as little state as possible and it is likely that we are
execing ourselves and will be able to handle them anyway.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/pseries/setup.c |   33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 4c4adc0..47d2a7e 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -40,6 +40,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/cpuidle.h>
+#include <linux/kexec.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -397,6 +398,35 @@ static int __init pSeries_enable_reloc_on_exc(void)
 	}
 }
 
+#ifdef CONFIG_KEXEC
+static long pSeries_disable_reloc_on_exc(void)
+{
+	long rc;
+
+	while (1) {
+		rc = disable_reloc_on_exceptions();
+		if (!H_IS_LONG_BUSY(rc))
+			return rc;
+		mdelay(get_longbusy_msecs(rc));
+	}
+}
+
+static void pSeries_machine_kexec(struct kimage *image)
+{
+	long rc;
+
+	if (firmware_has_feature(FW_FEATURE_SET_MODE) &&
+	    (image->type != KEXEC_TYPE_CRASH)) {
+		rc = pSeries_disable_reloc_on_exc();
+		if (rc != H_SUCCESS)
+			pr_warning("Warning: Failed to disable relocation on "
+				   "exceptions: %ld\n", rc);
+	}
+
+	default_machine_kexec(image);
+}
+#endif
+
 static void __init pSeries_setup_arch(void)
 {
 	panic_timeout = 10;
@@ -697,4 +727,7 @@ define_machine(pseries) {
 	.progress		= rtas_progress,
 	.system_reset_exception = pSeries_system_reset_exception,
 	.machine_check_exception = pSeries_machine_check_exception,
+#ifdef CONFIG_KEXEC
+	.machine_kexec          = pSeries_machine_kexec,
+#endif
 };
-- 
1.7.9.5
