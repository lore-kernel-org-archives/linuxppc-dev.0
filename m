Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNCPg13tDzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 11:38:30 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v731Xlxr067699
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 21:38:28 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c3km29g32-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 21:38:28 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 19:38:27 -0600
Date: Wed, 2 Aug 2017 18:38:22 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: xive: ensure active irqd when setting affinity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20170803013822.GD28905@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From fd0abf5c61b6041fdb75296e8580b86dc91d08d6 Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 1 Aug 2017 20:54:41 -0500
Subject: [PATCH] powerpc: xive: ensure active irqd when setting affinity

Ensure irqd is active before attempting to set affinity. This should
make the set affinity code more robust. For instance, this prevents
these messages seen on a 4.12 based kernel when taking cpus offline:

   [  123.053037264,3] XIVE[ IC 00  ] ISN 2 lead to invalid IVE !
   [   77.885859] xive: Error -6 reconfiguring irq 17
   [   77.885862] IRQ17: set affinity failed(-6).

The underlying problem with taking cpus offline was fixed in 4.13-rc1 by:

   commit 91f26cb4cd3c ("genirq/cpuhotplug: Do not migrated shutdown irqs")

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xive/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 6595462..2708d42 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -672,6 +672,10 @@ static int xive_irq_set_affinity(struct irq_data *d,
 	if (cpumask_any_and(cpumask, cpu_online_mask) >= nr_cpu_ids)
 		return -EINVAL;
 
+	/* Don't do anything if the interrupt isn't started */
+	if (!irqd_is_started(d))
+		return IRQ_SET_MASK_OK;
+
 	/*
 	 * If existing target is already in the new mask, and is
 	 * online then do nothing.
-- 
1.8.3.1
