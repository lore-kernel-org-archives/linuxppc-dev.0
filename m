Return-Path: <srs0=xwhe=72=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdF4P6vN4zDrJs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:38:45 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xdF4P32kYz8t37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:38:45 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xdF4N36jrz9t3P
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 16:38:44 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O6ZXQc094487
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 02:38:42 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2chm6sqr5p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 02:38:42 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 02:38:41 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 12/12] powerpc/vas: Define copy/paste interfaces
Date: Wed, 23 Aug 2017 23:38:08 -0700
In-Reply-To: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1503556688-15412-13-git-send-email-sukadev@linux.vnet.ibm.com>
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
Changelog[v4]
	- Export symbols
Changelog[v3]
	- Map raw CR value from paste instruction into an error code.
---
 MAINTAINERS                                 |  1 +
 arch/powerpc/include/asm/vas.h              | 13 +++++
 arch/powerpc/platforms/powernv/copy-paste.h | 74 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas-window.c | 52 ++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas.h        | 15 ++++++
 5 files changed, 155 insertions(+)
 create mode 100644 arch/powerpc/platforms/powernv/copy-paste.h

diff --git a/MAINTAINERS b/MAINTAINERS
index abc235f..4ca94e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6430,6 +6430,7 @@ M:	Sukadev Bhattiprolu
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/platforms/powernv/vas*
+F:	arch/powerpc/platforms/powernv/copy-paste.h
 F:	arch/powerpc/include/asm/vas.h
 F:	arch/powerpc/include/uapi/asm/vas.h
 
diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index ed1be4c..29531df 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -158,4 +158,17 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
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
index 70762c3..73081b4 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -16,6 +16,7 @@
 #include <linux/cred.h>
 
 #include "vas.h"
+#include "copy-paste.h"
 
 /*
  * Compute the paste address region for the window @window using the
@@ -1040,6 +1041,57 @@ struct vas_window *vas_tx_win_open(int vasid, enum vas_cop_type cop,
 }
 EXPORT_SYMBOL_GPL(vas_tx_win_open);
 
+int vas_copy_crb(void *crb, int offset, bool first)
+{
+	if (!vas_initialized())
+		return -1;
+
+	return vas_copy(crb, offset, first);
+}
+EXPORT_SYMBOL_GPL(vas_copy_crb);
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
+EXPORT_SYMBOL_GPL(vas_paste_crb);
+
 static void poll_window_busy_state(struct vas_window *window)
 {
 	int busy;
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 61fd80f..4e3e5fe 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -482,4 +482,19 @@ static inline void decode_pswid(u32 pswid, int *vasid, int *winid)
 	if (winid)
 		*winid = pswid & 0xFFFF;
 }
+
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
