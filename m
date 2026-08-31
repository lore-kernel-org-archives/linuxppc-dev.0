Return-Path: <linuxppc-dev+bounces-26326-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A183C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 19:00:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYdbq1MgQz2yhD;
	Tue, 01 Sep 2026 05:00:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788202823;
	cv=none; b=Q2OjSUxCLCTSPUad3UGJjRoy5FDSao7UqhHoCB7rVzcx2v7Ksk/1y/dy3GbXycm6MAcUCdNvxclTyGlVCVl5zY78k+oNzUIqxaZ8V3sQfvujRaeKcPTVo8rAwZ5LV062sXAeydacACPMEWvUgq7VWdsVnoYydCTj+fILITQ8kNVd3bHjL2rsZQBobaAeYg57dWQ6bZ3gnLdHxUGCLCtYP83NNjIw4kNjxY43HLVZrIUS90Sac+K/Qa/kiQHwkdqlhCykufplZmiFpjuSZ0S+YIOq4Mfb7XJyApoxbHyC/DNvL+/c7HHcRp5qISOZ6A+f3CQ/DMGjGFU1XKwTH+BGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788202823; c=relaxed/relaxed;
	bh=I1QOO7bNfwFkqcM/CdrZdKMBPpE9Gd8kT6iEN0FouFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mN4YxWwBwJ6hIjkEvwx203z8/+76AhJ1OHfAlwQgULdjSBgONz9bHrK9Xx1bg88Y+OlYkpVO7u5c4mnUsKBpi45FS0J7/vD9jOzvaJALaDrwEOtNw4yK6KrJ5aYk2+IvTPe09xF0zCDFPV2OppXsxQyAfHW0o45/M9ILoRDfTykHEZRcc5XeAiSPq2xW2IQ+1GHAwCY1uwO0U9pjjrCZBxL4DjSDW8QP2Y0nUADt8WJJ7iYBnvfttvYx6cDQfZBNhPML8Jr29PG2Pq9/Q81LZ0bt2PHWU5WbNh2IQcj7mXkQ9tir+WnjRkJXHqG4DzobDa3cXs5qosFIjMFjZQ3sEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b+Q2UdAL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b+Q2UdAL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYdbm61qnz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 05:00:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C8FB760218;
	Mon, 31 Aug 2026 19:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76819C4AF09;
	Mon, 31 Aug 2026 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788202817;
	bh=rjBmlQQTMG7h7d2b5mk9jOmECyYSFyRAc5cMyiPFXBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b+Q2UdALgQsDfkNTSjMjNMlI6axcqokp8Jynzt7Y3ul4bc0ubwHx3PlqSejTUqmWT
	 d0R4nKglu45htYQji+CniK0/ka2t1vVU/7h0Eqru/JSmqQr46tOnmTuUFgyEdPV2/j
	 NdDXplZzfedG2T4BMBIllSotpBsYlF2FlRaN1cFDRhnYjBUOvZl54ij/ajex3iRHQH
	 bYTckeiaQXQztyiDNe+IqmQjzveB0Rrhv4fWhG3Qj759BpS37lx7isfRTRFBcQ92hE
	 E4A3wfTCFk8teZNudVI43d2tpqtu/WLo+DV/EMN1HkGU4TBLx4EyzbNniXxsvv12/t
	 B3JUap/qRqi5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57360C61DFD;
	Mon, 31 Aug 2026 19:00:17 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 31 Aug 2026 14:00:14 -0500
Subject: [PATCH v7 2/8] scsi: ibmvfc: Add NOOP command support
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
Message-Id: <20260831-ibmvfc-fpin-support-v7-2-77d0b9809080@linux.ibm.com>
References: <20260831-ibmvfc-fpin-support-v7-0-77d0b9809080@linux.ibm.com>
In-Reply-To: <20260831-ibmvfc-fpin-support-v7-0-77d0b9809080@linux.ibm.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>, 
 "Martin K. Petersen" <mkp@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>, 
 Greg Joyce <gjoyce@linux.ibm.com>, Kyle Mahlkuch <kmahlkuc@linux.ibm.com>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788202815; l=2519;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=ZPYobFx4Tjmjv4+HMsDvOBnSXCtpmV13W5cWm9Aqs+k=;
 b=QhmopkvLCRSB87GEEqkFKKcdQ19roqMvftbaia9cA9eSUNEKQ5PJbfYNBlak1jIlBPZmmW1hr
 qSgI9yD0UunDT7qfO4ewn/esxZ5b2OoH9ouZJOps3mJaW963qSncfWa
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Add support for VFC_NOOP messages from VIOS to enable keep-alive
functionality between the client and server.

Define the VFC_NOOP CRQ format and add handling in both the main CRQ
handler (ibmvfc_handle_crq) and sub-CRQ handler (ibmvfc_handle_scrq).
Log unexpected NOOP messages if received before VIOS advertises support
during NPIV login. Also fix a typo in ibmvfc_handle_scrq.

Set the IBMVFC_CAN_USE_NOOP_CMD capability bit during NPIV login to
inform VIOS that the client can handle NOOP commands.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 78be00d31a06..e972e4ec5be0 100644
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
@@ -3693,6 +3695,14 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
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
@@ -4223,7 +4233,15 @@ static void ibmvfc_handle_scrq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost
 	case IBMVFC_CRQ_XPORT_EVENT:
 		return;
 	default:
-		dev_err(vhost->dev, "Got and invalid message type 0x%02x\n", crq->valid);
+		dev_err(vhost->dev, "Got an invalid message type 0x%02x\n", crq->valid);
+		return;
+	}
+
+	if (crq->format == IBMVFC_NOOP)
+		return;
+
+	if (unlikely(!evt)) {
+		dev_err(vhost->dev, "Received null event\n");
 		return;
 	}
 

-- 
2.55.0



