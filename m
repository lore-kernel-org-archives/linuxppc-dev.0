Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HW0x3X3HzF1qt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 08:05:21 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5TM5Irq134025
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:05:19 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jwtatx3c4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 18:05:19 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 29 Jun 2018 18:05:00 -0400
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v05 8/9] hotplug/rtas: No rtas_event_scan during PMT update
In-Reply-To: <e73c6076-34d9-d3fb-d1f0-ccef14dae093@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2018 17:04:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <34dc375f-8edf-b049-7dab-23397081c415@linux.vnet.ibm.com>
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
index 6267b53..f5c9e8f 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -686,14 +686,18 @@ static int dlpar_cpu_readd_by_index(u32 drc_index)
 
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
