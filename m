Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3kLd36N5zDqDN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 10:53:13 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0INnDDP017137
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 18:53:10 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 282f5jxph5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 18:53:10 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 19 Jan 2017 09:53:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0D57D2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 10:53:05 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0INr5Z721954682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 10:53:05 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0INr4Kh017949
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 10:53:04 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 stable@vger.kernel.org, #3.15+@gwshan.ozlabs.ibm.com
Subject: [PATCH] powerpc/powernv: Validate memcons descriptor and output buffer
Date: Thu, 19 Jan 2017 10:52:50 +1100
Message-Id: <1484783570-6298-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, it's assumed that memcons and its output buffer are included
in the linear mapping. It's not true when "mem=384M" is included in
bootargs. The system runs into kernel crash eventually.

   # od -x /proc/device-tree/ibm,opal/ibm,opal-memcons
   0000000 0000 0000 0b30 0010
   0000010

This validates memcons descriptor and its output buffer to ensure they
are valid in linear mapping. Otherwise, the interface won't be populated
to avoid kernel crash during system boot.

Cc: stable@vger.kernel.org #3.15+
Fixes: bfc36894a48 ("powerpc/powernv: Add OPAL message log interface")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-msglog.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 39d6ff9..34dc2f2 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/types.h>
 #include <asm/barrier.h>
+#include <asm/setup.h>
 
 /* OPAL in-memory console. Defined in OPAL source at core/console.c */
 struct memcons {
@@ -104,7 +105,7 @@ static struct bin_attribute opal_msglog_attr = {
 
 void __init opal_msglog_init(void)
 {
-	u64 mcaddr;
+	u64 mcaddr, obuf_top;
 	struct memcons *mc;
 
 	if (of_property_read_u64(opal_node, "ibm,opal-memcons", &mcaddr)) {
@@ -112,6 +113,12 @@ void __init opal_msglog_init(void)
 		return;
 	}
 
+	if (memory_limit && (mcaddr + sizeof(*mc)) > memory_limit) {
+		pr_warn("OPAL: memcons descriptor (0x%llx, 0x%lx) is out of memory (0x%llx)\n",
+			mcaddr, sizeof(*mc), memory_limit);
+		return;
+	}
+
 	mc = phys_to_virt(mcaddr);
 	if (!mc) {
 		pr_warn("OPAL: memory console address is invalid\n");
@@ -123,6 +130,13 @@ void __init opal_msglog_init(void)
 		return;
 	}
 
+	obuf_top = be64_to_cpu(mc->obuf_phys) + be32_to_cpu(mc->obuf_size);
+	if (memory_limit && obuf_top > memory_limit) {
+		pr_warn("OPAL: memcons output buffer ceiling (0x%llx) is out of memory (0x%llx)\n",
+			obuf_top, memory_limit);
+		return;
+	}
+
 	opal_memcons = mc;
 }
 
-- 
2.7.4
