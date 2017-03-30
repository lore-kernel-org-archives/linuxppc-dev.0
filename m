Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtrbk2mKCzDqKT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 15:04:02 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2U43jnJ021501
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 00:03:56 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29gdaejbus-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 00:03:56 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 00:03:56 -0400
Date: Wed, 29 Mar 2017 21:03:49 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: praveen.pandey@in.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/prom: Increase RMA size to 512MB
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20170330040349.GA31756@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 3ae8d1ed31b01b92b172fe20e4560cfbfab135ec Mon Sep 17 00:00:00 2001
From: root <root@furatripa-lp2.aus.stglabs.ibm.com>
Date: Mon, 27 Mar 2017 19:43:14 -0400
Subject: [PATCH] powerpc/prom: Increase RMA size to 512MB

When booting very large systems with a large initrd, we run out of
space for either the RTAS or the flattened device tree (FDT). Boot
fails with messages like:

	Could not allocate memory for RTAS
or
	No memory for flatten_device_tree (no room)

Increasing the minimum RMA size to 512MB fixes the problem. This
should not have an impact on smaller LPARs (with 256MB memory),
as the firmware will cap the RMA to the memory assigned to the LPAR.

Fix is based on input/discussions with Michael Ellerman. Thanks to
Praveen K. Pandey for testing on a large system.

Reported-by: Praveen K. Pandey <preveen.pandey@in.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 1c1b44e..dd8a04f 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -815,7 +815,7 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		.virt_base = cpu_to_be32(0xffffffff),
 		.virt_size = cpu_to_be32(0xffffffff),
 		.load_base = cpu_to_be32(0xffffffff),
-		.min_rma = cpu_to_be32(256),		/* 256MB min RMA */
+		.min_rma = cpu_to_be32(512),		/* 512MB min RMA */
 		.min_load = cpu_to_be32(0xffffffff),	/* full client load */
 		.min_rma_percent = 0,	/* min RMA percentage of total RAM */
 		.max_pft_size = 48,	/* max log_2(hash table size) */
-- 
1.8.3.1
