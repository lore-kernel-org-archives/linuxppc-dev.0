Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFmTL2gwmzDvjR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 04:03:34 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFmTK3NtHz9t2D
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2016 04:03:33 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABGx6ac130357
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:31 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nfda3n5b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 12:03:31 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 10:03:30 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 08/11] VAS: Define vas_copy_crb() and vas_paste_crb()
Date: Fri, 11 Nov 2016 09:02:53 -0800
In-Reply-To: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1478883776-11121-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1478883776-11121-9-git-send-email-sukadev@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/vas.h  | 13 +++++++
 drivers/misc/vas/copy-paste.h   | 78 +++++++++++++++++++++++++++++++++++++++++
 drivers/misc/vas/vas-internal.h | 14 ++++++++
 drivers/misc/vas/vas-window.c   | 42 ++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/misc/vas/copy-paste.h

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index 431692d..5ed3357 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -118,4 +118,17 @@ struct vas_window *vas_tx_win_open(int node, int chip, enum vas_cop_type cop,
  */
 int vas_win_close(struct vas_window *win);
 
+/*
+ * Copy the co-processor request block (CRB) @crb into the local L2 cache.
+ * For now, @offset must be 0 and @first must be false.
+ */
+extern int vas_copy_crb(void *crb, int offset, bool first);
+
+/*
+ * Paste a previously copied CRB (see vas_copy_crb()) from the L2 cache to
+ * the hardware address associated with the window @win. For now, @off must
+ * 0 and @last must be false. @re is expected/assumed to be true for NX windows.
+ */
+extern int vas_paste_crb(struct vas_window *win, int off, bool last, bool re);
+
 #endif
diff --git a/drivers/misc/vas/copy-paste.h b/drivers/misc/vas/copy-paste.h
new file mode 100644
index 0000000..977074b
--- /dev/null
+++ b/drivers/misc/vas/copy-paste.h
@@ -0,0 +1,78 @@
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
+ * Copy instruction:
+ *
+ *	copy RA,RB,L
+ *		Copy contents of address
+ *
+ *			(RA) + effective_address(RB)
+ *
+ *		to internal copy-buffer.
+ *
+ *		L == 1 indicates this is the first copy. 0 indicates its
+ *		a continuation of a prior first copy.
+ *
+ *	paste RA,RB,L
+ *		Paste contents of internal copy-buffer to the address:
+ *
+ *			(RA) + effective_address(RB)
+ *
+ *		L == 0 indicates its a continuation of a prior paste.
+ *			i.e paste won't wait for the completion/status.
+ *
+ *		L == 1 indicates this is the last paste. In this case,
+ *			paste waits for the entire group to complete and
+ *			updates the status in CR0.
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
diff --git a/drivers/misc/vas/vas-internal.h b/drivers/misc/vas/vas-internal.h
index 7234ff6..a58ffb2 100644
--- a/drivers/misc/vas/vas-internal.h
+++ b/drivers/misc/vas/vas-internal.h
@@ -433,4 +433,18 @@ static inline uint64_t read_hvwc_reg(struct vas_window *win,
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
 #endif
diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.c
index 140ce80..f6610de 100644
--- a/drivers/misc/vas/vas-window.c
+++ b/drivers/misc/vas/vas-window.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <asm/vas.h>
 #include "vas-internal.h"
+#include "copy-paste.h"
 
 static int fault_winid;
 
@@ -927,6 +928,47 @@ put_rxwin:
 
 }
 
+int vas_copy_crb(void *crb, int offset, bool first)
+{
+	if (!vas_initialized)
+		return -1;
+
+	return vas_copy(crb, offset, first);
+}
+
+int vas_paste_crb(struct vas_window *txwin, int offset, bool last, bool re)
+{
+	int rc;
+	uint64_t val;
+	void *addr;
+
+	if (!vas_initialized)
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
+	rc = vas_paste(addr, offset, last);
+
+	print_fifo_msg_count(txwin);
+
+	return rc;
+}
+
+
 int vas_win_close(struct vas_window *window)
 {
 	uint64_t val;
-- 
1.8.3.1
