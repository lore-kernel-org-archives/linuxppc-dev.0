Return-Path: <srs0=xwhe=72=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdF4K41yqzDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:38:41 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xdF4K222vz8w2V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:38:41 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xdF4H64xqz9t2l
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 16:38:39 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O6ZWwS094371
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 02:38:36 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2chm6sqr0b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2017 02:38:36 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 02:38:36 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 08/12] powerpc/vas: Define vas_win_id()
Date: Wed, 23 Aug 2017 23:38:04 -0700
In-Reply-To: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1503556688-15412-9-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define an interface to return a system-wide unique id for a given VAS
window.

The vas_win_id() will be used in a follow-on patch to generate an unique
handle for a user space receive window. Applications can use this handle
to pair send and receive windows for fast thread-wakeup.

The hardware refers to this system-wide unique id as a Partition Send
Window ID which is expected to be used during fault handling. Hence the
"pswid" in the function names.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/vas.h              |  5 +++++
 arch/powerpc/platforms/powernv/vas-window.c |  9 +++++++++
 arch/powerpc/platforms/powernv/vas.h        | 28 ++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index 2f1c168..6c126f3 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -53,6 +53,11 @@ enum vas_cop_type {
 };
 
 /*
+ * Return a system-wide unique id for the VAS window @win.
+ */
+extern uint32_t vas_win_id(struct vas_window *win);
+
+/*
  * Return the power bus paste address associated with @win so the caller
  * can map that address into their address space.
  */
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 3a4599f..42c1d4f 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -575,3 +575,12 @@ int vas_win_close(struct vas_window *window)
 {
 	return -1;
 }
+
+/*
+ * Return a system-wide unique window id for the window @win.
+ */
+uint32_t vas_win_id(struct vas_window *win)
+{
+	return encode_pswid(win->vinst->vas_id, win->winid);
+}
+EXPORT_SYMBOL_GPL(vas_win_id);
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 7b2bcd0..3eadf90 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -440,4 +440,32 @@ static inline uint64_t read_hvwc_reg(struct vas_window *win,
 	return in_be64(win->hvwc_map+reg);
 }
 
+/*
+ * Encode/decode the Partition Send Window ID (PSWID) for a window in
+ * a way that we can uniquely identify any window in the system. i.e.
+ * we should be able to locate the 'struct vas_window' given the PSWID.
+ *
+ *	Bits	Usage
+ *	0:7	VAS id (8 bits)
+ *	8:15	Unused, 0 (3 bits)
+ *	16:31	Window id (16 bits)
+ */
+static inline u32 encode_pswid(int vasid, int winid)
+{
+	u32 pswid = 0;
+
+	pswid |= vasid << (31 - 7);
+	pswid |= winid;
+
+	return pswid;
+}
+
+static inline void decode_pswid(u32 pswid, int *vasid, int *winid)
+{
+	if (vasid)
+		*vasid = pswid >> (31 - 7) & 0xFF;
+
+	if (winid)
+		*winid = pswid & 0xFFFF;
+}
 #endif /* _VAS_H */
-- 
2.7.4
