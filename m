Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3A281A1976
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:52:04 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 01:52:04 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E64BF3578048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:52:01 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GFprIR41681070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:52:01 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GFpTfl032250
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:51:29 +1000
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, mingo@kernel.org,
 mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org, scottwood@freescale.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: [PATCH v5 2/2] perf,kvm/ppc: Add hcall related info to kvm_perf.h
Date: Thu, 16 Jul 2015 21:18:42 +0530
Message-Id: <1437061722-15438-2-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1437061722-15438-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1437061722-15438-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To analyze the hcalls with perf, we need the hcall related tracepoints
information to be exported.

This patch adds hcall tracepoints "kvm_hv:kvm_hcall_enter" and
"kvm_hv:kvm_hcall_exit" to kvm_perf.h. So, perf will now know as to what
tracepoints to look for if we are using "perf kvm stat record" to
collect guest hcall statistics.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
Changes:
- Not exporting the hcall related codes and names through uapi compared to
  previous patch.

 arch/powerpc/include/uapi/asm/kvm_perf_book3s.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
index 8c8d8c2..1378a8d 100644
--- a/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
+++ b/arch/powerpc/include/uapi/asm/kvm_perf_book3s.h
@@ -11,4 +11,8 @@
 #define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
 #define KVM_EXIT_REASON "trap"
 
+#define KVM_HCALL_ENTRY_TRACE "kvm_hv:kvm_hcall_enter"
+#define KVM_HCALL_EXIT_TRACE "kvm_hv:kvm_hcall_exit"
+#define KVM_HCALL_REASON "req"
+
 #endif /* _ASM_POWERPC_KVM_PERF_BOOK3S_H */
-- 
1.9.3
