Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 13/14] powerpc: Enable relocation on during exceptions at boot
Date: Fri,  9 Nov 2012 17:19:12 +1100
Message-Id: <1352441953-29096-15-git-send-email-mikey@neuling.org>
In-Reply-To: <1352441953-29096-1-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

We currently do this synchronously at boot from setup_arch. On a large
system this could hypothetically take a little while to complete, so
currently we will give up if we are asked to wait for more than a second
in total.

If we actually start hitting that timeout in practice we can always move
this code into a kernel thread to take care of it in the background.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c |   38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e3cb7ae..4c4adc0 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -367,6 +367,36 @@ static void pSeries_idle(void)
 	}
 }
 
+/*
+ * Enable relocation on during exceptions. This has partition wide scope and
+ * may take a while to complete, if it takes longer than one second we will
+ * just give up rather than wasting any more time on this - if that turns out
+ * to ever be a problem in practice we can move this into a kernel thread to
+ * finish off the process later in boot.
+ */
+static int __init pSeries_enable_reloc_on_exc(void)
+{
+	long rc;
+	unsigned int delay, total_delay = 0;
+
+	while (1) {
+		rc = enable_reloc_on_exceptions();
+		if (!H_IS_LONG_BUSY(rc))
+			return rc;
+
+		delay = get_longbusy_msecs(rc);
+		total_delay += delay;
+		if (total_delay > 1000) {
+			pr_warn("Warning: Giving up waiting to enable "
+				"relocation on exceptions (%u msec)!\n",
+				total_delay);
+			return rc;
+		}
+
+		mdelay(delay);
+	}
+}
+
 static void __init pSeries_setup_arch(void)
 {
 	panic_timeout = 10;
@@ -402,6 +432,14 @@ static void __init pSeries_setup_arch(void)
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
 	else
 		ppc_md.enable_pmcs = power4_enable_pmcs;
+
+	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
+		long rc;
+		if ((rc = pSeries_enable_reloc_on_exc()) != H_SUCCESS) {
+			pr_warn("Unable to enable relocation on exceptions: "
+				"%ld\n", rc);
+		}
+	}
 }
 
 static int __init pSeries_init_panel(void)
-- 
1.7.9.5
