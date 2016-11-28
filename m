Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSCZk3NmVzDvY9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 03:59:26 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uASGxO9N004930
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 11:59:24 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 270nv9p4c1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 11:59:18 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 28 Nov 2016 09:59:17 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 71ACD3E40030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 09:59:14 -0700 (MST)
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uASGxE7x4456780
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 16:59:14 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7A2928041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 11:59:13 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id C726428048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 11:59:13 -0500 (EST)
Subject: [PATCH] powerpc/pserie: Use lmb_is_removable() to check removability
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 28 Nov 2016 11:50:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20161128165044.7375.36918.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should be using lmb_is_removable() to validate that enough LMBs
are available to remove when doing a remove by count. This will check
that the LMB is owned by the system and it is considered removable.
This patch also adds a pr_info() notification to report the LMB count
to remove was not satisfied.

What we do now is just check that there are enough LMBs owned by the
system when validating there are enough LMBs to remove. This can
lead to situations where there are enough LMBs owned by the system
but not enough that are considered removable. This results in having
to bail out of the remove operation instead of just failing the request
that we should have known wouldn't succeed.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 76ec104..2617f9f 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -472,12 +472,15 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove,
 
 	/* Validate that there are enough LMBs to satisfy the request */
 	for (i = 0; i < num_lmbs; i++) {
-		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
+		if (lmb_is_removable(&lmbs[i]))
 			lmbs_available++;
 	}
 
-	if (lmbs_available < lmbs_to_remove)
+	if (lmbs_available < lmbs_to_remove) {
+		pr_info("Not enough LMBs available (%d of %d) to satisfy request\n",
+			lmbs_available, lmbs_to_remove);
 		return -EINVAL;
+	}
 
 	for (i = 0; i < num_lmbs && lmbs_removed < lmbs_to_remove; i++) {
 		rc = dlpar_remove_lmb(&lmbs[i]);
