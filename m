Return-Path: <linuxppc-dev+bounces-26992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F5EC79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 19:08:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg9Lc1TjFz3092;
	Thu, 10 Sep 2026 05:08:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788980888;
	cv=none; b=URLYOJ93OQLVGm7dltgfa4oJ83sO7I5acnkA7QfjPxRc4PSinBZz2DpklppSwxcH4LhIs2YvUB9oX7ExsAvdecrOagq89q521dtcjhxz8i0Pin67Aq8e7uwB/wSR/lnEMMhKswKfR/Em6CPfUJEA2E3xDPpqdFP1YL7OAjObASkeiPCAxMm+LWOfBUa/Wv4eNZjUV/6LJhqJpT5kP/iWOjZJPZBoXc6+WcKDM0FYSZ4RKkNhYgiU9Cop98/ze+pVuCjIX5AGI76iW0crC1wuEd02ScbZ6khTxHNxvJK34GlGbBlRAuTC/4lDj5PT9ZXmFe4otXQL1SmWt0NdLeSDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788980888; c=relaxed/relaxed;
	bh=1Fm65ScBm++SJ/gBh8cczOppD9BSr1YL8D/dv55xRgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMuUrd1/nX6XcKuaglKfXrOGO6i7jkLcqNkV9iD9GgZxa4mixT5sxo6ET2pm6LnKpbb/BdNE6L8abKIFXTmc3exSYwZ98ltGu9Zt08ToINZ4ruiLWNsGagi+FBXF9s9ViYOrvboGHqVjQk0sAcybJPNDw7TwPPg5S19n98iFvqjhpRS4QdS7h1CeAiGGkMiK6g7N6fqOVD/OnufaikPgsWAIusSrECGt7LbkSlrUPhkn7CLEGLP06UK9opTHEHEcD7qcjTNwvT3HyKgxSBiszuwbqmWPqYoi1myneIWYeJUYK2Bp+zFQzGRATZmx0+BEQWRdHR9PE4A/QbWvpz9HBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UpDkrlqa; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UpDkrlqa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg9LW4CDdz2yxN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 05:08:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8765360202;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 102F6C2BCFB;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788980880;
	bh=mFnlH7/qPv+L0T9B45mohz9x62pSXgPbs74b2lQ0Hdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UpDkrlqaOjTxG1bQxA+syvZdV6zcAJP62pfqIqdHcFG+KjNVARy2+Af74NHuUQqgQ
	 tFsi+IhP9jgKUu0bxIXHut983VefNf4UCCCn+8KT34REA5n/ir3PzGIgGjK/AhI9ei
	 g7e4LLn3QlAHcaujhJQdadSQyCRdZ3XG/L0vw4HckDN9PrE7uPud/v3gXjeOVp0z2/
	 z4F/YSInFX7rQFqAOa1hnyvxi0Y5b+hnfrPsHQDBo0jSQeMcpvm+jd9gI/jp4DHVW9
	 i1zAnAq/d6+P2anMRyziIjKLMbyDyfH4X5G2DxE8uaw+FuByW0mtvPPouoHtE43KaT
	 xH91iYoNw18ug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE385C88E40;
	Wed,  9 Sep 2026 19:07:59 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 09 Sep 2026 14:07:58 -0500
Subject: [PATCH v8 3/9] scsi: ibmvfc: add FPIN extended flag and async
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
Message-Id: <20260909-ibmvfc-fpin-support-v8-3-b27183b055af@linux.ibm.com>
References: <20260909-ibmvfc-fpin-support-v8-0-b27183b055af@linux.ibm.com>
In-Reply-To: <20260909-ibmvfc-fpin-support-v8-0-b27183b055af@linux.ibm.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>, 
 Greg Joyce <gjoyce@linux.ibm.com>, Kyle Mahlkuch <kmahlkuc@linux.ibm.com>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788980878; l=1156;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=6+Vf0PoqfDYiBtRPDVPvMbpbtiabmKU9+0zi74lACkM=;
 b=wZL86Y4MW/fnRBDZlJyyY4UdT/X/nD6f0brUZLcFM2YlQr6XJnLQNQVuKYivvf1QE5AebfEUH
 SKBLxmoBjV3DW7Hp3o3bXIKCGBaLPQGbV/mBveo1wfVKoZtuKgpGJJe
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
index d7a30e7a4a28..a8a063d99564 100644
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



