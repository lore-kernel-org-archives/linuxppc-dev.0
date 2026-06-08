Return-Path: <linuxppc-dev+bounces-22285-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDCDCD6E79
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 18:30:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ0w95NdGz3bs2;
	Tue, 09 Jun 2026 04:30:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780943433;
	cv=none; b=kWHWbYhh3mlMtB9U6C/9lAAiArTTfXGfDdkbySs4PMRjOT/twAfdK6AZC173Y70kpMHwdPyQCUThKmQoZlH8+BhYD/k80IJsCSGnI2vU2D1KvVUzExUdB7cJzAH0W/z2NxaFs5agojDquCxuc4L9ECyA4MQ4JX8adyRr8Yy/Wn1Xrxhry6F3i4oFn9KZwTdedlpOBu3AZ7mlKs9fu8NekLttUZuwQSaW78+zE0eaMJ8FpXnYymYCkjkQL7jQUkhfBInU3tn4gi1JN8NpAhBmA2WXWif50yHe9sC5ogxgz+dOfbUK/02LqKwqfForJBfu5JnXJ5fGKomHfVs1B7ljDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780943433; c=relaxed/relaxed;
	bh=ph6w1MF78MYSYUR4r8zpoOk+daJPBA0g9zWAR1KRdNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/OXmXKMQqdg+5cKxrGI9QQ2QoGHRWywM8XnqyBidCY7+ELhtJOShkGWH6dhsQ/c93u86+Tnwwc/2Bl5gH66ljpbmiYM5Znd6Nl/1RPRzs1hoXHESeWsddCCq3hkGNkqnm26zG2Wjy0uB3hbdO4KjXovEXauiFgLMqYp/7BucFIk87aud8Sd4Os7aGdckmGR2M9ACN0nv7Wb/4FAcFtWVT7dat0zPL7zfJ11VH44V+lMBGMQSmQ+zNnWk1usx1cRKuYOwQIH+EtWpxB2/RIwB/d4YxtAFybv3tMklTF4i9v0SDcaDmNAdvuKMLdPVxNfdrJO1YiVrQDPrdoLV+KKLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jkT/QsPt; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jkT/QsPt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ0w41v9Pz2yv2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 04:30:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 176B6601E2;
	Mon,  8 Jun 2026 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B22DEC4AF0F;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780943424;
	bh=syQ2Gyfc9rjR++Qbi/B4XF6b6fWOAKQxLqM1f57Ohlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jkT/QsPt64fc0GVg3HR+FVFRCf3Jm/T+AlX3p7nnpGtRnkabla6vYZsA65iuzIzu1
	 wmjySUNAMQjNXaW5Ju9+CPIwoGBO8+pyBCuSwXLjS01xSsb7/6moGIm6R8k/FhQUYs
	 9kgRxz6JGR9TIsUZ0cQ2WO8jVfj10Tm9NDXRESt8bDxYXr2ZiKUUWyuesv0356Q9qs
	 11en16v+KFndvm6d+rE5O04SPZ5JbCaGIJvtKciAtOrWf0LiK30ewSTwM22LxoxKl8
	 pAgSt8Q5coIbdart0BLfRX2t9DqW4QzSiGAvPY+qUPoGBE61vyR8MKuqZLvozKTNml
	 ZHO6UoUrLigUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A296BCD8CA7;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 08 Jun 2026 13:30:17 -0500
Subject: [PATCH v2 2/7] ibmvfc: Add NOOP command support
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
Message-Id: <20260608-ibmvfc-fpin-support-v2-2-d41f540fba5c@linux.ibm.com>
References: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
In-Reply-To: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780943423; l=2828;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=Yeji3bKeI5rUvEPYFGrDZIoKZAiKRNWAIVzz/y+TjH0=;
 b=VISqN10F2dbrQ3+yRvqjDLLI5tfZWHem+gzHw4ZulDCgFQqdO7n8bKyUJjNaJT/w2R0JwFRuZ
 zMo+gv4n7MCDyDj7KGi9yUX0Rp4cpQcXwOux1E1k70ri4LDTb6+kP0z
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

This patch adds support for receiving and recognizing VFC_NOOP
messages from VIOS. This is done by
- defining the VFC_NOOP CRQ format
- recognizing the VFC_NOOP CRQ format in the CRQ handler. If the VIOS
  has not provided the "support VFC_NOOP" bit in its capabilities on
  NPIV login, note that the VFC_NOOP is unexpected
- setting the "can use VFC_NOOP" bit in the capabilities sent during
  NPIV login
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 11 ++++++++++-
 drivers/scsi/ibmvscsi/ibmvfc.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 9e5f0c0f0369..88386d7c9106 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1512,7 +1512,9 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 		login_info->flags |= cpu_to_be16(IBMVFC_CLIENT_MIGRATED);
 
 	login_info->max_cmds = cpu_to_be32(max_cmds);
-	login_info->capabilities = cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN);
+	login_info->capabilities =
+		cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN |
+			    IBMVFC_CAN_USE_NOOP_CMD);
 
 	if (vhost->mq_enabled || vhost->using_channels)
 		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_CHANNELS);
@@ -3555,6 +3557,13 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
 	if (crq->format == IBMVFC_ASYNC_EVENT)
 		return;
 
+	if (crq->format == IBMVFC_VFC_NOOP) {
+		if (!ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_NOOP_CMD))
+			dev_err_ratelimited(vhost->dev,
+					    "Received unexpected NOOP command from partner\n");
+		return;
+	}
+
 	/* The only kind of payload CRQs we should get are responses to
 	 * things we send. Make sure this response is to something we
 	 * actually sent
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index 8eb1493cbac8..dd26248cac3e 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -180,6 +180,7 @@ struct ibmvfc_npiv_login {
 #define IBMVFC_CAN_HANDLE_FPIN		0x04
 #define IBMVFC_CAN_USE_MAD_VERSION	0x08
 #define IBMVFC_CAN_SEND_VF_WWPN		0x10
+#define IBMVFC_CAN_USE_NOOP_CMD		0x200
 	__be64 node_name;
 	struct srp_direct_buf async;
 	u8 partition_name[IBMVFC_MAX_NAME];
@@ -226,6 +227,7 @@ struct ibmvfc_npiv_login_resp {
 #define IBMVFC_MAD_VERSION_CAP		0x20
 #define IBMVFC_HANDLE_VF_WWPN		0x40
 #define IBMVFC_CAN_SUPPORT_CHANNELS	0x80
+#define IBMVFC_SUPPORT_NOOP_CMD		0x1000
 	__be32 max_cmds;
 	__be32 scsi_id_sz;
 	__be64 max_dma_len;
@@ -621,6 +623,7 @@ struct ibmvfc_trace_entry {
 enum ibmvfc_crq_formats {
 	IBMVFC_CMD_FORMAT		= 0x01,
 	IBMVFC_ASYNC_EVENT	= 0x02,
+	IBMVFC_VFC_NOOP		= 0x03,
 	IBMVFC_MAD_FORMAT		= 0x04,
 };
 

-- 
2.54.0



