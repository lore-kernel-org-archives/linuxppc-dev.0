Return-Path: <srs0=5zt0=7f=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNPlk6nd7zDqs9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 19:24:50 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xNPlk6FsXz8vsv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 19:24:50 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xNPlk3C4Fz9s7v
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2017 19:24:50 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v739NsvF129164
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2017 05:24:48 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3snterdx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Aug 2017 05:24:48 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 3 Aug 2017 19:24:45 +1000
Subject: [PATCH 1/4] powerpc/prom: avoid endian conversions for linux,
 memory-limit node
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: sjitindarsingh@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, ben@codiert.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@ozlabs.org>, stable@vger.kernel.org#3.12+
Date: Thu, 03 Aug 2017 14:54:35 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As linux,memory-limit node is set and also later used by the kernel,
avoid endian conversions for this property.

Fixes: 493adffcb43f ("powerpc: Make prom_init.c endian safe")
Cc: stable@vger.kernel.org # 3.12+
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 613f79f..723df83 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -3180,9 +3180,8 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 * Fill in some infos for use by the kernel later on
 	 */
 	if (prom_memory_limit) {
-		__be64 val = cpu_to_be64(prom_memory_limit);
 		prom_setprop(prom.chosen, "/chosen", "linux,memory-limit",
-			     &val, sizeof(val));
+			     &prom_memory_limit, sizeof(prom_memory_limit));
 	}
 #ifdef CONFIG_PPC64
 	if (prom_iommu_off)
