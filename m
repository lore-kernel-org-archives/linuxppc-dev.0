Return-Path: <srs0=cc4y=bg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y89RQ6CvVzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:34 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y89RQ4T3Zz8vjD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:34 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y89RP42Bgz9t3C
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2017 13:28:33 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v972OZ0s003820
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Oct 2017 22:28:31 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2deewkym09-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 06 Oct 2017 22:28:31 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 20:28:30 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/18] powerpc/vas: Validate window credits
Date: Fri,  6 Oct 2017 19:28:02 -0700
In-Reply-To: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1507343298-27496-3-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NX-842, the only user of VAS, sets the window credits to default values
but VAS should check the credits against the possible max values.

The VAS_WCREDS_MIN is not needed and can be dropped.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 6 ++++++
 arch/powerpc/platforms/powernv/vas.h        | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index cec7ab7..a2fe120 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -738,6 +738,9 @@ static bool rx_win_args_valid(enum vas_cop_type cop,
 	if (attr->rx_fifo_size > VAS_RX_FIFO_SIZE_MAX)
 		return false;
 
+	if (attr->wcreds_max > VAS_RX_WCREDS_MAX)
+		return false;
+
 	if (attr->nx_win) {
 		/* cannot be fault or user window if it is nx */
 		if (attr->fault_win || attr->user_win)
@@ -927,6 +930,9 @@ static bool tx_win_args_valid(enum vas_cop_type cop,
 	if (cop > VAS_COP_TYPE_MAX)
 		return false;
 
+	if (attr->wcreds_max > VAS_TX_WCREDS_MAX)
+		return false;
+
 	if (attr->user_win &&
 			(cop != VAS_COP_TYPE_FTW || attr->rsvd_txbuf_count))
 		return false;
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 38dee5d..fea0de4 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -106,8 +106,8 @@
  *
  * TODO: Needs tuning for per-process credits
  */
-#define VAS_WCREDS_MIN			16
-#define VAS_WCREDS_MAX			((64 << 10) - 1)
+#define VAS_RX_WCREDS_MAX		((64 << 10) - 1)
+#define VAS_TX_WCREDS_MAX		((4 << 10) - 1)
 #define VAS_WCREDS_DEFAULT		(1 << 10)
 
 /*
-- 
2.7.4
