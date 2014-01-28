Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D9EDF2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 03:44:42 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 22:14:41 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B36B8E0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:17:43 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SGiXM334799662
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:34 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SGibqp020540
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:37 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 10/10] PPC: BOOK3S: Disable/Enable TM looking at the ibm,
 pa-features device tree entry
Date: Tue, 28 Jan 2014 22:14:15 +0530
Message-Id: <1390927455-3312-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
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
 arch/powerpc/kernel/prom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fa0ad8aafbcc..de8c2caf1024 100644
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
 
 static void __init scan_features(unsigned long node, unsigned char *ftrs,
-- 
1.8.5.3
