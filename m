Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymdJm21xBzDrpV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 09:15:20 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vASMEDog103557
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 17:15:18 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ehbb2x8xv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 17:15:17 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 17:15:16 -0500
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>, nfont@linux.vnet.ibm.com
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V5 4/4] powerpc: Enable support for ibm,drc-info devtree
 property
Date: Tue, 28 Nov 2017 16:14:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <69b49b1d-bf14-4733-63a5-67ca6b3e7472@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

prom_init.c: Enable support for new DRC device tree property
"ibm,drc-info" in initial handshake between the Linux kernel and
the front end processor.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 02190e9..f962908 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -873,6 +873,7 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		.mmu = 0,
 		.hash_ext = 0,
 		.radix_ext = 0,
+		.byte22 = OV5_FEAT(OV5_DRC_INFO),
 	},
 
 	/* option vector 6: IBM PAPR hints */
