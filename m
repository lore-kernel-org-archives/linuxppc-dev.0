Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D2606A33C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCDk5Txo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCzDf54CHz2yYK;
	Tue, 27 Oct 2026 03:12:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793031170;
	cv=pass; b=h/CDoG9Hqf041ubRwaQiptCRtWXmY8TF8p/I7d0xMEmC7IhYI0gjh2E44w1RxTLgOOlcBLvgE5UPb5coT1e1J99Y4J89EFOUcQbEhRBU72c/dzjf/1emhzdLw65la90gpiblfJ70TVMMLBiGcVFThYfFMvoNvupTCpj2oXlZzNkDoGuhzvQsIAvgq2Ah4UwGPjYUv0JA1agJTyvrymrqeXXxuCkGklO5bqZvervV+FKYBCnnKivuQaro+9C4gJqaqqrnH4c+LDSICZJxBq09deaN4R/dgujqiNdzsKVjV4sRim3glNd0SBUHheTsAWfbMdfUgTkX2op7R0+V+z5Ufw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793031170; c=relaxed/relaxed;
	bh=ZvJXQfHEE7VvzG2+OpjGruH0r7tUMmjxlKPJBxc62Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cXxcxVTqDn9vb65LnvXkizfLRR0AC1+rBuZwOpY437XD7j+B6obZgZf4N4NWtDlxJEP4p/bBmRu+JiSRudM4t9TDhk3C9TAGmDJzQDLBTL8/ouV/5sCOvHCA/Zm+7WhlGoguC5wS5CKjtZ6Uf5mvwyo5eR65QM66JyLaALVy/z9d7Zoo3fxjLzvKUhWSunmvhxpZsfFHFmfGQUx8S8pJFbAoPa2Us0bpycFKUXpSrMaolaTO7QkB3g35xAKRZ42fbvCBwry9Ikb0mtlsZv8BuZwKbOakAeSHjkbGPg6VEFXI6FxYY5/1UM9pI4TB3QtJVE6Mt+2V8ym6Yn0pz7rl6w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCDk5Txo; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCDk5Txo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCzDW4Dhgz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 03:12:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 782F144205;
	Mon, 26 Oct 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793031160;
	b=xK1KBC8t8AD3cpl+rn0GdRX7S4Z7F5gyiEU4eCWvyMKee4RU79Du8blFfZTYrR4gwpG7
	 3uoB2+13BNqEQ0vezrXsbjnBrA4cg3bOCFx9gHsIUh1w6I/d82O9Jf3R0HoC+JlotQ1uA
	 HasS6oHHzOeSH+IyHM/nyRPTuIoD+tbCnrWXkhYQnEGEz7cAJ6RkKRSUx3EqVMCK+TU5V
	 THH5wFiR5t5IVXyoc7ywfOwFzAPJuXXa/JnD4anJuvn0352PXuOM2cXeV4CZyvHL9fBe/
	 5Jh7cRxWduzJRqREvcEnY9RjGUvjylwCXXwbpytyGqq2DQE+3tqcxWNrbmJTw2IewUQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031160;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZvJXQfHEE7VvzG2+OpjGruH0r7tUMmjxlKPJBxc62Pg=;
	b=RL3AfTe4et03oP/96bnNA29J/YuUpnaUF1fbr0CdSGyqk2XhBA5FZ1hb0kDiZvpxe71T
	 HDFJf1D1cAu1PCrL7cOluCVH1aojwkJmF7E9s+Ao/ZE4JblWhGcbYEhCPRakjGskXPJ+v
	 ievGzBGoBu9DlRST8NphsRQxJ74hDk+9UhevCFYrz5ZXg7p53ImlIkdeqSn7EW0IzlS6K
	 73lAsc8jPTemsgrEhnj4KTEanrAhn6vMNtKrqJ5HCjaQgDktlcOnd9ZASs0+nmgxQo7v4
	 +mpHaWZSjenp1BHea07G6YImkAzIxZF1vemzrLo/qpMmWMKZCzJF/L+ntz62tYrxvow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 220AD1F031E6;
	Mon, 26 Oct 2026 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793031160;
	bh=ZvJXQfHEE7VvzG2+OpjGruH0r7tUMmjxlKPJBxc62Pg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UCDk5TxoX6vRuBhqzNXon2R6ti5QmTD7J01e06+3Lpk2AoA3OGW8PEL5ca4bazGMK
	 rgaZoHOqdESZa3gUdwLiWn5D93tV3N8uQc1MVloxLRcynfoeTtuIKvbQPKHXkARa3c
	 +fPUn0IJUnJ3cvtq8kc4bpvlZh6aetB9TpX+f/AqSRWQ3L+3Pb+HK/6HMp4KuxOr1f
	 R1kWjZ6fFzAJmZUsbzYxwGy8VB7feXj9bLJREy3cujDxp7xXGd2eKlSvQPPJaXZ9W4
	 khOu/Anz4osoUKsFzD+hDlk/t6lUOdi3SOSKcGU9iE7/gceBxu+CsX58PWHMEB7v/S
	 AorF0p3WkVuTA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8AC0D44DA5;
	Mon, 26 Oct 2026 16:12:36 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 26 Oct 2026 11:12:41 -0500
Subject: [PATCH v16 09/12] scsi: ibmvfc: add interrupt routine for
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-ibmvfc-fpin-support-v16-9-a900aa657ed5@linux.ibm.com>
References: <20261026-ibmvfc-fpin-support-v16-0-a900aa657ed5@linux.ibm.com>
In-Reply-To: <20261026-ibmvfc-fpin-support-v16-0-a900aa657ed5@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793031155; l=3347;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=go7bhrtGZ2dJgmunhF9sAEtDO56741ZtmMW3WsNf3J4=;
 b=YeNEVXD2yEAzkSpchkqjQ4s4lwYyDDj+2Ae9TWYDelihqk7eOG4r1GLXkulazakgduJQAFM/v
 mucLVGPe36VBMu8ktQOMI7DvGbFzTl5I6aDGTPqrzvlVFSgXT30vsnt
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
index 64981a5a39fb..2cb38757333a 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4387,6 +4387,72 @@ static struct ibmvfc_crq *ibmvfc_next_scrq(struct ibmvfc_queue *scrq)
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



