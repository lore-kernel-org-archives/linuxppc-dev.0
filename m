Return-Path: <srs0=xwhe=72=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdF4H5XLhzDrK2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:38:39 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xdF4H1cjfz8w2H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:38:39 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xdF4F0HZmz9t3h
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 16:38:36 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O6bJAS052797
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 02:38:34 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chspjr2nu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 02:38:34 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 02:38:33 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 07/12] powerpc/vas: Define vas_win_paste_addr()
Date: Wed, 23 Aug 2017 23:38:03 -0700
In-Reply-To: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1503556688-15412-8-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define an interface that the NX drivers can use to find the physical
paste address of a send window. This interface is expected to be used
with the mmap() operation of the NX driver's device. i.e the user space
process can use driver's mmap() operation to map the send window's paste
address into their address space and then use copy and paste instructions
to submit the CRBs to the NX engine.

Note that kernel drivers will use vas_paste_crb() directly and don't need
this interface.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/vas.h              |  7 +++++++
 arch/powerpc/platforms/powernv/vas-window.c | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index e34d46a..2f1c168 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -10,6 +10,8 @@
 #ifndef _MISC_VAS_H
 #define _MISC_VAS_H
 
+struct vas_window;
+
 /*
  * Min and max FIFO sizes are based on Version 1.05 Section 3.1.4.25
  * (Local FIFO Size Register) of the VAS workbook.
@@ -50,4 +52,9 @@ enum vas_cop_type {
 	VAS_COP_TYPE_MAX,
 };
 
+/*
+ * Return the power bus paste address associated with @win so the caller
+ * can map that address into their address space.
+ */
+extern uint64_t vas_win_paste_addr(struct vas_window *win);
 #endif /* _MISC_VAS_H */
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 9c12919..3a4599f 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -35,6 +35,16 @@ void compute_paste_address(struct vas_window *window, uint64_t *addr, int *len)
 	pr_debug("Txwin #%d: Paste addr 0x%llx\n", winid, *addr);
 }
 
+uint64_t vas_win_paste_addr(struct vas_window *win)
+{
+	uint64_t addr;
+
+	compute_paste_address(win, &addr, NULL);
+
+	return addr;
+}
+EXPORT_SYMBOL(vas_win_paste_addr);
+
 static inline void get_hvwc_mmio_bar(struct vas_window *window,
 			uint64_t *start, int *len)
 {
-- 
2.7.4
