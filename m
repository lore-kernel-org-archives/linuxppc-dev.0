Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CB6A1A0079
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 01:33:03 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 00:33:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D25202CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 01:32:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA2EWmtY32440424
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 01:32:49 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA2EWwO5017302
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 01:32:59 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V2] powerpc/TM: Disable/Enable TM looking at the ibm,
 pa-features device tree entry
Date: Sun,  2 Nov 2014 20:02:42 +0530
Message-Id: <1414938762-20126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Runtime disable transactional memory feature looking at pa-features
device tree entry. We need to do this so that we can run a kernel
built with TM config in PR mode. For PR guest we provide a device
tree entry with TM feature disabled in pa-features

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V1:
* rebase to latest linus

 arch/powerpc/kernel/prom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 099f27e6d1b0..3e22930f15d1 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -160,6 +160,11 @@ static struct ibm_pa_feature {
 	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
 	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
 	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
+	/*
+	 * We should use CPU_FTR_TM_COMP so that if we disable TM, it won't get
+	 * enabled via device tree
+	 */
+	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
-- 
2.1.0
