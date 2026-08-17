Return-Path: <linuxppc-dev+bounces-25909-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A32C5B572
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 20:28:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hP4CS621bz2yS0;
	Tue, 18 Aug 2026 06:28:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786998484;
	cv=none; b=AuGY8RlJGSZQ+bCENbET0jGfiyvtDgh9Pi/tucZEW2XibePQ99ik5lmSzEpSatvaAxsDQL/gEyWodhuzr6xS8DljuUntcVaxP9Dp2CG5Ovgzm51C27sL4lU38xxhhXG8lFZbMa33/KYC6Sk1tsBNUL36A2gYoLWFJPEBvzy0eYhfvWzHN6uEelnE3OYOiYhoCO2xhRgmRO98o9sd2Jk2cP+dRcsuF8ODoBM0bW1JV8miHGrUtJATy19TSoKVEFSmuwPSrPSrCH9G5wot4F3uSmlbSBc0CTLP2MeDQ5fUWeyalm3dGKxn0GK7djhk7EiV4MMa47+7T3aSLJY1Ucgokw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786998484; c=relaxed/relaxed;
	bh=iT7pyeCP68IrimjhvYp3yrFygUyQrKbAj9ZakBBlvWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuiotfTZTbfGTB1ouXIwJzs+lp74QQapZGeBW93MURjOQdmUtCxZbIjQLjTMQZDoPS3aEz157dHQIU4f1Zz4C4X8QKpecuZFyFfYURQo52TTdei/8tqwDsbra/6eG4H8TVHyYhXIPlbD/pzzJsj8W7A9WsLGn6zfwWPEnP2+lBUWUqm3v+vpfUAGG+T5VoPtQGVAAiLktCi2b/P4PhGujYFFsjyfp5h6y47EWV0joZP1OXmD+WCkMBa6nbDae4BnRhTRDNZkQQFEaE5TxRsarw8SA9eSpmIylufvNJ41ZZsKrcsi+Fz7ejcBojQmhUKvBUM1kaL2pNfj4jypXPcvVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gF10GSGJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gF10GSGJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hP4CR4g4Mz2yGf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 06:28:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C2E00438A5;
	Mon, 17 Aug 2026 20:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9709BC2BCFB;
	Mon, 17 Aug 2026 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786998480;
	bh=ibH6S6bENnAuY6Aa+juHgFRTm4gvytfx9OuJzg8EsIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gF10GSGJCzm6/VSnsXkagfLOTPmDgqQ/P/vDV4Et94s58qfdkxWElNBnO4ikpmCE5
	 zyMbJFxXVDFvrJlAj8TpgVmodRZzfmQaEg1qcAwkvhwifOiZ5l3EFBKnpiu9WHOlu7
	 IlUqRWxh+TFFtH/dYEeKKWwLNj55meaADEYUEzW3l5PZBd5wEBlHrT7MP+ViJ15xfY
	 SnPdBxuBmfAEKPGxldeCDhhEJ9AyiywQnkd+rtI4clUippC/b9qokb1dvB+bX5chkF
	 aLA2tbinbLHbHCF59a9mWbDAbOT268VU+JsulgQmdzR74lDC3qWcVof4ieK6b2K/vs
	 ZiGgru06KBxPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E21EC5DF7A;
	Mon, 17 Aug 2026 20:28:00 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 17 Aug 2026 15:27:56 -0500
Subject: [PATCH v6 3/8] scsi: ibmvfc: define asynchronous sub-queue
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
Message-Id: <20260817-ibmvfc-fpin-support-v6-3-62a2d525e70d@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786998478; l=1724;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=/KuclEPljx50OTgTOexb3g3OjrWOPH3RuTwtYAu4ZCA=;
 b=+1629IP57o+J51b+3ITeltUAP+OLqWdGeAZJHhZ90rI7MHuCuzRXht3bgo2YPc7JdegRHvPQg
 OJb/Ew+AxR3B0ZuppdltVOt7zVVrsY1iGhr+1qq82o7EImQS8yqL1zI
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
 drivers/scsi/ibmvscsi/ibmvfc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index e8ca0d30f483..d8880d02685b 100644
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
@@ -790,7 +791,6 @@ struct ibmvfc_async_work {
 	struct ibmvfc_async_crq crq;
 	struct work_struct async_work_s;
 };
-
 union ibmvfc_iu {
 	struct ibmvfc_mad_common mad_common;
 	struct ibmvfc_npiv_login_mad npiv_login;
@@ -990,6 +990,7 @@ struct ibmvfc_host {
 	mempool_t *tgt_pool;
 	struct ibmvfc_queue crq;
 	struct ibmvfc_queue async_crq;
+	struct ibmvfc_queue async_sub_crq;
 	struct ibmvfc_channels scsi_scrqs;
 	struct ibmvfc_channels nvme_scrqs;
 	struct ibmvfc_npiv_login login_info;

-- 
2.55.0



