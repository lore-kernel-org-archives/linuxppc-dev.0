Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF86606A31D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b81BAOSq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7qd51xWGz3bf3;
	Tue, 20 Oct 2026 09:16:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.105.4.254 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792448169;
	cv=pass; b=jKrHrAtCdKj/G3lDL2t/41HNnbpwM9Vy+xEa1LPe6Y2P57HTT6MypqOlJmBgVa7qF6tUXP10udvkFgoV5JsGV2YY0SoErqK28u3G5scKM0giECG5/KvwD3mPnRIRfLLPzgkdjvwNIe1A2o22WytwjXW2JBcAKDjsqye6A6Z+S7cLxLWQaOaDK1YLN6RoqplLeR9rPaozo+ybBYHMpH9Zg296l+0bvd8d2hc42uVI+BN4bogKOJf7yHHtqk3oYHdkszJBgDfMUq/aD0kwhGM8bMK/GH8hqkxb+mCDkomZIVJ0VIYCPyuBqDYQSowJcDrzAZifYc/ZOY4oKxxnmUWxCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792448169; c=relaxed/relaxed;
	bh=dioFL/4r9MX0BGQOrD3/DZ65V0sRf5dyX2YGMfsMfec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E92ArL6eVZ/GTfzq419ylkfGfoZ2sQ9AyXLjAna0Jkh0M/VWbH6V9Cl8VIAboEISat3jL/TdA/ws2EzoYSvcu+s3A2bifQ2obo9kkICWQ42u+Hvc0xjQTZfAcYSk6s1GPtGF78ExzWDOyIE8ik7MJHtDPjZMuSsl4TXBxfYxI8bz8Bc/H8w96EP+hL/KXZ4ndUrgb2Ni17KAPtw76OqoVy0xNuctiF32klmTYcK1gE0FIqteHE0y+mz6sThNoI5DWkwXXpnBvOOBquH4ejd2dwOUavgPl2nYEQ0R/d8GHks2eMaP7Nc5Ra0t/iMudXU4hYQ7dZZ1jCEYDxd7Gt63Og==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b81BAOSq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b81BAOSq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7qcr5HCDz308Q
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 09:15:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A657B605EF;
	Mon, 19 Oct 2026 22:15:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792448154;
	b=RC7FFfqTEVpcsOpPG1lVtbxpLxvaamy05e+ut3Vg9dqHzgSClGvRz1Hk1SuLY3o81axc
	 w+slfFo7w79Km1t23Tg7MK/Tu45VsMZQMbnxduUEUtm5s81tYURrnAS7ecsGvrux8i3lS
	 HA+zZIyaGUyBk8lmcPAN1YjDU/YW3EBoLWLYMHK9lgujWv73VAvN9RX3MfMYLS8lWSvL8
	 e0P90T8z0CTJzepaiKkC6bkLDbrqKQkZgtqcmSPu6mP8Vxu52E136SFZ7sUc8RFoRMo+O
	 DxqmNtIHgOhYJJkeKj2AiCQrmoyAPmo6Q67oKV/0kU1CQj31y3bx30g8kYA1iuDUFuQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792448154;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dioFL/4r9MX0BGQOrD3/DZ65V0sRf5dyX2YGMfsMfec=;
	b=pqwWYo9Z8UZsRRebob6kKCkj68aSBUzJ7I92jvzqE25rQ+pVAHFrrfaTlo8Ov7lQZpvx
	 nHY3VmHkTZO5i6KceourNl7OlZurAKNXdkrhjszzm4tTtAgAxQsGLuZ9tMvC5G4lXhdSh
	 hsFqZ/MitShnh9u2rNKQCVUPWC8o2lrg7iHOr+pOVKregLT6OSRkJglTfPOoOylDnOCKv
	 ZC9NvLIrENoq2Sl+Wz5KhPA2gVa9cctWY3I+qhrB9rJiQt0AOClRVCrNgu3Nw18bzDi3l
	 djmqvasPNY3NOeEnFAIEkLv6RqFinimGA66REQRqqztHt9gZixjAFzouWWtE83eULzw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 76E691F000C8;
	Mon, 19 Oct 2026 22:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448154;
	bh=dioFL/4r9MX0BGQOrD3/DZ65V0sRf5dyX2YGMfsMfec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=b81BAOSq3gY8vpH9G03BYGjNNgkESwAsPHZI6NcdZPUv1Z0CyEhyH/DIfD4FBIQTX
	 9HhljhOVZd9vsZlXCCvOeVV+lW7+F56Chi+BYDvxQSXUcpeRvWmDy3dEx5atW5O1Rw
	 yv34lBvUgdfUUyvzk785QIiacuqVJV8y12seKWgd7QI1IHqu0Jzk60RO6feGynI14B
	 yfMtwyV/VfHs2Zeh9MQbX7eWd0AOyulC3rEBC3DMpVupPSuC9P0rfp2MBFE3Tz+pfI
	 rLq+EajH4hZJ4KwrTpNLLD/T6BDkL+nGDQrLI3qyTuFUgnQI3HVirYsBnxf9nXMea1
	 PlzqC/K9VrB3w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 414E140672;
	Mon, 19 Oct 2026 22:15:49 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 19 Oct 2026 17:15:52 -0500
Subject: [PATCH v15 07/11] scsi: ibmvfc: extend async event handlers for
 async sub-CRQ events
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261019-ibmvfc-fpin-support-v15-7-a858726e178a@linux.ibm.com>
References: <20261019-ibmvfc-fpin-support-v15-0-a858726e178a@linux.ibm.com>
In-Reply-To: <20261019-ibmvfc-fpin-support-v15-0-a858726e178a@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792448148; l=21092;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=qE3HsR/MdV2PLwRJpM3+WuM3oUJsUQwnxJeSn5E7ziw=;
 b=0FpvyMp4x9ujL/tkuxSrdm+Q6GW5EJnPBxo3niX444v5gI4UkNk/m5sfH3Rvm0EcLzeqAlHY+
 1yHyrIpgtjNB4uR1cTJbThndopVVL9P6QLK2zngdhjAR+gIIWWprhVY
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Marquardt <davemarq@linux.ibm.com>

Refactor async event handling to support both traditional async CRQs and
new asynchronous sub-queue CRQs.

Introduce struct ibmvfc_async_crq_event, a tagged union that wraps
either an ibmvfc_async_crq (main CRQ) or an ibmvfc_async_sub_crq
(async sub-CRQ), with an enum ibmvfc_async_crq_type discriminator.
Replace the ibmvfc_async_work bare union and is_subq bool with a
single event field of this type.

Modify ibmvfc_handle_async() to accept a struct ibmvfc_async_crq_event *
instead of a void * plus a bool flag. Update ibmvfc_process_async_work()
to dispatch based on event.type.

Add ibmvfc_full_fpin_to_desc() to convert full FPIN messages from async
sub-queue format to fc_els_fpin structures. Update FPIN processing logic
to extract WWPN, node_name, and scsi_id from the appropriate union member
based on event type.

Update KUnit tests to use ibmvfc_run_async_work() with a single reused
struct ibmvfc_async_crq_event rather than arrays at call sites.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c  | 161 +++++++++++++++++++++++++--------
 drivers/scsi/ibmvscsi/ibmvfc.h       |  15 ++-
 drivers/scsi/ibmvscsi/ibmvfc_kunit.c | 171 +++++++++++++++++++++++++++++++----
 3 files changed, 291 insertions(+), 56 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 6816b8f2ad9a..eeba6e6b3cae 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -3431,6 +3431,46 @@ ibmvfc_basic_fpin_to_desc(struct ibmvfc_async_crq *crq, u64 wwpn)
 					  cpu_to_be32(1));
 }
 
+/**
+ * ibmvfc_full_fpin_to_desc(): allocate and populate a struct fc_els_fpin struct
+ * containing a descriptor.
+ * @ibmvfc_fpin: Pointer to async subq FPIN data
+ * @wwpn:	attached port WWPN (host-endian)
+ *
+ * Allocate a struct fc_els_fpin containing a descriptor and populate
+ * based on data from *ibmvfc_fpin.
+ *
+ * Return:
+ * NULL     - unable to allocate structure
+ * non-NULL - pointer to populated struct fc_els_fpin
+ */
+static struct fc_els_fpin *
+ibmvfc_full_fpin_to_desc(struct ibmvfc_async_sub_crq *ibmvfc_fpin, u64 wwpn)
+{
+	__be16 type;
+
+	switch (ibmvfc_fpin->fpin_status) {
+	case IBMVFC_AE_FPIN_LINK_CONGESTED:
+	case IBMVFC_AE_FPIN_PORT_CONGESTED:
+		type = cpu_to_be16(FPIN_CONGN_DEVICE_SPEC);
+		break;
+	case IBMVFC_AE_FPIN_PORT_CLEARED:
+	case IBMVFC_AE_FPIN_CONGESTION_CLEARED:
+		type = cpu_to_be16(FPIN_CONGN_CLEAR);
+		break;
+	case IBMVFC_AE_FPIN_PORT_DEGRADED:
+		type = cpu_to_be16(FPIN_LI_UNKNOWN);
+		break;
+	default:
+		return NULL;
+	}
+
+	return ibmvfc_common_fpin_to_desc(ibmvfc_fpin->fpin_status, cpu_to_be64(wwpn),
+					  type, cpu_to_be16(0),
+					  cpu_to_be32(IBMVFC_FPIN_DEFAULT_EVENT_THRESHOLD),
+					  cpu_to_be32(1));
+}
+
 /**
  * ibmvfc_find_target - Search for a target in a target list
  * @target_list: list head of targets to search
@@ -3468,28 +3508,40 @@ static struct ibmvfc_target *ibmvfc_find_target(struct list_head *target_list,
  */
 VISIBLE_IF_KUNIT void ibmvfc_process_async_work(struct work_struct *work)
 {
+	struct ibmvfc_async_sub_crq *subq = NULL;
 	struct ibmvfc_async_work *aw;
-	struct ibmvfc_async_crq *crq;
+	struct ibmvfc_async_crq *crq = NULL;
 	struct ibmvfc_target *tgt;
 	struct ibmvfc_host *vhost;
-	struct fc_els_fpin *fpin;
+	struct fc_els_fpin *fpin = NULL;
 	unsigned long flags;
+	__be64 node_name;
+	__be64 scsi_id;
+	__be64 wwpn;
 
 	aw = container_of_const(work, struct ibmvfc_async_work, async_work_s);
 	vhost = aw->vhost;
-	crq = &aw->crq;
+	if (aw->event.type == IBMVFC_ASYNC_CRQ_SUB) {
+		subq = &aw->event.subq;
+		scsi_id = 0;
+		wwpn = subq->wwpn;
+		node_name = (subq->flags & IBMVFC_ASYNC_ID_IS_ASSOC_ID) ? 0 : subq->id.node_name;
+	} else {
+		crq = &aw->event.async_crq;
+		scsi_id = crq->scsi_id;
+		wwpn = crq->wwpn;
+		node_name = crq->node_name;
+	}
 
-	if (!crq->scsi_id && !crq->wwpn && !crq->node_name)
+	if (!scsi_id && !wwpn && !node_name)
 		goto free;
 
 	spin_lock_irqsave(&vhost->host->host_lock, flags);
-	tgt = ibmvfc_find_target(&vhost->scsi_scrqs.targets, crq->scsi_id,
-				 crq->wwpn, crq->node_name);
+	tgt = ibmvfc_find_target(&vhost->scsi_scrqs.targets, scsi_id, wwpn, node_name);
+
 	if (!tgt) {
 		/* Target not found in scsi_scrqs, search nvme_scrqs */
-		tgt = ibmvfc_find_target(&vhost->nvme_scrqs.targets,
-					 crq->scsi_id, crq->wwpn,
-					 crq->node_name);
+		tgt = ibmvfc_find_target(&vhost->nvme_scrqs.targets, scsi_id, wwpn, node_name);
 	}
 
 	if (tgt) {
@@ -3501,7 +3553,11 @@ VISIBLE_IF_KUNIT void ibmvfc_process_async_work(struct work_struct *work)
 		goto free;
 	}
 
-	fpin = ibmvfc_basic_fpin_to_desc(crq, tgt->wwpn);
+	if (crq)
+		fpin = ibmvfc_basic_fpin_to_desc(crq, tgt->wwpn);
+	else
+		fpin = ibmvfc_full_fpin_to_desc(subq, tgt->wwpn);
+
 	if (fpin) {
 		fc_host_fpin_rcv(tgt->vhost->host,
 				 sizeof(*fpin) + be32_to_cpu(fpin->desc_len),
@@ -3519,25 +3575,51 @@ EXPORT_SYMBOL_IF_KUNIT(ibmvfc_process_async_work);
 
 /**
  * ibmvfc_handle_async - Handle an async event from the adapter
- * @crq:	crq to process
+ * @ae:		tagged union wrapping either an ibmvfc_async_crq (main CRQ) or an
+ *		ibmvfc_async_sub_crq (async sub-CRQ); the type field identifies which
  * @vhost:	ibmvfc host struct
  *
  **/
-static void ibmvfc_handle_async(struct ibmvfc_async_crq *crq,
+static void ibmvfc_handle_async(struct ibmvfc_async_crq_event *ae,
 				struct ibmvfc_host *vhost)
 {
-	const struct ibmvfc_async_desc *desc = ibmvfc_get_ae_desc(be64_to_cpu(crq->event));
+	struct ibmvfc_async_crq *async_crq = NULL;
+	struct ibmvfc_async_sub_crq *subq = NULL;
+	const struct ibmvfc_async_desc *desc;
 	struct ibmvfc_async_work *aw;
 	struct ibmvfc_target *tgt;
-
-	ibmvfc_log(vhost, desc->log_level, "%s event received. scsi_id: %llx, wwpn: %llx,"
-		   " node_name: %llx%s\n", desc->desc, be64_to_cpu(crq->scsi_id),
-		   be64_to_cpu(crq->wwpn), be64_to_cpu(crq->node_name),
-		   ibmvfc_get_link_state(crq->link_state));
-
-	switch (be64_to_cpu(crq->event)) {
+	__be64 node_name;
+	__be64 scsi_id;
+	u8 link_state;
+	__be64 wwpn;
+	u64 event;
+
+	if (ae->type == IBMVFC_ASYNC_CRQ_SUB) {
+		subq = &ae->subq;
+		event = (u64)be16_to_cpu(subq->event);
+		link_state = subq->link_state;
+		scsi_id = 0;
+		wwpn = subq->wwpn;
+		node_name = subq->flags & IBMVFC_ASYNC_ID_IS_ASSOC_ID ? 0 : subq->id.node_name;
+	} else {
+		async_crq = &ae->async_crq;
+		event = be64_to_cpu(async_crq->event);
+		link_state = async_crq->link_state;
+		scsi_id = async_crq->scsi_id;
+		wwpn = async_crq->wwpn;
+		node_name = async_crq->node_name;
+	}
+
+	desc = ibmvfc_get_ae_desc(event);
+	ibmvfc_log(vhost, desc->log_level,
+		   "%s event received. scsi_id: %llx, wwpn: %llx, node_name: %llx, event %llx%s\n",
+		   desc->desc, be64_to_cpu(scsi_id),
+		   be64_to_cpu(wwpn), be64_to_cpu(node_name), event,
+		   ibmvfc_get_link_state(link_state));
+
+	switch (event) {
 	case IBMVFC_AE_RESUME:
-		switch (crq->link_state) {
+		switch (link_state) {
 		case IBMVFC_AE_LS_LINK_DOWN:
 			ibmvfc_link_down(vhost, IBMVFC_LINK_DOWN);
 			break;
@@ -3576,33 +3658,33 @@ static void ibmvfc_handle_async(struct ibmvfc_async_crq *crq,
 	case IBMVFC_AE_ELS_PRLO:
 	case IBMVFC_AE_ELS_PLOGI:
 		list_for_each_entry(tgt, &vhost->scsi_scrqs.targets, queue) {
-			if (!crq->scsi_id && !crq->wwpn && !crq->node_name)
+			if (!scsi_id && !wwpn && !node_name)
 				break;
-			if (crq->scsi_id && cpu_to_be64(tgt->scsi_id) != crq->scsi_id)
+			if (scsi_id && cpu_to_be64(tgt->scsi_id) != scsi_id)
 				continue;
-			if (crq->wwpn && cpu_to_be64(tgt->ids.port_name) != crq->wwpn)
+			if (wwpn && cpu_to_be64(tgt->ids.port_name) != wwpn)
 				continue;
-			if (crq->node_name && cpu_to_be64(tgt->ids.node_name) != crq->node_name)
+			if (node_name && cpu_to_be64(tgt->ids.node_name) != node_name)
 				continue;
-			if (tgt->need_login && be64_to_cpu(crq->event) == IBMVFC_AE_ELS_LOGO)
+			if (tgt->need_login && event == IBMVFC_AE_ELS_LOGO)
 				tgt->logo_rcvd = 1;
-			if (!tgt->need_login || be64_to_cpu(crq->event) == IBMVFC_AE_ELS_PLOGI) {
+			if (!tgt->need_login || event == IBMVFC_AE_ELS_PLOGI) {
 				ibmvfc_del_tgt(tgt);
 				ibmvfc_reinit_host(vhost);
 			}
 		}
 		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
-			if (!crq->scsi_id && !crq->wwpn && !crq->node_name)
+			if (!scsi_id && !wwpn && !node_name)
 				break;
-			if (crq->scsi_id && cpu_to_be64(tgt->scsi_id) != crq->scsi_id)
+			if (scsi_id && cpu_to_be64(tgt->scsi_id) != scsi_id)
 				continue;
-			if (crq->wwpn && cpu_to_be64(tgt->ids.port_name) != crq->wwpn)
+			if (wwpn && cpu_to_be64(tgt->ids.port_name) != wwpn)
 				continue;
-			if (crq->node_name && cpu_to_be64(tgt->ids.node_name) != crq->node_name)
+			if (node_name && cpu_to_be64(tgt->ids.node_name) != node_name)
 				continue;
-			if (tgt->need_login && be64_to_cpu(crq->event) == IBMVFC_AE_ELS_LOGO)
+			if (tgt->need_login && event == IBMVFC_AE_ELS_LOGO)
 				tgt->logo_rcvd = 1;
-			if (!tgt->need_login || be64_to_cpu(crq->event) == IBMVFC_AE_ELS_PLOGI) {
+			if (!tgt->need_login || event == IBMVFC_AE_ELS_PLOGI) {
 				ibmvfc_del_tgt(tgt);
 				ibmvfc_reinit_host(vhost);
 			}
@@ -3629,14 +3711,14 @@ static void ibmvfc_handle_async(struct ibmvfc_async_crq *crq,
 			}
 			INIT_WORK(&aw->async_work_s, ibmvfc_process_async_work);
 			aw->vhost = vhost;
-			aw->crq = *crq;
+			aw->event = *ae;
 			queue_work(vhost->fpin_workq, &aw->async_work_s);
 		} else
 			dev_err_ratelimited(vhost->dev,
 					    "can't offload async CRQ to work queue\n");
 		break;
 	default:
-		dev_err(vhost->dev, "Unknown async event received: %lld\n", crq->event);
+		dev_err(vhost->dev, "Unknown async event received: %llu\n", event);
 		break;
 	}
 }
@@ -4163,6 +4245,9 @@ static void ibmvfc_tasklet(void *data)
 {
 	struct ibmvfc_host *vhost = data;
 	struct vio_dev *vdev = to_vio_dev(vhost->dev);
+	struct ibmvfc_async_crq_event ae = {
+		.type = IBMVFC_ASYNC_CRQ_MAIN,
+	};
 	struct ibmvfc_crq *crq;
 	struct ibmvfc_async_crq *async;
 	struct ibmvfc_event *evt, *temp;
@@ -4175,7 +4260,8 @@ static void ibmvfc_tasklet(void *data)
 	while (!done) {
 		/* Pull all the valid messages off the async CRQ */
 		while ((async = ibmvfc_next_async_crq(vhost)) != NULL) {
-			ibmvfc_handle_async(async, vhost);
+			ae.async_crq = *async;
+			ibmvfc_handle_async(&ae, vhost);
 			async->valid = 0;
 			wmb();
 		}
@@ -4189,8 +4275,9 @@ static void ibmvfc_tasklet(void *data)
 
 		vio_enable_interrupts(vdev);
 		if ((async = ibmvfc_next_async_crq(vhost)) != NULL) {
+			ae.async_crq = *async;
 			vio_disable_interrupts(vdev);
-			ibmvfc_handle_async(async, vhost);
+			ibmvfc_handle_async(&ae, vhost);
 			async->valid = 0;
 			wmb();
 		} else if ((crq = ibmvfc_next_crq(vhost)) != NULL) {
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index 2ecd60138d58..86b600ec57c7 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -786,9 +786,22 @@ struct ibmvfc_async_sub_crq {
 	} id;
 } __packed __aligned(8);
 
+enum ibmvfc_async_crq_type {
+	IBMVFC_ASYNC_CRQ_MAIN = 0,
+	IBMVFC_ASYNC_CRQ_SUB,
+};
+
+struct ibmvfc_async_crq_event {
+	enum ibmvfc_async_crq_type type;
+	union {
+		struct ibmvfc_async_crq async_crq;
+		struct ibmvfc_async_sub_crq subq;
+	};
+};
+
 struct ibmvfc_async_work {
 	struct ibmvfc_host *vhost;
-	struct ibmvfc_async_crq crq;
+	struct ibmvfc_async_crq_event event;
 	struct work_struct async_work_s;
 };
 
diff --git a/drivers/scsi/ibmvscsi/ibmvfc_kunit.c b/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
index 8f261b8672b1..b867cfe3138d 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
@@ -3,7 +3,6 @@
 #include <kunit/visibility.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_transport_fc.h>
-#include <scsi/fc/fc_els.h>
 #include <linux/list.h>
 #include <linux/delay.h>
 #include "ibmvfc.h"
@@ -25,7 +24,7 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
  */
 static void ibmvfc_run_async_work(struct workqueue_struct *wq,
 				  struct ibmvfc_host *vhost,
-				  struct ibmvfc_async_crq *ae)
+				  struct ibmvfc_async_crq_event *ae)
 {
 	struct ibmvfc_async_work *aw;
 
@@ -38,7 +37,7 @@ static void ibmvfc_run_async_work(struct workqueue_struct *wq,
 	}
 	INIT_WORK(&aw->async_work_s, ibmvfc_process_async_work);
 	aw->vhost = vhost;
-	aw->crq = *ae;
+	aw->event = *ae;
 	queue_work(wq, &aw->async_work_s);
 	flush_workqueue(wq);
 }
@@ -58,7 +57,7 @@ static void ibmvfc_async_fpin_test(struct kunit *test)
 {
 	u64 post[IBMVFC_AE_FPIN_CONGESTION_CLEARED + 1];
 	u64 pre[IBMVFC_AE_FPIN_CONGESTION_CLEARED + 1];
-	struct ibmvfc_async_crq ae;
+	struct ibmvfc_async_crq_event ae = { .type = IBMVFC_ASYNC_CRQ_MAIN };
 	enum ibmvfc_ae_fpin_status fs;
 	struct workqueue_struct *wq;
 	struct fc_host_attrs *fc_host;
@@ -113,13 +112,13 @@ static void ibmvfc_async_fpin_test(struct kunit *test)
 	pre[IBMVFC_AE_FPIN_CONGESTION_CLEARED] = READ_ONCE(fc_host->fpin_stats.cn_clear);
 
 	for (fs = IBMVFC_AE_FPIN_LINK_CONGESTED; fs <= IBMVFC_AE_FPIN_CONGESTION_CLEARED; fs++) {
-		ae.valid = 0x80;
-		ae.link_state = IBMVFC_AE_LS_LINK_UP;
-		ae.fpin_status = fs;
-		ae.event = cpu_to_be64(IBMVFC_AE_FPIN);
-		ae.scsi_id = cpu_to_be64(tgt->scsi_id);
-		ae.wwpn = cpu_to_be64(tgt->wwpn);
-		ae.node_name = cpu_to_be64(tgt->ids.node_name);
+		ae.async_crq.valid = 0x80;
+		ae.async_crq.link_state = IBMVFC_AE_LS_LINK_UP;
+		ae.async_crq.fpin_status = fs;
+		ae.async_crq.event = cpu_to_be64(IBMVFC_AE_FPIN);
+		ae.async_crq.scsi_id = cpu_to_be64(tgt->scsi_id);
+		ae.async_crq.wwpn = cpu_to_be64(tgt->wwpn);
+		ae.async_crq.node_name = cpu_to_be64(tgt->ids.node_name);
 		ibmvfc_run_async_work(wq, vhost, &ae);
 	}
 
@@ -147,13 +146,13 @@ static void ibmvfc_async_fpin_test(struct kunit *test)
 	pre[IBMVFC_AE_FPIN_PORT_DEGRADED] = READ_ONCE(rport->fpin_stats.li_failure_unknown);
 	pre[IBMVFC_AE_FPIN_CONGESTION_CLEARED] = READ_ONCE(fc_host->fpin_stats.cn_clear);
 
-	ae.valid = 0x80;
-	ae.link_state = IBMVFC_AE_LS_LINK_UP;
-	ae.fpin_status = 0; /* bad value */
-	ae.event = cpu_to_be64(IBMVFC_AE_FPIN);
-	ae.scsi_id = cpu_to_be64(tgt->scsi_id);
-	ae.wwpn = cpu_to_be64(tgt->wwpn);
-	ae.node_name = cpu_to_be64(tgt->ids.node_name);
+	ae.async_crq.valid = 0x80;
+	ae.async_crq.link_state = IBMVFC_AE_LS_LINK_UP;
+	ae.async_crq.fpin_status = 0; /* bad value */
+	ae.async_crq.event = cpu_to_be64(IBMVFC_AE_FPIN);
+	ae.async_crq.scsi_id = cpu_to_be64(tgt->scsi_id);
+	ae.async_crq.wwpn = cpu_to_be64(tgt->wwpn);
+	ae.async_crq.node_name = cpu_to_be64(tgt->ids.node_name);
 	ibmvfc_run_async_work(wq, vhost, &ae);
 
 	post[IBMVFC_AE_FPIN_LINK_CONGESTED] = READ_ONCE(fc_host->fpin_stats.cn_device_specific);
@@ -230,8 +229,144 @@ static struct kunit_suite ibmvfc_channel_test_suite = {
 };
 kunit_test_init_section_suite(ibmvfc_channel_test_suite);
 
+
+/**
+ * ibmvfc_full_fpin_test - unit test for sub-CRQ FPIN handling via
+ * ibmvfc_process_async_work
+ * @test: pointer to kunit structure
+ *
+ * Tests
+ * - statistics updates on valid FPIN status values
+ * - statistics unchanged on invalid FPIN status value
+ *
+ * Return: void
+ */
+static void ibmvfc_full_fpin_test(struct kunit *test)
+{
+	u64 post[IBMVFC_AE_FPIN_CONGESTION_CLEARED + 1];
+	u64 pre[IBMVFC_AE_FPIN_CONGESTION_CLEARED + 1];
+	struct ibmvfc_async_crq_event ae = { .type = IBMVFC_ASYNC_CRQ_SUB };
+	enum ibmvfc_ae_fpin_status fs;
+	struct workqueue_struct *wq;
+	struct fc_host_attrs *fc_host;
+	struct ibmvfc_target *tgt;
+	struct ibmvfc_host *vhost;
+	struct fc_rport *rport;
+	unsigned long flags;
+
+	vhost = ibmvfc_get_first_vhost();
+	if (!vhost)
+		kunit_skip(test, "No ibmvfc devices available");
+
+	wq = alloc_ordered_workqueue("ibmvfc-kunit-fpin", 0);
+	if (!wq) {
+		scsi_host_put(vhost->host);
+		kunit_skip(test, "Failed to allocate workqueue");
+	}
+
+	spin_lock_irqsave(&vhost->host->host_lock, flags);
+	if (vhost->scsi_scrqs.num_targets < 1) {
+		spin_unlock_irqrestore(&vhost->host->host_lock, flags);
+		destroy_workqueue(wq);
+		scsi_host_put(vhost->host);
+		kunit_skip(test, "No targets");
+	}
+	tgt = NULL;
+	rport = NULL;
+	list_for_each_entry(tgt, &vhost->scsi_scrqs.targets, queue) {
+		if (tgt->rport &&
+		    tgt->rport->port_state == FC_PORTSTATE_ONLINE &&
+		    (tgt->rport->roles & (FC_PORT_ROLE_FCP_TARGET | FC_PORT_ROLE_NVME_TARGET))) {
+			rport = tgt->rport;
+			get_device(&rport->dev);
+			kref_get(&tgt->kref);
+			break;
+		}
+	}
+	if (!rport) {
+		spin_unlock_irqrestore(&vhost->host->host_lock, flags);
+		destroy_workqueue(wq);
+		scsi_host_put(vhost->host);
+		kunit_skip(test, "No suitable online target rport found");
+	}
+	spin_unlock_irqrestore(&vhost->host->host_lock, flags);
+
+	fc_host = shost_to_fc_host(vhost->host);
+
+	pre[IBMVFC_AE_FPIN_LINK_CONGESTED] = READ_ONCE(fc_host->fpin_stats.cn_device_specific);
+	pre[IBMVFC_AE_FPIN_PORT_CONGESTED] = READ_ONCE(rport->fpin_stats.cn_device_specific);
+	pre[IBMVFC_AE_FPIN_PORT_CLEARED] = READ_ONCE(rport->fpin_stats.cn_clear);
+	pre[IBMVFC_AE_FPIN_PORT_DEGRADED] = READ_ONCE(rport->fpin_stats.li_failure_unknown);
+	pre[IBMVFC_AE_FPIN_CONGESTION_CLEARED] = READ_ONCE(fc_host->fpin_stats.cn_clear);
+
+	for (fs = IBMVFC_AE_FPIN_LINK_CONGESTED; fs <= IBMVFC_AE_FPIN_CONGESTION_CLEARED; fs++) {
+		ae.subq.valid = 0x80;
+		ae.subq.link_state = IBMVFC_AE_LS_LINK_UP;
+		ae.subq.fpin_status = fs;
+		ae.subq.event = cpu_to_be16(IBMVFC_AE_FPIN);
+		ae.subq.wwpn = cpu_to_be64(tgt->wwpn);
+		ae.subq.id.node_name = cpu_to_be64(tgt->ids.node_name);
+		ibmvfc_run_async_work(wq, vhost, &ae);
+	}
+
+	post[IBMVFC_AE_FPIN_LINK_CONGESTED] = READ_ONCE(fc_host->fpin_stats.cn_device_specific);
+	post[IBMVFC_AE_FPIN_PORT_CONGESTED] = READ_ONCE(rport->fpin_stats.cn_device_specific);
+	post[IBMVFC_AE_FPIN_PORT_CLEARED] = READ_ONCE(rport->fpin_stats.cn_clear);
+	post[IBMVFC_AE_FPIN_PORT_DEGRADED] = READ_ONCE(rport->fpin_stats.li_failure_unknown);
+	post[IBMVFC_AE_FPIN_CONGESTION_CLEARED] = READ_ONCE(fc_host->fpin_stats.cn_clear);
+
+	KUNIT_EXPECT_GE(test, post[IBMVFC_AE_FPIN_LINK_CONGESTED],
+			pre[IBMVFC_AE_FPIN_LINK_CONGESTED]+1);
+	KUNIT_EXPECT_GE(test, post[IBMVFC_AE_FPIN_PORT_CONGESTED],
+			pre[IBMVFC_AE_FPIN_PORT_CONGESTED]+1);
+	KUNIT_EXPECT_GE(test, post[IBMVFC_AE_FPIN_PORT_CLEARED],
+			pre[IBMVFC_AE_FPIN_PORT_CLEARED]+1);
+	KUNIT_EXPECT_GE(test, post[IBMVFC_AE_FPIN_PORT_DEGRADED],
+			pre[IBMVFC_AE_FPIN_PORT_DEGRADED]+1);
+	KUNIT_EXPECT_GE(test, post[IBMVFC_AE_FPIN_CONGESTION_CLEARED],
+			pre[IBMVFC_AE_FPIN_CONGESTION_CLEARED]+1);
+
+	/* bad path */
+	pre[IBMVFC_AE_FPIN_LINK_CONGESTED] = READ_ONCE(fc_host->fpin_stats.cn_device_specific);
+	pre[IBMVFC_AE_FPIN_PORT_CONGESTED] = READ_ONCE(rport->fpin_stats.cn_device_specific);
+	pre[IBMVFC_AE_FPIN_PORT_CLEARED] = READ_ONCE(rport->fpin_stats.cn_clear);
+	pre[IBMVFC_AE_FPIN_PORT_DEGRADED] = READ_ONCE(rport->fpin_stats.li_failure_unknown);
+	pre[IBMVFC_AE_FPIN_CONGESTION_CLEARED] = READ_ONCE(fc_host->fpin_stats.cn_clear);
+
+	ae.subq.valid = 0x80;
+	ae.subq.link_state = IBMVFC_AE_LS_LINK_UP;
+	ae.subq.fpin_status = 0; /* bad value */
+	ae.subq.event = cpu_to_be16(IBMVFC_AE_FPIN);
+	ae.subq.wwpn = cpu_to_be64(tgt->wwpn);
+	ae.subq.id.node_name = cpu_to_be64(tgt->ids.node_name);
+	ibmvfc_run_async_work(wq, vhost, &ae);
+
+	post[IBMVFC_AE_FPIN_LINK_CONGESTED] = READ_ONCE(fc_host->fpin_stats.cn_device_specific);
+	post[IBMVFC_AE_FPIN_PORT_CONGESTED] = READ_ONCE(rport->fpin_stats.cn_device_specific);
+	post[IBMVFC_AE_FPIN_PORT_CLEARED] = READ_ONCE(rport->fpin_stats.cn_clear);
+	post[IBMVFC_AE_FPIN_PORT_DEGRADED] = READ_ONCE(rport->fpin_stats.li_failure_unknown);
+	post[IBMVFC_AE_FPIN_CONGESTION_CLEARED] = READ_ONCE(fc_host->fpin_stats.cn_clear);
+
+	KUNIT_EXPECT_EQ(test, pre[IBMVFC_AE_FPIN_LINK_CONGESTED],
+			post[IBMVFC_AE_FPIN_LINK_CONGESTED]);
+	KUNIT_EXPECT_EQ(test, pre[IBMVFC_AE_FPIN_PORT_CONGESTED],
+			post[IBMVFC_AE_FPIN_PORT_CONGESTED]);
+	KUNIT_EXPECT_EQ(test, pre[IBMVFC_AE_FPIN_PORT_CLEARED],
+			post[IBMVFC_AE_FPIN_PORT_CLEARED]);
+	KUNIT_EXPECT_EQ(test, pre[IBMVFC_AE_FPIN_PORT_DEGRADED],
+			post[IBMVFC_AE_FPIN_PORT_DEGRADED]);
+	KUNIT_EXPECT_EQ(test, pre[IBMVFC_AE_FPIN_CONGESTION_CLEARED],
+			post[IBMVFC_AE_FPIN_CONGESTION_CLEARED]);
+
+	destroy_workqueue(wq);
+	put_device(&rport->dev);
+	kref_put(&tgt->kref, ibmvfc_release_tgt);
+	scsi_host_put(vhost->host);
+}
+
 static struct kunit_case ibmvfc_fpin_test_cases[] = {
 	KUNIT_CASE(ibmvfc_async_fpin_test),
+	KUNIT_CASE(ibmvfc_full_fpin_test),
 	{},
 };
 

-- 
2.56.0



