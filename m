Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405ntP25TXzF1h9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 22:40:44 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LBdF2c095853
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 07:40:42 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gun4kvjx9-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 07:40:42 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 11:40:40 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/perf: Fix the kernel address leak to userspace via
 SDAR
Date: Wed, 21 Mar 2018 17:10:26 +0530
In-Reply-To: <1521632426-30770-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1521632426-30770-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1521632426-30770-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sampled Data Address Register (SDAR) is a 64-bit
register that contains the effective address of
the storage operand of an instruction that was
being executed, possibly out-of-order, at or around
the time that the Performance Monitor alert occurred.

In certain scenario SDAR happen to contain the kernel
address even for userspace only sampling. Add checks
to prevent it.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
- Removed the event exclusive_ check. Will take it up in a separate patch

 arch/powerpc/perf/core-book3s.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index f89bbd54ecec..e143f85a4098 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -95,7 +95,7 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
 {
 	return 0;
 }
-static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp) { }
+static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp, struct perf_event *event) { }
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	return 0;
@@ -174,7 +174,7 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
  * pointed to by SIAR; this is indicated by the [POWER6_]MMCRA_SDSYNC, the
  * [POWER7P_]MMCRA_SDAR_VALID bit in MMCRA, or the SDAR_VALID bit in SIER.
  */
-static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
+static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp, struct perf_event *event)
 {
 	unsigned long mmcra = regs->dsisr;
 	bool sdar_valid;
@@ -198,6 +198,10 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
 
 	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || sdar_valid)
 		*addrp = mfspr(SPRN_SDAR);
+
+	if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
+		is_kernel_addr(mfspr(SPRN_SDAR)))
+		*addrp = 0;
 }
 
 static bool regs_sihv(struct pt_regs *regs)
@@ -2050,7 +2054,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		if (event->attr.sample_type &
 		    (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
-			perf_get_data_addr(regs, &data.addr);
+			perf_get_data_addr(regs, &data.addr, event);
 
 		if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
 			struct cpu_hw_events *cpuhw;
-- 
2.7.4
