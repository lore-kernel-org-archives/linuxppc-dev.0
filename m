Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xy6d5v3FzDrp0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 18:24:25 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w518JbGS105287
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2018 04:24:23 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jayhwqafu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2018 04:24:23 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 1 Jun 2018 02:24:22 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/mm/hash: hard disable irq in the SLB insert path
Date: Fri,  1 Jun 2018 13:54:02 +0530
Message-Id: <20180601082402.17192-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When inserting SLB entries for EA above 512TB, we need to hard disable irq.
This will make sure we don't take a PMU interrupt that can possibly touch
user space address via a stack dump. To prevent this, we need to hard disable
the interrupt.

Also add a comment explaining why we don't need context synchronizing isync
with slbmte.

Fixes: f384796c4 ("powerpc/mm: Add support for handling > 512TB address in SLB miss")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/slb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 66577cc66dc9..27f5b81c372a 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -352,6 +352,14 @@ static void insert_slb_entry(unsigned long vsid, unsigned long ea,
 	/*
 	 * We are irq disabled, hence should be safe to access PACA.
 	 */
+	VM_WARN_ON(!irqs_disabled());
+
+	/*
+	 * We can't take a PMU exception in the following code, so hard
+	 * disable interrupts.
+	 */
+	hard_irq_disable();
+
 	index = get_paca()->stab_rr;
 
 	/*
@@ -369,6 +377,11 @@ static void insert_slb_entry(unsigned long vsid, unsigned long ea,
 		    ((unsigned long) ssize << SLB_VSID_SSIZE_SHIFT);
 	esid_data = mk_esid_data(ea, ssize, index);
 
+	/*
+	 * No need for an isync before or after this slbmte. The exception
+	 * we enter with and the rfid we exit with are context synchronizing.
+	 * Also we only handle user segments here.
+	 */
 	asm volatile("slbmte %0, %1" : : "r" (vsid_data), "r" (esid_data)
 		     : "memory");
 
-- 
2.17.0
