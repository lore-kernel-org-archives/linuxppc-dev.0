Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8DF2014009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 18:11:52 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Apr 2014 18:11:46 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A8D3A2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 18:11:43 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3U7oSKO8716706
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 17:50:29 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3U8BSWD017241
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 18:11:28 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] PPC: BOOK3S: Disable/Enable TM looking at the ibm,
 pa-features device tree entry
Date: Wed, 30 Apr 2014 13:41:20 +0530
Message-Id: <1398845480-9945-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
device tree entry. This provides a mechanism to disable TM on P8
systems.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 668aa4791fd7..537bd7e7db0b 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -161,6 +161,11 @@ static struct ibm_pa_feature {
 	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
 	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
 	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
+	/*
+	 * We should use CPU_FTR_TM_COMP so that if we disable TM, it won't get
+	 * enabled via device tree
+	 */
+	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, unsigned char *ftrs,
-- 
1.9.1
