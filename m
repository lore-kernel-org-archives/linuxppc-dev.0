Return-Path: <linuxppc-dev+bounces-26325-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481ECC61DFD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 19:00:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYdbn2VPmz2yDD;
	Tue, 01 Sep 2026 05:00:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788202821;
	cv=none; b=aWp3BUumC6VEZ0KzhbqYeUFd7Bj9dCTzC6wSvi4DJAmgATEdcmwA66OdQB48tnbjqK0jWUVljyYL9F6wqQmB/w0cbOQgwagM00labcLVnCL0dFJm3lfXy784CURjSlyZ4WyrD15jLHMn+fgdP/AcqNv226HqvOcIdQDluSiucyQCN6zebKExBVnGPiGBB9PN3jmBEcSGWDry6z3deW4vqDE73cWxaDYIuvQbss8XxLWxerQHFiyfA9ePiXBPwW65hWUEZ+Mkgc26W8XfP1XiOEHk55WHFaAVcVmIbABWKvP70CuwfPTxskS/nHSkhd6jBqtPRKGUsUlZ5WN++MIi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788202821; c=relaxed/relaxed;
	bh=MDlMZUMtpqWUKjECKuYDgvcuPycu9QPaRchF4Sz8TZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bno/JyAOaRaSftNAbRv5ow6DVeJq8J6AF0RFlEgdCQ6OlULPTnGJ6gggS1lNGImvfwCa+IfOpikP2sw1PGBeRAO7SSele1yugnogzVGweEhIqbrCL0g3GCa0O+Wyyhki9PZNpy/5M2yGBk7QXVQyTW970irILT8D24Wdq1FvnP3cV4e5aM/7BpOtVBkfZhVthgQCTCJ9QcyxvDCdOgk4RIrM5PyqKG91pivhrEtRtN+aX3dxaS45SVVCsHbqipjKfT04ZE2m/CB7bBHFUAO+BrXc8ULJiUsRMvD/D5HSDz8Hq/2Gwzg6ZwOEH2byNIbHYtyrlCDtU1Ca7wQxgk91Xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pMqcKiln; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pMqcKiln;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYdbm21YVz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 05:00:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A0D0F403FC;
	Mon, 31 Aug 2026 19:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80A8CC2BCF5;
	Mon, 31 Aug 2026 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788202817;
	bh=2Tu9hv7UV4sPka0itSJBGOvFzakW74cJMqAuTb+GLcQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pMqcKilneysIDDgdZ6m9l0HLB5TZmvXCq2HfnzR1GUbYLq2SFOTq14N7+itfrCADs
	 kCTYJLqLvc3Zwim8XezyD4PN2FBdwgHhAFM55swv6J7jN0Ag35gRN/SEkD7JE23pDV
	 o49YPSeeCbQhZ4kE1cXGf49gRhtm/uT3OroABI/OU6d3IBe9dfSyv1ZYGRHVIpiG/o
	 jSgsQT8elQLDJ0PMJuJIuksrbhE7MVRdD/SLlpNeLXu14oVJnIE0C7oIhulbGHz67K
	 uubE4DHB+e/NfnPsFWzh9dp//UtaYvuYBU8YweDKnOdsZbG0CvzmCoaVRgVCvWo1kE
	 sZMccKPOpso6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6862FC624D1;
	Mon, 31 Aug 2026 19:00:17 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 31 Aug 2026 14:00:15 -0500
Subject: [PATCH v7 3/8] scsi: ibmvfc: add FPIN extended flag and async
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
Message-Id: <20260831-ibmvfc-fpin-support-v7-3-77d0b9809080@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788202815; l=1156;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=LHQEdLSXmrelE8PxihHPWRiGoEQFDjeL6jTPhksOZpY=;
 b=WVDH/Gt43dZKsRfLhefKop8P2BeM2nsgkaxFVpJgKHvfkep9WTxXsuBRcE/m7xfsiCCKKR9pm
 YsJslS+wF9/DeKJE5acnlxqT1WJ3PUJICpPJo28iK8/aflMIwlpOqwh
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Add IBMVFC_ASYNC_IS_FPIN_EXT flag bit (0x02) to ibmvfc_async_sub_crq.flags
to distinguish extended FPIN events from standard ones.

Add async_sub_crq field of type ibmvfc_queue to ibmvfc_host to hold the
queue handle for the asynchronous sub-CRQ, alongside the existing crq and
async_crq queues.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index 646aaa01177c..3848fa936e38 100644
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
@@ -990,6 +991,7 @@ struct ibmvfc_host {
 	mempool_t *tgt_pool;
 	struct ibmvfc_queue crq;
 	struct ibmvfc_queue async_crq;
+	struct ibmvfc_queue async_sub_crq;
 	struct ibmvfc_channels scsi_scrqs;
 	struct ibmvfc_channels nvme_scrqs;
 	struct ibmvfc_npiv_login login_info;

-- 
2.55.0



