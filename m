Return-Path: <linuxppc-dev+bounces-29004-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E89CCA5FFF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 19:25:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0NQ70xN4z30VM;
	Thu, 08 Oct 2026 06:25:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791401151;
	cv=none; b=FyQTrfDDxaPilJAgzLlXF+Y2fYs9pZJz/vUm/sUtH0IZDBLZZI8Ew9ZlxgJvBQVyDfaWMCi2T+lEzdr6Q4rHWM2ygELVwHcokwbLKEDDkdBBNYOJE39T2Vq46YQyqwEql/U59Ayu6vHiM2KeLakKRwV0pPjiBshoqthomT5nm+kBiL7KLwvH2/REt5ETUkHfUnyMAPYkJ6WAUxALCPAHtPfXVsW6NUVkvzAo08guQA8HXJXzf6ACEp1rNTDAdK1V20n3Ozv6ksllgzZ9Ux3/OW1DNaWQ3EN9NiHWodu/4vIDys/A+gOLEX3Gl+5DSBXr13WFeRoa27IYciA9tufMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791401151; c=relaxed/relaxed;
	bh=bqFmGWUYWYwbBhKf5cSau95IT7zrp2rDbRxnBPklwUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abqC8UtMaKRZ6kNslO+LkmT69e9TlAdcAqsxVHvCUVbseDApbPXjHfJwfRtI8o60Z8tjI29nN78ZvhDtbk5er+e1o7aeBVKDbUqzj4AatZ1NIAj32YuOROvVQ+67YtKiAcx2H+kDFSVn6TAeSzKrjQx0nH871Asy/Qfa2to932V8TFEp5u7xm0Gnc7yKuro8ppK2G4Z30joCtVsWWxNBjjHRDU67dw3fQxK1oeCvkWRrgsrT+CK+RxNFPVSrfGcnz5LLVlWslK2T9nyqCkkL4es5qgIwkWL1FKWvyo5HrDgMgpiESSHRP3w/KgEvqu79JHdzedMsIHKEF4hzpC1VnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t6wrf7PT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t6wrf7PT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0NQ61fPdz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 06:25:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A033E44500;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78016C4AF09;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791401147;
	bh=pxTCB+8r4h9iLO+9EiB4XXAQcmK8WExkDzMIEXKqWQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t6wrf7PTbHhEzOIhjTs6wjgnHrPK3xAaCdq3hlQDD8zzs0YpoDmD4xpETqUsJHHv+
	 k8+Oa38hmCNNx8PVceRjuRcmdmGTP33Toy4jA1YnGmSWXvPS0nPR+6xQp0OP1YmfmN
	 n7RKIHO//RaYTXKWzYeVA+/QMb2DOwwOkq9Cfml7N119snRloFD5mBQkTvuGZp6/f3
	 IM9jZ2OsAda3Vv69ZNisi03YiE6NL3RgOAD2naqlxqB4WH7+VBOPwfZwXOj6Pw3nGL
	 GlMXBzgCu523yvw7XU3wY3sib/sA2R2Bq4QxOQRlb5xngtTYfDatzTvEAAtMzRTPa4
	 faNYAwvP+AOnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566E9CA6002;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 07 Oct 2026 14:25:47 -0500
Subject: [PATCH v13 03/11] scsi: ibmvfc: fix potential NULL pointer
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
Message-Id: <20261007-ibmvfc-fpin-support-v13-3-b816abfa4fcc@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791401146; l=1111;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=5MabxL8K2rBUNQC1NT9ZFM4Bgb2QgZQZyrHF4zEwrIs=;
 b=8vOF60GIEts5umotur9o5bMuyMkkPWWmDft62QDPpRfaZRXQqLzN2Wj9BukQACoS3Qu5g3ulo
 XXR7EPp6NBCC5cRd8WBOERIHNQHCE+e3Ld7ZLfCF1r9CsqfonaFk+ii
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
index 145d559041f1..6a42d15db9ec 100644
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



