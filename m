Return-Path: <linuxppc-dev+bounces-24020-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0720BC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 19:17:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxhR11lFFz308f;
	Sat, 11 Jul 2026 05:17:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783711021;
	cv=none; b=C4AjPvL6QsFUG2/INwSj6nljQidQBs2jIsTKxxbC3UV0qA3SzZibyWUijeQh7878xuRrwWHFOeknNFuHv9mQtGaB4wJz3uKWl8rCVlJ5zsRTlw7i5ZxGyik+BouRChkJvWgdj2ClN5VMjyyo1pCpIBgl7if9Re9h11Bv0G8ofV62vwtl7kb1/l8Tu3JKXBt9j0vm9Ay7Ien7UDfE3dUg7I74fJyTo8jv7kJD6WxO1YmQu11MXawd3nmVXIX0c82EqFlWWMu6dTz5Q3eIqHoMm+U2HT6c/Uxx08djrkna2HZv8gGKPipfc9Ja5phHtZwgBSv71Ru4bC1TqIA4ICfI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783711021; c=relaxed/relaxed;
	bh=MP3dQ5k/ujGZS+e7t+X/1dlYFWwsh2WKcqWAiZ7yUvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWecxtPFp2xUtAhYw+zWPW0Znr13ROkMLYoIq2XJMQIYdUNHZr7ocL9AtvVpPkoESBo9wYvG1pqbIzKsLAvU3jM9Cjg+p7kJBDULDZELK0zzlCDhZiimibDIBBpnMCrFlvKweLtocxjAbP6OkUzjaM4hS2hRFd0+2RNbJVKtTuJnUxE2U0bpJzRI6KiCV3U0wWkDRQx3ovbDpqyGj4lFKmT+36XaB7+lFYg0N5fIjcIUNjWfI7Ozm1bV8OxQ5WXWMq9ALVzJQLuyJJcT2pw2G6qByrgUIrLOPmplSd1DbGKZVWoRRCNETibfm1OljMmb6HVPpEwo1qksaQ/672WcCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ojNnmYvd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ojNnmYvd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxhQz63cyz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 05:16:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0BD9B43C41;
	Fri, 10 Jul 2026 19:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF554C2BCF6;
	Fri, 10 Jul 2026 19:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783711017;
	bh=VRmoMzw5cFwFEWPHaHM9b3BnH1I17iu1gzzZ2adcQcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ojNnmYvd5g5c6dW4iSlI8QgwPP6I73IEkLShM9tdqJF/K5XsxFH0sz0AdHTZ37ZYI
	 XnOcQuESj9+dRmc1N7FhP3D4gEl17U3HgGL7X/xWnGQDnEICkstcJwJpF+VyZMNpBb
	 W3KjiUbAYVIry/0k5oc/yPous+2HX83aeLUcVLISQr1v0Yo8GKWV+crj4ocv8bN515
	 i0FQlcy9I07YJNta9MjQCQAW9dW2n2Ixn51ABVcwNXCYD32tNMRAqJkrZGdkuHqvNj
	 L5iXibtibPHQYKZ4L9rMVUYudEHUdDkHVbPJQsFmh/oDaf+vzy25Z1lzapXsSXKGk5
	 me9TlQj3bVf5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6096C44507;
	Fri, 10 Jul 2026 19:16:57 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Fri, 10 Jul 2026 14:16:44 -0500
Subject: [PATCH v4 4/8] ibmvfc: define asynchronous sub-queue
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
Message-Id: <20260710-ibmvfc-fpin-support-v4-4-ef031ac19520@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783711016; l=2962;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=kg4QY+7DyAccNJ/5aUxRMv0jVr3wd2+MpIkF1ucpAmU=;
 b=OqwZB7KS0w5NCNlZ8+LMZKF+NyzQfxoVVfmBJvOBZYUuNP/qCbuFsvK292wcbbblRFvWtHcL+
 ecbCZcFXRSBDv/THNx744Yl4K0eBIR2dwXEF00gZL4BJuYSwtqm3tup
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Define data structures for asynchronous sub-queue support required for
full and extended FPIN functionality.

Add ibmvfc_async_subq structure to represent async events received via
the sub-queue, including FPIN status, link state, event type, and WWPN
information.

Update ibmvfc_channel_setup structure to include async_subq_handle field
and reduce IBMVFC_MAX_CHANNELS from 502 to 501 to accommodate the async
sub-queue. Add async_scrq pointer to ibmvfc_channels structure.

Add capability flags IBMVFC_USE_ASYNC_SUBQ and IBMVFC_SUPPORT_ASYNC_SUBQ
for negotiating async sub-queue support with VIOS during login.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index adfd67e85af8..f38dfae9924c 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -182,6 +182,7 @@ struct ibmvfc_npiv_login {
 #define IBMVFC_CAN_USE_MAD_VERSION	0x008
 #define IBMVFC_CAN_SEND_VF_WWPN		0x010
 #define IBMVFC_YES_SCSI			0x040
+#define IBMVFC_USE_ASYNC_SUBQ		0x100
 #define IBMVFC_CAN_USE_NOOP_CMD		0x200
 	__be64 node_name;
 	struct srp_direct_buf async;
@@ -230,6 +231,7 @@ struct ibmvfc_npiv_login_resp {
 #define IBMVFC_HANDLE_VF_WWPN		0x0040
 #define IBMVFC_CAN_SUPPORT_CHANNELS	0x0080
 #define IBMVFC_SUPPORT_SCSI		0x0200
+#define IBMVFC_SUPPORT_ASYNC_SUBQ	0x0800
 #define IBMVFC_SUPPORT_NOOP_CMD		0x1000
 	__be32 max_cmds;
 	__be32 scsi_id_sz;
@@ -564,7 +566,7 @@ struct ibmvfc_channel_setup_mad {
 	struct srp_direct_buf buffer;
 } __packed __aligned(8);
 
-#define IBMVFC_MAX_CHANNELS	502
+#define IBMVFC_MAX_CHANNELS	501
 
 struct ibmvfc_channel_setup {
 	__be32 flags;
@@ -579,6 +581,7 @@ struct ibmvfc_channel_setup {
 	struct srp_direct_buf buffer;
 	__be64 reserved2[5];
 	__be64 channel_handles[IBMVFC_MAX_CHANNELS];
+	__be64 async_subq_handle;
 } __packed __aligned(8);
 
 struct ibmvfc_connection_info {
@@ -715,6 +718,25 @@ struct ibmvfc_async_work {
 	struct work_struct async_work_s;
 };
 
+struct ibmvfc_async_subq {
+	volatile u8 valid;
+#define IBMVFC_ASYNC_ID_IS_ASSOC_ID	0x01
+#define IBMVFC_FC_EEH			0x04
+#define IBMVFC_FC_FW_UPDATE		0x08
+#define IBMVFC_FC_FW_DUMP		0x10
+	u8 flags;
+	u8 link_state;
+	u8 fpin_status;
+	__be16 event;
+	__be16 pad;
+	volatile __be64 wwpn;
+	volatile __be64 nport_id;
+	union {
+		__be64 node_name;
+		__be64 assoc_id;
+	} id;
+} __packed __aligned(8);
+
 union ibmvfc_iu {
 	struct ibmvfc_mad_common mad_common;
 	struct ibmvfc_npiv_login_mad npiv_login;
@@ -854,6 +876,7 @@ struct ibmvfc_queue {
 
 struct ibmvfc_channels {
 	struct ibmvfc_queue *scrqs;
+	struct ibmvfc_queue *async_scrq;
 	enum ibmvfc_protocol protocol;
 	unsigned int active_queues;
 	unsigned int desired_queues;

-- 
2.55.0



