Return-Path: <linuxppc-dev+bounces-29561-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FE5CC6B3A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:07:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5BJ22YF7z2yrC;
	Fri, 16 Oct 2026 02:07:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792076832;
	cv=none; b=DUIF74HHpx9jcxCGJvQwKC16s66ld7Q/hZUdHCt/1bL3rfWmyMuuNmPyxptCDCTEmP9mOmvyTfl7nNaaadaOhDuEB2qBZTwvFnPzIlZUBnJAsAZwKjkg0G3Fah3nN003sIxTh8wBoJdwheJJkxGXxwZmf0PkNp1zyozKTibFfE6KWgaoJsTnu4pPeT28idIyiGy1abORL/jECtdzsCY/W4RQtPNYe6pYdJpUGwaGFy8s63z9hGcOCjTSjnuAKWD645eRZDI+n8fp2Owgk2yxpfNN5u8MXcoGHKJG/OSPbORP7+rwbQeK5wxsLCOepG71Kyjq1SmKqccOFSB/IoCH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792076832; c=relaxed/relaxed;
	bh=SWMnG+kuTc20vvv6+tEeyzoaduK00vTtwVS98vfgLVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CssVmvdWvoI25b+KrBWBGinliy4aqwSMNthTS6SEpA40GFdAZEX8ZO7uSma0buJqLwRfJbvI9P5HlBfNspkZMKKEDLVrAjHpNaZPTY1J/K6cIfIWvJCS61+PSOP55VQndLF1LOEUK5eWWSmGU3RFshcjXcQbUPNYxN7RXjEzUUiHYrIHWbQele4is+eABchH9VtS6cY5qlYDBzBnYjbcvD4R2k67RW/qzgDz3nzBsJ4GDgxsmnJUwKs1I3wqeXFMG59vYXFwpRFw7Ip97tcRFQesI8xm/yNg6h5MPjxnpjjfNYw10lXAJI6WDdmEFElVJbNQu7B0PE1ddfTsvmit/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gz2JSPBa; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gz2JSPBa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5BHv72jjz2xjh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 02:07:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0259540669;
	Thu, 15 Oct 2026 15:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB664C2BCFC;
	Thu, 15 Oct 2026 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792076822;
	bh=2stzQdrk1OfAJgcgnmub5f+HxAVvB1WokyV6OOHvnfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gz2JSPBauH8tEQB3sUz4TMCHw+h210Vj74anzcWFUa22M71bzjVylrUJlzGjoW+RJ
	 kYG7E69Rl2JKMonPe67jInKVq+oWrQCIr6ZxWfZwhEdlEpT1L9amiXUVgPgQEni/d8
	 /1A8rJUprHSQl0MmynxOYxLCpP0oHJSM+G5zBa6GI9nTI3vLFjeXkXI0T2XF/0kKdb
	 3OlE/Ohoghn++7GK0tj+HabffZ9atrb29LHLZsLYzHF3QY40Kq/oN4ptRlYo8Ljy5T
	 ypIHCm2zkQyjKjTYyk8++oGB66ujgzt2dTrloyNHl1kKVuBykyhMff8KHtYpcVf7FW
	 gLgmqd7pSAJSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9560CCA461;
	Thu, 15 Oct 2026 15:07:02 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 15 Oct 2026 10:07:07 -0500
Subject: [PATCH v14 08/11] scsi: ibmvfc: add interrupt routine for
 asynchronous sub CRQ
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
Message-Id: <20261015-ibmvfc-fpin-support-v14-8-a0b063b8d825@linux.ibm.com>
References: <20261015-ibmvfc-fpin-support-v14-0-a0b063b8d825@linux.ibm.com>
In-Reply-To: <20261015-ibmvfc-fpin-support-v14-0-a0b063b8d825@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792076821; l=3347;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=WNVoNGZBEz4/7wCFyOgiP6KjDxMl9VfXNGvmuFjPfuA=;
 b=RVgxExPBnhN4NFcKz905G9iS2IvA7GSOmYcuN2mFZGAzCUnONsoNf5/W1NfXsyEy/ww5xa0y3
 OhEj4e+b5x+Doa/eDy31XjjtSI5EjXOBtuxLIvrGPIC/ITS4Dpao3T0
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Add ibmvfc_interrupt_async_subq(), an IRQ handler dedicated to
asynchronous sub-CRQ events from the adapter. The handler disables
the sub-CRQ IRQ and then calls ibmvfc_drain_async_subq() to consume
all pending entries before re-enabling interrupts.

Add ibmvfc_next_async_scrq() to traverse the async sub-CRQ ring
directly via msgs.async_scrq[], returning a typed
struct ibmvfc_async_sub_crq * without the cast that would be needed
when going through ibmvfc_next_scrq().

ibmvfc_drain_async_subq() holds the host lock and per-queue q_lock
while processing. It loops over available entries via
ibmvfc_next_async_scrq(), wrapping each in a struct
ibmvfc_async_crq_event and dispatching to ibmvfc_handle_async(),
then clears the valid bit and issues a write barrier. After draining,
it re-enables the sub-CRQ IRQ and performs one final check for a
newly arrived entry to close the IRQ-enable race; if one is found it
is processed before exiting the loop.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 87ee19057551..fc69012efccc 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4385,6 +4385,72 @@ static struct ibmvfc_crq *ibmvfc_next_scrq(struct ibmvfc_queue *scrq)
 	return crq;
 }
 
+static struct ibmvfc_async_sub_crq *ibmvfc_next_async_scrq(struct ibmvfc_queue *scrq)
+{
+	struct ibmvfc_async_sub_crq *crq;
+
+	crq = &scrq->msgs.async_scrq[scrq->cur];
+	if (crq->valid & 0x80) {
+		if (++scrq->cur == scrq->size)
+			scrq->cur = 0;
+		rmb();
+	} else
+		crq = NULL;
+
+	return crq;
+}
+
+static void ibmvfc_drain_async_subq(struct ibmvfc_queue *scrq)
+{
+	struct ibmvfc_host *vhost = scrq->vhost;
+	struct ibmvfc_async_crq_event ae = {
+		.type = IBMVFC_ASYNC_CRQ_SUB,
+	};
+	struct ibmvfc_async_sub_crq *crq;
+	unsigned long flags;
+	int done = 0;
+
+	spin_lock_irqsave(&vhost->host->host_lock, flags);
+	spin_lock(scrq->q_lock);
+	while (!done) {
+		while ((crq = ibmvfc_next_async_scrq(scrq)) != NULL) {
+			ae.subq = *crq;
+			ibmvfc_handle_async(&ae, scrq->vhost);
+			crq->valid = 0;
+			wmb();	/* complete write */
+		}
+
+		ibmvfc_toggle_scrq_irq(scrq, 1);
+		crq = ibmvfc_next_async_scrq(scrq);
+		if (crq != NULL) {
+			ae.subq = *crq;
+			ibmvfc_toggle_scrq_irq(scrq, 0);
+			ibmvfc_handle_async(&ae, scrq->vhost);
+			crq->valid = 0;
+			wmb();	/* complete write */
+		} else
+			done = 1;
+	}
+	spin_unlock(scrq->q_lock);
+	spin_unlock_irqrestore(&vhost->host->host_lock, flags);
+}
+
+/**
+ * ibmvfc_interrupt_async_subq - Handle an async event from the adapter
+ * @irq:           interrupt request
+ * @scrq_instance: async subq
+ *
+ **/
+static irqreturn_t __maybe_unused ibmvfc_interrupt_async_subq(int irq, void *scrq_instance)
+{
+	struct ibmvfc_queue *scrq = (struct ibmvfc_queue *)scrq_instance;
+
+	ibmvfc_toggle_scrq_irq(scrq, 0);
+	ibmvfc_drain_async_subq(scrq);
+
+	return IRQ_HANDLED;
+}
+
 static void ibmvfc_drain_sub_crq(struct ibmvfc_queue *scrq)
 {
 	struct ibmvfc_crq *crq;

-- 
2.56.0



