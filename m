Return-Path: <linuxppc-dev+bounces-29560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26666CC6B3A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:07:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5BHz5618z2xtC;
	Fri, 16 Oct 2026 02:07:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792076831;
	cv=none; b=mQxUA3tttFBkTARC7NKMjGGzBMPGsEqDofPPXSgKtJAYDuV3Jm5jSBKstwKb5gFwOh1OwUC0d0h/w/NPw7vEnpN454D/JWUA4xt8d0A9nSxlhF20ZApgI0yDS+aYouu1i8SM55SQhAe2cCA+GzAGgQGqKnzg0Pl7lcxMlFQnkjtDQLHflkEPXnB4DUWMhI4NiUR19yQxnjV0fa4DsZH7vcHDV7qMy5ZH2maOWkThT3IPAs9EVkMQlJKJONkiRVSED+rDzoE74t/gvht+aczrWRGdkocSM1kcsPX0DomUIF6TPygVOL/J7yZKQJAynDw1APsDjrVZo6h3p5K20eMxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792076831; c=relaxed/relaxed;
	bh=RJJVAvyxwCiQTNLPbgQO0BRwHq37o+8e7BdWBHlIKxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5vKlm+tlIiVxSrWfLHWioU7dBQbRckA/KLUE3dISgMlbib3eMPSvW1BO2GSdtkF1sucu0GVB+65Nv79o7IK4IQex9vJF5vgzFaIjZ101lF20Eo3PlOqOBPJER70ir9/BmwWT3o6WSgMI6OaFGn2MYlIoU9icW+vKepzHJyEBPDra7reL64HCZ++blm3buxmNas+A93FADX3X95HzgYtlt2RpxyGYNgSdUwqnrweU2WX0MKgPqJCeIeWxZINNbdX7BJ01sOL1adVRpWS9wG4CMg3AXEQigvEJagPV3gIuSwaZm6k0HY3NbF4+K1qHL8YVrDtt51tqdPpjuCdpP0xFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MSrO596N; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MSrO596N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5BHs1ctvz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 02:07:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B93A94452F;
	Thu, 15 Oct 2026 15:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A412C4AF0B;
	Thu, 15 Oct 2026 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792076822;
	bh=ptbGTBMQjp/tBea46iPtMFcoLHn5jWZk6d7k9IGcZ8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MSrO596NsIG7JL/QMXM8t4TcjFSgrnB+3eBkX9LCP62Mu3CWXi/RGDmIjRIq5oq+m
	 5JBqG2WFHpH40IKmmX7a3B1yLSFTlEmDO7XdlJZ/s5ZXeBE6VfVzBlrAHmI0Kpk3Pi
	 /m0RWmpH+/N1NnBcYm09yJGYaHo3XSKptzMwLwZ8vxKgGmedAmygOs2DGH3Q3mLd7D
	 t9wEpNeTvvVUJIPGlNYms0QrtfwCNf743MC8q88UYYjQpIYEYz6WQ426uSUXrc9uKn
	 ZOCKp5s26vMPBG8j/al2Bsk+YJYUbCQu7E//5C8L3bP8KOOUMwp3sm3JvzmdP4pA8Y
	 JfmEWwVzeBctw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89076CC6B34;
	Thu, 15 Oct 2026 15:07:02 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 15 Oct 2026 10:07:04 -0500
Subject: [PATCH v14 05/11] scsi: ibmvfc: add NOOP command support
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
Message-Id: <20261015-ibmvfc-fpin-support-v14-5-a0b063b8d825@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792076820; l=4964;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=vnA8TM32RSDLRijz6T07CNbPtZpZ3/+HXqbwADXe+L4=;
 b=Cw6YHF6xRgFYF8QRpv9c5I526OI22aW6RsXf3U+OKqga/zIqn/cSF8cehOIXTstglCJp9HVY1
 aeOqQ09U0MFBvj1UUTogYb2TMk/jCVmf+bUU+aja4DNM+PJzA9fuPUr
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Add support for handling IBMVFC_NOOP format CRQ messages from the
VIOS partner.

Advertise the client's ability to handle NOOP commands by setting the
IBMVFC_CAN_USE_NOOP_CMD capability in ibmvfc_set_login_info().

Handle and ignore IBMVFC_NOOP format messages in both ibmvfc_handle_crq()
and ibmvfc_handle_scrq(). In both handlers, log a rate-limited error if a
NOOP is received while in the IBMVFC_ACTIVE state without the partner
having advertised IBMVFC_SUPPORT_NOOP_CMD.

In ibmvfc_handle_scrq(), also fix a typo ("Got and invalid" -> "Got an
invalid"), add a missing return on invalid message types, and guard
against null event pointers before processing CRQ responses.

Change ibmvfc_handle_scrq() to take a struct ibmvfc_queue *scrq
parameter instead of struct ibmvfc_host *vhost, deriving vhost from
scrq->vhost internally. Use &scrq->evt_pool for event validation instead
of &evt->queue->evt_pool, avoiding a potential wild pointer dereference
if crq->ioba contains a non-zero garbage token before ibmvfc_valid_event()
has a chance to validate it.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 871decab2985..9c710897cd54 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -1578,7 +1578,9 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 		login_info->flags |= cpu_to_be16(IBMVFC_CLIENT_MIGRATED);
 
 	login_info->max_cmds = cpu_to_be32(max_cmds);
-	login_info->capabilities = cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN);
+	login_info->capabilities =
+		cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN |
+			    IBMVFC_CAN_USE_NOOP_CMD);
 
 	if (vhost->mq_enabled || vhost->using_channels) {
 		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_CHANNELS);
@@ -3704,6 +3706,14 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
 	if (crq->format == IBMVFC_ASYNC_EVENT)
 		return;
 
+	if (crq->format == IBMVFC_NOOP) {
+		if (vhost->state == IBMVFC_ACTIVE &&
+		    !ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_NOOP_CMD))
+			dev_err_ratelimited(vhost->dev,
+					    "Received unexpected NOOP command from partner\n");
+		return;
+	}
+
 	/* The only kind of payload CRQs we should get are responses to
 	 * things we send. Make sure this response is to something we
 	 * actually sent
@@ -4223,9 +4233,10 @@ static int ibmvfc_toggle_scrq_irq(struct ibmvfc_queue *scrq, int enable)
 	return rc;
 }
 
-static void ibmvfc_handle_scrq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
+static void ibmvfc_handle_scrq(struct ibmvfc_crq *crq, struct ibmvfc_queue *scrq,
 			       struct list_head *evt_doneq)
 {
+	struct ibmvfc_host *vhost = scrq->vhost;
 	struct ibmvfc_event *evt = (struct ibmvfc_event *)be64_to_cpu(crq->ioba);
 
 	switch (crq->valid) {
@@ -4234,7 +4245,20 @@ static void ibmvfc_handle_scrq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost
 	case IBMVFC_CRQ_XPORT_EVENT:
 		return;
 	default:
-		dev_err(vhost->dev, "Got and invalid message type 0x%02x\n", crq->valid);
+		dev_err(vhost->dev, "Got an invalid message type 0x%02x\n", crq->valid);
+		return;
+	}
+
+	if (crq->format == IBMVFC_NOOP) {
+		if (vhost->state == IBMVFC_ACTIVE &&
+		    !ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_NOOP_CMD))
+			dev_err_ratelimited(vhost->dev,
+					    "Received unexpected NOOP command from partner\n");
+		return;
+	}
+
+	if (unlikely(!evt)) {
+		dev_err(vhost->dev, "Received null event\n");
 		return;
 	}
 
@@ -4242,7 +4266,7 @@ static void ibmvfc_handle_scrq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost
 	 * things we send. Make sure this response is to something we
 	 * actually sent
 	 */
-	if (unlikely(!ibmvfc_valid_event(&evt->queue->evt_pool, evt))) {
+	if (unlikely(!ibmvfc_valid_event(&scrq->evt_pool, evt))) {
 		dev_err(vhost->dev, "Returned correlation_token 0x%08llx is invalid!\n",
 			crq->ioba);
 		return;
@@ -4285,7 +4309,7 @@ static void ibmvfc_drain_sub_crq(struct ibmvfc_queue *scrq)
 	spin_lock_irqsave(scrq->q_lock, flags);
 	while (!done) {
 		while ((crq = ibmvfc_next_scrq(scrq)) != NULL) {
-			ibmvfc_handle_scrq(crq, scrq->vhost, &evt_doneq);
+			ibmvfc_handle_scrq(crq, scrq, &evt_doneq);
 			crq->valid = 0;
 			wmb();
 		}
@@ -4293,7 +4317,7 @@ static void ibmvfc_drain_sub_crq(struct ibmvfc_queue *scrq)
 		ibmvfc_toggle_scrq_irq(scrq, 1);
 		if ((crq = ibmvfc_next_scrq(scrq)) != NULL) {
 			ibmvfc_toggle_scrq_irq(scrq, 0);
-			ibmvfc_handle_scrq(crq, scrq->vhost, &evt_doneq);
+			ibmvfc_handle_scrq(crq, scrq, &evt_doneq);
 			crq->valid = 0;
 			wmb();
 		} else

-- 
2.56.0



