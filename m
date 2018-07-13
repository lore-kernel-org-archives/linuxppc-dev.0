Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41S3z81SQMzF35k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 06:18:28 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6DKFlf3110237
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 16:18:25 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k6yvf7bfj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 16:18:25 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 13 Jul 2018 16:18:24 -0400
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v07 8/9] hotplug/rtas: No rtas_event_scan during PMT update
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <458ff569-f611-f506-afa1-138146551dde@linux.vnet.ibm.com>
Date: Fri, 13 Jul 2018 15:18:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <78aef3e8-f659-a783-8db2-7b5172971205@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hotplug/rtas: Disable rtas_event_scan during device-tree property
updates after migration to reduce conflicts with changes propagated
to other parts of the kernel configuration, such as CPUs or memory.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index df1791b..09633de 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -685,14 +685,18 @@ static int dlpar_cpu_readd_by_index(u32 drc_index)
 
 	pr_info("Attempting to re-add CPU, drc index %x\n", drc_index);
 
+	rtas_event_scan_disable();
 	arch_update_cpu_topology_suspend();
 	rc = dlpar_cpu_remove_by_index(drc_index, false);
 	arch_update_cpu_topology_resume();
+	rtas_event_scan_enable();
 
 	if (!rc) {
+		rtas_event_scan_disable();
 		arch_update_cpu_topology_suspend();
 		rc = dlpar_cpu_add(drc_index, false);
 		arch_update_cpu_topology_resume();
+		rtas_event_scan_enable();
 	}
 
 	if (rc)
