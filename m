Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84A171A028B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:48:13 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 31 Aug 2015 12:18:11 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C7802E0058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 12:17:26 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7V6m4s837486680
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 12:18:04 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7V6m3nM018282
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 12:18:04 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, scottwood@freescale.com, acme@kernel.org,
 mingo@kernel.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v6 1/2] perf,kvm/powerpc: Add kvm_perf.h for powerpc
Date: Mon, 31 Aug 2015 12:18:00 +0530
Message-Id: <1441003681-10259-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To analyze the exit events with perf, we need to export the related
tracepoints through kvm_perf.h. kvm_perf.h is to be added in the
arch/powerpc directory, where the kvm tracepoints needed to trace the
KVM exit events are defined.

To indicate that the tracepoints are book3s_hv specific, suffix _HV has
been added to the tracepoint macros. Additionally, we also need to
define the generic macros (albeit, with null strings) suffix, because
the preprocessor looks for them in the generic code in builtin-kvm.c.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
Changes since v5:
- Moved back the tracepoint definitions from kvm_perf_book3s.h to kvm_perf.h

 arch/powerpc/include/uapi/asm/kvm_perf.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h

diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
new file mode 100644
index 0000000..68f105e
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
@@ -0,0 +1,21 @@
+#ifndef _ASM_POWERPC_KVM_PERF_H
+#define _ASM_POWERPC_KVM_PERF_H
+
+#include <asm/kvm.h>
+
+#define DECODE_STR_LEN 40
+
+#define VCPU_ID "vcpu_id"
+
+/* For Book3S_HV machines */
+#define KVM_ENTRY_TRACE_HV "kvm_hv:kvm_guest_enter"
+#define KVM_EXIT_TRACE_HV "kvm_hv:kvm_guest_exit"
+#define KVM_EXIT_REASON_HV "trap"
+
+/* This is to shut the compiler up */
+#define KVM_ENTRY_TRACE ""
+#define KVM_EXIT_TRACE ""
+#define KVM_EXIT_REASON ""
+
+
+#endif /* _ASM_POWERPC_KVM_PERF_H */
-- 
1.9.3
