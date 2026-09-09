Return-Path: <linuxppc-dev+bounces-26991-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61034C79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 19:08:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg9LX3hBbz2yys;
	Thu, 10 Sep 2026 05:08:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788980884;
	cv=none; b=ftq9P8SCy9O0D7s2eK//8GElXYRMEY8np2gx2UlOThuRoAfcQrY5kC1ZvpTjvHvnHyvW7Rctoe4q2SDHaQAB43dBVZ8Sbneo3aDvnZ5hKGkaYwOrgsJPoLi3nYRq5QkBCTyXlglv/3j8ibfYbx0SKAk3nUqQG9tTL6rCNjTCla0/kOXkiu3LsYmqybAPyBTkEFnQene7egpfDIi3n6IDcV1jRKBn3yr+wSpt7VrJQhbWUrwHbNxQUzdlmbBdK7Z2p+9DzduZO4HzA8GWM2rrmuSA7aehGDjoxx+Qpr/3FRrG0EXQjbFWgQSEVSY6JI6ZGaOGzwirNHgFIitqi3Teug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788980884; c=relaxed/relaxed;
	bh=InN1mXyUh9imJhyB1YVClE9wvZxUXaV6wc5QP/TxMss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYvQ+LvusH9V4jEgzRx0gsex+78TFZibA/BE6wYTYoL3mxJ5+ZwDnKVXtdMTEkP5J/IowTKq3Nc9ayguN7LDQ1t/3WVdnaTY42f5IxhtDPhg95/Wy5tLRuHyAIAzRPTe2R955K2deKw0xsyfMteXFdRWHXcynfWcgQ+nn9aPH0TcS5jk7VwLnOUSPPZ0W7YL/tXPj1L+HiEyeIVugup9S6/wYDeEjv6bX3WTDizSqBZ7o+3wAuZfXdyVtvtqioI9lq4ipUnD79Ne+Q+WBKYUryW/KfEgetRCIl09Y7kSjHZcWLp+hey5pWa2SDRz4VUXq/NENYMx5RWXagjk1kAyXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A0w80BKo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A0w80BKo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg9LV64nxz2ywy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 05:08:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 71BD14478E;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4513CC2BD04;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788980880;
	bh=AWw3K6sjRvRkZJbz1oUCRvfpf+qyaEBlIZslgrmfYa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A0w80BKoEWKBhQ6SYt4zTByPvWAsdxE22LRQ1SrVSzhqsYfRdv0HK40FV3STLIQzP
	 d2FnZRMcVkdOTDKyjJBMCLkw/HT7LPxcSa9pG7Yx3FE5942aHGPdkoYPdRNjQZOpEc
	 eTuWkDbEVegjp6EAgqLzh74AOWJASMeYcKgvdH519uqnGM2qpy7jcNjCD5MiWTPVRD
	 cSLZ0bt0QQbwt23d8eYjweh++DFV8FLPPgOkvyps36D8opWFi45MaZgdVCW/3hHlkk
	 XfaOHDBfv98fbd47r0p6Us2w246gNrdsS7EhOe4bZNDOQ3aV/wDu/xYOassOpkVEYc
	 4Lww/9BkeQ7uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213ABC88E42;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 09 Sep 2026 14:08:01 -0500
Subject: [PATCH v8 6/9] scsi: ibmvfc: extend channel reg/dereg helpers for
 async sub-CRQ
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
Message-Id: <20260909-ibmvfc-fpin-support-v8-6-b27183b055af@linux.ibm.com>
References: <20260909-ibmvfc-fpin-support-v8-0-b27183b055af@linux.ibm.com>
In-Reply-To: <20260909-ibmvfc-fpin-support-v8-0-b27183b055af@linux.ibm.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>, 
 Greg Joyce <gjoyce@linux.ibm.com>, Kyle Mahlkuch <kmahlkuc@linux.ibm.com>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788980878; l=6716;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=4EjGhWprczcxjAPV5hsLUCQusZB4eMxBu/fLpWAUd7c=;
 b=ayTMmNji44X6EgOswxSTxkZjPJfzjRBTPNPr635O+yU29Q1RqK20mTcbdXN5/SKyakdL2eVlr
 IKWOYuQ3Su2DPwSSclvTtuZjr6LBdICPrDGSY/z/e7I6tLgpYrd7O5A
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

ibmvfc_register_channel() and ibmvfc_deregister_channel() previously only
handled indexed sub-CRQ channels drawn from the channels->scrqs[] array.
The async sub-CRQ (vhost->async_sub_crq) had no registration path through
these helpers, requiring separate handling.

Extend both functions to accept a negative index as a sentinel value
signalling that the async sub-CRQ should be operated on instead of an
indexed scrq entry. When index < 0, the queue pointer is set to
&vhost->async_sub_crq, the IRQ is named "ibmvfc-<addr>-async", and the
handler is set to ibmvfc_interrupt_async_subq rather than the per-protocol
ibmvfc_interrupt_mq handler. hwq_id assignment is skipped for the async
queue since it has no meaningful hardware queue index.

Stopped marking ibmvfc_interrupt_async_subq as __maybe_unused.

Error messages in both paths are updated to distinguish async sub-CRQ
failures from indexed sub-CRQ failures. Kernel-doc headers are added to
both functions documenting the negative-index convention.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 93 ++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 2e5f4c4c55e2..1c660edcf608 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4418,7 +4418,7 @@ static void ibmvfc_drain_async_subq(struct ibmvfc_queue *scrq)
  * @scrq_instance: async subq
  *
  **/
-static irqreturn_t __maybe_unused ibmvfc_interrupt_async_subq(int irq, void *scrq_instance)
+static irqreturn_t ibmvfc_interrupt_async_subq(int irq, void *scrq_instance)
 {
 	struct ibmvfc_queue *scrq = (struct ibmvfc_queue *)scrq_instance;
 
@@ -6808,13 +6808,29 @@ static int ibmvfc_init_crq(struct ibmvfc_host *vhost)
 	return retrc;
 }
 
+/**
+ * ibmvfc_register_channel - Register a sub-CRQ channel with the hypervisor
+ * @vhost:	ibmvfc host struct
+ * @channels:	ibmvfc channels struct containing the channel array and protocol
+ * @index:	index into the channels array for the queue to register, or
+ *		a negative value to register the async sub-CRQ
+ *
+ * Register a sub-CRQ with the hypervisor via h_reg_sub_crq, map its hardware
+ * IRQ to a Linux IRQ, and bind an interrupt handler to it. The handler is
+ * selected based on the channel protocol (SCSI or NVMe) for normal queues, or
+ * set to the async sub-CRQ handler when @index is negative.
+ *
+ * Return value:
+ *	0 on success / non-zero on failure
+ **/
 static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 				   struct ibmvfc_channels *channels,
 				   int index)
 {
 	struct device *dev = vhost->dev;
 	struct vio_dev *vdev = to_vio_dev(dev);
-	struct ibmvfc_queue *scrq = &channels->scrqs[index];
+	bool is_async = index < 0;
+	struct ibmvfc_queue *scrq = !is_async ? &channels->scrqs[index] : &vhost->async_sub_crq;
 	int rc = -ENOMEM;
 
 	ENTER;
@@ -6834,36 +6850,49 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 
 	if (!scrq->irq) {
 		rc = -EINVAL;
-		dev_err(dev, "Error mapping sub-crq[%d] irq\n", index);
+		if (!is_async)
+			dev_err(dev, "Error mapping sub-crq[%d] irq\n", index);
+		else
+			dev_err(dev, "Error mapping async sub-crq irq\n");
 		goto irq_failed;
 	}
 
-	switch (channels->protocol) {
-	case IBMVFC_PROTO_SCSI:
-		snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-scsi%d",
-			 vdev->unit_address, index);
-		scrq->handler = ibmvfc_interrupt_mq;
-		break;
-	case IBMVFC_PROTO_NVME:
-		snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-nvmf%d",
-			 vdev->unit_address, index);
-		scrq->handler = ibmvfc_interrupt_mq;
-		break;
-	default:
-		dev_err(dev, "Unknown channel protocol (%d)\n",
-			channels->protocol);
-		goto irq_failed;
+	if (!is_async) {
+		switch (channels->protocol) {
+		case IBMVFC_PROTO_SCSI:
+			snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-scsi%d",
+				 vdev->unit_address, index);
+			scrq->handler = ibmvfc_interrupt_mq;
+			break;
+		case IBMVFC_PROTO_NVME:
+			snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-nvmf%d",
+				 vdev->unit_address, index);
+			scrq->handler = ibmvfc_interrupt_mq;
+			break;
+		default:
+			dev_err(dev, "Unknown channel protocol (%d)\n",
+				channels->protocol);
+			goto irq_failed;
+		}
+	} else {
+		snprintf(scrq->name, sizeof(scrq->name), "ibmvfc-%x-async",
+			 vdev->unit_address);
+		scrq->handler = ibmvfc_interrupt_async_subq;
 	}
 
 	rc = request_irq(scrq->irq, scrq->handler, 0, scrq->name, scrq);
 
 	if (rc) {
-		dev_err(dev, "Couldn't register sub-crq[%d] irq\n", index);
+		if (!is_async)
+			dev_err(dev, "Couldn't register sub-crq[%d] irq\n", index);
+		else
+			dev_err(dev, "Couldn't register async sub-crq irq\n");
 		irq_dispose_mapping(scrq->irq);
 		goto irq_failed;
 	}
 
-	scrq->hwq_id = index;
+	if (!is_async)
+		scrq->hwq_id = index;
 
 	LEAVE;
 	return 0;
@@ -6877,13 +6906,26 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 	return rc;
 }
 
+/**
+ * ibmvfc_deregister_channel - Deregister a sub-CRQ channel with the hypervisor
+ * @vhost:	ibmvfc host struct
+ * @channels:	ibmvfc channels struct containing the sub-CRQ array
+ * @index:	index into the sub-CRQ array, or -1 to deregister the
+ *		asynchronous sub-CRQ
+ *
+ * Frees the IRQ, disposes of the IRQ mapping, and calls H_FREE_SUB_CRQ to
+ * release the sub-CRQ with the hypervisor. On success the queue message
+ * buffer is zeroed and the current index is reset. If H_FREE_SUB_CRQ fails,
+ * an error is logged but the channel resources are cleaned up regardless.
+ */
 static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 				      struct ibmvfc_channels *channels,
 				      int index)
 {
 	struct device *dev = vhost->dev;
 	struct vio_dev *vdev = to_vio_dev(dev);
-	struct ibmvfc_queue *scrq = &channels->scrqs[index];
+	bool is_async = index < 0;
+	struct ibmvfc_queue *scrq = !is_async ? &channels->scrqs[index] : &vhost->async_sub_crq;
 	long rc;
 
 	ENTER;
@@ -6897,8 +6939,13 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 					scrq->cookie);
 	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
 
-	if (rc)
-		dev_err(dev, "Failed to free sub-crq[%d]: rc=%ld\n", index, rc);
+	if (rc) {
+		if (!is_async)
+			dev_err(dev, "Failed to free sub-crq[%d]: rc=%ld\n",
+				index, rc);
+		else
+			dev_err(dev, "Failed to free async sub-crq: rc=%ld\n", rc);
+	}
 
 	/* Clean out the queue */
 	memset(scrq->msgs.crq, 0, PAGE_SIZE);

-- 
2.55.0



