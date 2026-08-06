Return-Path: <linuxppc-dev+bounces-25484-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F9CC56207
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 15:17:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hG9rT2DrYz30B0;
	Fri, 07 Aug 2026 01:17:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786029465;
	cv=none; b=WA7jbWpw41nJTLRUpikQ0/MHjNMU3LgyEiAEObqnjI6/VTv4Sjr7qW5GNdluBEBdOxbBV8Hen6SrqRy5DSHzs6niE0VF1y/QjSSpqB7+PP17JZtyxeShzqr4eoHolC7s5SjdfYZNgLeNAdLbSztw6qzll3Y2995uNmo41IlT4fC/HxSYgsiVGneUWiWhOyznLviyYau+NSMf7/3caLV21biwMC2b/iRB09Z7rZdw8XDUXFlzYr9mGxRQvo4eMaehuavuoUbQMq+tRS3Tf5gmNAV2/8duMpeydbDes4SB7aed9fzHQS9RYO9x+QCGwx6IbtyhntxvypNwvm2WZNdH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786029465; c=relaxed/relaxed;
	bh=TmK79VEXsTDn7gJPGxP6qho90H+2dUL+ecJC/OHZhC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ml37Q08zZ8qZwGR9sBVtIipfcVBEO7M3oblz7qEQSJdttYTIm2p0BPN6uUrZPhJ/lQzYuGbQAh0ed97tvID33Vmz593/QwQ3hGkl/eaM/3BT49G5Df+iWgtqMNl9vqb63jl38EhAWgPCDCdCYnuAJKEqpDOp1u1163VFBAouVQDvx5YRuIunEGJmMHOkXwbrQqEuqZeVEnZ7ie3Dzjcpm6yDfKKIvqF9w2rO2XK9ae2TPfYUnMgHXscbJij58B8VHv0pbBPR7hsuLWY6exjz0eRpdiK//IKZfqtYOLcvvvp51i+Yi55NarwyElbcoPdi05Hy9gLAAG0QgXpw+XMiaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=STKdnQNm; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=STKdnQNm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hG9rR2NWKz3080
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 01:17:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DC09D43B6C;
	Thu,  6 Aug 2026 15:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD6AAC2BCF7;
	Thu,  6 Aug 2026 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786029460;
	bh=NpORjKnGGwSWjo96rY491mQ4DCuXGuJzwqjHxSwNKB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=STKdnQNmPVMeb64FDz98TcSXhTcT5hjpa7BYjytrdcCihGselS5M2B/WukUeCkMRO
	 3QvdV8jl2FoNZctVu3jxSLAeEL+ysIf287SVxd/oR6oatmNQuVQuO7FUQgW51lHPRp
	 q8VU6IRf6k0qgU06AerKfAH+otcVVb9ALdcFey+teZNgNmK5S8hxzIyPimFSXX4Twe
	 t30SRxyu8ZPJs93WfeYKc8A26smzgPDH5tp2Zp81QeYIPlve2RlSrplTCoE/FY0ryR
	 OGZQKFKZ0n72vsBeusaBzarqE+2dpN/s+7BKxHvj2KBwPzu5nereivkPAMIIWig3JC
	 mOuT48tyBUDRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3579C56205;
	Thu,  6 Aug 2026 15:17:40 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 06 Aug 2026 10:17:33 -0500
Subject: [PATCH v5 3/7] scsi: ibmvfc: define asynchronous sub-queue
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
Message-Id: <20260806-ibmvfc-fpin-support-v5-3-13fd6f8a8f8b@linux.ibm.com>
References: <20260806-ibmvfc-fpin-support-v5-0-13fd6f8a8f8b@linux.ibm.com>
In-Reply-To: <20260806-ibmvfc-fpin-support-v5-0-13fd6f8a8f8b@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786029459; l=1853;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=w68m3zR1aKLFee7eqfMuZfkcraWrl8VL7pHlxbyiDug=;
 b=EShFeXOjm+MksZFb+wLG8x+m98Oq4fE/ypTeNJ/BB3QEVRM7POCIFoZ+E9bbOccrcGTPt72m6
 E6Gce7LJwVsD5NMz1jJ608Nei+4iLjUMakiALFxXZImLIa5DPrId85B
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
 drivers/scsi/ibmvscsi/ibmvfc.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index e8ca0d30f483..3711be4b6748 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -791,6 +791,25 @@ struct ibmvfc_async_work {
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
@@ -935,6 +954,7 @@ struct ibmvfc_queue {
 
 struct ibmvfc_channels {
 	struct ibmvfc_queue *scrqs;
+	struct ibmvfc_queue *async_scrq;
 	enum ibmvfc_protocol protocol;
 	unsigned int active_queues;
 	unsigned int desired_queues;

-- 
2.55.0



