Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VVy224jdzF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 05:40:57 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6HJd2kU062544
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 15:40:55 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k9p209h0w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 15:40:55 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Tue, 17 Jul 2018 15:40:55 -0400
From: John Allen <jallen@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
Cc: John Allen <jallen@linux.ibm.com>
Subject: [PATCH v2 2/2] powerpc/pseries: Wait for completion of hotplug events
 during PRRN handling
Date: Tue, 17 Jul 2018 14:40:48 -0500
In-Reply-To: <20180717194048.3057-1-jallen@linux.ibm.com>
References: <20180717194048.3057-1-jallen@linux.ibm.com>
Message-Id: <20180717194048.3057-3-jallen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While handling PRRN events, the time to handle the actual hotplug events
dwarfs the time it takes to perform the device tree updates and queue the
hotplug events. In the case that PRRN events are being queued continuously,
hotplug events have been observed to be queued faster than the kernel can
actually handle them. This patch avoids the problem by waiting for a
hotplug request to complete before queueing more hotplug events.

Signed-off-by: John Allen <jallen@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 8a8033a249c7..49930848fa78 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -242,6 +242,7 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
 static void prrn_update_node(__be32 phandle)
 {
 	struct pseries_hp_errorlog *hp_elog;
+	struct completion hotplug_done;
 	struct device_node *dn;
 
 	/*
@@ -263,7 +264,9 @@ static void prrn_update_node(__be32 phandle)
 	hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
 	hp_elog->_drc_u.drc_index = phandle;
 
-	queue_hotplug_event(hp_elog, NULL, NULL);
+	init_completion(&hotplug_done);
+	queue_hotplug_event(hp_elog, &hotplug_done, NULL);
+	wait_for_completion(&hotplug_done);
 
 	kfree(hp_elog);
 }
-- 
2.17.1
