Return-Path: <linuxppc-dev+bounces-26994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C29C79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 19:08:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg9Ld0xyjz30Wb;
	Thu, 10 Sep 2026 05:08:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788980888;
	cv=none; b=WC/E6KZbPUltvJ8leorZtqhM5GGfDX78bHPOFzsndIie0IERo1wtLlD8b61jJLCLGk96BcrgKqa64pg2qS4dkE15trNipY2pc/ggr7cwWerSo8wYGFHdhWIO0sthGGgXzAOywuH//xWcPI7g8T+5/WrUzvT/dBQ27BUCneeyCZQKmFxOVYw6S1LU+OWCQ2AQMGapg8YjxtUD5dpmDBHbrUk7tfnolexOf4DR6lD6Yj32X7ClDvoxx+Em4Memy6r4YyOQG/5ZYtBEJgX+8WRo6rFrHaPHRMAiqz3K/xA1rpCRPDWfSZIsmjoGEsD/i/XwC8F5a5dWW3wtZOAGHUDv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788980888; c=relaxed/relaxed;
	bh=S6I3Bj2FQFAkfATUteMH1tOvrUzlzK7aI6SQap8VWP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0Qh+psLKO2SfeY6LG+EHG7XPbpXNQi6NhbVL0ktA3cCpz5pbW6iW3CtR0zcUklN6wWCZYvQmI9Gg3/RvlpHB62T8nGDBP5qQnwwSN4NTy6xp7Iixl1UILMYa7BxTZwc/ouBPP6+Z3zARW+902VfCDVqbNtqGrwR7cjnireDTTDJZSS65lVP3AcW3UL0sEyM2QEV6PLxKdR7BqHg6rwmMyWoALlbh5fQXKAfVoP+/o4PKae+aJ12IF79jdQfPzesy/qn+cDcsLjH/Tq+pLPlUv2SNScz0ZzTijvUWaU8zWJ2e/IObMf24FGy+goodsERSl0WAKGxZkXFEBDN9HM7Kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I8ClQwt2; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I8ClQwt2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg9LW42HHz2yxB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 05:08:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 874DC60200;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24D63C2BCFD;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788980880;
	bh=jcozd/dmw2hLGVzJVKwdhFg6OBg9XjpiexgWscaE9Ps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I8ClQwt2vM7fHGDE5lC/y3z0aq5qwDJJ8txxK2JzT3O666ihur7LF2l84h6VeveDU
	 DdqpLiddcW8rM9lIo/j9IGelb4Dxy8d0wNppYQteCy2S3KZySvPGv4sRzS5gSTepn2
	 svRP8XOFrbXgbEG+V5DiGSjELxm4a7EB9mdQesw0dyhbGJ1JAvqcVb0IGkVHfDZSGL
	 Apr21md7iXnoRNljLFZVNxY1LmjVU2IylWsd6BYBXFihS9Nkg+NpT4tCIn5qN0JU9h
	 0xrDL2nQtFs53YcXZjbEzZHq6Eqn0xUS9N2JMClSQAKCEfjhu6grqmgHCELTyF8N0Q
	 NT8IMa/mImuUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA78C79FB9;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 09 Sep 2026 14:08:00 -0500
Subject: [PATCH v8 5/9] scsi: ibmvfc: add interrupt routine for
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
Message-Id: <20260909-ibmvfc-fpin-support-v8-5-b27183b055af@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788980878; l=2943;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=tSZBA1TX2Ay4N3YekCkCjDMBwV4xcAORZV0DygkdGcI=;
 b=Eq65XXdRIHq7Hjn65JC4ZKyU50Mw/8wmOh0U044GQ8bqMgcamBbbRGk1lK/89nAMSjZHLefTB
 uKA35m8tmvqBqmzvSRhqfOK3vkZkElH/Uz6PWANXsIbflcj5dNmvjA/
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
all pending entries before re-enabling interrupts. The handler is
marked as __maybe_unused until a later patch when it is used.

ibmvfc_drain_async_subq() holds the per-queue q_lock while
processing. It loops over available CRQ entries via ibmvfc_next_scrq(),
wrapping each in a typed struct ibmvfc_async_crq_event and dispatching
it to ibmvfc_handle_async(), then clears the valid bit and issues a
write barrier. After draining, it re-enables the sub-CRQ IRQ and performs
one final check for a newly arrived entry to close the IRQ-enable race;
if one is found it is processed before exiting the loop.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 54 +++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 1126c86d08fa..2e5f4c4c55e2 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4374,6 +4374,60 @@ static struct ibmvfc_crq *ibmvfc_next_scrq(struct ibmvfc_queue *scrq)
 	return crq;
 }
 
+static void ibmvfc_drain_async_subq(struct ibmvfc_queue *scrq)
+{
+	struct ibmvfc_host *vhost = scrq->vhost;
+	unsigned long flags;
+	struct ibmvfc_crq *crq;
+	int done = 0;
+
+	spin_lock_irqsave(vhost->host->host_lock, flags);
+	spin_lock(scrq->q_lock);
+	while (!done) {
+		while ((crq = ibmvfc_next_scrq(scrq)) != NULL) {
+			struct ibmvfc_async_crq_event ae = {
+				.type = IBMVFC_ASYNC_CRQ_SUB,
+				.subq = *(struct ibmvfc_async_sub_crq *)crq,
+			};
+			ibmvfc_handle_async(&ae, scrq->vhost);
+			crq->valid = 0;
+			wmb();	/* complete write */
+		}
+
+		ibmvfc_toggle_scrq_irq(scrq, 1);
+		crq = ibmvfc_next_scrq(scrq);
+		if (crq != NULL) {
+			struct ibmvfc_async_crq_event ae = {
+				.type = IBMVFC_ASYNC_CRQ_SUB,
+				.subq = *(struct ibmvfc_async_sub_crq *)crq,
+			};
+			ibmvfc_toggle_scrq_irq(scrq, 0);
+			ibmvfc_handle_async(&ae, scrq->vhost);
+			crq->valid = 0;
+			wmb();	/* complete write */
+		} else
+			done = 1;
+	}
+	spin_unlock(scrq->q_lock);
+	spin_unlock_irqrestore(vhost->host->host_lock, flags);
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
2.55.0



