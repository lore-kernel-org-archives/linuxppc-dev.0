Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLYcP1lhdzDrdx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 07:11:01 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7QL3r81078863
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:59 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 251xkbh9et-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:59 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 26 Aug 2016 15:10:58 -0600
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 80BA13E40047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 15:10:56 -0600 (MDT)
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7QLApCg12255714
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 21:10:56 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 132F72803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:56 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id E6CBB28046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:10:55 -0400 (EDT)
Subject: [PATCH 2/3] powerpc/pseries: Remove no longer needed rtas_hp_event
 flag
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 26 Aug 2016 17:04:02 -0400
In-Reply-To: <20160826210312.44862.37838.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20160826210312.44862.37838.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20160826210402.44862.36027.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the use of the rtas_hp_event flag as it is no longer needed. the
managememnet of the static dynamic-memory property does not go through
of_update_property so we do not need to set this flag.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 5173e49..a0371d1 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -24,8 +24,6 @@
 #include <asm/sparsemem.h>
 #include "pseries.h"
 
-static bool rtas_hp_event;
-
 static struct drconf_mem {
 	u32 num_lmbs;
 	struct of_drconf_cell *lmbs;
@@ -929,9 +927,6 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
 	__be32 *p;
 	int i, rc = -EINVAL;
 
-	if (rtas_hp_event)
-		return 0;
-
 	update_drconf_memory();
 
 	memblock_size = pseries_memory_block_size();
