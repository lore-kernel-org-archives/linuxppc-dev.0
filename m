Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A060703CF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuNs+6Fs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL8K5706Pz2yfs;
	Fri, 06 Nov 2026 04:23:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793899385;
	cv=pass; b=k989vaxeLBD6eB5jW+GCY/lyDUBQsJ/wD+iddciH5nfWqeeNRZnK3adiybEw/HgzPEvVNvq56QVt4QfCgW/tDGyiu/z3TlpTV8b39PTI8QWtiuOg4qVTDuNSLiOyyzVlHKfqq7SSoRefmRRxp1d1bIO+Pr4nQuMys3PcHIgK6w6+dlqaxsFJrr4YKzDr2ELt5F2ORIE53Aun7gTkKZK7iIaxpN/GxrQk4NNAwowgmSfAS1aG8KmrBVc406RIuVi1jUS2mlzvCFHs6kviVYeAbLWq3qLXn4fI413tvG6JT1yCakqXE8G7hVHKS8nKZwXBhYn6oMaghssHifmwHaYYvw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793899385; c=relaxed/relaxed;
	bh=Fh+HunchuhqVdtdCOCL3ai+kgeFFQT8QBQ0Qibxywqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEhqkkrwMR6bvn1z0yplKpjWYOqR5P2akoLD6tZFrj3NSi+3aER16jbYQtp9806lEUvq5MJn8SOJ0wi+Dx05wf2PUf7J24q5E5ZSeLTNptQXWaJUov2vKT1ttUwMocWGzBaQIOgW8yUeKfswbZCZuzHmugdqY7Cn7QWd2uWzHII21iK2lUygJLdzjds7U1sZRbj+bkafJrV5qhEztc68XP7onGf0NbIip9Kxm8YrCAcknveuaUR9VGlZWC5H5Aj3v27jJba094CAZuicfOJbY5Nl0ffPq+Tbo9Jo1YOyHyRTtX96re+nz18V6xM0NQ6IUV5m5y7NTiAlvKQhyrh3Ig==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuNs+6Fs; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MuNs+6Fs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL8K405TCz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 04:23:03 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7BF5860180;
	Thu,  5 Nov 2026 17:23:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793899381;
	b=l22Q+BgpWir+mIHec1nG0eDCyrGW3N7N9oyeLHJRrgYU7SqZPJiOrbDt+z8mOm7xtfFw
	 d9P+uduyCp4CTWL8YlJZts/q3YrEUJqSXBm4lL0thq2irkqnQ+hp+t2lRQYFPpmJavf1W
	 dApgXFjAPwVro/oG8A8Z3Kdbs1Cy5ch9tUSW1PD2qwMLy/nyDXVOGvwdh3ss1gI3wD7d8
	 csjvpOGI/c2E48aFdQ4Lugma9/8I1jQDaCQ5K5zZlmvDCy7/6aGL1NIKr6ejTaKw9/aiH
	 +pJSGwwSKlDMFJuPFgHXAE1uNkYWTg3nDdBTFBVhic/4wSKTKdSyF0JC12kgPwghfmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793899381;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Fh+HunchuhqVdtdCOCL3ai+kgeFFQT8QBQ0Qibxywqs=;
	b=iB4WilW1kX2ekTvI3BAji9f5asKyyhHjro3IR6S9yu6dnjyu6ucJ9X0qqweOf6GA/KXo
	 nAO3ruOaTBEMH90aB/evEJw+vr4zOL2bPeTmi5CgDpL9B7wb9nMe1NZafGm98bMcGlhT9
	 o+tnzvemN4OcqSSvbu77AkyzieTP7V27Hf+Nk6XpmOs5mfLmSxTiFhHr+eJv1IykwxZCi
	 j2DsYjpV0Qgk5AQOWJsXAalhq87M7AOHlC7dG6yyPpAzAX7tR57GMN86S2aNEp/LHmN9m
	 4dScz2PiQI1kR5om0TclJbxETyxwkgtutTFRMpirqvxP3BfwjBlC8/4ZHFhquAg9Azg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ECA9A1F00A16;
	Thu,  5 Nov 2026 17:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899381;
	bh=Fh+HunchuhqVdtdCOCL3ai+kgeFFQT8QBQ0Qibxywqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MuNs+6FsQeKm7iLvEOoA6nbZOYD+I8dl4sI6YZqRKAVUEWtulf6zwAMUmA8gU2/ep
	 tgB3nqVxF79Zx+paKhEc6pAXYG0VgqzQoX9WD35lNaBCmn89CdYqXmtX0HeWVqNiai
	 i3Chb7FnuuFFjkmBs5E+BFYH7f5V3eobauyK7sn65Il4fVjFipVsf2d6zzklxXWKSL
	 m5xC4YlObJHUx53QuAlEtVK4K3/j2/ul5h1NOK4BZsPvobtF6WnQYNZIDqhbIaMR5d
	 FQ05CHelVBZHVBXhDvRACKdKteEXvr5Aq5iA9KDp/EpVPHuhKhMBr4gGYS0B0u4ryd
	 O86GYrUjkmhLA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 757A54737E;
	Thu,  5 Nov 2026 17:22:58 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 05 Nov 2026 11:22:58 -0600
Subject: [PATCH v18 05/13] scsi: ibmvfc: fix resource leaks on partial
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
Message-Id: <20261105-ibmvfc-fpin-support-v18-5-d683b74736a3@linux.ibm.com>
References: <20261105-ibmvfc-fpin-support-v18-0-d683b74736a3@linux.ibm.com>
In-Reply-To: <20261105-ibmvfc-fpin-support-v18-0-d683b74736a3@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793899377; l=2725;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=9C1Drt4rDISp5hUU8r+SsNmnCRtIPklwJLn7Jdj0Gy4=;
 b=wJW2KbN8vNcFA4WEBiJc26sKNHKVulRqTr29biqOKrbVOYJ+CcARW9C0jIV9/CFgO6hX5+dV8
 MZbv9GNJnv0CUdm6vui53dfwFrzbmzS1XSbYNa02svo7EPddVkHggqz
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



