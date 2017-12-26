Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z5bXT3qNvzDrWg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 23:54:17 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBQCqPpw142818
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 07:54:14 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f3n78tu2p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 07:54:14 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Tue, 26 Dec 2017 07:54:13 -0500
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, david@gibson.dropbear.id.au, benh@au1.ibm.com
Subject: [PATCH v2 1/1] powerpc/pseries: increase pseries_dlpar_init initcall
 priority
Date: Tue, 26 Dec 2017 10:53:59 -0200
In-Reply-To: <20171226125359.23706-1-joserz@linux.vnet.ibm.com>
References: <20171226125359.23706-1-joserz@linux.vnet.ibm.com>
Message-Id: <20171226125359.23706-2-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hotplug engine uses its own workqueue to handle IRQ requests, the
problem is that such workqueue is initialized after init_ras_IRQ, which
will cause a kernel panic if any hotplug interruption is issued in that
period of time.

This patch changes the dlpar initcall registration to make sure it will
be initialized before init_ras_IRQ.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 6e35780c5962..1f9ae1d0b2be 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -580,5 +580,5 @@ static int __init pseries_dlpar_init(void)
 					WQ_UNBOUND, 1);
 	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
 }
-machine_device_initcall(pseries, pseries_dlpar_init);
+machine_arch_initcall(pseries, pseries_dlpar_init);
 
-- 
2.14.1
