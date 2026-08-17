Return-Path: <linuxppc-dev+bounces-25911-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42768C5DF7D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 20:28:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hP4CX1tgsz2ygJ;
	Tue, 18 Aug 2026 06:28:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786998488;
	cv=none; b=izE+GvXIs7MffCpvgDrUutMcO40ncvb5TOXwBxZ4fs9TXsxed+pkIEfLdacLHDg1gB4dUCyeyIFeHaGB1Fz9v8lD9vBPfKs44WKA5RxtraUnJc3CyCK4q3mTnwsRy/IoTPbWNqZ+Dpax+YNdIDVCDGT2RMSKlUFATL0XRdMcXzNLflZq3uIP+jJyzAGAIByuW9Wb+92QllDV4HP8pWtH25gPDcN8UzNQNEngHfFxtgdydGh3iCgNiLXZvekgpG6Hj94K0rZuvPODJeJGChiuh3roNoD4zjOjV83EbEXp8wnMQZblAz/ZAXg9VORKeWYMDXzxi3PBF5n9oKKp+B/ugg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786998488; c=relaxed/relaxed;
	bh=LANh+zd5DCB5JRWwGG/WtM9i50Rrpqc4PJYu4yNy3vE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ltf/JXv8xy1bCP4gW/SwtW39H+mwAgJkuxXR1Ie0xByGDH2N5l1JhUMj/eyT7wKtwJ+5axSSK2ECKrnsIi95oVSqpZ6mWN023KdQ9CTTFYOME7qELijLdmXQahBmgsUkPdV2sGF+WW4XYxX11GfwIJJiUXI8Rrkl+7vveHCpG4vMWPGVPf17+wnR0zmRHnSRjfYLPWrUWCZ71h1zA7XPE+SRWIeKNAv9s1rb4xhUlm62cpBPz7j3MQEBQtOJJG6Qd/XKEITjVpveXX83J8NLb9YJyzmFiJb+ARmwk3xJxkVUPHP395/+p97fDG0k8IsYRYnhQhCThJtiy7+Rj2HM9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OvXUKDdc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OvXUKDdc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hP4CR5DQBz2yLG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 06:28:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D655743FD2;
	Mon, 17 Aug 2026 20:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9EBDC2BD04;
	Mon, 17 Aug 2026 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786998480;
	bh=npfH/SvYzT/0JdIG65b9lFjBjFK6IAPbJe3MeAJoVkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OvXUKDdc4IZdoFW+onc2JbE4lT9pHmqLKQhjBidbqcHMbfskxJYBXJWoKw1Lg+cgE
	 1zv9e0EjvIqXHaSLyAKL6CHryRfhHfmp7xPbrCtdkRBffgSroSp9Rjo+f/1I8Iv+EX
	 05y2I1/cCRTPuVNupUjhYkUHVWesZf+7HJnk21UEKX6h833/JQNNZhCbNZTxCYch+s
	 nqFIyc2PQ1gjZLwcn4K2TDPXEx6bvTuoWjGf+89Qo+ewtkt6UPf7Hw/GtMnnnd1ev4
	 2QIALx9svjgcTXihzBEe+36Iy45t1UpawsodiOVodro5IzQC9UBMBYk499UWHDd2ph
	 j1bB7/w1+4odw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AA9C5DF7E;
	Mon, 17 Aug 2026 20:28:00 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 17 Aug 2026 15:27:58 -0500
Subject: [PATCH v6 5/8] scsi: ibmvfc: add interrupt routine for
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
Message-Id: <20260817-ibmvfc-fpin-support-v6-5-62a2d525e70d@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786998478; l=2520;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=7/pOhL66oIfhC+c2Ky/GKig1QdGkJ5gXNjXvwPpOstQ=;
 b=UyyqRGb9DG8+vFzmNzkA2zxmpe1CTUHrMMk1sRPRTql3em5WjOKEfZNye/BW9tc1of7kawlnC
 SyKGiDhEPrzDFJk5OCJWQatUnB3llD2a4nZH1Pf2QIN0Ey54K7/oI3z
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

ibmvfc_drain_async_subq() holds both the host lock and the per-queue
q_lock while processing. It loops over available CRQ entries via
ibmvfc_next_scrq(), dispatching each to ibmvfc_handle_async() with
the async flag set, then clears the valid bit and issues a write
barrier. After draining, it re-enables the sub-CRQ IRQ and performs
one final check for a newly arrived entry to close the IRQ-enable
race; if one is found it is processed before exiting the loop.
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 37ee8f00322a..23c1a4cb40d9 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4337,6 +4337,52 @@ static struct ibmvfc_crq *ibmvfc_next_scrq(struct ibmvfc_queue *scrq)
 	return crq;
 }
 
+static void ibmvfc_drain_async_subq(struct ibmvfc_queue *scrq)
+{
+	struct ibmvfc_host *vhost = scrq->vhost;
+	struct ibmvfc_crq *crq;
+	unsigned long flags;
+	int done = 0;
+
+	spin_lock_irqsave(vhost->host->host_lock, flags);
+	spin_lock(scrq->q_lock);
+	while (!done) {
+		while ((crq = ibmvfc_next_scrq(scrq)) != NULL) {
+			ibmvfc_handle_async(crq, scrq->vhost, true);
+			crq->valid = 0;
+			wmb();	/* complete write */
+		}
+
+		ibmvfc_toggle_scrq_irq(scrq, 1);
+		crq = ibmvfc_next_scrq(scrq);
+		if (crq != NULL) {
+			ibmvfc_toggle_scrq_irq(scrq, 0);
+			ibmvfc_handle_async(crq, scrq->vhost, true);
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
+static irqreturn_t ibmvfc_interrupt_async_subq(int irq, void *scrq_instance)
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



