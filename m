Return-Path: <srs0=m9cn=as=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvwXp6BWCzDrn7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:46 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xvwXp5S0wz8t3H
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:46 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xvwXp1Bv0z9s7p
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 14:05:45 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8H44Pbj049153
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:44 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d10ggga40-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:44 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 16 Sep 2017 22:05:43 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/10] powerpc/vas: Cleanup some debug code
Date: Sat, 16 Sep 2017 21:05:21 -0700
In-Reply-To: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1505621128-23877-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cleanuup vas.h and the debug code around ifdef vas_debug.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c |  8 +++--
 arch/powerpc/platforms/powernv/vas.h        | 56 +++++++----------------------
 2 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index a2fe120..67ffc5d 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -726,7 +726,10 @@ static void init_winctx_for_rxwin(struct vas_window *rxwin,
 static bool rx_win_args_valid(enum vas_cop_type cop,
 			struct vas_rx_win_attr *attr)
 {
-	dump_rx_win_attr(attr);
+	pr_debug("Rxattr: fault %d, notify %d, intr %d, early %d, fifo %d\n",
+			attr->fault_win, attr->notify_disable,
+			attr->intr_disable, attr->notify_early,
+			attr->rx_fifo_size);
 
 	if (cop >= VAS_COP_TYPE_MAX)
 		return false;
@@ -1050,7 +1053,8 @@ int vas_paste_crb(struct vas_window *txwin, int offset, bool re)
 	else
 		rc = -EINVAL;
 
-	print_fifo_msg_count(txwin);
+	pr_debug("Txwin #%d: Msg count %llu\n", txwin->winid,
+			read_hvwc_reg(txwin, VREG(LRFIFO_PUSH)));
 
 	return rc;
 }
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index fea0de4..15d2dfa 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -259,6 +259,16 @@
 #define VAS_NX_UTIL_ADDER		PPC_BITMASK(32, 63)
 
 /*
+ * VREG(x):
+ * Expand a register's short name (eg: LPID) into two parameters:
+ *	- the register's short name in string form ("LPID"), and
+ *	- the name of the macro (eg: VAS_LPID_OFFSET), defining the
+ *	  register's offset in the window context
+ */
+#define VREG_SFX(n, s)	__stringify(n), VAS_##n##s
+#define VREG(r)		VREG_SFX(r, _OFFSET)
+
+/*
  * Local Notify Scope Control Register. (Receive windows only).
  */
 enum vas_notify_scope {
@@ -385,43 +395,15 @@ struct vas_winctx {
 
 extern struct vas_instance *find_vas_instance(int vasid);
 
-/*
- * VREG(x):
- * Expand a register's short name (eg: LPID) into two parameters:
- *	- the register's short name in string form ("LPID"), and
- *	- the name of the macro (eg: VAS_LPID_OFFSET), defining the
- *	  register's offset in the window context
- */
-#define VREG_SFX(n, s)	__stringify(n), VAS_##n##s
-#define VREG(r)		VREG_SFX(r, _OFFSET)
-
-#ifdef vas_debug
-static inline void dump_rx_win_attr(struct vas_rx_win_attr *attr)
-{
-	pr_err("fault %d, notify %d, intr %d early %d\n",
-			attr->fault_win, attr->notify_disable,
-			attr->intr_disable, attr->notify_early);
-
-	pr_err("rx_fifo_size %d, max value %d\n",
-				attr->rx_fifo_size, VAS_RX_FIFO_SIZE_MAX);
-}
-
 static inline void vas_log_write(struct vas_window *win, char *name,
 			void *regptr, u64 val)
 {
-	if (val)
-		pr_err("%swin #%d: %s reg %p, val 0x%016llx\n",
+	if (!val)
+		pr_debug("%swin #%d: %s reg %p, val 0x%016llx\n",
 				win->tx_win ? "Tx" : "Rx", win->winid, name,
 				regptr, val);
 }
 
-#else	/* vas_debug */
-
-#define vas_log_write(win, name, reg, val)
-#define dump_rx_win_attr(attr)
-
-#endif	/* vas_debug */
-
 static inline void write_uwc_reg(struct vas_window *win, char *name,
 			s32 reg, u64 val)
 {
@@ -450,18 +432,4 @@ static inline u64 read_hvwc_reg(struct vas_window *win,
 	return in_be64(win->hvwc_map+reg);
 }
 
-#ifdef vas_debug
-
-static void print_fifo_msg_count(struct vas_window *txwin)
-{
-	uint64_t read_hvwc_reg(struct vas_window *w, char *n, uint64_t o);
-	pr_devel("Winid %d, Msg count %llu\n", txwin->winid,
-			(uint64_t)read_hvwc_reg(txwin, VREG(LRFIFO_PUSH)));
-}
-#else	/* vas_debug */
-
-#define print_fifo_msg_count(window)
-
-#endif	/* vas_debug */
-
 #endif /* _VAS_H */
-- 
2.7.4
