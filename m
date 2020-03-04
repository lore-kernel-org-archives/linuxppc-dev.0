Return-Path: <SRS0=d5Dh=4V=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F447C3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 21:04:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDB420842
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 21:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDB420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48XmbC4xQFzDqkP
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Mar 2020 08:04:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=haren@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48XmJj3tbnzDqnT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2020 07:51:49 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 024KpF3Q007203; Wed, 4 Mar 2020 15:51:39 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yhs0ukmuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2020 15:51:38 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 024Kpc9v008732;
 Wed, 4 Mar 2020 15:51:38 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yhs0ukmu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2020 15:51:38 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 024KmuMl001765;
 Wed, 4 Mar 2020 20:51:37 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03dal.us.ibm.com with ESMTP id 2yffk7qb68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2020 20:51:37 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 024Kpam238207882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2020 20:51:36 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E292C6059;
 Wed,  4 Mar 2020 20:51:36 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFAD0C6057;
 Wed,  4 Mar 2020 20:51:35 +0000 (GMT)
Received: from [9.70.82.143] (unknown [9.70.82.143])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2020 20:51:35 +0000 (GMT)
Subject: [PATCH V6 11/14] powerpc/vas: Do not use default credits for
 receive window
From: Haren Myneni <haren@linux.ibm.com>
To: mpe@ellerman.id.au
In-Reply-To: <1583353283.18705.2112.camel@hbabu-laptop>
References: <1583353283.18705.2112.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Mar 2020 12:50:33 -0800
Message-ID: <1583355033.18705.2158.camel@hbabu-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-04_08:2020-03-04,
 2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=1
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxlogscore=889 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040135
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mikey@neuling.org, herbert@gondor.apana.org.au, npiggin@gmail.com,
 hch@infradead.org, oohall@gmail.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


System checkstops if RxFIFO overruns with more requests than the
maximum possible number of CRBs allowed in FIFO at any time. So
max credits value (rxattr.wcreds_max) is set and is passed to
vas_rx_win_open() by the the driver.

Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-window.c | 4 ++--
 arch/powerpc/platforms/powernv/vas.h        | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index 7587258..427a884 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -772,7 +772,7 @@ static bool rx_win_args_valid(enum vas_cop_type cop,
 	if (attr->rx_fifo_size > VAS_RX_FIFO_SIZE_MAX)
 		return false;
 
-	if (attr->wcreds_max > VAS_RX_WCREDS_MAX)
+	if (!attr->wcreds_max)
 		return false;
 
 	if (attr->nx_win) {
@@ -877,7 +877,7 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
 	rxwin->nx_win = rxattr->nx_win;
 	rxwin->user_win = rxattr->user_win;
 	rxwin->cop = cop;
-	rxwin->wcreds_max = rxattr->wcreds_max ?: VAS_WCREDS_DEFAULT;
+	rxwin->wcreds_max = rxattr->wcreds_max;
 
 	init_winctx_for_rxwin(rxwin, rxattr, &winctx);
 	init_winctx_regs(rxwin, &winctx);
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 7c8e0182..9ba4605 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -101,11 +101,9 @@
 /*
  * Initial per-process credits.
  * Max send window credits:    4K-1 (12-bits in VAS_TX_WCRED)
- * Max receive window credits: 64K-1 (16 bits in VAS_LRX_WCRED)
  *
  * TODO: Needs tuning for per-process credits
  */
-#define VAS_RX_WCREDS_MAX		((64 << 10) - 1)
 #define VAS_TX_WCREDS_MAX		((4 << 10) - 1)
 #define VAS_WCREDS_DEFAULT		(1 << 10)
 
-- 
1.8.3.1



