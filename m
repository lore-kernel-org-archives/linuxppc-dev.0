Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 11/14] powerpc: Add wrappers to enable/disable relocation on
 exceptions
Date: Fri,  9 Nov 2012 17:19:10 +1100
Message-Id: <1352441953-29096-13-git-send-email-mikey@neuling.org>
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

These wrappers hide the parameters that have to be passed to H_SET_MODE
to enable/disable relocation on during exceptions.

As noted in the comments, since these have partition wide scope, they
may take some time to complete and must be periodically retried until
H_SUCCESS is returned.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
index 44ad214..e6cc34a 100644
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -279,4 +279,29 @@ static inline long plpar_set_mode(unsigned long mflags, unsigned long resource,
 {
 	return plpar_hcall_norets(H_SET_MODE, mflags, resource, value1, value2);
 }
+
+/*
+ * Enable relocation on exceptions on this partition
+ *
+ * Note: this call has a partition wide scope and can take a while to complete.
+ * If it returns H_LONG_BUSY_* it should be retried periodically until it
+ * returns H_SUCCESS.
+ */
+static inline long enable_reloc_on_exceptions(void)
+{
+	/* mflags = 3: Exceptions at 0xC000000000004000 */
+	return plpar_set_mode(3, 3, 0, 0);
+}
+
+/*
+ * Disable relocation on exceptions on this partition
+ *
+ * Note: this call has a partition wide scope and can take a while to complete.
+ * If it returns H_LONG_BUSY_* it should be retried periodically until it
+ * returns H_SUCCESS.
+ */
+static inline long disable_reloc_on_exceptions(void) {
+	return plpar_set_mode(0, 3, 0, 0);
+}
+
 #endif /* _PSERIES_PLPAR_WRAPPERS_H */
-- 
1.7.9.5
