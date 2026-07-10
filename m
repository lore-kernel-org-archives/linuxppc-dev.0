Return-Path: <linuxppc-dev+bounces-24021-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9632EC44506
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 19:17:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxhR12HGJz308k;
	Sat, 11 Jul 2026 05:17:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783711021;
	cv=none; b=Sp419T8Hob0FwAEMmoba+9j/mg4APe6osNPP6Zy3i4OqZxM+8bT4U1QPpedY9tQQhWox8CgCu7z7DUbZ1eSaceiWC/Z8ettI/mZFYVzV+KGBYwMm/MGW7jU2AlnXjXLHFMEavmGuSNWvW0f6BVlJF6aUwVloCI/LjZy9S7vWdkQjxUuGmgRdFvYgKlCyGnz3kkEz3cUVNe4DNvCr9pQotEkhypypbBmmBV5H/hdq1vD950NexgAk325PdGz482DePWs9HNVUmAcjQzza/2TGnPX5Hpn2UnP5cEW/gmb0mM4b/52DSuuqpV11haXPRRjkzemg27Kzj2uuHhQ46VCt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783711021; c=relaxed/relaxed;
	bh=I+a2CqRlehLIYgJyEKN8J42G4waMbmcwZbnuscfeTpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ccgGyo2wVY1Q9DajkN3IOL4jvJMDJrO5j+0WPvSLxs4Pz+g57fuBX95tpgwWhvegE5WQ71KrXrCiHx6tAPkGEgg4Ctc2Ux8McrMks7DlT8imm3GLZHAS3o8KaRsvkqsoMSJgImGOScjWQRRN9zwAYo4GrWGWHMHxzyv5Qy/AQVyOOSO2IyCN+yPPCN+Ow6pgxFZka/wlyTPRohQaSMvLNYg/2NWcb67ZwqTjtQKsjTQgFPw3Q0u4eAsGUZrhkz31cGZxbt/SiiYPiCFFLi/v3rdfXsmubrsN60wIChN/16Gs0MKo679xG2mfE6aNsURkxgKsXI/XYtcD1FY5sMlLgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sBYfisGu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sBYfisGu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxhQz5KKbz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 05:16:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EB88F4396F;
	Fri, 10 Jul 2026 19:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7DBFC2BCC6;
	Fri, 10 Jul 2026 19:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783711017;
	bh=1YE5g6HVPLyiV5N1mPToJqURBjxD0Z6Q7YYPMblTBB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sBYfisGuXYxCCia8kH2OyHdHw+sYozn/DyESr7ldlvwzIf0qlo9zHuSBvuHIKgXtn
	 sYfD9ZW0g0rmapUZIWXRuzCTilula5hWQibjAUIT3Ac1rKcwiDF+pKvPwPRixI097M
	 vaI//BR5X0LUdNUA5FA24PldkudfopfG3+74WR2Jm04sXyM+qxuJbRwyYeY4u4H+6h
	 wpAmYy5eEHfVR06c0DsI5FA7V9ku7Y4kTY9YsviY98A2SGUXZ8+Zh5QMkPATRiYX0O
	 wYejXPC1jGQdu8ZUHvRkMARSvaQ2lRMZEuBVET+BmxqYW0Vtg8SZkUJX2Fhwwno80T
	 FfDXZnRGXIAbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3AFC44506;
	Fri, 10 Jul 2026 19:16:57 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Fri, 10 Jul 2026 14:16:42 -0500
Subject: [PATCH v4 2/8] ibmvfc: Add NOOP command support
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
Message-Id: <20260710-ibmvfc-fpin-support-v4-2-ef031ac19520@linux.ibm.com>
References: <20260710-ibmvfc-fpin-support-v4-0-ef031ac19520@linux.ibm.com>
In-Reply-To: <20260710-ibmvfc-fpin-support-v4-0-ef031ac19520@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783711016; l=4233;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=5KXW4HiPzhI1ypiHMLbjy5Mv9KevT3p+ueI1qaFVPf4=;
 b=YUG4wqho5z8jkmX/DnPcnCNZuTF+R9Cv0kCY2Wj5Uc0N+NZ1y4XOJ7c7s5TWzfCNjflkJzccb
 q1P5nxU3U8GB3hDbMcoCQmyPADAspGvab3gBSbfoBat+n5gZ5X5BoE1
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
during NPIV login.

Set the IBMVFC_CAN_USE_NOOP_CMD capability bit during NPIV login to
inform VIOS that the client can handle NOOP commands.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 22 ++++++++++++++++++++--
 drivers/scsi/ibmvscsi/ibmvfc.h | 23 +++++++++++++----------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index d3fd1d3437c6..a7e3b7ee0683 100644
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
@@ -3569,6 +3571,14 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
 	if (crq->format == IBMVFC_ASYNC_EVENT)
 		return;
 
+	if (crq->format == IBMVFC_VFC_NOOP) {
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
@@ -4095,7 +4105,15 @@ static void ibmvfc_handle_scrq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost
 	case IBMVFC_CRQ_XPORT_EVENT:
 		return;
 	default:
-		dev_err(vhost->dev, "Got and invalid message type 0x%02x\n", crq->valid);
+		dev_err(vhost->dev, "Got an invalid message type 0x%02x\n", crq->valid);
+		return;
+	}
+
+	if (crq->format == IBMVFC_VFC_NOOP)
+		return;
+
+	if (unlikely(!evt)) {
+		dev_err(vhost->dev, "Received null event\n");
 		return;
 	}
 
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index f69e0605a78d..526632cb7237 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -175,11 +175,12 @@ struct ibmvfc_npiv_login {
 #define IBMVFC_FLUSH_ON_HALT		0x02
 	__be32 max_cmds;
 	__be64 capabilities;
-#define IBMVFC_CAN_MIGRATE		0x01
-#define IBMVFC_CAN_USE_CHANNELS		0x02
-#define IBMVFC_CAN_HANDLE_FPIN		0x04
-#define IBMVFC_CAN_USE_MAD_VERSION	0x08
-#define IBMVFC_CAN_SEND_VF_WWPN		0x10
+#define IBMVFC_CAN_MIGRATE		0x001
+#define IBMVFC_CAN_USE_CHANNELS		0x002
+#define IBMVFC_CAN_HANDLE_FPIN		0x004
+#define IBMVFC_CAN_USE_MAD_VERSION	0x008
+#define IBMVFC_CAN_SEND_VF_WWPN		0x010
+#define IBMVFC_CAN_USE_NOOP_CMD		0x200
 	__be64 node_name;
 	struct srp_direct_buf async;
 	u8 partition_name[IBMVFC_MAX_NAME];
@@ -221,11 +222,12 @@ struct ibmvfc_npiv_login_resp {
 #define IBMVFC_NATIVE_FC		0x01
 	__be32 reserved;
 	__be64 capabilities;
-#define IBMVFC_CAN_FLUSH_ON_HALT	0x08
-#define IBMVFC_CAN_SUPPRESS_ABTS	0x10
-#define IBMVFC_MAD_VERSION_CAP		0x20
-#define IBMVFC_HANDLE_VF_WWPN		0x40
-#define IBMVFC_CAN_SUPPORT_CHANNELS	0x80
+#define IBMVFC_CAN_FLUSH_ON_HALT	0x0008
+#define IBMVFC_CAN_SUPPRESS_ABTS	0x0010
+#define IBMVFC_MAD_VERSION_CAP		0x0020
+#define IBMVFC_HANDLE_VF_WWPN		0x0040
+#define IBMVFC_CAN_SUPPORT_CHANNELS	0x0080
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
2.55.0



