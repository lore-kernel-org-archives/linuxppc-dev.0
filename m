Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcvKT6Bj9zDrJg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 03:18:52 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7NHInGE133733
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 13:18:50 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chafkv30k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 13:18:49 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Wed, 23 Aug 2017 13:18:47 -0400
To: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/pseries: Don't attempt to acquire drc during memory
 hot add for assigned lmbs
Date: Wed, 23 Aug 2017 12:18:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check if an LMB is assigned before attempting to call dlpar_acquire_drc in
order to avoid any unnecessary rtas calls. This substantially reduces the
running time of memory hot add on lpars with large amounts of memory.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
---
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index ca9b2f4..95cf2ff 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -817,6 +817,9 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
 		return -EINVAL;

 	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
+		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
+			continue;
+
 		rc = dlpar_acquire_drc(lmbs[i].drc_index);
 		if (rc)
 			continue;
