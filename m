Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41PT4c0GVQzDr2p
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 00:59:11 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w69ErluI058882
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2018 10:59:09 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k48tgvktq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jul 2018 10:59:09 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 9 Jul 2018 08:59:08 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v06 9/9] hotplug/pmt: Update topology after PMT
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <4e6b3582-0033-b232-3769-226ba6f68eac@linux.vnet.ibm.com>
Date: Mon, 9 Jul 2018 09:59:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <d5b2e902-e34d-3eaf-2364-f6902d175f46@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hotplug/pmt: Call rebuild_sched_domains after applying changes
to update CPU associativity i.e. 'readd' CPUs.  This is to
ensure that the deferred calls to arch_update_cpu_topology are
now reflected in the system data structures.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 7264b8e..ea3c08a 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 
@@ -451,6 +452,9 @@ static int dlpar_pmt(struct pseries_hp_errorlog *work)
 		ssleep(10);
 	}
 
+	ssleep(5);
+	rebuild_sched_domains();
+
 	return 0;
 }
 
