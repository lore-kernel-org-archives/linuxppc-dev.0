Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471D7C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:02:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C438E206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C438E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YPsF5Jh6zDqJT
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 06:02:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.61.94; helo=7.mo179.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 486 seconds by postgrey-1.36 at bilbo;
 Tue, 08 Jan 2019 05:52:14 AEDT
Received: from 7.mo179.mail-out.ovh.net (7.mo179.mail-out.ovh.net
 [46.105.61.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YPdV6sjxzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 05:52:14 +1100 (AEDT)
Received: from player737.ha.ovh.net (unknown [10.109.143.225])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6F5B010EF4F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 19:44:04 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 4920B186630A;
 Mon,  7 Jan 2019 18:43:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 01/19] powerpc/xive: export flags for the XIVE native
 exploitation mode hcalls
Date: Mon,  7 Jan 2019 19:43:13 +0100
Message-Id: <20190107184331.8429-2-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11381722159073364951
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These flags are shared between Linux/KVM implementing the hypervisor
calls for the XIVE native exploitation mode and the driver for the
sPAPR guests.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/xive.h  | 23 +++++++++++++++++++++++
 arch/powerpc/sysdev/xive/spapr.c | 28 ++++++++--------------------
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 3c704f5dd3ae..32f033bfbf42 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -93,6 +93,29 @@ extern void xive_flush_interrupt(void);
 /* xmon hook */
 extern void xmon_xive_do_dump(int cpu);
 
+/*
+ * Hcall flags shared by the sPAPR backend and KVM
+ */
+
+/* H_INT_GET_SOURCE_INFO */
+#define XIVE_SPAPR_SRC_H_INT_ESB	PPC_BIT(60)
+#define XIVE_SPAPR_SRC_LSI		PPC_BIT(61)
+#define XIVE_SPAPR_SRC_TRIGGER		PPC_BIT(62)
+#define XIVE_SPAPR_SRC_STORE_EOI	PPC_BIT(63)
+
+/* H_INT_SET_SOURCE_CONFIG */
+#define XIVE_SPAPR_SRC_SET_EISN		PPC_BIT(62)
+#define XIVE_SPAPR_SRC_MASK		PPC_BIT(63) /* unused */
+
+/* H_INT_SET_QUEUE_CONFIG */
+#define XIVE_SPAPR_EQ_ALWAYS_NOTIFY	PPC_BIT(63)
+
+/* H_INT_SET_QUEUE_CONFIG */
+#define XIVE_SPAPR_EQ_DEBUG		PPC_BIT(63)
+
+/* H_INT_ESB */
+#define XIVE_SPAPR_ESB_STORE		PPC_BIT(63)
+
 /* APIs used by KVM */
 extern u32 xive_native_default_eq_shift(void);
 extern u32 xive_native_alloc_vp_block(u32 max_vcpus);
diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 575db3b06a6b..730284f838c8 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -184,9 +184,6 @@ static long plpar_int_get_source_info(unsigned long flags,
 	return 0;
 }
 
-#define XIVE_SRC_SET_EISN (1ull << (63 - 62))
-#define XIVE_SRC_MASK     (1ull << (63 - 63)) /* unused */
-
 static long plpar_int_set_source_config(unsigned long flags,
 					unsigned long lisn,
 					unsigned long target,
@@ -243,8 +240,6 @@ static long plpar_int_get_queue_info(unsigned long flags,
 	return 0;
 }
 
-#define XIVE_EQ_ALWAYS_NOTIFY (1ull << (63 - 63))
-
 static long plpar_int_set_queue_config(unsigned long flags,
 				       unsigned long target,
 				       unsigned long priority,
@@ -286,8 +281,6 @@ static long plpar_int_sync(unsigned long flags, unsigned long lisn)
 	return 0;
 }
 
-#define XIVE_ESB_FLAG_STORE (1ull << (63 - 63))
-
 static long plpar_int_esb(unsigned long flags,
 			  unsigned long lisn,
 			  unsigned long offset,
@@ -321,7 +314,7 @@ static u64 xive_spapr_esb_rw(u32 lisn, u32 offset, u64 data, bool write)
 	unsigned long read_data;
 	long rc;
 
-	rc = plpar_int_esb(write ? XIVE_ESB_FLAG_STORE : 0,
+	rc = plpar_int_esb(write ? XIVE_SPAPR_ESB_STORE : 0,
 			   lisn, offset, data, &read_data);
 	if (rc)
 		return -1;
@@ -329,11 +322,6 @@ static u64 xive_spapr_esb_rw(u32 lisn, u32 offset, u64 data, bool write)
 	return write ? 0 : read_data;
 }
 
-#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
-#define XIVE_SRC_LSI           (1ull << (63 - 61))
-#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
-#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
-
 static int xive_spapr_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
 {
 	long rc;
@@ -349,11 +337,11 @@ static int xive_spapr_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
 	if (rc)
 		return  -EINVAL;
 
-	if (flags & XIVE_SRC_H_INT_ESB)
+	if (flags & XIVE_SPAPR_SRC_H_INT_ESB)
 		data->flags  |= XIVE_IRQ_FLAG_H_INT_ESB;
-	if (flags & XIVE_SRC_STORE_EOI)
+	if (flags & XIVE_SPAPR_SRC_STORE_EOI)
 		data->flags  |= XIVE_IRQ_FLAG_STORE_EOI;
-	if (flags & XIVE_SRC_LSI)
+	if (flags & XIVE_SPAPR_SRC_LSI)
 		data->flags  |= XIVE_IRQ_FLAG_LSI;
 	data->eoi_page  = eoi_page;
 	data->esb_shift = esb_shift;
@@ -374,7 +362,7 @@ static int xive_spapr_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
 	data->hw_irq = hw_irq;
 
 	/* Full function page supports trigger */
-	if (flags & XIVE_SRC_TRIGGER) {
+	if (flags & XIVE_SPAPR_SRC_TRIGGER) {
 		data->trig_mmio = data->eoi_mmio;
 		return 0;
 	}
@@ -391,8 +379,8 @@ static int xive_spapr_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
 {
 	long rc;
 
-	rc = plpar_int_set_source_config(XIVE_SRC_SET_EISN, hw_irq, target,
-					 prio, sw_irq);
+	rc = plpar_int_set_source_config(XIVE_SPAPR_SRC_SET_EISN, hw_irq,
+					 target, prio, sw_irq);
 
 	return rc == 0 ? 0 : -ENXIO;
 }
@@ -432,7 +420,7 @@ static int xive_spapr_configure_queue(u32 target, struct xive_q *q, u8 prio,
 	q->eoi_phys = esn_page;
 
 	/* Default is to always notify */
-	flags = XIVE_EQ_ALWAYS_NOTIFY;
+	flags = XIVE_SPAPR_EQ_ALWAYS_NOTIFY;
 
 	/* Configure and enable the queue in HW */
 	rc = plpar_int_set_queue_config(flags, target, prio, qpage_phys, order);
-- 
2.20.1

