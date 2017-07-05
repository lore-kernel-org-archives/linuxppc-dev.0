Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 skiboot@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/powernv: handle the platform error reboot in
 ppc_md.restart
Date: Wed,  5 Jul 2017 14:04:19 +1000
Message-Id: <20170705040422.20933-2-npiggin@gmail.com>
In-Reply-To: <20170705040422.20933-1-npiggin@gmail.com>
References: <20170705040422.20933-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unrecovered MCE and HMI errors are sent through a special restart
OPAL call to log the platform error. The downside is that they don't
go through normal crash paths, so they don't give much information
to the Linux console.

Change this by allowing them to set an error which then causes the
normal restart handler to use the platform error call. Have MCE and HMI
handlers set this and then use the normal panic path for unrecoverable
cases.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal.h           |  2 +-
 arch/powerpc/platforms/powernv/opal-hmi.c | 20 +++-------------
 arch/powerpc/platforms/powernv/opal.c     | 39 ++-----------------------------
 arch/powerpc/platforms/powernv/powernv.h  |  2 ++
 arch/powerpc/platforms/powernv/setup.c    | 31 ++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 588fb1c23af9..182dab435aad 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -50,7 +50,7 @@ int64_t opal_tpo_write(uint64_t token, uint32_t year_mon_day,
 		       uint32_t hour_min);
 int64_t opal_cec_power_down(uint64_t request);
 int64_t opal_cec_reboot(void);
-int64_t opal_cec_reboot2(uint32_t reboot_type, char *diag);
+int64_t opal_cec_reboot2(uint32_t reboot_type, const char *diag);
 int64_t opal_read_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_write_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_handle_interrupt(uint64_t isn, __be64 *outstanding_event_mask);
diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index 88f3c61eec95..dbb0e91058e9 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -30,6 +30,8 @@
 #include <asm/cputable.h>
 #include <asm/machdep.h>
 
+#include "powernv.h"
+
 static int opal_hmi_handler_nb_init;
 struct OpalHmiEvtNode {
 	struct list_head list;
@@ -267,8 +269,6 @@ static void hmi_event_handler(struct work_struct *work)
 	spin_unlock_irqrestore(&opal_hmi_evt_lock, flags);
 
 	if (unrecoverable) {
-		int ret;
-
 		/* Pull all HMI events from OPAL before we panic. */
 		while (opal_get_msg(__pa(&msg), sizeof(msg)) == OPAL_SUCCESS) {
 			u32 type;
@@ -284,22 +284,8 @@ static void hmi_event_handler(struct work_struct *work)
 			print_hmi_event_info(hmi_evt);
 		}
 
-		/*
-		 * Unrecoverable HMI exception. We need to inform BMC/OCC
-		 * about this error so that it can collect relevant data
-		 * for error analysis before rebooting.
-		 */
-		ret = opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR,
-			"Unrecoverable HMI exception");
-		if (ret == OPAL_UNSUPPORTED) {
-			pr_emerg("Reboot type %d not supported\n",
-						OPAL_REBOOT_PLATFORM_ERROR);
-		}
+		pnv_platform_error = "Unrecoverable HMI exception";
 
-		/*
-		 * Fall through and panic if opal_cec_reboot2() returns
-		 * OPAL_UNSUPPORTED.
-		 */
 		panic("Unrecoverable HMI exception");
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 59684b4af4d1..4b2505d98eb8 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -424,7 +424,6 @@ static int opal_recover_mce(struct pt_regs *regs,
 int opal_machine_check(struct pt_regs *regs)
 {
 	struct machine_check_event evt;
-	int ret;
 
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
 		return 0;
@@ -440,43 +439,9 @@ int opal_machine_check(struct pt_regs *regs)
 	if (opal_recover_mce(regs, &evt))
 		return 1;
 
-	/*
-	 * Unrecovered machine check, we are heading to panic path.
-	 *
-	 * We may have hit this MCE in very early stage of kernel
-	 * initialization even before opal-prd has started running. If
-	 * this is the case then this MCE error may go un-noticed or
-	 * un-analyzed if we go down panic path. We need to inform
-	 * BMC/OCC about this error so that they can collect relevant
-	 * data for error analysis before rebooting.
-	 * Use opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR) to do so.
-	 * This function may not return on BMC based system.
-	 */
-	ret = opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR,
-			"Unrecoverable Machine Check exception");
-	if (ret == OPAL_UNSUPPORTED) {
-		pr_emerg("Reboot type %d not supported\n",
-					OPAL_REBOOT_PLATFORM_ERROR);
-	}
+	pnv_platform_error = "Unrecoverable Machine Check exception";
 
-	/*
-	 * We reached here. There can be three possibilities:
-	 * 1. We are running on a firmware level that do not support
-	 *    opal_cec_reboot2()
-	 * 2. We are running on a firmware level that do not support
-	 *    OPAL_REBOOT_PLATFORM_ERROR reboot type.
-	 * 3. We are running on FSP based system that does not need opal
-	 *    to trigger checkstop explicitly for error analysis. The FSP
-	 *    PRD component would have already got notified about this
-	 *    error through other channels.
-	 *
-	 * If hardware marked this as an unrecoverable MCE, we are
-	 * going to panic anyway. Even if it didn't, it's not safe to
-	 * continue at this point, so we should explicitly panic.
-	 */
-
-	panic("PowerNV Unrecovered Machine Check");
-	return 0;
+	panic("Unrecoverable Machine Check exception");
 }
 
 /* Early hmi handler called in real mode. */
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 6dbc0a1da1f6..998f19828b85 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -7,6 +7,8 @@ extern void pnv_smp_init(void);
 static inline void pnv_smp_init(void) { }
 #endif
 
+extern const char *pnv_platform_error;
+
 struct pci_dev;
 
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 2dc7e5fb86c3..c4571788f1c9 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -125,10 +125,41 @@ static void pnv_prepare_going_down(void)
 	opal_flash_term_callback();
 }
 
+/*
+ * This can be set to have ppc_md.restart to request a
+ * OPAL_REBOOT_PLATFORM_ERROR reboot, which logs the error reason.
+ */
+const char *pnv_platform_error = NULL;
+
 static void  __noreturn pnv_restart(char *cmd)
 {
 	long rc = OPAL_BUSY;
 
+	if (pnv_platform_error) {
+		/*
+		 * Don't bother to shut things down because this will
+		 * xstop the system.
+		 */
+		rc = opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR,
+					pnv_platform_error);
+		if (rc == OPAL_UNSUPPORTED) {
+			pr_emerg("Reboot type %d not supported\n",
+					OPAL_REBOOT_PLATFORM_ERROR);
+			rc = OPAL_BUSY;
+		}
+		/*
+		 * We reached here. There can be three possibilities:
+		 * 1. We are running on a firmware level that do not support
+		 *    opal_cec_reboot2()
+		 * 2. We are running on a firmware level that do not support
+		 *    OPAL_REBOOT_PLATFORM_ERROR reboot type.
+		 * 3. We are running on FSP based system that does not need
+		 *    opal to trigger checkstop explicitly for error analysis.
+		 *    The FSP PRD component would have already got notified
+		 *    about this error through other channels.
+		 */
+	}
+
 	pnv_prepare_going_down();
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-- 
2.11.0
