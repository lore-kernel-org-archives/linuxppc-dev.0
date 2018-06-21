Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B351405nzF132
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 10:49:57 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5L0nD6x058326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:49:55 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jqyxm37km-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:49:55 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 20 Jun 2018 18:49:54 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <71195eb3-e11c-f586-d359-7026bdfd9a8a@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v04 9/9] hotplug/pmt: Update topology after PMT
Date: Wed, 20 Jun 2018 19:49:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <8c437fe5-632c-a7ed-1f11-66c4578a1d93@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Sorry.  File error.  Previous copy was older version of file.]

hotplug/pmt: Call rebuild_sched_domains after applying changes
to update CPU associativity i.e. 'readd' CPUs.  This is to
ensure that the deferred calls to arch_update_cpu_topology are
now reflected in the system data structures.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 4b43fec..74b6287 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 
@@ -449,6 +450,9 @@ static int dlpar_pmt(struct pseries_hp_errorlog *work)
 		kfree(tmp);
 	}
 
+	ssleep(5);
+	rebuild_sched_domains();
+
 	return 0;
 }
 
