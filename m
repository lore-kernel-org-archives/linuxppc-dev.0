Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E32672C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 19:54:31 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 22 Aug 2013 15:14:55 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B5C861258043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:24:14 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7M9twn942729686
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:25:58 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7M9sQ2l027872
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:24:27 +0530
Subject: [PATCH V5 2/5] pseries: Move plpar_wrapper.h to powerpc common
 include/asm location.
To: benh@kernel.crashing.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 15:23:52 +0530
Message-ID: <20130822095347.27416.62240.stgit@deepthi.in.ibm.com>
In-Reply-To: <20130822095323.27416.79369.stgit@deepthi.in.ibm.com>
References: <20130822095323.27416.79369.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: preeti@linux.vnet.ibm.com, dongsheng.wang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As a part of pseries_idle backend driver cleanup to make
the code common to both pseries and powernv platforms, it
is necessary to move the backend-driver code to drivers/cpuidle.

As a pre-requisite for that, it is essential to move plpar_wrapper.h
to include/asm.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/plpar_wrappers.h       |  325 +++++++++++++++++++++++
 arch/powerpc/platforms/pseries/cmm.c            |    3 
 arch/powerpc/platforms/pseries/dtl.c            |    3 
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |    3 
 arch/powerpc/platforms/pseries/hvconsole.c      |    2 
 arch/powerpc/platforms/pseries/iommu.c          |    3 
 arch/powerpc/platforms/pseries/kexec.c          |    2 
 arch/powerpc/platforms/pseries/lpar.c           |    2 
 arch/powerpc/platforms/pseries/plpar_wrappers.h |  324 -----------------------
 arch/powerpc/platforms/pseries/processor_idle.c |    3 
 arch/powerpc/platforms/pseries/setup.c          |    2 
 arch/powerpc/platforms/pseries/smp.c            |    2 
 12 files changed, 336 insertions(+), 338 deletions(-)
 create mode 100644 arch/powerpc/include/asm/plpar_wrappers.h
 delete mode 100644 arch/powerpc/platforms/pseries/plpar_wrappers.h

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
new file mode 100644
index 0000000..e2f84d6
--- /dev/null
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -0,0 +1,325 @@
+#ifndef _PSERIES_PLPAR_WRAPPERS_H
+#define _PSERIES_PLPAR_WRAPPERS_H
+
+#include <linux/string.h>
+#include <linux/irqflags.h>
+
+#include <asm/hvcall.h>
+#include <asm/paca.h>
+#include <asm/page.h>
+
+/* Get state of physical CPU from query_cpu_stopped */
+int smp_query_cpu_stopped(unsigned int pcpu);
+#define QCSS_STOPPED 0
+#define QCSS_STOPPING 1
+#define QCSS_NOT_STOPPED 2
+#define QCSS_HARDWARE_ERROR -1
+#define QCSS_HARDWARE_BUSY -2
+
+static inline long poll_pending(void)
+{
+	return plpar_hcall_norets(H_POLL_PENDING);
+}
+
+static inline u8 get_cede_latency_hint(void)
+{
+	return get_lppaca()->cede_latency_hint;
+}
+
+static inline void set_cede_latency_hint(u8 latency_hint)
+{
+	get_lppaca()->cede_latency_hint = latency_hint;
+}
+
+static inline long cede_processor(void)
+{
+	return plpar_hcall_norets(H_CEDE);
+}
+
+static inline long extended_cede_processor(unsigned long latency_hint)
+{
+	long rc;
+	u8 old_latency_hint = get_cede_latency_hint();
+
+	set_cede_latency_hint(latency_hint);
+
+	rc = cede_processor();
+#ifdef CONFIG_TRACE_IRQFLAGS
+		/* Ensure that H_CEDE returns with IRQs on */
+		if (WARN_ON(!(mfmsr() & MSR_EE)))
+			__hard_irq_enable();
+#endif
+
+	set_cede_latency_hint(old_latency_hint);
+
+	return rc;
+}
+
+static inline long vpa_call(unsigned long flags, unsigned long cpu,
+		unsigned long vpa)
+{
+	flags = flags << H_VPA_FUNC_SHIFT;
+
+	return plpar_hcall_norets(H_REGISTER_VPA, flags, cpu, vpa);
+}
+
+static inline long unregister_vpa(unsigned long cpu)
+{
+	return vpa_call(H_VPA_DEREG_VPA, cpu, 0);
+}
+
+static inline long register_vpa(unsigned long cpu, unsigned long vpa)
+{
+	return vpa_call(H_VPA_REG_VPA, cpu, vpa);
+}
+
+static inline long unregister_slb_shadow(unsigned long cpu)
+{
+	return vpa_call(H_VPA_DEREG_SLB, cpu, 0);
+}
+
+static inline long register_slb_shadow(unsigned long cpu, unsigned long vpa)
+{
+	return vpa_call(H_VPA_REG_SLB, cpu, vpa);
+}
+
+static inline long unregister_dtl(unsigned long cpu)
+{
+	return vpa_call(H_VPA_DEREG_DTL, cpu, 0);
+}
+
+static inline long register_dtl(unsigned long cpu, unsigned long vpa)
+{
+	return vpa_call(H_VPA_REG_DTL, cpu, vpa);
+}
+
+static inline long plpar_page_set_loaned(unsigned long vpa)
+{
+	unsigned long cmo_page_sz = cmo_get_page_size();
+	long rc = 0;
+	int i;
+
+	for (i = 0; !rc && i < PAGE_SIZE; i += cmo_page_sz)
+		rc = plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED, vpa + i, 0);
+
+	for (i -= cmo_page_sz; rc && i != 0; i -= cmo_page_sz)
+		plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE,
+				   vpa + i - cmo_page_sz, 0);
+
+	return rc;
+}
+
+static inline long plpar_page_set_active(unsigned long vpa)
+{
+	unsigned long cmo_page_sz = cmo_get_page_size();
+	long rc = 0;
+	int i;
+
+	for (i = 0; !rc && i < PAGE_SIZE; i += cmo_page_sz)
+		rc = plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE, vpa + i, 0);
+
+	for (i -= cmo_page_sz; rc && i != 0; i -= cmo_page_sz)
+		plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED,
+				   vpa + i - cmo_page_sz, 0);
+
+	return rc;
+}
+
+extern void vpa_init(int cpu);
+
+static inline long plpar_pte_enter(unsigned long flags,
+		unsigned long hpte_group, unsigned long hpte_v,
+		unsigned long hpte_r, unsigned long *slot)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_ENTER, retbuf, flags, hpte_group, hpte_v, hpte_r);
+
+	*slot = retbuf[0];
+
+	return rc;
+}
+
+static inline long plpar_pte_remove(unsigned long flags, unsigned long ptex,
+		unsigned long avpn, unsigned long *old_pteh_ret,
+		unsigned long *old_ptel_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_REMOVE, retbuf, flags, ptex, avpn);
+
+	*old_pteh_ret = retbuf[0];
+	*old_ptel_ret = retbuf[1];
+
+	return rc;
+}
+
+/* plpar_pte_remove_raw can be called in real mode. It calls plpar_hcall_raw */
+static inline long plpar_pte_remove_raw(unsigned long flags, unsigned long ptex,
+		unsigned long avpn, unsigned long *old_pteh_ret,
+		unsigned long *old_ptel_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall_raw(H_REMOVE, retbuf, flags, ptex, avpn);
+
+	*old_pteh_ret = retbuf[0];
+	*old_ptel_ret = retbuf[1];
+
+	return rc;
+}
+
+static inline long plpar_pte_read(unsigned long flags, unsigned long ptex,
+		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_READ, retbuf, flags, ptex);
+
+	*old_pteh_ret = retbuf[0];
+	*old_ptel_ret = retbuf[1];
+
+	return rc;
+}
+
+/* plpar_pte_read_raw can be called in real mode. It calls plpar_hcall_raw */
+static inline long plpar_pte_read_raw(unsigned long flags, unsigned long ptex,
+		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall_raw(H_READ, retbuf, flags, ptex);
+
+	*old_pteh_ret = retbuf[0];
+	*old_ptel_ret = retbuf[1];
+
+	return rc;
+}
+
+/*
+ * plpar_pte_read_4_raw can be called in real mode.
+ * ptes must be 8*sizeof(unsigned long)
+ */
+static inline long plpar_pte_read_4_raw(unsigned long flags, unsigned long ptex,
+					unsigned long *ptes)
+
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+	rc = plpar_hcall9_raw(H_READ, retbuf, flags | H_READ_4, ptex);
+
+	memcpy(ptes, retbuf, 8*sizeof(unsigned long));
+
+	return rc;
+}
+
+static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
+		unsigned long avpn)
+{
+	return plpar_hcall_norets(H_PROTECT, flags, ptex, avpn);
+}
+
+static inline long plpar_tce_get(unsigned long liobn, unsigned long ioba,
+		unsigned long *tce_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_GET_TCE, retbuf, liobn, ioba);
+
+	*tce_ret = retbuf[0];
+
+	return rc;
+}
+
+static inline long plpar_tce_put(unsigned long liobn, unsigned long ioba,
+		unsigned long tceval)
+{
+	return plpar_hcall_norets(H_PUT_TCE, liobn, ioba, tceval);
+}
+
+static inline long plpar_tce_put_indirect(unsigned long liobn,
+		unsigned long ioba, unsigned long page, unsigned long count)
+{
+	return plpar_hcall_norets(H_PUT_TCE_INDIRECT, liobn, ioba, page, count);
+}
+
+static inline long plpar_tce_stuff(unsigned long liobn, unsigned long ioba,
+		unsigned long tceval, unsigned long count)
+{
+	return plpar_hcall_norets(H_STUFF_TCE, liobn, ioba, tceval, count);
+}
+
+static inline long plpar_get_term_char(unsigned long termno,
+		unsigned long *len_ret, char *buf_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	unsigned long *lbuf = (unsigned long *)buf_ret;	/* TODO: alignment? */
+
+	rc = plpar_hcall(H_GET_TERM_CHAR, retbuf, termno);
+
+	*len_ret = retbuf[0];
+	lbuf[0] = retbuf[1];
+	lbuf[1] = retbuf[2];
+
+	return rc;
+}
+
+static inline long plpar_put_term_char(unsigned long termno, unsigned long len,
+		const char *buffer)
+{
+	unsigned long *lbuf = (unsigned long *)buffer;	/* TODO: alignment? */
+	return plpar_hcall_norets(H_PUT_TERM_CHAR, termno, len, lbuf[0],
+			lbuf[1]);
+}
+
+/* Set various resource mode parameters */
+static inline long plpar_set_mode(unsigned long mflags, unsigned long resource,
+		unsigned long value1, unsigned long value2)
+{
+	return plpar_hcall_norets(H_SET_MODE, mflags, resource, value1, value2);
+}
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
+static inline long disable_reloc_on_exceptions(void)
+{
+	return plpar_set_mode(0, 3, 0, 0);
+}
+
+static inline long plapr_set_ciabr(unsigned long ciabr)
+{
+	return plpar_set_mode(0, 1, ciabr, 0);
+}
+
+static inline long plapr_set_watchpoint0(unsigned long dawr0, unsigned long dawrx0)
+{
+	return plpar_set_mode(0, 2, dawr0, dawrx0);
+}
+
+#endif /* _PSERIES_PLPAR_WRAPPERS_H */
diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index c638535..1e561be 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -40,8 +40,7 @@
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <linux/memory.h>
-
-#include "plpar_wrappers.h"
+#include <asm/plpar_wrappers.h>
 
 #define CMM_DRIVER_VERSION	"1.0.0"
 #define CMM_DEFAULT_DELAY	1
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 0cc0ac0..f6cb051 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -29,8 +29,7 @@
 #include <asm/firmware.h>
 #include <asm/lppaca.h>
 #include <asm/debug.h>
-
-#include "plpar_wrappers.h"
+#include <asm/plpar_wrappers.h>
 
 struct dtl {
 	struct dtl_entry	*buf;
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 217ca5c..a8ef932 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -30,7 +30,8 @@
 #include <asm/machdep.h>
 #include <asm/vdso_datapage.h>
 #include <asm/xics.h>
-#include "plpar_wrappers.h"
+#include <asm/plpar_wrappers.h>
+
 #include "offline_states.h"
 
 /* This version can't take the spinlock, because it never returns */
diff --git a/arch/powerpc/platforms/pseries/hvconsole.c b/arch/powerpc/platforms/pseries/hvconsole.c
index b344f94..f3f108b 100644
--- a/arch/powerpc/platforms/pseries/hvconsole.c
+++ b/arch/powerpc/platforms/pseries/hvconsole.c
@@ -28,7 +28,7 @@
 #include <linux/errno.h>
 #include <asm/hvcall.h>
 #include <asm/hvconsole.h>
-#include "plpar_wrappers.h"
+#include <asm/plpar_wrappers.h>
 
 /**
  * hvc_get_chars - retrieve characters from firmware for denoted vterm adatper
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 23fc1dc..4821933 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -48,8 +48,7 @@
 #include <asm/ppc-pci.h>
 #include <asm/udbg.h>
 #include <asm/mmzone.h>
-
-#include "plpar_wrappers.h"
+#include <asm/plpar_wrappers.h>
 
 
 static void tce_invalidate_pSeries_sw(struct iommu_table *tbl,
diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index 7d94bdc..13fa95b3 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -17,9 +17,9 @@
 #include <asm/mpic.h>
 #include <asm/xics.h>
 #include <asm/smp.h>
+#include <asm/plpar_wrappers.h>
 
 #include "pseries.h"
-#include "plpar_wrappers.h"
 
 static void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
 {
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 8bad880..e1873bc 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -41,8 +41,8 @@
 #include <asm/smp.h>
 #include <asm/trace.h>
 #include <asm/firmware.h>
+#include <asm/plpar_wrappers.h>
 
-#include "plpar_wrappers.h"
 #include "pseries.h"
 
 /* Flag bits for H_BULK_REMOVE */
diff --git a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
deleted file mode 100644
index f35787b..0000000
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ /dev/null
@@ -1,324 +0,0 @@
-#ifndef _PSERIES_PLPAR_WRAPPERS_H
-#define _PSERIES_PLPAR_WRAPPERS_H
-
-#include <linux/string.h>
-#include <linux/irqflags.h>
-
-#include <asm/hvcall.h>
-#include <asm/paca.h>
-#include <asm/page.h>
-
-/* Get state of physical CPU from query_cpu_stopped */
-int smp_query_cpu_stopped(unsigned int pcpu);
-#define QCSS_STOPPED 0
-#define QCSS_STOPPING 1
-#define QCSS_NOT_STOPPED 2
-#define QCSS_HARDWARE_ERROR -1
-#define QCSS_HARDWARE_BUSY -2
-
-static inline long poll_pending(void)
-{
-	return plpar_hcall_norets(H_POLL_PENDING);
-}
-
-static inline u8 get_cede_latency_hint(void)
-{
-	return get_lppaca()->cede_latency_hint;
-}
-
-static inline void set_cede_latency_hint(u8 latency_hint)
-{
-	get_lppaca()->cede_latency_hint = latency_hint;
-}
-
-static inline long cede_processor(void)
-{
-	return plpar_hcall_norets(H_CEDE);
-}
-
-static inline long extended_cede_processor(unsigned long latency_hint)
-{
-	long rc;
-	u8 old_latency_hint = get_cede_latency_hint();
-
-	set_cede_latency_hint(latency_hint);
-
-	rc = cede_processor();
-#ifdef CONFIG_TRACE_IRQFLAGS
-		/* Ensure that H_CEDE returns with IRQs on */
-		if (WARN_ON(!(mfmsr() & MSR_EE)))
-			__hard_irq_enable();
-#endif
-
-	set_cede_latency_hint(old_latency_hint);
-
-	return rc;
-}
-
-static inline long vpa_call(unsigned long flags, unsigned long cpu,
-		unsigned long vpa)
-{
-	flags = flags << H_VPA_FUNC_SHIFT;
-
-	return plpar_hcall_norets(H_REGISTER_VPA, flags, cpu, vpa);
-}
-
-static inline long unregister_vpa(unsigned long cpu)
-{
-	return vpa_call(H_VPA_DEREG_VPA, cpu, 0);
-}
-
-static inline long register_vpa(unsigned long cpu, unsigned long vpa)
-{
-	return vpa_call(H_VPA_REG_VPA, cpu, vpa);
-}
-
-static inline long unregister_slb_shadow(unsigned long cpu)
-{
-	return vpa_call(H_VPA_DEREG_SLB, cpu, 0);
-}
-
-static inline long register_slb_shadow(unsigned long cpu, unsigned long vpa)
-{
-	return vpa_call(H_VPA_REG_SLB, cpu, vpa);
-}
-
-static inline long unregister_dtl(unsigned long cpu)
-{
-	return vpa_call(H_VPA_DEREG_DTL, cpu, 0);
-}
-
-static inline long register_dtl(unsigned long cpu, unsigned long vpa)
-{
-	return vpa_call(H_VPA_REG_DTL, cpu, vpa);
-}
-
-static inline long plpar_page_set_loaned(unsigned long vpa)
-{
-	unsigned long cmo_page_sz = cmo_get_page_size();
-	long rc = 0;
-	int i;
-
-	for (i = 0; !rc && i < PAGE_SIZE; i += cmo_page_sz)
-		rc = plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED, vpa + i, 0);
-
-	for (i -= cmo_page_sz; rc && i != 0; i -= cmo_page_sz)
-		plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE,
-				   vpa + i - cmo_page_sz, 0);
-
-	return rc;
-}
-
-static inline long plpar_page_set_active(unsigned long vpa)
-{
-	unsigned long cmo_page_sz = cmo_get_page_size();
-	long rc = 0;
-	int i;
-
-	for (i = 0; !rc && i < PAGE_SIZE; i += cmo_page_sz)
-		rc = plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_ACTIVE, vpa + i, 0);
-
-	for (i -= cmo_page_sz; rc && i != 0; i -= cmo_page_sz)
-		plpar_hcall_norets(H_PAGE_INIT, H_PAGE_SET_LOANED,
-				   vpa + i - cmo_page_sz, 0);
-
-	return rc;
-}
-
-extern void vpa_init(int cpu);
-
-static inline long plpar_pte_enter(unsigned long flags,
-		unsigned long hpte_group, unsigned long hpte_v,
-		unsigned long hpte_r, unsigned long *slot)
-{
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall(H_ENTER, retbuf, flags, hpte_group, hpte_v, hpte_r);
-
-	*slot = retbuf[0];
-
-	return rc;
-}
-
-static inline long plpar_pte_remove(unsigned long flags, unsigned long ptex,
-		unsigned long avpn, unsigned long *old_pteh_ret,
-		unsigned long *old_ptel_ret)
-{
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall(H_REMOVE, retbuf, flags, ptex, avpn);
-
-	*old_pteh_ret = retbuf[0];
-	*old_ptel_ret = retbuf[1];
-
-	return rc;
-}
-
-/* plpar_pte_remove_raw can be called in real mode. It calls plpar_hcall_raw */
-static inline long plpar_pte_remove_raw(unsigned long flags, unsigned long ptex,
-		unsigned long avpn, unsigned long *old_pteh_ret,
-		unsigned long *old_ptel_ret)
-{
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall_raw(H_REMOVE, retbuf, flags, ptex, avpn);
-
-	*old_pteh_ret = retbuf[0];
-	*old_ptel_ret = retbuf[1];
-
-	return rc;
-}
-
-static inline long plpar_pte_read(unsigned long flags, unsigned long ptex,
-		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
-{
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall(H_READ, retbuf, flags, ptex);
-
-	*old_pteh_ret = retbuf[0];
-	*old_ptel_ret = retbuf[1];
-
-	return rc;
-}
-
-/* plpar_pte_read_raw can be called in real mode. It calls plpar_hcall_raw */
-static inline long plpar_pte_read_raw(unsigned long flags, unsigned long ptex,
-		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
-{
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall_raw(H_READ, retbuf, flags, ptex);
-
-	*old_pteh_ret = retbuf[0];
-	*old_ptel_ret = retbuf[1];
-
-	return rc;
-}
-
-/*
- * plpar_pte_read_4_raw can be called in real mode.
- * ptes must be 8*sizeof(unsigned long)
- */
-static inline long plpar_pte_read_4_raw(unsigned long flags, unsigned long ptex,
-					unsigned long *ptes)
-
-{
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
-
-	rc = plpar_hcall9_raw(H_READ, retbuf, flags | H_READ_4, ptex);
-
-	memcpy(ptes, retbuf, 8*sizeof(unsigned long));
-
-	return rc;
-}
-
-static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
-		unsigned long avpn)
-{
-	return plpar_hcall_norets(H_PROTECT, flags, ptex, avpn);
-}
-
-static inline long plpar_tce_get(unsigned long liobn, unsigned long ioba,
-		unsigned long *tce_ret)
-{
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-
-	rc = plpar_hcall(H_GET_TCE, retbuf, liobn, ioba);
-
-	*tce_ret = retbuf[0];
-
-	return rc;
-}
-
-static inline long plpar_tce_put(unsigned long liobn, unsigned long ioba,
-		unsigned long tceval)
-{
-	return plpar_hcall_norets(H_PUT_TCE, liobn, ioba, tceval);
-}
-
-static inline long plpar_tce_put_indirect(unsigned long liobn,
-		unsigned long ioba, unsigned long page, unsigned long count)
-{
-	return plpar_hcall_norets(H_PUT_TCE_INDIRECT, liobn, ioba, page, count);
-}
-
-static inline long plpar_tce_stuff(unsigned long liobn, unsigned long ioba,
-		unsigned long tceval, unsigned long count)
-{
-	return plpar_hcall_norets(H_STUFF_TCE, liobn, ioba, tceval, count);
-}
-
-static inline long plpar_get_term_char(unsigned long termno,
-		unsigned long *len_ret, char *buf_ret)
-{
-	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
-	unsigned long *lbuf = (unsigned long *)buf_ret;	/* TODO: alignment? */
-
-	rc = plpar_hcall(H_GET_TERM_CHAR, retbuf, termno);
-
-	*len_ret = retbuf[0];
-	lbuf[0] = retbuf[1];
-	lbuf[1] = retbuf[2];
-
-	return rc;
-}
-
-static inline long plpar_put_term_char(unsigned long termno, unsigned long len,
-		const char *buffer)
-{
-	unsigned long *lbuf = (unsigned long *)buffer;	/* TODO: alignment? */
-	return plpar_hcall_norets(H_PUT_TERM_CHAR, termno, len, lbuf[0],
-			lbuf[1]);
-}
-
-/* Set various resource mode parameters */
-static inline long plpar_set_mode(unsigned long mflags, unsigned long resource,
-		unsigned long value1, unsigned long value2)
-{
-	return plpar_hcall_norets(H_SET_MODE, mflags, resource, value1, value2);
-}
-
-/*
- * Enable relocation on exceptions on this partition
- *
- * Note: this call has a partition wide scope and can take a while to complete.
- * If it returns H_LONG_BUSY_* it should be retried periodically until it
- * returns H_SUCCESS.
- */
-static inline long enable_reloc_on_exceptions(void)
-{
-	/* mflags = 3: Exceptions at 0xC000000000004000 */
-	return plpar_set_mode(3, 3, 0, 0);
-}
-
-/*
- * Disable relocation on exceptions on this partition
- *
- * Note: this call has a partition wide scope and can take a while to complete.
- * If it returns H_LONG_BUSY_* it should be retried periodically until it
- * returns H_SUCCESS.
- */
-static inline long disable_reloc_on_exceptions(void) {
-	return plpar_set_mode(0, 3, 0, 0);
-}
-
-static inline long plapr_set_ciabr(unsigned long ciabr)
-{
-	return plpar_set_mode(0, 1, ciabr, 0);
-}
-
-static inline long plapr_set_watchpoint0(unsigned long dawr0, unsigned long dawrx0)
-{
-	return plpar_set_mode(0, 2, dawr0, dawrx0);
-}
-
-#endif /* _PSERIES_PLPAR_WRAPPERS_H */
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index ca70279..c905b99 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -18,8 +18,7 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/runlatch.h>
-
-#include "plpar_wrappers.h"
+#include <asm/plpar_wrappers.h>
 
 struct cpuidle_driver pseries_idle_driver = {
 	.name             = "pseries_idle",
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index c11c823..4291589 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -66,8 +66,8 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 #include <asm/reg.h>
+#include <asm/plpar_wrappers.h>
 
-#include "plpar_wrappers.h"
 #include "pseries.h"
 
 int CMO_PrPSP = -1;
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 306643c..1c79af7 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -43,8 +43,8 @@
 #include <asm/cputhreads.h>
 #include <asm/xics.h>
 #include <asm/dbell.h>
+#include <asm/plpar_wrappers.h>
 
-#include "plpar_wrappers.h"
 #include "pseries.h"
 #include "offline_states.h"
 
