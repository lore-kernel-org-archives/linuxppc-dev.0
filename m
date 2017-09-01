Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkNtk49JtzDqkc
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 01:48:14 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v81FhtVr044337
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Sep 2017 11:48:12 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cqa8e94yf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Sep 2017 11:48:11 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 1 Sep 2017 09:48:11 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V13 2/4] powerpc/vphn: Improve recognition of PRRN/VPHN
In-Reply-To: <fc21bb6f-9df8-ab7d-5987-6bdce5d39842@linux.vnet.ibm.com>
Date: Fri, 1 Sep 2017 10:48:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <067ca4f6-3181-6c6d-32cf-7164fe2c715d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/vphn: On Power systems with shared configurations of CPUs
and memory, there are some issues with the association of additional
CPUs and memory to nodes when hot-adding resources.  This patch
updates the initialization checks to independently recognize PRRN
or VPHN support.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V13:
  -- Split patch to improve review
---
 arch/powerpc/mm/numa.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 312f6ee..c08d736 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1543,7 +1543,8 @@ int start_topology_update(void)
 			rc = of_reconfig_notifier_register(&dt_update_nb);
 #endif
 		}
-	} else if (firmware_has_feature(FW_FEATURE_VPHN) &&
+	}
+	if (firmware_has_feature(FW_FEATURE_VPHN) &&
 		   lppaca_shared_proc(get_lppaca())) {
 		if (!vphn_enabled) {
 			vphn_enabled = 1;
@@ -1568,7 +1569,8 @@ int stop_topology_update(void)
 #ifdef CONFIG_SMP
 		rc = of_reconfig_notifier_unregister(&dt_update_nb);
 #endif
-	} else if (vphn_enabled) {
+	}
+	if (vphn_enabled) {
 		vphn_enabled = 0;
 		rc = del_timer_sync(&topology_timer);
 	}
