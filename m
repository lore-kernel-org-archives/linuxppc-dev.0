Return-Path: <srs0=buqp=cg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWqr14jRwzDrCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yWqr05FsFz8w0l
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:32 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yWqqz5zbWz9sNr
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2017 13:24:31 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA82Np4M104820
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Nov 2017 21:24:29 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e3js6ggr0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Nov 2017 21:24:29 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Nov 2017 19:24:28 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 17/18] powerpc/vas: Define vas_win_id()
Date: Tue,  7 Nov 2017 18:23:57 -0800
In-Reply-To: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1510107838-15181-18-git-send-email-sukadev@linux.vnet.ibm.com>
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
index f98ade8..7714562 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -168,6 +168,11 @@ int vas_copy_crb(void *crb, int offset);
 int vas_paste_crb(struct vas_window *win, int offset, bool re);
 
 /*
+ * Return a system-wide unique id for the VAS window @win.
+ */
+extern u32 vas_win_id(struct vas_window *win);
+
+/*
  * Return the power bus paste address associated with @win so the caller
  * can map that address into their address space.
  */
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index d7d0653..8275492 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1235,3 +1235,12 @@ int vas_win_close(struct vas_window *window)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vas_win_close);
+
+/*
+ * Return a system-wide unique window id for the window @win.
+ */
+u32 vas_win_id(struct vas_window *win)
+{
+	return encode_pswid(win->vinst->vas_id, win->winid);
+}
+EXPORT_SYMBOL_GPL(vas_win_id);
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 756cbc5..ae0100f 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -447,4 +447,32 @@ static inline u64 read_hvwc_reg(struct vas_window *win,
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
