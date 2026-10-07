Return-Path: <linuxppc-dev+bounces-29006-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F96CA6002
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 19:26:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0NQB3QDkz3bps;
	Thu, 08 Oct 2026 06:25:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791401154;
	cv=none; b=P5GQEPIBNCIS9P1zQ1p2HrkXTQNOQvScH2aOctNTNzW+ZZ1LdqdKtGiZIHsdOOM5EMWKSvTVey+12beNB4UT0S2ZAnyWz6e4jESYrbZK2pL6aEk95q0UGAFd/evPT9tj6eSR/7PLvohlQnJwT4vU1P4hysSQSTxQ4QnNYMD5LeqV74ILqrJyB/6lblpvJmu+ILTZxy2T1BMfZeKeh/0oZdg1afkJQnIfF6dQI4qP6q/cRoj6B5gEGiKVz8sYiV+cyhVs7ZJYyvigMP8H3YwUUxBGKaK7rYixXb7m2TOdS0vXODRYlrHdCULV8CwTHdmmOngZb+SStrNSZ7eP2mguwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791401154; c=relaxed/relaxed;
	bh=2UsM18h+zbLmLP8UJazXgz9wRZ291uklc8TLvZCVDFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kCfYniU4FLYFou3ksk8JtUPLPolrTHsgrpmzjhPzCVDOl1aVbX4kdAoY3KjM9/bvPD261dXD3KRIKVmoFsWewEwflNVntLcKqxqijhYMWEXk2lty+gQVTQz+5vwLT7WDvs1xyY6boDjH0RnshHumXn/5Q5HxivaWupRlpAsPGoTMRz7S6xSnJGTmAd6RBick3P67SjUWkW/LQe2Xcv5Q3gnAbPlReAwjQvLeQ1X12waSVyQSf59kkpx7tByCBC+gUcmPekeRN4jlSs32MhmlSDqEe3MqEgkhYIKNsLUnhRH7lrS5mNgaM9xZcwdP+1F4mMwvuxpbIhwXmoq/a7oiHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YR00aolP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YR00aolP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0NQ63Fqnz30Tf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 06:25:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C2077447E0;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5A13C2BD04;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791401147;
	bh=3dR3bQhbVFD6CaK4nkwyg+M1MY6kVwlo9U5P9pkztfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YR00aolP1Uk2vneHP0954RTVQP6HxiqzrHIXlcSwcQEc9EvWkn7fZs33dkm1B2m/O
	 G7t+iovsWRanfnJ/7BRZK+JDqdTowxrO9ydsMPe3B/auyYwZkt9mBEAWFa6eCyQB7M
	 tdT+dIdcHz+LhzQpXjLO2Q40xE03gO/rfI0vbhhzyPyGYQ3CBCpdec9C9ql4Htnqrg
	 a/Whd6RBiPOYBrYKLNJew5Se8IrQfikKk6tpOW8tWJdOZeFx9i87r+0RIVMdUn7Cu8
	 jIcxQX3HfBzrmHDiZCa464MAPatxa0TBfsYQ4Di4CEVfMoTo4qNh1lLZIDtCEI69rG
	 gGR/pczwEnvqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A9CA5FFC;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 07 Oct 2026 14:25:50 -0500
Subject: [PATCH v13 06/11] scsi: ibmvfc: add FPIN extended flag and async
 sub-CRQ queue handle
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
Message-Id: <20261007-ibmvfc-fpin-support-v13-6-b816abfa4fcc@linux.ibm.com>
References: <20261007-ibmvfc-fpin-support-v13-0-b816abfa4fcc@linux.ibm.com>
In-Reply-To: <20261007-ibmvfc-fpin-support-v13-0-b816abfa4fcc@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791401146; l=1878;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=4tDRYGPOdalcjrcQxoWbj2Q6l6Bvzp5u1GG4s8VoVCQ=;
 b=8hINjiuBnCZR6asQbTBcWjQQPNRAPzpvlTKbA8ZjPMycfw70obT4ovtaf63uV+gCk2cDtgyOr
 p1AnFEQ7yBKBZC3LJ7dQ1diZSCYjRRuVgX2vQ5gt2wf00UgYiMAm8IV
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Add IBMVFC_ASYNC_IS_FPIN_EXT flag bit (0x02) to ibmvfc_async_sub_crq.flags
to distinguish extended FPIN events from standard ones.

Add async_scrqs field of type ibmvfc_channels to ibmvfc_host to hold the
channel set for the asynchronous sub-CRQ, alongside the existing scsi_scrqs
and nvme_scrqs channels. This uses the same ibmvfc_channels infrastructure
as the SCSI and NVMe channel queues.

Add IBMVFC_ASYNC_SUB_CRQ_FMT to enum ibmvfc_msg_fmt and a corresponding
async_scrq pointer to union ibmvfc_msgs to support the new async sub-CRQ
message format.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index d7a30e7a4a28..df2f312fd7b9 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -773,6 +773,7 @@ struct ibmvfc_async_sub_crq {
 	volatile u8 valid;
 	u8 flags;
 #define IBMVFC_ASYNC_ID_IS_ASSOC_ID	0x01
+#define IBMVFC_ASYNC_IS_FPIN_EXT	0x02
 	u8 link_state;
 	u8 fpin_status;
 	__be16 event;
@@ -893,6 +894,7 @@ enum ibmvfc_msg_fmt {
 	IBMVFC_CRQ_FMT = 0,
 	IBMVFC_ASYNC_FMT,
 	IBMVFC_SUB_CRQ_FMT,
+	IBMVFC_ASYNC_SUB_CRQ_FMT,
 };
 
 union ibmvfc_msgs {
@@ -900,6 +902,7 @@ union ibmvfc_msgs {
 	struct ibmvfc_crq *crq;
 	struct ibmvfc_async_crq *async;
 	struct ibmvfc_sub_crq *scrq;
+	struct ibmvfc_async_sub_crq *async_scrq;
 };
 
 struct ibmvfc_queue {
@@ -992,6 +995,7 @@ struct ibmvfc_host {
 	struct ibmvfc_queue async_crq;
 	struct ibmvfc_channels scsi_scrqs;
 	struct ibmvfc_channels nvme_scrqs;
+	struct ibmvfc_channels async_scrqs;
 	struct ibmvfc_npiv_login login_info;
 	union ibmvfc_npiv_login_data *login_buf;
 	dma_addr_t login_buf_dma;

-- 
2.55.0



