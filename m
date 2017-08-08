Return-Path: <srs0=ev05=7k=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRqn05D38zDqrL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:07:48 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xRqn03bJJz8tnp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 09:07:48 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xRqmz1DqHz9t2y
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2017 09:07:47 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78N4ERx144790
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2017 19:07:45 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c7k46jpdc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Aug 2017 19:07:45 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 19:07:44 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 15/17] powerpc/vas: Define window open ioctls API
Date: Tue,  8 Aug 2017 16:07:00 -0700
In-Reply-To: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1502233622-9330-16-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define the VAS_TX_WIN_OPEN and VAS_RX_WIN_OPEN ioctl interface. Each user
of VAS, like the NX-FTW driver in a follow-on patch, should implement
these ioctls.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/vas.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/vas.h b/arch/powerpc/include/uapi/asm/vas.h
index 21249f5..e9730fb 100644
--- a/arch/powerpc/include/uapi/asm/vas.h
+++ b/arch/powerpc/include/uapi/asm/vas.h
@@ -10,6 +10,8 @@
 #ifndef _UAPI_MISC_VAS_H
 #define _UAPI_MISC_VAS_H
 
+#include <asm/ioctl.h>
+
 /*
  * Threshold Control Mode: Have paste operation fail if the number of
  * requests in receive FIFO exceeds a threshold.
@@ -22,6 +24,34 @@
 #define VAS_THRESH_FIFO_GT_QTR_FULL	2
 #define VAS_THRESH_FIFO_GT_EIGHTH_FULL	3
 
+#define VAS_FLAGS_PIN_WINDOW		0x1
+#define VAS_FLAGS_HIGH_PRI		0x2
+
+#define VAS_TX_WIN_OPEN		_IOW('v', 1, struct vas_tx_win_open_attr)
+#define VAS_RX_WIN_OPEN		_IOW('v', 2, struct vas_rx_win_open_attr)
+
+struct vas_tx_win_open_attr {
+	int16_t		version;
+	int16_t		vas_id;
+	uint32_t	rx_win_handle;
+
+	int64_t		reserved1;
+
+	int64_t		flags;
+	int64_t		reserved2;
+
+	int32_t		tc_mode;
+	int32_t		rsvd_txbuf;
+	int64_t		reserved3[6];
+};
+
+struct vas_rx_win_open_attr {
+	int16_t		version;
+	int16_t		vas_id;
+	uint32_t	rx_win_handle;	/* output field */
+	int64_t		reserved[8];
+};
+
 /*
  * Get/Set bit fields
  */
-- 
2.7.4
