Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v69YK0TSYzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 10:25:56 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0MNIhu5042381
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jan 2017 18:25:54 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28558n9jph-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jan 2017 18:25:53 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 23 Jan 2017 09:25:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A5FC62BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 10:25:49 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0MNPnmj7733716
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 10:25:49 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0MNPnt1010196
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 10:25:49 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/kernel: Use of_property_read_u32() in
 rtas_initialize()
Date: Mon, 23 Jan 2017 10:25:45 +1100
In-Reply-To: <1485127546-18859-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1485127546-18859-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1485127546-18859-3-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This uses of_property_read_u32() in rtas_initialize() so that we
needn't explicitly care the CPU's endian.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 9ba0f67..d13b92d 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1145,7 +1145,8 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
 void __init rtas_initialize(void)
 {
 	unsigned long rtas_region = RTAS_INSTANTIATE_MAX;
-	const __be32 *basep, *entryp, *sizep;
+	u32 base, size, entry;
+	int no_base, no_size, no_entry;
 
 	/* Get RTAS dev node and fill up our "rtas" structure with infos
 	 * about it.
@@ -1154,20 +1155,17 @@ void __init rtas_initialize(void)
 	if (!rtas.dev)
 		return;
 
-	basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
-	sizep = of_get_property(rtas.dev, "rtas-size", NULL);
-	if (basep == NULL && sizep == NULL) {
+	no_base = of_property_read_u32(rtas.dev, "linux,rtas-base", &base);
+	no_size = of_property_read_u32(rtas.dev, "rtas-size", &size);
+	if (no_base && no_size) {
 		rtas.dev = NULL;
 		return;
 	}
 
-	rtas.base = __be32_to_cpu(*basep);
-	rtas.size = __be32_to_cpu(*sizep);
-	entryp = of_get_property(rtas.dev, "linux,rtas-entry", NULL);
-	if (entryp == NULL) /* Ugh */
-		rtas.entry = rtas.base;
-	else
-		rtas.entry = __be32_to_cpu(*entryp);
+	rtas.base = base;
+	rtas.size = size;
+	no_entry = of_property_read_u32(rtas.dev, "linux,rtas-entry", &entry);
+	rtas.entry = no_entry ? rtas.base : entry;
 
 	/* If RTAS was found, allocate the RMO buffer for it and look for
 	 * the stop-self token if any
-- 
2.7.4
