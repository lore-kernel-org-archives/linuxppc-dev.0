Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJH5H43mXzDrKP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 02:10:43 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6RG7gVT031341
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:10:41 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2byjkxjtcq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:10:40 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 10:10:40 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, Michael Bringmann <mwb@linux.vnet.ibm.com>
In-Reply-To: <e884f428-c76d-112a-aa2f-f57a94de55fb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V2 4/4] powerpc: Enable support for ibm,drc-info devtree
 property
Date: Thu, 27 Jul 2017 11:10:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <21fa3cc3-7f56-61fa-38f8-6259543644ac@linux.vnet.ibm.com>
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
index 613f79f..1fd07aa 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -872,6 +872,7 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		.mmu = 0,
 		.hash_ext = 0,
 		.radix_ext = 0,
+		.byte22 = OV5_FEAT(OV5_DRC_INFO),
 	},
 
 	/* option vector 6: IBM PAPR hints */
