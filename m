Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3CGn5ZQtzDsPK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 10:33:53 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8T0XpnL008535
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 20:33:51 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d97pbb1pj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 20:33:50 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 28 Sep 2017 20:33:43 -0400
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 stable@vger.kernel.org
Subject: [PATCH] powerpc/vio: dispose of virq mapping on vdevice unregister
Date: Thu, 28 Sep 2017 20:19:20 -0400
Message-Id: <1506644360-8688-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a vdevice is DLPAR removed from the system the vio subsystem doesn't
bother unmapping the virq from the irq_domain. As a result we have a virq
mapped to a hardware irq that is no longer valid for the irq_domain. A side
effect is that we are left with /proc/irq/<irq#> affinity entries, and
attempts to modify the smp_affinity of the irq will fail.

In the following observed example the kernel log is spammed by
ics_rtas_set_affinity errors after the removal of a VSCSI adapter. This is a
result of irqbalance trying to adjust the affinity every 10 seconds.

rpadlpar_io: slot U8408.E8E.10A7ACV-V5-C25 removed
ics_rtas_set_affinity: ibm,set-xive irq=655385 returns -3
ics_rtas_set_affinity: ibm,set-xive irq=655385 returns -3

This patch fixes the issue by calling irq_dispose_mapping() on the virq of the
viodev on unregister.

Cc: stable@vger.kernel.org
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/vio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 5f8dcda..a3228d6 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1577,6 +1577,8 @@ static struct device_attribute vio_dev_attrs[] = {
 void vio_unregister_device(struct vio_dev *viodev)
 {
 	device_unregister(&viodev->dev);
+	if (viodev->family == VDEVICE)
+		irq_dispose_mapping(viodev->irq);
 }
 EXPORT_SYMBOL(vio_unregister_device);
 
-- 
1.7.12.4
