Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD5606A6BF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnCszP4P
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYny82fsBz3bZm;
	Wed, 25 Nov 2026 03:17:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795537024;
	cv=pass; b=WGhRKUfGY5ZWhsVDrqh+SokNciXovHkMWwP0ktvxUctHR358JNhz+A3AICx2FWIwZQmilm754bSwFFvglbaiL87Ac2Qw8pxbAuieen+QmA9kYQiYqRr+B9oGxfoUm1qn2bW4q2VH5lUYIbEZo0eeSYOZlfED5xKGPQhfZfpzYoMTRtnIKY2zp20wG8bSQJqLr6LWZnQjMGNAqew874GUw24iIv5xPfTQ162nufCmeD1Zvt0zhLD8TRL1iwDj3p6t1q4gooGNCI0t2I5N7Ql1bLzFMV6mKAxJXE9nz/+c3f903wT7LD/gjchyGRYLEYWvtvRnCj0iTH6z1UNtEedxfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795537024; c=relaxed/relaxed;
	bh=RnsKlKmYlfnyfDpfuCHZKRfjqREJi3XMRQPFe3CmpEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C00oimHZ3WsXalTEkU5IW/K+Dr4FpHMCIaXkELXeu6UY90KrxusJAVe/EWkHOnWmDJ+PTUEtYNyxIm7bHfSRrHQaHUwk/lkiDxdEacSKBOD7XBk6YqNNwDjiuHZpMN4WANGdSkDIPBIPqlVKhiblBmCGW8KVZdjNriivQ0zETS5PjltZpBQpvSONMzRg4inA0h5OB5qNnsdXpG8MZjpxxnvfwtbLagNsNRyR6uRfPPq1VDzy+AtJi3fLxMk5aKILB/LWaeZx2wx5efoQCVdN9JoTrqqqbdS3Nv6bZCrGtDkiABOUZ2Ef/L4q2hUhQpxJYEefU1kG+AqVgflm4PqJ9g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnCszP4P; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnCszP4P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYny66y5lz30W5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:17:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6F10E45BE9;
	Tue, 24 Nov 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795537021;
	b=zNcxcOhNRkklIObG9BfpryQ9Cqg1AsW8IrTiAiHCaEfwxQ2nJYkl0aAbWMa/DpnQy8Yr
	 Gw8uc9CFAz3sGi0FhQIsKnBUHgB3cP3oGSFanlf893XRwc1zak3H1GSIaRIAOq5PJlM8/
	 wo8rrxaf9hNmzQDwffyQFG+SH7f5Mltf9tcbz/bW5H68J7g5rFG+PPDNoLJ856RuaXuFJ
	 fvKeuJQSSdVROlO2UZo28RAOLz+3ZgVZPat62ehYwY0+/9XhwtJ4jZg+IJvucCjgVG6qm
	 OPkceqWlQx0udfrrKVROY4EOUIsKrO75ZTOHihok608AvVQJcfHDzH6AwBa2T7WI3CA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537021;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RnsKlKmYlfnyfDpfuCHZKRfjqREJi3XMRQPFe3CmpEI=;
	b=cL37PfMXnTEcVbR5dO47vJlG1kDu0O9o6xS663zeSLB0qJVWgkUHrPxGXDucN0/7f/FL
	 7i5GbtMbT6KY8CvGX/M1fCIRqKx6xRNBQN7GGBdeOVZmspokVkARbWUWQimlU9jyL+OR6
	 yQL33gCUxZvxHXH+Eq7Hk6fGD5LpUc4ytRhr8XgBQBans0LEotW4mbAyFG3Am+baMHsTn
	 vRKc5Mwb0dHFfKN6x8BzHYiA4kptCEFgDnxFOXsDRp+ucOWga+xBtkkmOuoB7EzkrQDGX
	 R/+qghy+9dT2kX/UMtyQrippBxxJWzspLh9p+JwMhuyZsqEG84oMTYRNQG23fv5Mcsg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E4E5F1F000E0;
	Tue, 24 Nov 2026 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537021;
	bh=RnsKlKmYlfnyfDpfuCHZKRfjqREJi3XMRQPFe3CmpEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EnCszP4P3cgcMNGT/rpAqG0Ur+VdQU0GQBvm0A95oJ/CEq0KnrDkN3prORLtheH9+
	 1HO76RrJaQfI8TAUq6GV6GkWyOVTfF7StXDKLrq8I+rrsesZBiiH84SahU6kmc1MMk
	 9MJUNb5lq/3gacNZKHyOtkO65isu6P1NO5/X+6N4wsBpaXGjSlgxzf2AAFBPVwsO36
	 trRRq28vUwb7P1uqSdXr8wBoXXp4SBnKRKdquT/rrxI3Pj238TANZMG4waFLGQHXgp
	 q9vV4kuWDQKSXHJYmEfj2wGE3riN5SctJt8TOTz6dDfa/4UETRi1DiLG6VVz7GOiRL
	 ROIr4ia6eX8+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 04FCD4CACC;
	Tue, 24 Nov 2026 16:16:47 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Tue, 24 Nov 2026 10:16:46 -0600
Subject: [PATCH v19 05/13] scsi: ibmvfc: fix resource leaks on partial
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
Message-Id: <20261124-ibmvfc-fpin-support-v19-5-2aaffe5fe7d2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795537005; l=2781;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=wxC/5k+1fH+x2U7saJs/+NtXgLmv0/MHv+liqk2H5Nc=;
 b=Xn25L7tzoxW0DFJ3eERDPFphWEVHFe/ITk20wzD06/5d+OKYEwsZpDZGbwaQ7ADxiG7rLpFr/
 r4kQNj5xp2hDiGr2U2oA+IOXVqPVG6wLVbxgqMjfut7iWa47qQxopFa
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

ibmvfc_alloc_queue() leaks the event pool on both failure paths
after ibmvfc_init_event_pool() succeeds: neither the
get_zeroed_page() failure path nor the dma_mapping_error() failure
path calls ibmvfc_free_event_pool(). No caller compensates, since
ibmvfc_init_crq() returns immediately on ibmvfc_alloc_queue()
failure, ibmvfc_alloc_channels() only unwinds previously succeeded
queues, and ibmvfc_alloc_mem() jumps to a label that does not free
the failed queue. Add ibmvfc_free_event_pool() calls on both error
paths in ibmvfc_alloc_queue() to close the leak.

ibmvfc_free_queue() also unconditionally calls dma_unmap_single()
and free_page(), even if the message page was never allocated. In
that case msgs.handle and msg_token are both zero/NULL, and calling
dma_unmap_single() with address 0 is unsafe on many architectures.
Guard dma_unmap_single() and free_page() together under a
msgs.handle check.

ibmvfc_alloc_queue() releases everything it allocated when it
fails, so a queue it failed to allocate must not be passed to
ibmvfc_free_queue(): ibmvfc_free_event_pool() does not reset the
pool size or pointers, so the stale values would be used again. No
caller does this.

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
2.56.1



