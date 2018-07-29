Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41djwY3qvrzF13G
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 23:19:41 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6TDIlHp051834
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:19:39 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kh60bugn2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:19:38 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 29 Jul 2018 07:19:38 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v08 5/5] hotplug/pmt: Update topology after PMT
In-Reply-To: <9573dc30-01ad-2650-c247-28df08875cef@linux.vnet.ibm.com>
Date: Sun, 29 Jul 2018 08:19:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <99ac2a52-ac84-0e5b-bedc-ce029c1684cf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hotplug/pmt: Invoke rebuild_sched_domains before applying any CPU
'readd' modifications.  The call leads to arch_update_cpu_topology()
which will recognize and report any changes to the CPU topology
are now applied, and that the relevant system data structures are
updated.  It may also initialize nodes that were unused in the
topology of the source migration system.  This will avoid some
locking synchronization issues that were observed during development
of this patch set.  Also, the addition of the explicit call ensures
that such changes are made even when the automatic topology update
worker, triggered by a timer, has been disabled.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in patch:
  -- Add information to description.
  -- Remove long ssleep calls
  -- Rearrange code to perform rebuild before any other PMT mods
---
 arch/powerpc/platforms/pseries/dlpar.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 13ac1cc..2de0f0d 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 
@@ -437,6 +438,17 @@ static int dlpar_pmt(struct pseries_hp_errorlog *work)
 {
 	struct list_head *pos, *q;
 
+	/* Rebuild the domains and init any memoryless nodes
+	 * first to avoid later sync issues with CPU readd.
+	 */
+	rebuild_sched_domains();
+	msleep(100);
+		/* Ensure that the worker for rebuild_sched_domains
+		 * has the opportunity to actually begin work as we
+		 * don't want it delayed by the CPU readd hotplug
+		 * locking.
+		 */
+
 	list_for_each_safe(pos, q, &dlpar_delayed_list) {
 		struct pseries_hp_errorlog *tmp;
 
