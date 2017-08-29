Return-Path: <srs0=4uxs=77=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhJWS0ChSzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:24:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xhJWR6M5Vz8vLq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:24:19 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xhJWQ733Vz9t48
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 16:24:18 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7T6OHeo026538
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:24:17 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cmvyf61s7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 02:24:15 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 02:24:11 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 10/10] powerpc/vas: Define copy/paste interfaces
Date: Mon, 28 Aug 2017 23:23:40 -0700
In-Reply-To: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503987820-31933-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1503987820-31933-11-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define interfaces (wrappers) to the 'copy' and 'paste' instructions
(which are new in PowerISA 3.0). These are intended to be used to
by NX driver(s) to submit Coprocessor Request Blocks (CRBs) to the
NX hardware engines.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

---
Changelog[v8]:
	- [Michael Ellerman] Drop vas_initialized() check; cleanup asm code,
	  reuse existing macros, fix old references; add cr0 to clobbers

Changelog[v4]
	- Export symbols
Changelog[v3]
	- Map raw CR value from paste instruction into an error code.

Conflicts:
	arch/powerpc/platforms/powernv/vas.h
---
 MAINTAINERS                                 |  1 +
 arch/powerpc/include/asm/ppc-opcode.h       |  2 ++
 arch/powerpc/include/asm/vas.h              | 12 ++++++++
 arch/powerpc/platforms/powernv/copy-paste.h | 46 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas-window.c | 47 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.h        | 18 +++++++++--
 6 files changed, 124 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/copy-paste.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ec68732..624c67a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6442,6 +6442,7 @@ M:	Sukadev Bhattiprolu
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/platforms/powernv/vas*
+F:	arch/powerpc/platforms/powernv/copy-paste.h
 F:	arch/powerpc/include/asm/vas.h
 F:	arch/powerpc/include/uapi/asm/vas.h
 
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index fa9ebae..749336d 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -414,6 +414,8 @@
 					___PPC_RB(b))
 #define PPC_MSGCLRP(b)		stringify_in_c(.long PPC_INST_MSGCLRP | \
 					___PPC_RB(b))
+#define PPC_PASTE(a, b)		stringify_in_c(.long PPC_INST_PASTE | \
+					___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_POPCNTB(a, s)	stringify_in_c(.long PPC_INST_POPCNTB | \
 					__PPC_RA(a) | __PPC_RS(s))
 #define PPC_POPCNTD(a, s)	stringify_in_c(.long PPC_INST_POPCNTD | \
diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index efbdde5..dfc97f5 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -145,4 +145,16 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
  */
 int vas_win_close(struct vas_window *win);
 
+/*
+ * Copy the co-processor request block (CRB) @crb into the local L2 cache.
+ */
+extern int vas_copy_crb(void *crb, int offset);
+
+/*
+ * Paste a previously copied CRB (see vas_copy_crb()) from the L2 cache to
+ * the hardware address associated with the window @win. @re is expected/
+ * assumed to be true for NX windows.
+ */
+extern int vas_paste_crb(struct vas_window *win, int offset, bool re);
+
 #endif /* _MISC_VAS_H */
diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
new file mode 100644
index 0000000..c9a5036
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/copy-paste.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2016-17 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <asm/ppc-opcode.h>
+
+#define CR0_SHIFT	28
+#define CR0_MASK	0xF
+/*
+ * Copy/paste instructions:
+ *
+ *	copy RA,RB
+ *		Copy contents of address (RA) + effective_address(RB)
+ *		to internal copy-buffer.
+ *
+ *	paste RA,RB
+ *		Paste contents of internal copy-buffer to the address
+ *		(RA) + effective_address(RB)
+ */
+static inline int vas_copy(void *crb, int offset)
+{
+	asm volatile(PPC_COPY(%0, %1)";"
+		:
+		: "b" (offset), "b" (crb)
+		: "memory");
+
+	return 0;
+}
+
+static inline int vas_paste(void *paste_address, int offset)
+{
+	u32 cr;
+
+	cr = 0;
+	asm volatile(PPC_PASTE(%1, %2)";"
+		"mfocrf %0, 0x80;"
+		: "=r" (cr)
+		: "b" (offset), "b" (paste_address)
+		: "memory", "cr0");
+
+	return (cr >> CR0_SHIFT) & CR0_MASK;
+}
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index cd12e44..b02f26d 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -18,6 +18,7 @@
 #include <linux/cred.h>
 
 #include "vas.h"
+#include "copy-paste.h"
 
 /*
  * Compute the paste address region for the window @window using the
@@ -997,6 +998,52 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 }
 EXPORT_SYMBOL_GPL(vas_tx_win_open);
 
+int vas_copy_crb(void *crb, int offset)
+{
+	return vas_copy(crb, offset);
+}
+EXPORT_SYMBOL_GPL(vas_copy_crb);
+
+#define RMA_LSMP_REPORT_ENABLE PPC_BIT(53)
+int vas_paste_crb(struct vas_window *txwin, int offset, bool re)
+{
+	int rc;
+	void *addr;
+	uint64_t val;
+
+	/*
+	 * Only NX windows are supported for now and hardware assumes
+	 * report-enable flag is set for NX windows. Ensure software
+	 * complies too.
+	 */
+	WARN_ON_ONCE(txwin->nx_win && !re);
+
+	addr = txwin->paste_kaddr;
+	if (re) {
+		/*
+		 * Set the REPORT_ENABLE bit (equivalent to writing
+		 * to 1K offset of the paste address)
+		 */
+		val = SET_FIELD(RMA_LSMP_REPORT_ENABLE, 0ULL, 1);
+		addr += val;
+	}
+
+	/*
+	 * Map the raw CR value from vas_paste() to an error code (there
+	 * is just pass or fail for now though).
+	 */
+	rc = vas_paste(addr, offset);
+	if (rc == 2)
+		rc = 0;
+	else
+		rc = -EINVAL;
+
+	print_fifo_msg_count(txwin);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(vas_paste_crb);
+
 static void poll_window_busy_state(struct vas_window *window)
 {
 	int busy;
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index d3e4f55..38dee5d 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -398,11 +398,11 @@ extern struct vas_instance *find_vas_instance(int vasid);
 #ifdef vas_debug
 static inline void dump_rx_win_attr(struct vas_rx_win_attr *attr)
 {
-	pr_err("VAS: fault %d, notify %d, intr %d early %d\n",
+	pr_err("fault %d, notify %d, intr %d early %d\n",
 			attr->fault_win, attr->notify_disable,
 			attr->intr_disable, attr->notify_early);
 
-	pr_err("VAS: rx_fifo_size %d, max value %d\n",
+	pr_err("rx_fifo_size %d, max value %d\n",
 				attr->rx_fifo_size, VAS_RX_FIFO_SIZE_MAX);
 }
 
@@ -450,4 +450,18 @@ static inline u64 read_hvwc_reg(struct vas_window *win,
 	return in_be64(win->hvwc_map+reg);
 }
 
+#ifdef vas_debug
+
+static void print_fifo_msg_count(struct vas_window *txwin)
+{
+	uint64_t read_hvwc_reg(struct vas_window *w, char *n, uint64_t o);
+	pr_devel("Winid %d, Msg count %llu\n", txwin->winid,
+			(uint64_t)read_hvwc_reg(txwin, VREG(LRFIFO_PUSH)));
+}
+#else	/* vas_debug */
+
+#define print_fifo_msg_count(window)
+
+#endif	/* vas_debug */
+
 #endif /* _VAS_H */
-- 
2.7.4
