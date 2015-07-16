Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 807751A075F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:51:32 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 01:51:32 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E0B672CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:51:26 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GFpIBc45023380
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:51:26 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GForEB031694
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:50:54 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, mingo@kernel.org,
 mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org, scottwood@freescale.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v5 1/2] perf,kvm/ppc: Add kvm_perf.h for powerpc
Date: Thu, 16 Jul 2015 21:18:41 +0530
Message-Id: <1437061722-15438-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To analyze the exit events with perf, we need kvm_perf.h to be added in
the arch/powerpc directory, where the kvm tracepoints needed to trace
the KVM exit events are defined.

This patch adds "kvm_perf_book3s.h" to indicate that the tracepoints are
book3s specific. Generic "kvm_perf.h" then can just include
"kvm_perf_book3s.h".

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
Changes:
- Not exporting the exit reasons compared to previous patchset (suggested by Paul)

 arch/powerpc/include/uapi/asm/kvm_perf.h        |  6 ++++++
 arch/powerpc/include/uapi/asm/kvm_perf_book3s.h | 14 ++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf.h
 create mode 100644 arch/powerpc/include/uapi/asm/kvm_perf_book3s.h

diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
new file mode 100644
index 0000000..5ed2ff3
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_POWERPC_KVM_PERF_H
+#define _ASM_POWERPC_KVM_PERF_H
+
+#include <asm/kvm_perf_book3s.h>
+
+#endif
diff --git a/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
new file mode 100644
index 0000000..8c8d8c2
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
@@ -0,0 +1,14 @@
+#ifndef _ASM_POWERPC_KVM_PERF_BOOK3S_H
+#define _ASM_POWERPC_KVM_PERF_BOOK3S_H
+
+#include <asm/kvm.h>
+
+#define DECODE_STR_LEN 20
+
+#define VCPU_ID "vcpu_id"
+
+#define KVM_ENTRY_TRACE "kvm_hv:kvm_guest_enter"
+#define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
+#define KVM_EXIT_REASON "trap"
+
+#endif /* _ASM_POWERPC_KVM_PERF_BOOK3S_H */
-- 
1.9.3
