Return-Path: <srs0=lfg8=3i=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvV6X5fhFzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 16:14:28 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vvV6X47mRz8w5m
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 16:14:28 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vvV6W5Fw5z9s2x
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 16:14:27 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2V5Drvn121259
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:14:21 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29gx8c98bu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:14:21 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 23:14:20 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 11/11] VAS: Define copy/paste interfaces
Date: Thu, 30 Mar 2017 22:13:44 -0700
In-Reply-To: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1490937224-29149-12-git-send-email-sukadev@linux.vnet.ibm.com>
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
Changelog[v3]
	- Map raw CR value from paste instruction into an error code.
---
 arch/powerpc/include/asm/vas.h              | 13 +++++
 arch/powerpc/platforms/powernv/copy-paste.h | 74 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas-window.c | 50 +++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.h        | 14 ++++++
 4 files changed, 151 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/copy-paste.h

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index 944bb4b..4e5a470 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -125,4 +125,17 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
  */
 int vas_win_close(struct vas_window *win);
 
+/*
+ * Copy the co-processor request block (CRB) @crb into the local L2 cache.
+ * For now, @offset must be 0 and @first must be true.
+ */
+extern int vas_copy_crb(void *crb, int offset, bool first);
+
+/*
+ * Paste a previously copied CRB (see vas_copy_crb()) from the L2 cache to
+ * the hardware address associated with the window @win. For now, @off must
+ * 0 and @last must be true. @re is expected/assumed to be true for NX windows.
+ */
+extern int vas_paste_crb(struct vas_window *win, int off, bool last, bool re);
+
 #endif /* _MISC_VAS_H */
diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
new file mode 100644
index 0000000..7783bb8
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/copy-paste.h
@@ -0,0 +1,74 @@
+/*
+ * Copyright 2016 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * Macros taken from tools/testing/selftests/powerpc/context_switch/cp_abort.c
+ */
+#define PASTE(RA, RB, L, RC) \
+	.long (0x7c00070c | (RA) << (31-15) | (RB) << (31-20) \
+			  | (L) << (31-10) | (RC) << (31-31))
+
+#define COPY(RA, RB, L) \
+	.long (0x7c00060c | (RA) << (31-15) | (RB) << (31-20) \
+			  | (L) << (31-10))
+
+#define CR0_FXM		"0x80"
+#define CR0_SHIFT	28
+#define CR0_MASK	0xF
+/*
+ * Copy/paste instructions:
+ *
+ *	copy RA,RB,L
+ *		Copy contents of address (RA) + effective_address(RB)
+ *		to internal copy-buffer.
+ *
+ *		L == 1 indicates this is the first copy.
+ *
+ *		L == 0 indicates its a continuation of a prior first copy.
+ *
+ *	paste RA,RB,L
+ *		Paste contents of internal copy-buffer to the address
+ *		(RA) + effective_address(RB)
+ *
+ *		L == 0 indicates its a continuation of a prior paste. i.e.
+ *		don't wait for the completion or update status.
+ *
+ *		L == 1 indicates this is the last paste in the group (i.e.
+ *		wait for the group to complete and update status in CR0).
+ *
+ *	For Power9, the L bit must be 'true' in both copy and paste.
+ */
+
+static inline int vas_copy(void *crb, int offset, int first)
+{
+	WARN_ON_ONCE(!first);
+
+	__asm__ __volatile(stringify_in_c(COPY(%0, %1, %2))";"
+		:
+		: "b" (offset), "b" (crb), "i" (1)
+		: "memory");
+
+	return 0;
+}
+
+static inline int vas_paste(void *paste_address, int offset, int last)
+{
+	unsigned long long cr;
+
+	WARN_ON_ONCE(!last);
+
+	cr = 0;
+	__asm__ __volatile(stringify_in_c(PASTE(%1, %2, 1, 1))";"
+		"mfocrf %0," CR0_FXM ";"
+		: "=r" (cr)
+		: "b" (paste_address), "b" (offset)
+		: "memory");
+
+	return cr;
+}
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 4f4c134..fe09d6f 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -14,6 +14,7 @@
 #include <linux/log2.h>
 
 #include "vas.h"
+#include "copy-paste.h"
 
 static int fault_winid;
 
@@ -866,6 +867,55 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 
 }
 
+int vas_copy_crb(void *crb, int offset, bool first)
+{
+	if (!vas_initialized())
+		return -1;
+
+	return vas_copy(crb, offset, first);
+}
+
+#define RMA_LSMP_REPORT_ENABLE PPC_BIT(53)
+int vas_paste_crb(struct vas_window *txwin, int offset, bool last, bool re)
+{
+	int rc;
+	uint64_t val;
+	void *addr;
+
+	if (!vas_initialized())
+		return -1;
+	/*
+	 * Only NX windows are supported for now and hardware assumes
+	 * report-enable flag is set for NX windows. Ensure software
+	 * complies too.
+	 */
+	WARN_ON_ONCE(!re);
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
+	rc = vas_paste(addr, offset, last);
+	if (rc == 0x20000000)
+		rc = 0;
+	else
+		rc = -EINVAL;
+
+	print_fifo_msg_count(txwin);
+
+	return rc;
+}
+
 static void poll_window_busy_state(struct vas_window *window)
 {
 	int busy;
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 86ed526..83c2559 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -453,4 +453,18 @@ static inline uint64_t read_hvwc_reg(struct vas_window *win,
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
