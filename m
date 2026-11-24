Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63D606A33F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxIttCPQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYny545nTz2yRC;
	Wed, 25 Nov 2026 03:17:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795537021;
	cv=pass; b=FvWwXobuQ02BmyWEel0WeE8DvB+7FvX090XJ55H11wlEjMYHNN7zNjTHOwZXrIZd8vB5OxwiDKcBYGO1wtQFZmqSHAT/2YO2f1kNwy3Idholg3ChBG2ZvMtfHPX9+pOrqvl9cmzUdRIg6qfG3KpxopkslmKhE6ydh1hGRuXE2mzEv+T1gdsIil/3VPpogg7fDJ7Y2rxFUfafKznXen74TF8oojpLYxc+eIh5a/RuudmOHKCyMpubL1XBlsOS8Etoc92Ga8aTgFmRMjRukQMen+WSwpI+rBJE/Ziw84WedioNLeAROxXERfZw0nQDYsO7QX772Huwno5CFjsO+gRiTA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795537021; c=relaxed/relaxed;
	bh=iWHHpK7I1aPxhjQiISteCfAmv4UI48rr2CE7X1IOAQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UdtPWTHBHsdIE0IzaQbj3wAvz5GG1scNJfRosx46lfu+u+GHnjXq+RyrTtDO/eZ2yihZybtUbuF1H6Hv0piwxCvKMXuWRIHhLlEpzKo3lnmd0b3RzH1NOTYwlFXJ8qxB5n+Ly6KNyDialJJ6CWNy0oVqcL970KWTQWC7JaNxtzPDzC9810EVmb/SVM0omyz1bE6iscMq0z2p9yI0VC8zzwiwUSb1GvXscORynv+yEyV3DR2Q095wQo0i3+/ORTG69jvVDDVUPHVh+joKs+G2OxRCzuvk/kzFf4uOKjgJrxrT0qtuhpXTKm5zfNA4qfliCvYvMEkwD3irYKIxzp8cPg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxIttCPQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxIttCPQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYny434Jcz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:17:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C9FFE448A0;
	Tue, 24 Nov 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795537017;
	b=p6jL8VX+XL+K/sRb7Tmixb03U8ABGU1+yaGFk5No6xgcVY/Qb16M/DsnMvKDbeFEW5oK
	 TAQhUUQyZEYF95+288PftWxfwNUUfuN9PW1zHBE4Xubib53kcCLK+9hgcSpgxk6wsIiw9
	 QnWbTL8V9DQ+ksOid6EEG11U4teKEMndYVxzEZsD4/K1kJF4WdpUvjHfS1z9QfKCnaxmk
	 w/vhyAOAxfY/VOLqx2tBo22X5weLRJiUSv/y0isGoiL3VHHNkI3YNwl/EAIjSo1msh/0f
	 u3hiWlZ8Sgh23alHvyP85kw/XFYynI95AoJBX6/sDGitWcq+fxbWt2a0/pP8H82rCCw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537017;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iWHHpK7I1aPxhjQiISteCfAmv4UI48rr2CE7X1IOAQg=;
	b=A4h0ZgG3PiyszKIQOZ1yP5PVINfOn+DIYdPPRJJT0BFxpxc12V3+7yFo64Bn209D5yrn
	 fSjakga61p6qJ48TJBksClBzvPJpPLUwpX9XpPsuHKfUs/AJI/FRea0Onx4mfqEEg+z1C
	 LOEnoz3f6OrZtZkfR//PoEPXzdRZPt3LkcPJrc6dem7cRqIXyNDXwfNNSJaNN2nYUPSrG
	 7ohnf5SV/z4mLFq5JdMkmO2az/eJX3WJFyST8EuksyMYHzlcTZx+dRCmKdxhF20S6QqFI
	 D3dGxkXry2YvboTBkWrDqvZnF6nDz+PYBFRgRYam2W5neP15tcX3kHiqWZjpMrbqdkQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 109B11F000CF;
	Tue, 24 Nov 2026 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537017;
	bh=iWHHpK7I1aPxhjQiISteCfAmv4UI48rr2CE7X1IOAQg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PxIttCPQT1UgXuf/BzffGeoWWB3rMZDayWDyXldViuM4eezGoV3aVc02xV7uu9UDF
	 HJFTN6/smdO43AdsB1k1xjt0QFweexmqXOxkfvghf8RPQdIShK49a9+hYYBSaYm0hC
	 46IXAM112hgXh5vl9NuTp8NSuxdSM+kdgkYLL4EnF4rHn/traT9RLeHrJZXuRKp1cc
	 8iUO4pUaqjO5S1IbRP1sCD8weyoDik+1tnOPnKhMbghQeaaih198acrfTlIkdz5Mg8
	 zH8cxZ4NcpgoDWMRmw5QBFRnou1qmieDM1TuXc2gcyHauCUoUczkfuVnZsQgzqEes7
	 F7MF/2rGnPjUQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8A2584CAB3;
	Tue, 24 Nov 2026 16:16:46 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Tue, 24 Nov 2026 10:16:42 -0600
Subject: [PATCH v19 01/13] scsi: ibmvfc: fix IRQ leak and guard deregister
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-ibmvfc-fpin-support-v19-1-2aaffe5fe7d2@linux.ibm.com>
References: <20261124-ibmvfc-fpin-support-v19-0-2aaffe5fe7d2@linux.ibm.com>
In-Reply-To: <20261124-ibmvfc-fpin-support-v19-0-2aaffe5fe7d2@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795537005; l=1764;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=pdRCCHFHcIdzSMz7J4MKijZ8CZDRz+a9xWemOyE6eEE=;
 b=cofSvstI90OfaG2ybZFQXJ6mMGEhqhcz6zh9/b5TO7osR+Npb8hKcEHCgGpGJT9EcGAGh4DTe
 LjavmDHJm07AwPE1trauYdPAmaqRfxMQ1nzbM2P7SIyua/L4ULiNpnN
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.1



