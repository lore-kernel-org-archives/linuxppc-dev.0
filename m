Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE1AE1A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 01:54:46 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3E97414031A
 for <linuxppc-dev@ozlabs.org>; Sat,  1 Aug 2015 01:54:46 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 31 Jul 2015 21:24:44 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8BA18E0058
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2015 21:28:52 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6VFsfsG40501472
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2015 21:24:42 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6VFseYT011210
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2015 21:24:41 +0530
Subject: [PATCH] powernv: Invoke opal_cec_reboot2() on unrecoverable machine
 check errors.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>
Date: Fri, 31 Jul 2015 21:24:38 +0530
Message-ID: <20150731155312.30819.80637.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

On non-recoverable MCE errors in kernel space, Linux kernel panics
and system reboots. On BMC based system opal-prd runs as a daemon
in the host. Hence, kernel crash may prevent opal-prd to detect and
analyze this MCE error. This may land us in a situation where the faulty
memory never gets de-configured and Linux would keep hitting same MCE error
again and again. If this happens in early stage of kernel initialization,
then Linux will keep crashing and rebooting in a loop.

This patch fixes this issue by invoking new opal_cec_reboot2() call with
reboot type OPAL_REBOOT_PLATFORM_ERROR to inform BMC/OCC about this
error, so that BMC can collect relevant data for error analysis and
decide what component to de-configure before rebooting.

This patch is dependent on OPAL patchset posted on skiboot mailing list
at https://lists.ozlabs.org/pipermail/skiboot/2015-July/001771.html that
introduces opal_cec_reboot2() opal call.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |    9 +++++-
 arch/powerpc/include/asm/opal.h                |    1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 +
 arch/powerpc/platforms/powernv/opal.c          |   35 ++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 513d60e..4b620d99 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -154,7 +154,8 @@
 #define OPAL_FLASH_WRITE			111
 #define OPAL_FLASH_ERASE			112
 #define OPAL_PRD_MSG				113
-#define OPAL_LAST				113
+#define OPAL_CEC_REBOOT2			116
+#define OPAL_LAST				116
 
 /* Device tree flags */
 
@@ -817,6 +818,12 @@ struct opal_i2c_request {
 	__be64 buffer_ra;		/* Buffer real address */
 };
 
+/* Argument to OPAL_CEC_REBOOT2() */
+enum {
+	OPAL_REBOOT_NORMAL		= 0,
+	OPAL_REBOOT_PLATFORM_ERROR	= 1,
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 958e941..fb8e4d7 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -44,6 +44,7 @@ int64_t opal_tpo_write(uint64_t token, uint32_t year_mon_day,
 		       uint32_t hour_min);
 int64_t opal_cec_power_down(uint64_t request);
 int64_t opal_cec_reboot(void);
+int64_t opal_cec_reboot2(uint32_t reboot_type, char *diag);
 int64_t opal_read_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_write_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_handle_interrupt(uint64_t isn, __be64 *outstanding_event_mask);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index c56913d..4d5e967 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -200,6 +200,7 @@ OPAL_CALL(opal_rtc_read,			OPAL_RTC_READ);
 OPAL_CALL(opal_rtc_write,			OPAL_RTC_WRITE);
 OPAL_CALL(opal_cec_power_down,			OPAL_CEC_POWER_DOWN);
 OPAL_CALL(opal_cec_reboot,			OPAL_CEC_REBOOT);
+OPAL_CALL(opal_cec_reboot2,			OPAL_CEC_REBOOT2);
 OPAL_CALL(opal_read_nvram,			OPAL_READ_NVRAM);
 OPAL_CALL(opal_write_nvram,			OPAL_WRITE_NVRAM);
 OPAL_CALL(opal_handle_interrupt,		OPAL_HANDLE_INTERRUPT);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f084afa..a2b53f2 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -441,6 +441,7 @@ static int opal_recover_mce(struct pt_regs *regs,
 int opal_machine_check(struct pt_regs *regs)
 {
 	struct machine_check_event evt;
+	int ret;
 
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
 		return 0;
@@ -455,6 +456,40 @@ int opal_machine_check(struct pt_regs *regs)
 
 	if (opal_recover_mce(regs, &evt))
 		return 1;
+
+	/*
+	 * Unrecovered machine check, we are heading to panic path.
+	 *
+	 * We may have hit this MCE in very early stage of kernel
+	 * initialization even before opal-prd has started running. If
+	 * this is the case then this MCE error may go un-noticed or
+	 * un-analyzed if we go down panic path. We need to inform
+	 * BMC/OCC about this error so that they can collect relevant
+	 * data for error analysis before rebooting.
+	 * Use opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR) to do so.
+	 * This function may not return on BMC based system.
+	 */
+	ret = opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR,
+			"Unrecoverable Machine Check exception");
+	if (ret == OPAL_UNSUPPORTED) {
+		pr_emerg("Reboot type %d not supported\n",
+					OPAL_REBOOT_PLATFORM_ERROR);
+	}
+
+	/*
+	 * We reached here. There can be three possibilities:
+	 * 1. We are running on a firmware level that do not support
+	 *    opal_cec_reboot2()
+	 * 2. We are running on a firmware level that do not support
+	 *    OPAL_REBOOT_PLATFORM_ERROR reboot type.
+	 * 3. We are running on FSP based system that does not need opal
+	 *    to trigger checkstop explicitly for error analysis. The FSP
+	 *    PRD component would have already got notified about this
+	 *    error through other channels.
+	 *
+	 * In any case, let us just fall through. We anyway heading
+	 * down to panic path.
+	 */
 	return 0;
 }
 
