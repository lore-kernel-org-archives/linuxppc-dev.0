Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9060A262D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSnGLLDw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7qcp5JKCz2yVT;
	Tue, 20 Oct 2026 09:15:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792448154;
	cv=pass; b=dq3+BX93D0qVpCyfJh4yT79eXsOMSPoVhcLEZtQ2nV6HDsMUodEhlzxbOnyYendEvPpb3gAug/GAUKCGinRGN0lrJ61/rh6+PWnOE4djRiFu5f7yUE8JfILsxk0JpFFtDCT7NCftN8NqCO86L/QqGoo76zHR43mc8XoUEOJj/23kLxv7juorx3CnsPzojVHlB+Gb2RgKbzPqQRzcAuP+7xbTSyn2iTuBadbjvYm9XsTzJ/3ckxePg6WPowzD6YPJh8RhnHa8Zd7ApVzIhjHiaEwFCSo0L/UiUeD6C7KFkM+zCEISjGIhwXbGcQUp95GQfBF0ukmyneTfMQFkWovKIA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792448154; c=relaxed/relaxed;
	bh=6uMcoAQqwVWg4ZD2SLJD0mX50qt6CYwlXqXbX/bVuJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrdvJN7VtERP00e3wAMwTb7hOHKj1CoZDEgdA5wobivNTSzAPbLQcgabpEAFvFuDpOzRcvjGBol+jHTTMKTonHfkI3Fp5ZNpbRxda3TaxnQ1um0HHpbp/4wNHs6+JMo0+YtrheZJL8wsubeRitnWaEHUNRcdIk8k9TFHHXypwP4zOZb7K7gRyvPpMwRVlkwPBBqrBnzTMbdqLUIxhyCiEHvqYS1N95ZyaoEJFyag4xO+zbFamdW7NNlnyPAOpVNAEs1KP82Dx1/1lnSylbbg2g4lGJlrQJ28CtQ3SR+PIpA0INDCsWoH+BtlnicTkLZ/E52oecInwZarENAC/Op2Cw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSnGLLDw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSnGLLDw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7qcn3XN9z2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 09:15:53 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3336B60211;
	Mon, 19 Oct 2026 22:15:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792448150;
	b=Ao+Ok/icZFn1UylAL+xqvHF3yolmErdBjLr/NoDmXVuA5YV5YlAyBSZR+av7u2p19kUI
	 m929qr0jKh9Wq7gDmXWT9fiCwWa0mU2lTk6rfILNGrKYM6yu9Ct123JPQmq2M3KgE0g1e
	 hqDRPBimgVIrJ9X6eZR6PoGv1APNHRQZdb0Hy7jMWQQaBbJHTs4GISNgfw9wNdvp/vzsV
	 5/NbXmxLTeGLloj2GncY6rrKEMgbjAbRcTf1cbdODpinAAytAS+KeSc1xauApi52FXLR2
	 AC6Ri7Vtxj7WdSawmWTxm1WOCxlKa+3N8Gu+uTuraKLdsTZsDyjzurUP5NDEp+l36Yg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792448150;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6uMcoAQqwVWg4ZD2SLJD0mX50qt6CYwlXqXbX/bVuJM=;
	b=hOFMoUAbAdtY9oBqN7CzlYyGvAJtZvhVnffUvktkgxRaNt/s/sCmaGxE7U8UDqwCys8p
	 bdOoWyH1sXtNQRnuoCovpAKSxJ/6llDwQI0u//h+q0aV7l/hXxvJ2jPsw0cFaitFt2LZX
	 i5bv97Lk5QxIy/fCpvNtZErGsChzZZ/wp+bLCzbsW203y32VEiObFKKsVcfrayUsjShI9
	 hDK+LCaGDOrBdSI3B1b2X0Skd1Rkp4/EbItd/ST5bbKqCXpCsJ0yHZaFRFZWrjuutGgOq
	 Sfb6WEoqeIoq5pkXqyKHJDpM91cdjaoSoWUAFqPTvpbL6yzTN3wROMW4fRRE1rsryZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BCC371F000C6;
	Mon, 19 Oct 2026 22:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448150;
	bh=6uMcoAQqwVWg4ZD2SLJD0mX50qt6CYwlXqXbX/bVuJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GSnGLLDwUph2o4XVsYEia1Eoo6LE8IUbIq5DujL7XrQPF1yqIUzf5vkn0jO2jFx1Q
	 TVxLWqK+xDvK3uKWS1LXZ+StFMKQcZ+wvyyG+KVEjPgQITlekjqMW6rHaTCVG3JjxD
	 dnCsnaIMDseGgMXXl66/Z1Kt4QGpq2PI6yK6TxJBU6TduF+QYhi3CPja4bxCOdxhNM
	 kVTXfDNqODoA9GLzAaeBt+uVRpl9iLnNMjP4xSOlQsq3A/ZwspxcRVK+jic7GBvF0P
	 GASLslKjrMfBv614OUvWgsVqrTM/pjx5xQwe0yYUrKSUNITJ0IvysBq9ZXavUf9UpA
	 jx4ldiqqjZVUQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 249D040655;
	Mon, 19 Oct 2026 22:15:49 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 19 Oct 2026 17:15:47 -0500
Subject: [PATCH v15 02/11] scsi: ibmvfc: fix potential clobbering of rc
 after failed irq setup
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-ibmvfc-fpin-support-v15-2-a858726e178a@linux.ibm.com>
References: <20261019-ibmvfc-fpin-support-v15-0-a858726e178a@linux.ibm.com>
In-Reply-To: <20261019-ibmvfc-fpin-support-v15-0-a858726e178a@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792448148; l=1351;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=nvE9rGLbRD6+mhvHw9wBWLEiRdGSv55IfTVTSl/45g0=;
 b=UXwllF4KNBbvbF1qYV1ZWDQsmIndMDHIp5NjLU1edJi2Qgu2LPJSjUc3VS5Q0k9umZ8cuW2HQ
 D/XEIoWzj/dDIvjsuaB+8rLHdt/TH9XpSgfsoZNc2d+07NdV8hp7khC
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tyrel Datwyler <tyreld@linux.ibm.com>

Fix a variable-shadowing bug in ibmvfc_register_channel() where the
irq_failed cleanup loop reused rc for the H_FREE_SUB_CRQ hcall result,
clobbering the error code returned to the caller.

Introduce hcall_rc for the cleanup loop instead.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 7818838669ae..145d559041f1 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6391,6 +6391,7 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 	struct vio_dev *vdev = to_vio_dev(dev);
 	struct ibmvfc_queue *scrq = &channels->scrqs[index];
 	int rc = -ENOMEM;
+	int hcall_rc;
 
 	ENTER;
 
@@ -6446,8 +6447,8 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 
 irq_failed:
 	do {
-		rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
-	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
+		hcall_rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
+	} while (hcall_rc == H_BUSY || H_IS_LONG_BUSY(hcall_rc));
 reg_failed:
 	LEAVE;
 	return rc;

-- 
2.56.0



