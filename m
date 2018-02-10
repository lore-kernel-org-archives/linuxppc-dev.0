Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdpls3F9tzF0fN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 21:56:57 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1AArsLu129674
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 05:56:54 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1wgj2mdv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 05:56:54 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 10 Feb 2018 05:56:54 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/5] powerpc: Don't do runtime futex_cmpxchg test
Date: Sat, 10 Feb 2018 16:26:39 +0530
In-Reply-To: <20180210105643.11857-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180210105643.11857-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180210105643.11857-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

futex_detect_cmpxchg() does a cmpxchg_futex_value_locked on a NULL user addr to
runtime detect whether architecture implements atomic cmpxchg for futex. POWER
do implement the feature and hence we can enable the config instead of depending
on runtime detection.

We could possible enable this on everything. For now limitted to book3s_64

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a429d859f15d..31bc2bd5dfd1 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -75,6 +75,7 @@ config PPC_BOOK3S_64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select IRQ_WORK
 	select HAVE_KERNEL_XZ
+	select HAVE_FUTEX_CMPXCHG if FUTEX
 
 config PPC_BOOK3E_64
 	bool "Embedded processors"
-- 
2.14.3
