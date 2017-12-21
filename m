Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2bYv5VZNzDwbP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 02:45:07 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBLFiDbD050750
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 10:45:05 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f0e5hw1xd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 10:45:05 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Thu, 21 Dec 2017 08:45:04 -0700
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, david@gibson.dropbear.id.au, benh@au1.ibm.com
Subject: [PATCH 1/1] powerpc/pseries: Use the system workqueue as fallback to
 hotplug workqueue
Date: Thu, 21 Dec 2017 13:44:48 -0200
In-Reply-To: <20171221154448.22965-1-joserz@linux.vnet.ibm.com>
References: <20171221154448.22965-1-joserz@linux.vnet.ibm.com>
Message-Id: <20171221154448.22965-2-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hotplug engine uses its own workqueue to handle IRQ requests, the
problem is that such workqueue is initialized not so early in the boot
process.

Thus, when the kernel is ready to handle IRQ requests, after the system
workqueue is initialized, we have a timeframe where any hotplug issued
by the client will result in a kernel panic. That timeframe goes until
the hotplug workqueue is initialized.

It would be good to have the hotplug workqueue initialized as soon as
the system workqueue but I don't think it is possible. So, this patch
uses the system workqueue as a fallback the handle such IRQs.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 6e35780c5962..0474aa14b5f6 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -399,7 +399,15 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 		work->errlog = hp_errlog_copy;
 		work->hp_completion = hotplug_done;
 		work->rc = rc;
-		queue_work(pseries_hp_wq, (struct work_struct *)work);
+
+		/* The hotplug workqueue may happen to be NULL at the moment
+		 * this code is executed, during the boot phase. So, in this
+		 * scenario, we can fallback to the system workqueue.
+		 */
+		if (unlikely(pseries_hp_wq == NULL))
+			schedule_work((struct work_struct *)work);
+		else
+			queue_work(pseries_hp_wq, (struct work_struct *)work);
 	} else {
 		*rc = -ENOMEM;
 		kfree(hp_errlog_copy);
-- 
2.14.1
