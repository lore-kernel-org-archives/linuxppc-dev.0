Return-Path: <linuxppc-dev+bounces-26996-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F39EC79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 19:08:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg9Lf5z6Wz3bjk;
	Thu, 10 Sep 2026 05:08:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788980890;
	cv=none; b=eKuUjwvt/B4yY2WYddFIn0HDDzkWsc2famOJw5AiaN6OgbgUFmWSAlbYHTxyZjHpbww4Xrj9RAKVwfAEo6iEx+eoDDxvD+99+aQmeejm5R0i6L+qcDRE8errDB4z1hXaDUnyDOomWwFqkBHNOtWqrEsXpYbjOFKt/TYS/NtW23EOreBJq+3qmX9PvlBR3IzlcD/Ad00sL+GJ620l1PIvkoSuevUVyN6dXVKPnXoC6fuF7Jtzic5BkEoRHZ8cZjoNmOSwvtCS+8BEZKs9vz1h2UgCgGKY50kYG6l3pTlIxUsbDZaeFClreXv/mbaK+8+0+2QeqfyM9YJelmd1ON7+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788980890; c=relaxed/relaxed;
	bh=W84cg9o6fMbJU043t8jNsVxxQZTXW1g8dMY/Vu+kd1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrjlhZknFD3HCF++vtJZpu3fBKgBGwXsDpiinVDPH2cdMnpD0IyLXPgS7QpAIkOlV/SD7DJt9lF2okcDIQPOUF4mpv3bAzySeCemoxGjeood9j7N/B7muNR+YKsnPJ6YftuuMRkowrLuZRWOe5ebHMbOugLU0tI+dyVB/F2y/QB2xyWaVw6mha8htrSPjL/1mLh14pcV1xFluMpe8J4bRhivomlQdCNFDWms71EuLg5aWnh7xLVWj4HVqbobeqEewqFC811iJGHB8i4dOclHwCAhSAHI79fyfmh0naGeWSCodCkVIo8xD3LdAKpEVv/87bLKqNF6HeK4KY5PIsE2Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ooCEZ8Ym; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ooCEZ8Ym;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg9LZ0XQdz308V
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 05:08:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A24B44796;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55131C2BD01;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788980880;
	bh=XkBXrQmmKWZ+hf01Y8mXNBZ2JaNJ3dWvop4CqYBj65M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ooCEZ8Ym5Qao96wo4dkQoNKP5xdJZr0iOg5K4mnVOIuKuX/6Tw4LZ7LYHb1eNAZNr
	 2wBYZSdgUkTxA9v4Ev5JZ2GUj/kddRTnKpbcHonZn5gEW1lPtsimA+z5sqauX36Nw0
	 EInd/qB0VQH84fAl6oKpa5uLrwMbwYLjf7V4M/Gr7kp8T5q+FdVSUbTLvMkbs2b3hu
	 OBO9ueoZcFDfDy2YBqQdY8T51Mv7hLZuxTMl7DmLKfoUt5Eo4dKxfIxde075XTgjZD
	 oylgNEQoptrouTYadVZtw3oRntP8tYy2CqIz3L6Z9vmfuXrq8W9/O6927Khgb2vYNF
	 4iT4VQRZgtkcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33785C88E41;
	Wed,  9 Sep 2026 19:08:00 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 09 Sep 2026 14:08:02 -0500
Subject: [PATCH v8 7/9] scsi: ibmvfc: fix IRQ leak and guard deregister on
 channel reg failure
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
Message-Id: <20260909-ibmvfc-fpin-support-v8-7-b27183b055af@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788980878; l=1707;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=S7JoJv6nrDtzuAz4WAYCfne5ZRPe72ADWh4nieJY2a8=;
 b=9EKpDYXsAWuyIv5VClmdHCHj6iXDLtkM3OFohJa0odSJLkXvi8TC85rn2+NQ4uM+X/Coewesr
 DFIQNkDhKVyDB7dezOZNN7ASZMQYys04zY0EeMvwzD9v0uoG+Ewmwr8
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
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 1c660edcf608..f88262ffad13 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6888,6 +6888,7 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 		else
 			dev_err(dev, "Couldn't register async sub-crq irq\n");
 		irq_dispose_mapping(scrq->irq);
+		scrq->irq = 0;
 		goto irq_failed;
 	}
 
@@ -6930,9 +6931,11 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 
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



