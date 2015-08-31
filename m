Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48E7B1A028B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:48:12 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 31 Aug 2015 12:18:09 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B680AE005B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 12:17:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7V6m6O919267794
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 12:18:06 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7V6m5Wk018383
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 12:18:06 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, scottwood@freescale.com, acme@kernel.org,
 mingo@kernel.org, mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v6 2/2] perf, kvm/powerpc: Add hcall related info to kvm_perf.h
Date: Mon, 31 Aug 2015 12:18:01 +0530
Message-Id: <1441003681-10259-2-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1441003681-10259-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1441003681-10259-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To analyze the hcalls with perf kvm stat, we need the hcall related
tracepoint information to be exported.

This patch adds hcall tracepoints "kvm_hv:kvm_hcall_enter" and
"kvm_hv:kvm_hcall_exit" to kvm_perf.h. So, perf will now know to look
for these tracepoints if "perf kvm stat record" is invoked to collect
guest hcall statistics.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/kvm_perf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
index 68f105e..2af6290 100644
--- a/arch/powerpc/include/uapi/asm/kvm_perf.h
+++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
@@ -12,6 +12,10 @@
 #define KVM_EXIT_TRACE_HV "kvm_hv:kvm_guest_exit"
 #define KVM_EXIT_REASON_HV "trap"
 
+#define KVM_HCALL_ENTRY_TRACE_HV "kvm_hv:kvm_hcall_enter"
+#define KVM_HCALL_EXIT_TRACE_HV "kvm_hv:kvm_hcall_exit"
+#define KVM_HCALL_REASON_HV "req"
+
 /* This is to shut the compiler up */
 #define KVM_ENTRY_TRACE ""
 #define KVM_EXIT_TRACE ""
-- 
1.9.3
