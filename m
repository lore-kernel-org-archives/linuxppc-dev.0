Return-Path: <linuxppc-dev+bounces-28606-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB90CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 18:24:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw3Mm08T9z30T9;
	Thu, 01 Oct 2026 04:23:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790792627;
	cv=none; b=c/15Q4ArQ6bQzNawNUsALW8655sc2lzWCD2tsTGPXx/9tKIfZVni6u1CqMrdraXwGHQg2yFQfu1fdxJ+BP2XnxCpHARXQdw8ISpGNANSl8NylvkHzYRoOxuqDCLla1f5pivRtRGJ+bUEoEjxua3Ua5kqVIfTRgPmG2AaJOCXTVAv9Ka1D/A/SRz17zEz+zHNugrASDCkCln58iaL16ASxmrYKcSY//tHKKjFd+xf1cS//4HhGuYS55o1LroPt5RzeRnl2Qspvt+8tXxb6VM8Fh5D8WT7kFH7nJzBWyL7oWt3HwOL2wfY+uCSvUevGy8g2Np8aisZN4BttkzubZFdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790792627; c=relaxed/relaxed;
	bh=2UsM18h+zbLmLP8UJazXgz9wRZ291uklc8TLvZCVDFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzT1jyk5vWJeX7z75um1wTRW0fAVqc/IT/5LxYIQ0iQCUFaFTQB0nhFpGUj+y952zSX9J4wQpcKGrhL3yYpZ8CgyDedRtphLKDeYkpyfY1y4OEudJmoOCG1UL16nlq6CLEU9HG2H5JpipJS4gDwL+24IWN+a0TCY8AVUpFjl71g0uEHxnMk+zgq7RBNkxOrRZkGoavkfQLF2ILEGZ9PhWxWTDT6VAKblAithCTb1NX6zZvseIOHc/kycSAl/L3BHJxe26IbYyjQLmZT1TV/+cJEo01cpCB4BfBjcVqXaP+Od0gU0xukphjyvplGl+LzScXLMkHq0L1PcSR4lxIFOoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eWJWvEso; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eWJWvEso;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw3Mg1yKWz30Vf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 04:23:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B59974478A;
	Wed, 30 Sep 2026 18:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99DEFC4AF1A;
	Wed, 30 Sep 2026 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790792617;
	bh=3dR3bQhbVFD6CaK4nkwyg+M1MY6kVwlo9U5P9pkztfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eWJWvEsoaZBYW0Le70dA+8IiQr4vhJCB9rfPy5m4OriO8AgOCVNBbwq7U1QK7rfDF
	 MzSkoexxiiJwz7Ew1MwIA0MPiQFUPtl8mRMHOa9sIDmQV7G/xNo+yN/HJ6PE1Wx3kc
	 BC2OkKTywSK978ZX2fOScdNIdWQLstBtOElBJ2eYxX+AzuMChoW4WfhMv1qjT4sNU7
	 vE39Gljk3MFzOgaeOYJ3cP5PvNFj7B3pOtEJP6344jfTNHmS+pdHoL/pEItpOZtXmd
	 MjfR9V1nOzRBYbt4VPtqYN/t7Gz+h+KiWpteLwG3SavEyQ7YWhciEAwd1SKj8YqjZm
	 k9fAR9LZuWVcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BF6CA5FCC;
	Wed, 30 Sep 2026 18:23:37 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 30 Sep 2026 13:23:34 -0500
Subject: [PATCH v12 06/11] scsi: ibmvfc: add FPIN extended flag and async
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
Message-Id: <20260930-ibmvfc-fpin-support-v12-6-53a3fff7d77b@linux.ibm.com>
References: <20260930-ibmvfc-fpin-support-v12-0-53a3fff7d77b@linux.ibm.com>
In-Reply-To: <20260930-ibmvfc-fpin-support-v12-0-53a3fff7d77b@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790792616; l=1878;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=4tDRYGPOdalcjrcQxoWbj2Q6l6Bvzp5u1GG4s8VoVCQ=;
 b=aKDjAR6jHaXPJ/2bcjqZrZTUX5N7QzpkQG8MSRe7wgaJENRff9fVYsVQwPVF5Cu53xaZhssSp
 Ik5tW3UU6+ZBnocweq6BTYpzAJR329ZlemdPUciLA8toKQeMc4hOd/Z
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



