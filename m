Return-Path: <linuxppc-dev+bounces-28602-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A91CA5FC1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 18:23:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw3Mf48XKz30V1;
	Thu, 01 Oct 2026 04:23:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790792622;
	cv=none; b=NgJQHSmxRpAs7QuVEhZEwx5Q11U81CJMfZ6amssiGVuGyP6OLNk/rbFmIXjcwVY9zcA9zgPXnGum0TJw0+rBJ+2OPLnSzjaO6A7r4Rae+C4cr/gtWmUcPckNboCRthrWe2SqtjE9uwP4Zt5SZv9tflXYS3wmTliXPv9F98FdM0cH+6vNpe5xJxLiWNxAIAUdsfnzAImabIu5axLQlSC9RDQlDhjRUFanQ0UpjqfqAEEzgtW55fqjv/ynd9T7XORireZodbMF9nY6wTOQWaEnyCUaq3/4wkngycx6xCWXxlsU17gfsJMXpXnxC0iW9uXgq0q+EPn3hGGEp4oakV79Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790792622; c=relaxed/relaxed;
	bh=ySNnYG7chljxmRKScOSdAprAfsSuju096T1n5r3sAeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIbN26UGzeGpXXbVx3VrSVxAQVtKfO8NaWpyOLJlFlt3gIqADGug4czjDY/B60rCcmnHQrPx9PoNCoQ31Fap2Rfbkrcn0wnxFm3dShYjem+XPU6lOifRVj3thIg3uMtDBVT9Z3d0XOZlni7uVttSlT0kyJ6KeU/zYVjALeoptSvB5ulAzTNPAkdzSffs/M0994Q95AGbjJbAUzUVK+hcXH/7bwWCGkyC0ks6/MRDkLH23BNf2hq6fiGRf7hcdtpmbo/qeJlzwf0qBRNWsD4YN7piwwd6E+L6TlAG1D8crfZZEk71WylzEB07Em3Wj+jHcIQ0ddIx01730d29cs91mA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hlk1LpFl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Hlk1LpFl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw3Mb5qLWz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 04:23:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B82444037;
	Wed, 30 Sep 2026 18:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75258C4AF15;
	Wed, 30 Sep 2026 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790792617;
	bh=mmHAI4lqTiWTWsOFBymcfgvv8S2qQq8i1Z2ZjGjy+mE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Hlk1LpFl/3LpfiDXkeoBoHzLa8j8C8D4PoaxcRwmGWGFhqhMZmoYJ06ETkTpsDnf+
	 GNakbcWs1KmlnuIH4dRv3n+NwGWE/BkFdx7pia2DpyzUgIlHsTa9vc31/WHRUi3SO6
	 iCJ2KYgIr+vkg4GuYxxJcM5kAdGc+fdLDnissk4AiNaXCmNIcLtlXOiWp2zsN15mcf
	 57seNk6FU+lVhmzOKUKmotTetnSoDMBGEZ5DELqIk/72PJHj6J0G0d6xMMJnm00v5+
	 pbP+yjg5bqzDoNmtjxjlgk0RP0t/9YOZ8VLIhwed4KD5jEpD0QlMj+eWWGY6V2lGFD
	 RnUasIsnJLfQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A446CA5FC1;
	Wed, 30 Sep 2026 18:23:37 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 30 Sep 2026 13:23:31 -0500
Subject: [PATCH v12 03/11] scsi: ibmvfc: fix potential NULL pointer
 dereference on failed queue allocation
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
Message-Id: <20260930-ibmvfc-fpin-support-v12-3-53a3fff7d77b@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790792616; l=1111;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=wAZi3BQ6xlr40111qSneTKnSLs5YURCCqScQ3cxxd4c=;
 b=r/VU30jCdhbJPK6Aelfox28Qr16E8hvz4KYiuZlauaftjn9+Ww+yILCMwgTlxmT9B2yAo5mVT
 ykKlXxoDmNxB9aIdwfx/GMyJDmatwIZuk9T4yAbN8KyYGw4tu9nDuR/
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Tyrel Datwyler <tyreld@linux.ibm.com>

Guard the memset() in ibmvfc_deregister_channel() behind a check of
scrq->msgs.handle to prevent a NULL dereference when the function is
called on a queue that was never allocated, such as async_sub_crq when
multi-queue is disabled or initialization failed before
ibmvfc_alloc_queue() was reached.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index e847e0e5f0c2..cf775f0673a0 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6480,8 +6480,10 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 		dev_err(dev, "Failed to free sub-crq[%d]: rc=%ld\n", index, rc);
 
 	/* Clean out the queue */
-	memset(scrq->msgs.crq, 0, PAGE_SIZE);
-	scrq->cur = 0;
+	if (scrq->msgs.handle) {
+		memset(scrq->msgs.crq, 0, PAGE_SIZE);
+		scrq->cur = 0;
+	}
 
 	LEAVE;
 }

-- 
2.55.0



