Return-Path: <prvs=0630bfdc66=aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40F3my1j67zF24G
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2018 17:31:07 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w327TOVQ118434
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Apr 2018 03:31:03 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h3ehrucma-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Apr 2018 03:31:03 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 2 Apr 2018 03:31:03 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc: Fix oops due to deferral of lpacca on non
 virtualized platform
Date: Mon,  2 Apr 2018 13:00:44 +0530
Message-Id: <20180402073044.12561-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 8e0b634b1327 ("powerpc/64s: Do not allocate lppaca if we are not
virtualized") removed allocation of lppaca on non virtualized platform. But with
CONFIG_PPC_SPLPAR enabled, we do access lppaca non-virtualized platform in some
code paths.

Fix this but adding runtime check for virtualized platform.

Fixes: 8e0b634b1327 ("powerpc/64s: Do not allocate lppaca if we are not virtualized")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/lppaca.h   | 3 +++
 arch/powerpc/include/asm/spinlock.h | 2 ++
 arch/powerpc/kernel/time.c          | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 65d589689f01..7c23ce8a5a4c 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -34,6 +34,7 @@
 #include <linux/threads.h>
 #include <asm/types.h>
 #include <asm/mmu.h>
+#include <asm/firmware.h>
 
 /*
  * The lppaca is the "virtual processor area" registered with the hypervisor,
@@ -114,6 +115,8 @@ struct lppaca {
 
 static inline bool lppaca_shared_proc(struct lppaca *l)
 {
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
+		return false;
 	return !!(l->__old_status & LPPACA_OLD_SHARED_PROC);
 }
 
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index b9ebc3085fb7..72dc4ddc2972 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -56,6 +56,8 @@
 #define vcpu_is_preempted vcpu_is_preempted
 static inline bool vcpu_is_preempted(int cpu)
 {
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
+		return false;
 	return !!(be32_to_cpu(lppaca_of(cpu).yield_count) & 1);
 }
 #endif
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index f7d96a68ecaa..360e71d455cc 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -266,6 +266,9 @@ void accumulate_stolen_time(void)
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
 {
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
+		return 0;
+
 	if (get_paca()->dtl_ridx != be64_to_cpu(get_lppaca()->dtl_idx))
 		return scan_dispatch_log(stop_tb);
 
-- 
2.14.3
