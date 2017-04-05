Return-Path: <srs0=rqy9=3n=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyyb663flzDqJ9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 06:47:46 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vyyb65J29z8sXJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 06:47:46 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vyyb61zdwz9s9Y
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2017 06:47:46 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v35KhntB082869
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Apr 2017 16:47:29 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29n47927u0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 05 Apr 2017 16:47:29 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 02:17:25 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v35Kk4q013369510
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 02:16:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v35KlMBu009951
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 02:17:23 +0530
Subject: [PATCH v7 2/3] powerpc/powernv: Introduce a machine check hook for
 Guest MCEs.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: gleb@kernel.org, agraf@suse.de, KVM-PPC <kvm-ppc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com
Cc: KVM <kvm@vger.kernel.org>, david@gibson.dropbear.id.au
Date: Thu, 06 Apr 2017 02:17:22 +0530
In-Reply-To: <149142508580.28284.10052904644951828717.stgit@jupiter.in.ibm.com>
References: <149142508580.28284.10052904644951828717.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149142524189.28284.14876788789820474952.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch introduces a mce hook which is invoked at the time of guest
exit to facilitate the host-side handling of machine check exception
before the exception is passed on to the guest. This hook will be invoked
from host virtual mode from KVM (before exiting the guest with
KVM_EXIT_NMI reason) for machine check exception that occurs in the guest.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h     |    7 +++++++
 arch/powerpc/include/asm/opal.h        |    4 ++++
 arch/powerpc/platforms/powernv/opal.c  |   26 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c |    3 +++
 4 files changed, 40 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 5011b69..9d74e7a 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -15,6 +15,7 @@
 #include <linux/export.h>
 
 #include <asm/setup.h>
+#include <asm/mce.h>
 
 /* We export this macro for external modules like Alsa to know if
  * ppc_md.feature_call is implemented or not
@@ -112,6 +113,12 @@ struct machdep_calls {
 	/* Called during machine check exception to retrive fixup address. */
 	bool		(*mce_check_early_recovery)(struct pt_regs *regs);
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	/* Called after KVM interrupt handler finishes handling MCE for guest */
+	int		(*machine_check_exception_guest)
+					(struct machine_check_event *evt);
+#endif
+
 	/* Motherboard/chipset features. This is a kind of general purpose
 	 * hook used to control some machine specific features (like reset
 	 * lines, chip power control, etc...).
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 1ff03a6..9b1fcbf 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -17,6 +17,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/notifier.h>
+#include <asm/mce.h>
 
 /* We calculate number of sg entries based on PAGE_SIZE */
 #define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
@@ -273,6 +274,9 @@ extern int opal_hmi_handler_init(void);
 extern int opal_event_init(void);
 
 extern int opal_machine_check(struct pt_regs *regs);
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+extern int opal_machine_check_guest(struct machine_check_event *evt);
+#endif
 extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
 extern int opal_hmi_exception_early(struct pt_regs *regs);
 extern int opal_handle_hmi_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index e0f856b..5e633a4 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -479,6 +479,32 @@ int opal_machine_check(struct pt_regs *regs)
 	return 0;
 }
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+/*
+ * opal_machine_check_guest() is a hook which is invoked at the time
+ * of guest exit to facilitate the host-side handling of machine check
+ * exception before the exception is passed on to the guest. This hook
+ * is invoked from host virtual mode from KVM (before exiting the guest
+ * with KVM_EXIT_NMI reason) for machine check exception that occurs in
+ * the guest.
+ *
+ * Currently no action is performed in the host other than printing the
+ * event information. The machine check exception is passed on to the
+ * guest kernel and the guest kernel will attempt for recovery.
+ */
+int opal_machine_check_guest(struct machine_check_event *evt)
+{
+	/* Print things out */
+	if (evt->version != MCE_V1) {
+		pr_err("Machine Check Exception, Unknown event version %d !\n",
+		       evt->version);
+		return 0;
+	}
+	machine_check_print_event_info(evt);
+	return 0;
+}
+#endif
+
 /* Early hmi handler called in real mode. */
 int opal_hmi_exception_early(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d50c7d9..333ee09 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -264,6 +264,9 @@ static void __init pnv_setup_machdep_opal(void)
 	ppc_md.mce_check_early_recovery = opal_mce_check_early_recovery;
 	ppc_md.hmi_exception_early = opal_hmi_exception_early;
 	ppc_md.handle_hmi_exception = opal_handle_hmi_exception;
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	ppc_md.machine_check_exception_guest = opal_machine_check_guest;
+#endif
 }
 
 static int __init pnv_probe(void)
