Return-Path: <srs0=cc4y=bg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y89RP58jczDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:33 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y89RP30z4z8vjD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:33 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y89RN64gjz9t3C
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2017 13:28:32 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v972Obmk020404
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Oct 2017 22:28:30 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dek7t59sj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 06 Oct 2017 22:28:30 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 20:28:29 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/18] powerpc/vas: init missing fields from [rt]xattr
Date: Fri,  6 Oct 2017 19:28:01 -0700
In-Reply-To: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1507343298-27496-2-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initialize a few missing window context fields from the window attributes
specified by the caller. These fields are currently set to their default
values by the caller (NX-842), but would be good to apply them anyway.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 5aae845..cec7ab7 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -679,10 +679,13 @@ static void init_winctx_for_rxwin(struct vas_window *rxwin,
 
 	winctx->nx_win = rxattr->nx_win;
 	winctx->fault_win = rxattr->fault_win;
+	winctx->user_win = rxattr->user_win;
+	winctx->rej_no_credit = rxattr->rej_no_credit;
 	winctx->rx_word_mode = rxattr->rx_win_ord_mode;
 	winctx->tx_word_mode = rxattr->tx_win_ord_mode;
 	winctx->rx_wcred_mode = rxattr->rx_wcred_mode;
 	winctx->tx_wcred_mode = rxattr->tx_wcred_mode;
+	winctx->notify_early = rxattr->notify_early;
 
 	if (winctx->nx_win) {
 		winctx->data_stamp = true;
@@ -889,11 +892,14 @@ static void init_winctx_for_txwin(struct vas_window *txwin,
 	winctx->user_win = txattr->user_win;
 	winctx->nx_win = txwin->rxwin->nx_win;
 	winctx->pin_win = txattr->pin_win;
+	winctx->rej_no_credit = txattr->rej_no_credit;
+	winctx->rsvd_txbuf_enable = txattr->rsvd_txbuf_enable;
 
 	winctx->rx_wcred_mode = txattr->rx_wcred_mode;
 	winctx->tx_wcred_mode = txattr->tx_wcred_mode;
 	winctx->rx_word_mode = txattr->rx_win_ord_mode;
 	winctx->tx_word_mode = txattr->tx_win_ord_mode;
+	winctx->rsvd_txbuf_count = txattr->rsvd_txbuf_count;
 
 	if (winctx->nx_win) {
 		winctx->data_stamp = true;
-- 
2.7.4
