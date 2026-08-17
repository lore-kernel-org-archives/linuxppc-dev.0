Return-Path: <linuxppc-dev+bounces-25915-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BD5C5DF7D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 20:28:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hP4Cd1Px5z2yrP;
	Tue, 18 Aug 2026 06:28:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786998493;
	cv=none; b=VnfIsHapWSDfoBaNMIxPXsuOKISRNt7ryWAwI2fPiip/y35Lfe7LU4yfw6FuI8cIOEowOn7RsnUHqIW8kA5ujdC5kT6zsb4zolawrMD6+Ma1dEaCBOrUN6rTiZhm4Zkc7wVSqfC0hmMuLpyG07feU+MrRcSOyYFgKinjppJ0MSym5puQcNUUjlnPRmx0dtQzyK/8YIOhQzZQxgvC8Ov1A9WhyZ187HXX4OzXLwW21FWyhnp2+qS2KSQDXwaqKbShcMSO4JiQQDVw3mYB7m2+Da+dG4hX+7sb51O/COuM9GpIyITzvInGo0Mgzg8KnJqKFRj0LzYLRspB5nKEgIMxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786998493; c=relaxed/relaxed;
	bh=OPTx8nSYsK8u5mX5oRHK2E76F7v9vG6efXCPUyJbppM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7V/UJLXOPrpSFfrUrFLqT0v0d0dig1Vx6PA7Fgdc7RQxhckA9T+g8d3HZp3ldHOkSdfBFDkVhbpUiN4cVcn125vGLFkS+b1jj7Esxci1Mw+2KxAtr0E/vw/TXIdB2wphVCQ6qEWaTQqZJ+yNpQxucAg35mvbIB0A/5Ra5trrMaLZeE9UVur4NRyiZ2dmm3UdUVA4f5BECi7zXVqelTfu665d25KTYH3ZXp28mpSHZy3/jzd5F/Qt1obctbUQa5zK5yp2Hn58vIHdNCD0twXCXFmjOHT+GKLsYTQ1g5fp5ky+w6CgKab/wqkeLUGBgvzagcM/A/cDuh07Q5Hif72Dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OfK/peEs; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OfK/peEs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hP4CW3t4Lz2yf0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 06:28:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 220294401C;
	Mon, 17 Aug 2026 20:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02EC4C2BD00;
	Mon, 17 Aug 2026 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786998481;
	bh=amL52l/okHbYKiCDMsCPi5kgeo/yQt3zDter/qTs5oQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OfK/peEsDfqN8RN4wR1cQAXjmsv8sHDr6O/XYz/QVEHXnI2zF7B1dIbEyNnJ8qS3S
	 6rpwWqo+Gg/E8de/Kc7SJ7sfOY631CZj3fQCjtc6uWPT6FpZM6lUbSw/5wyx5I+CCS
	 jMfwCm7P4gPph5jL3/iVTkuf0Owu7kX9v13IRoB2Wkb7UNcEkAKVCuvoTdtJy0kuIO
	 bf7XR3kO3NVwJPuZPepmQW+RCWVQ9xf3+KDbV6/fYRGSWL8bnDAAzCaercB5KTOxKI
	 X3d9gS68yAP+CHErV2vdaxBvz/3OanHdD6wENyPAJQxHQJg/+ptXjaH69idhHcgiYR
	 Swf0loL/kEgGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E561EC5DF7F;
	Mon, 17 Aug 2026 20:28:00 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 17 Aug 2026 15:28:01 -0500
Subject: [PATCH v6 8/8] scsi: ibmvfc: handle extended FPIN events
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ibmvfc-fpin-support-v6-8-62a2d525e70d@linux.ibm.com>
References: <20260817-ibmvfc-fpin-support-v6-0-62a2d525e70d@linux.ibm.com>
In-Reply-To: <20260817-ibmvfc-fpin-support-v6-0-62a2d525e70d@linux.ibm.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>, 
 Greg Joyce <gjoyce@linux.ibm.com>, Kyle Mahlkuch <kmahlkuc@linux.ibm.com>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786998478; l=11267;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=wtV6dTnhWVvMmvGiELngpnyuuTDST/nEYZo8U676ADI=;
 b=qCLma0aWa0xnXBV46Nc5J63YruNDz2hnIGavBEGx3rmFD/VIeQ2u00EFAkKPFfhonYWXDw/2z
 AYQdyEjN/fQB915i2/hEeXE0D8GUZrH/ZkSFuqpeVQq/kLP490Jgg2O
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Implement support for extended FPIN messages received via the
asynchronous sub-queue, completing full FPIN functionality.

Extended FPIN messages provide more detailed information about fabric
events compared to basic FPIN messages, including specific event types,
modifiers, thresholds, and event counts.

Add ibmvfc_extended_fpin_to_desc() to convert extended FPIN messages from
async sub-queue format to fc_els_fpin structures with complete descriptor
information. Update ibmvfc_process_async_work() to handle extended FPIN
events from the async sub-queue.

Set IBMVFC_CAN_HANDLE_FPIN capability during login to inform VIOS that
the client can process extended FPIN messages.

Add comprehensive KUnit tests to validate extended FPIN event handling
and verify proper statistics updates for all FPIN event types.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c  |  53 ++++++++++++++++-
 drivers/scsi/ibmvscsi/ibmvfc.h       |  30 ++++++++++
 drivers/scsi/ibmvscsi/ibmvfc_kunit.c | 110 +++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 686142761863..5c711447ac6d 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -1571,6 +1571,7 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 		login_info->capabilities |= cpu_to_be64(IBMVFC_USE_ASYNC_SUBQ);
 		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_HANDLE_FPIN);
 		login_info->capabilities |= cpu_to_be64(IBMVFC_YES_SCSI);
+		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_HANDLE_FPIN_EXT);
 		if (vhost->nvme_enabled) {
 			login_info->capabilities |= cpu_to_be64(IBMVFC_YES_NVMEOF);
 			login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_WWPN_ALL);
@@ -3447,6 +3448,41 @@ ibmvfc_full_fpin_to_desc(struct ibmvfc_async_sub_crq *ibmvfc_fpin)
 					  cpu_to_be32(1));
 }
 
+/**
+ * ibmvfc_ext_fpin_to_desc(): allocate and populate a struct fc_els_fpin struct
+ * containing a descriptor.
+ * @ibmvfc_fpin: Pointer to async subq FPIN data
+ *
+ * Allocate a struct fc_els_fpin containing a descriptor and populate
+ * based on data from *ibmvfc_fpin.
+ *
+ * Return:
+ * NULL     - unable to allocate structure
+ * non-NULL - pointer to populated struct fc_els_fpin
+ */
+static struct fc_els_fpin *
+ibmvfc_ext_fpin_to_desc(struct ibmvfc_async_subq_fpin *ibmvfc_fpin)
+{
+	u8 flags = ibmvfc_fpin->fpin_data.flags;
+	__be32 threshold = cpu_to_be32(IBMVFC_FPIN_DEFAULT_EVENT_THRESHOLD);
+	__be16 modifier = 0;
+	__be32 count = cpu_to_be32(1);
+	__be16 type = 0;
+
+	if (flags & IBMVFC_FPIN_EVENT_TYPE_VALID)
+		type = ibmvfc_fpin->fpin_data.event_type;
+	if (flags & IBMVFC_FPIN_MODIFIER_VALID)
+		modifier = ibmvfc_fpin->fpin_data.event_type_modifier;
+	if (flags & IBMVFC_FPIN_THRESHOLD_VALID)
+		threshold = ibmvfc_fpin->fpin_data.event_threshold;
+	if (flags & IBMVFC_FPIN_EVENT_COUNT_VALID)
+		count = ibmvfc_fpin->fpin_data.event_data.event_count;
+
+	return ibmvfc_common_fpin_to_desc(ibmvfc_fpin->fpin_status,
+					  ibmvfc_fpin->wwpn, type,
+					  modifier, threshold, count);
+}
+
 /**
  * ibmvfc_find_target - Search for a target in a target list
  * @target_list: list head of targets to search
@@ -3485,6 +3521,7 @@ static struct ibmvfc_target *ibmvfc_find_target(struct list_head *target_list,
 static void ibmvfc_process_async_work(struct work_struct *work)
 {
 	struct ibmvfc_async_sub_crq *subq = NULL;
+	struct ibmvfc_async_subq_fpin *sqfpin;
 	struct ibmvfc_async_work *aw;
 	struct ibmvfc_async_crq *crq = NULL;
 	struct ibmvfc_target *tgt;
@@ -3532,8 +3569,20 @@ static void ibmvfc_process_async_work(struct work_struct *work)
 
 	if (crq)
 		fpin = ibmvfc_basic_fpin_to_desc(crq, tgt->wwpn);
-	else
-		fpin = ibmvfc_full_fpin_to_desc(subq);
+	else {
+		sqfpin = (struct ibmvfc_async_subq_fpin *)subq;
+		if ((subq->flags & IBMVFC_ASYNC_IS_FPIN_EXT) == 0) {
+			fpin = ibmvfc_full_fpin_to_desc(subq);
+		} else if (!(sqfpin->fpin_data.flags & IBMVFC_FPIN_EVENT_TYPE_VALID)) {
+			dev_err_ratelimited(vhost->dev,
+					    "Invalid extended FPIN event received\n");
+		} else if (!ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_FPIN_EXT)) {
+			dev_err_ratelimited(vhost->dev,
+					    "Unexpected extended FPIN event received\n");
+		} else {
+			fpin = ibmvfc_ext_fpin_to_desc(sqfpin);
+		}
+	}
 
 	if (fpin) {
 		fc_host_fpin_rcv(tgt->vhost->host,
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index 26a2be9354e9..e1b9884ea27e 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -210,6 +210,7 @@ struct ibmvfc_npiv_login {
 #define IBMVFC_CAN_USE_WWPN_ALL		0x080
 #define IBMVFC_USE_ASYNC_SUBQ		0x100
 #define IBMVFC_CAN_USE_NOOP_CMD		0x200
+#define IBMVFC_CAN_HANDLE_FPIN_EXT	0x800
 	__be64 node_name;
 	struct srp_direct_buf async;
 	u8 partition_name[IBMVFC_MAX_NAME];
@@ -261,6 +262,7 @@ struct ibmvfc_npiv_login_resp {
 #define IBMVFC_SUPPORT_WWPN_ALL		0x0400
 #define IBMVFC_ASYNC_SUBQ		0x0800
 #define IBMVFC_SUPPORT_NOOP_CMD		0x1000
+#define IBMVFC_SUPPORT_FPIN_EXT		0x2000
 	__be32 max_cmds;
 	__be32 scsi_id_sz;
 	__be64 max_dma_len;
@@ -786,6 +788,34 @@ struct ibmvfc_async_sub_crq {
 	} id;
 } __packed __aligned(8);
 
+struct ibmvfc_fpin_data {
+#define IBMVFC_FPIN_EVENT_TYPE_VALID	0x01
+#define IBMVFC_FPIN_MODIFIER_VALID	0x02
+#define IBMVFC_FPIN_THRESHOLD_VALID	0x04
+#define IBMVFC_FPIN_SEVERITY_VALID	0x08
+#define IBMVFC_FPIN_EVENT_COUNT_VALID	0x10
+	u8 flags;
+	u8 reserved[3];
+	__be16 event_type;
+	__be16 event_type_modifier;
+	__be32 event_threshold;
+	union {
+		u8 severity;
+		__be32 event_count;
+	} event_data;
+} __packed __aligned(8);
+
+struct ibmvfc_async_subq_fpin {
+	volatile u8 valid;
+	u8 flags;
+	u8 link_state;
+	u8 fpin_status;
+	__be16 event;
+	__be16 pad;
+	volatile __be64 wwpn;
+	struct ibmvfc_fpin_data fpin_data;
+} __packed __aligned(8);
+
 struct ibmvfc_async_work {
 	struct ibmvfc_host *vhost;
 	bool is_subq;
diff --git a/drivers/scsi/ibmvscsi/ibmvfc_kunit.c b/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
index 444e6e6e1c39..ce938b93ecb4 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
@@ -3,6 +3,7 @@
 #include <kunit/visibility.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_transport_fc.h>
+#include <scsi/fc/fc_els.h>
 #include <linux/list.h>
 #include <linux/delay.h>
 #include "ibmvfc.h"
@@ -225,9 +226,118 @@ static void ibmvfc_full_fpin_test(struct kunit *test)
 			post[IBMVFC_AE_FPIN_CONGESTION_CLEARED]);
 }
 
+#define IBMVFC_TEST_FPIN_EXT(fs, ev, stat, crq) {		\
+	crq.valid = 0x80;					\
+	crq.flags = IBMVFC_ASYNC_IS_FPIN_EXT;			\
+	crq.link_state = IBMVFC_AE_LS_LINK_UP;			\
+	crq.fpin_status = (fs);					\
+	crq.event = cpu_to_be16(IBMVFC_AE_FPIN);		\
+	crq.wwpn = cpu_to_be64(tgt->wwpn);			\
+	crq.fpin_data.flags = IBMVFC_FPIN_EVENT_TYPE_VALID;	\
+	crq.fpin_data.event_type = cpu_to_be16((ev));		\
+	pre = READ_ONCE(tgt->rport->fpin_stats.stat);		\
+	ibmvfc_handle_async((struct ibmvfc_crq *)&crq, vhost, true);	\
+	msleep(1U);							\
+	post = READ_ONCE(tgt->rport->fpin_stats.stat);		\
+}
+
+/**
+ * ibmvfc_extended_fpin_test - unit test for extended FPIN events
+ * @test: pointer to kunit structure
+ *
+ * Tests
+ *
+ * Return: void
+ */
+static void ibmvfc_extended_fpin_test(struct kunit *test)
+{
+	enum ibmvfc_ae_fpin_status fs;
+	struct ibmvfc_async_subq_fpin crq[IBMVFC_AE_FPIN_CONGESTION_CLEARED+1] = {};
+	struct ibmvfc_async_subq_fpin
+		crqcn[IBMVFC_AE_FPIN_PORT_CONGESTED][FPIN_CONGN_DEVICE_SPEC+1] = {};
+	struct ibmvfc_async_subq_fpin crqportdg[FPIN_LI_DEVICE_SPEC+1] = {};
+	struct ibmvfc_target *tgt;
+	struct ibmvfc_host *vhost;
+	struct list_head *headp;
+	LIST_HEAD(evt_doneq);
+	u64 pre, post;
+
+	headp = ibmvfc_get_headp();
+	KUNIT_ASSERT_FALSE_MSG(test, list_empty(headp), "No ibmvfc devices available\n");
+	vhost = list_first_entry(headp, struct ibmvfc_host, queue);
+	KUNIT_ASSERT_GE_MSG(test, vhost->scsi_scrqs.num_targets, 1, "No targets");
+
+	tgt = list_first_entry(&vhost->scsi_scrqs.targets, struct ibmvfc_target, queue);
+	KUNIT_ASSERT_NOT_NULL(test, tgt->rport);
+
+	for (fs = IBMVFC_AE_FPIN_LINK_CONGESTED; fs <= IBMVFC_AE_FPIN_CONGESTION_CLEARED; fs++) {
+		switch (fs) {
+		case IBMVFC_AE_FPIN_PORT_CLEARED:
+		case IBMVFC_AE_FPIN_CONGESTION_CLEARED:
+			crq[fs].valid = 0x80;
+			crq[fs].flags = IBMVFC_ASYNC_IS_FPIN_EXT;
+			crq[fs].link_state = IBMVFC_AE_LS_LINK_UP;
+			crq[fs].fpin_status = fs;
+			crq[fs].event = cpu_to_be16(IBMVFC_AE_FPIN);
+			crq[fs].wwpn = cpu_to_be64(tgt->wwpn);
+			crq[fs].fpin_data.flags = IBMVFC_FPIN_EVENT_TYPE_VALID;
+			crq[fs].fpin_data.event_type = cpu_to_be16(FPIN_CONGN_CLEAR);
+			pre = READ_ONCE(tgt->rport->fpin_stats.cn_clear);
+			ibmvfc_handle_async((struct ibmvfc_crq *)&crq[fs], vhost, true);
+			msleep(1U);
+			post = READ_ONCE(tgt->rport->fpin_stats.cn_clear);
+			break;
+		case IBMVFC_AE_FPIN_LINK_CONGESTED:
+		case IBMVFC_AE_FPIN_PORT_CONGESTED:
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_CONGN_CLEAR, cn_clear,
+					     crqcn[fs-1][FPIN_CONGN_CLEAR]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_CONGN_LOST_CREDIT,
+					     cn_lost_credit,
+					     crqcn[fs-1][FPIN_CONGN_LOST_CREDIT]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_CONGN_CREDIT_STALL,
+					     cn_credit_stall,
+					     crqcn[fs-1][FPIN_CONGN_CREDIT_STALL]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_CONGN_OVERSUBSCRIPTION,
+					     cn_oversubscription,
+					     crqcn[fs-1][FPIN_CONGN_OVERSUBSCRIPTION]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_CONGN_DEVICE_SPEC,
+					     cn_device_specific,
+					     crqcn[fs-1][FPIN_CONGN_DEVICE_SPEC]);
+			break;
+		case IBMVFC_AE_FPIN_PORT_DEGRADED:
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_LI_UNKNOWN,
+					     li_failure_unknown,
+					     crqportdg[FPIN_LI_UNKNOWN]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_LI_LINK_FAILURE,
+					     li_link_failure_count,
+					     crqportdg[FPIN_LI_LINK_FAILURE]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_LI_LOSS_OF_SYNC,
+					     li_loss_of_sync_count,
+					     crqportdg[FPIN_LI_LOSS_OF_SYNC]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_LI_LOSS_OF_SIG,
+					     li_loss_of_signals_count,
+					     crqportdg[FPIN_LI_LOSS_OF_SIG]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_LI_PRIM_SEQ_ERR,
+					     li_prim_seq_err_count,
+					     crqportdg[FPIN_LI_PRIM_SEQ_ERR]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_LI_INVALID_TX_WD,
+					     li_invalid_tx_word_count,
+					     crqportdg[FPIN_LI_INVALID_TX_WD]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_LI_INVALID_CRC,
+					     li_invalid_crc_count,
+					     crqportdg[FPIN_LI_INVALID_CRC]);
+			IBMVFC_TEST_FPIN_EXT(fs, FPIN_LI_DEVICE_SPEC,
+					     li_device_specific,
+					     crqportdg[FPIN_LI_DEVICE_SPEC]);
+			break;
+		}
+	}
+}
+
 static struct kunit_case ibmvfc_fpin_test_cases[] = {
 	KUNIT_CASE(ibmvfc_async_fpin_test),
 	KUNIT_CASE(ibmvfc_full_fpin_test),
+	KUNIT_CASE(ibmvfc_extended_fpin_test),
 	{},
 };
 

-- 
2.55.0



