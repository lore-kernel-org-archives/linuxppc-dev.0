Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58105606A33E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mw7RfUZo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJQ7v6zNbz3c1S;
	Tue, 03 Nov 2026 08:39:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793655547;
	cv=pass; b=L+7TahodFpOCsA0PgugfYmIToO0zL/u79vQ95cDRoHOg4OhBFbYhJud8jwXIGdkKZJ8lQbmA2De2m9O3XWM1vwrAfstvF2xYrilZQy8+/f1EnCvPui+99Klqe4Qm0igBp6js+8IhdaM6SRQisHNAYFba7Z5XWeCYZBLR+cPgKZG68Qa9FqJOcwSmtAvyKCkIQ2vVqAUDk91vGPNWewVxfwbtTJLWiqkI0RE1oay7YiULs2sQ7l3TCHSaNl0xDpMWY63uOJRKpjNX+1mEWnNjc0UwjuG8OR0VY8DuKlOwu8oIV0rXwR8L79r/vpQ7dFmN9FpxzTpRVqbxPHul3D8cKA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793655547; c=relaxed/relaxed;
	bh=Fh+HunchuhqVdtdCOCL3ai+kgeFFQT8QBQ0Qibxywqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSLLazswDXVxgcBDzPakMYYBCpO7XHKaZ+w637X26tFbwrDilrfz8oCUQvf31KcfNCGKcHEh4gPRIgTEQrY3iZ/NlbO1jUEzAXxSDAdCqd0okIPNkwOt/CFB87NCFZzdkJfoltoOnzv2tymHcua9TKl36TL6NgrHeRqhlIezEBwoYMbXHBGG7Eb2HQf6fbF9NQjrQF1CGrjkiFfjhuFp/s8mdErZd5M4I2r5tzUboK4nNiAopp2fHkgxsi9SzNppZ3uPqbxW5cYDycIwyVgqSbJifJCxYnZB7TGUtkquUIBfi/ANW8oPymlA7S1iLweK3jumSYTx8+vqfSW4YX4U3Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mw7RfUZo; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mw7RfUZo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJQ7m1ldXz2xb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:38:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D8FE343EA8;
	Mon,  2 Nov 2026 21:38:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793655537;
	b=yn6mPDKrIzgGwJ/3v2lhxbvT2aPdoRB4lW/oIwdsDoaMeixqIx+l9TFwuh3qyTWzF0sc
	 PQMylYqPThdSKs7PW+wH1AJOkfLXXIKh+YZ0jp9+tIzkjgw0mV8GT0qiBwjIceZkFMRnp
	 E4MZrDvfRxRFv7cHiORIRiEm+kDWPE0+ZC0rmdQ5wnKor6YMjtUqAqn4PKYShB4mx4wnM
	 edMAQlxyzRRzRZc5iomMh0aD/eyoOYN7cjTv2CdWIybBJFA/yGqCcPzPkrcBiCOtPv8/C
	 ELa93d1ZsCteRmVvv6MIC2iNQq5ImweWnnVtLQZvcJT/DyayOj7fuymVOfJb0FlOT3g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793655537;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Fh+HunchuhqVdtdCOCL3ai+kgeFFQT8QBQ0Qibxywqs=;
	b=JbNNoNOzNiFv9vZg3wrQ0BTK9r9eDYuAtEzvIWXu3uC9D20kn6qbnafIHTRwhsCgqAay
	 Bp5Z4BNcHlnOWJJgoVnHxoSTtqWLcjZd2iCvtK0aQuyiXySJ/logwcU/5iz0IbEFTeBMS
	 2iDjTEk8NhSZ7wiDOlnYJX9Z9zFr2LzPbY7NVZ635wOEGcAiIxp5XMgmDCzpGrzWWvy4H
	 BgyKwy47zApeDifPpun/ijSS3AtXwLqr+8imhZ+EUYNC9L+/IsNcO0+xu3nWB+dFdnlVv
	 TGU6Z80FhkhlgHG25/Ue0Nx41x/4foToyhTayMEwdYEmg2YhHBm1dUXr9m8g+6kFG0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1FAFE1F00A1A;
	Mon,  2 Nov 2026 21:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655537;
	bh=Fh+HunchuhqVdtdCOCL3ai+kgeFFQT8QBQ0Qibxywqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mw7RfUZoQGxbj29ycvRsYX2Y2AovHIlkqkPr1lb8pNdOr7MNFxG+9+nGruVFFQ4/F
	 DO2o9Y/L5x4Rn/U5unXOm5kcQ2jm6pAjsMDrOmG3RZc1/UNjIuald+iCEDrIRZ0lwB
	 h3ZDEYLlMRIOlDhuZPwF2gv/Hl0qozVx8wu4jvoh3cpj8YxHVtruadqlFijVaR/s6N
	 zUdWwJWg6+ZbDiqvxj/jUfeEN1zON5ZSrKWgiklzLfoWRggtkEcrp5BwuwMrrNDzyZ
	 J9KVhwTCyh2BOq0MnWOevhd0y5OVrAzbJ0AMZHC0oidG+8iLj3Ee3Y2BN0wBr4+jUJ
	 TC9jUkqEmm5LQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A000E466A2;
	Mon,  2 Nov 2026 21:38:51 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 02 Nov 2026 15:38:45 -0600
Subject: [PATCH v17 05/13] scsi: ibmvfc: fix resource leaks on partial
 queue allocation failure
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
Message-Id: <20261102-ibmvfc-fpin-support-v17-5-9ee5f195ac91@linux.ibm.com>
References: <20261102-ibmvfc-fpin-support-v17-0-9ee5f195ac91@linux.ibm.com>
In-Reply-To: <20261102-ibmvfc-fpin-support-v17-0-9ee5f195ac91@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793655530; l=2725;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=9C1Drt4rDISp5hUU8r+SsNmnCRtIPklwJLn7Jdj0Gy4=;
 b=bul+AD6bAcEEBsRfWds/HJZwnxkyB9/1EAc4lDmM1s0phmh7gle1dlwQG12n3nDnrDYqXHyKY
 wZ5dfthw4buA88g7YfvM6MokmD2/zu0tAl55WmT8KFYxkThB5COxkxL
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

ibmvfc_free_queue() unconditionally calls dma_unmap_single() and
free_page() but does not guard either call against a partially or
never-initialized queue. If ibmvfc_alloc_queue() fails before the DMA
mapping is established (e.g. get_zeroed_page() fails or
dma_mapping_error()), msgs.handle and msg_token are both zero/NULL.
Calling dma_unmap_single() with address 0 is unsafe on many
architectures.

Guard dma_unmap_single() and free_page() together under a msgs.handle
check so ibmvfc_free_queue() is safe to call on a partially or
never-initialized queue.

ibmvfc_alloc_queue() also leaks the event pool on both failure paths
after ibmvfc_init_event_pool() succeeds: neither the get_zeroed_page()
failure path nor the dma_mapping_error() failure path calls
ibmvfc_free_event_pool(). No caller compensates, since
ibmvfc_init_crq() returns immediately on ibmvfc_alloc_queue() failure,
ibmvfc_alloc_channels() only unwinds previously succeeded queues, and
ibmvfc_alloc_mem() jumps to a label that does not free the failed queue.
Add ibmvfc_free_event_pool() calls on both error paths in
ibmvfc_alloc_queue() to close the leak.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 77c685f6f959..e04c80050b98 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -914,9 +914,11 @@ static void ibmvfc_free_queue(struct ibmvfc_host *vhost,
 {
 	struct device *dev = vhost->dev;
 
-	dma_unmap_single(dev, queue->msg_token, PAGE_SIZE, DMA_BIDIRECTIONAL);
-	free_page((unsigned long)queue->msgs.handle);
-	queue->msgs.handle = NULL;
+	if (queue->msgs.handle) {
+		dma_unmap_single(dev, queue->msg_token, PAGE_SIZE, DMA_BIDIRECTIONAL);
+		free_page((unsigned long)queue->msgs.handle);
+		queue->msgs.handle = NULL;
+	}
 
 	ibmvfc_free_event_pool(vhost, queue);
 }
@@ -6303,8 +6305,10 @@ static int ibmvfc_alloc_queue(struct ibmvfc_host *vhost,
 	}
 
 	queue->msgs.handle = (void *)get_zeroed_page(GFP_KERNEL);
-	if (!queue->msgs.handle)
+	if (!queue->msgs.handle) {
+		ibmvfc_free_event_pool(vhost, queue);
 		return -ENOMEM;
+	}
 
 	queue->msg_token = dma_map_single(dev, queue->msgs.handle, PAGE_SIZE,
 					  DMA_BIDIRECTIONAL);
@@ -6312,6 +6316,7 @@ static int ibmvfc_alloc_queue(struct ibmvfc_host *vhost,
 	if (dma_mapping_error(dev, queue->msg_token)) {
 		free_page((unsigned long)queue->msgs.handle);
 		queue->msgs.handle = NULL;
+		ibmvfc_free_event_pool(vhost, queue);
 		return -ENOMEM;
 	}
 

-- 
2.56.0



