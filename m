Return-Path: <linuxppc-dev+bounces-29008-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5250CCA6004
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 19:26:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0NQD4phgz30Tf;
	Thu, 08 Oct 2026 06:25:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791401156;
	cv=none; b=m0mKGWa9waERwZFmn4+Hic/J26sO1L+Yk4t1srsiRZvEKrExrKYq/yjMCNVshK1seWVLKZLRc186gNb0+rTuNzGxZC//Ywn3d8xFqarUi9A/z0rzgEyUnoxe+dqwo7JA9UZIa0YFswxqcQN/WeXs4ZDX3Vpdu7Sa90OjXp7R6izvY+0a8Zzg3lTlogL8eP56TRQ/IoJO8Om+5TpZ2t6aDROOtxacJACyF/ZrgUX9R6NeRDO573eXowTeXOeU+PFD8zBBYvz13SyRM41PDQWYKFUOvdYNKGwv3j+p+R2h7e6ZV9lySf1DGMrv/OGsrGoR71xfZ08qNyMUE2XLeeJRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791401156; c=relaxed/relaxed;
	bh=gxX3Wy9N5yQB0Bl77I4F3GZ0JqUVDZICYZ4Sr32QWRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LaI5DTs4YD4lBy7uLJCVVPMJ5ihHGTbBNwoaFxhOSyXF0dCF4o39Y/emzbkPDlIgrh9CMl6PBGBtJeV6TxFum0Kr663iAppxPUyY0rTE73CR4tTb/VVRQQv1nHT52+mTNUEYPck6ORiYXkBwNOCczU78DjQ1g7ftpcMDpnkIq/0waLBRdyC4u70ap7ldq6hWKIoQTn3zzgTRG0IfgYMYdBOfszF4RyHXCnkRqO+XkStSv9eQq+FJf1AHebdJObaSVckuFT97Qy1zTGdgaSQ+cHij5AxzhQH35UkawScLAdQwf3vMJdU+TNb63veJix7bnl3OymbzB97/CS5rvGARGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B/BZ6WA1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B/BZ6WA1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0NQ671MQz30VL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 06:25:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B2FC060A81;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5714BC2BCC7;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791401147;
	bh=DqAQ8z/WoiDPk1n+pCkXMkhZUBNo4WXi+gu4+3yeXIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=B/BZ6WA1vk6xcC4u6Rh3iPL4jQGol5+l8VcnsTxJQtQ/j1jAfFvNth2yueEqAVWSF
	 SRMhoXCgAh442fir8KJnJlZvbha1Zjn27tNa6aOlU0WziBGCiy7ESQeHz45m7XCaMg
	 HxB//HfecCLzhBUZbMMUfuyaq61vt/RYLn+o98fUQ0b3mAa9JLXL3+9zJt4JCFPIS8
	 xDkwUYRDJPNXiLV4DJ187y7DOlVopSPTEAiAEujHMVdH01dUPtKnsYXpvcQ72A2fk2
	 oXKTuNlN28DSoxwneEVOslfDwHnoitSohgYFO02E6Nyc8nowyZwup6gIK3hQW1e8C3
	 3xasUfrOT8WXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32176CA5FFC;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 07 Oct 2026 14:25:45 -0500
Subject: [PATCH v13 01/11] scsi: ibmvfc: fix IRQ leak and guard deregister
 on channel reg failure
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
Message-Id: <20261007-ibmvfc-fpin-support-v13-1-b816abfa4fcc@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791401146; l=1764;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=OAcs1YKHpT4X85OJN/gsmGBdld28yvNIUXEXPDT+HOE=;
 b=ba1pKBQ6x37yhtQkZIOE0sEUBRaiJSps+sLpK9faUgZ3xNB/S06D2A7hRWoE+LFNDWe1Ql4Vg
 mSFXhagtQwOAF2B4pXpeWxD71BibWNSCd1JnNbVWi82CDmsZqf1uOrX
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

If request_irq() fails during ibmvfc_register_channel(), the error path
disposes of the IRQ mapping via irq_dispose_mapping() but leaves scrq->irq
populated with the stale virq number. A subsequent call to
ibmvfc_deregister_channel() during teardown or reset cleanup then
unconditionally invokes free_irq() and irq_dispose_mapping() on the stale
IRQ descriptor, triggering kernel warnings.

Fix this by:
1. Explicitly setting scrq->irq to 0 after irq_dispose_mapping() in the
   ibmvfc_register_channel() error path.
2. Guarding free_irq() and irq_dispose_mapping() with a check for scrq->irq
   in ibmvfc_deregister_channel() so unmapped or unregistered queues are
   safely skipped.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 0b154e07299c..7818838669ae 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6435,6 +6435,7 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 	if (rc) {
 		dev_err(dev, "Couldn't register sub-crq[%d] irq\n", index);
 		irq_dispose_mapping(scrq->irq);
+		scrq->irq = 0;
 		goto irq_failed;
 	}
 
@@ -6463,9 +6464,11 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 
 	ENTER;
 
-	free_irq(scrq->irq, scrq);
-	irq_dispose_mapping(scrq->irq);
-	scrq->irq = 0;
+	if (scrq->irq) {
+		free_irq(scrq->irq, scrq);
+		irq_dispose_mapping(scrq->irq);
+		scrq->irq = 0;
+	}
 
 	do {
 		rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address,

-- 
2.55.0



