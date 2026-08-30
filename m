Return-Path: <linuxppc-dev+bounces-26194-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EADC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 07:48:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hXkkq6CHdz30HB;
	Sun, 30 Aug 2026 17:48:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788076099;
	cv=none; b=QnFQfHIgTxZRFYNS7N+u7/h+U9zq26/VHJrDs0+xig6cS03htpVgL5h9VlJbAsiC72cat4t8cUJdxqKZkqnWjW+Pz+Y1H9gEeR7lRXblhNN+gtVUDSbLJkvYLBalhjNRnlnt5FBmee6CTkZ0z56Zu+7O5gcJx1+sqJT/feZSVt8Rt6TwGSAjcBFfnKHwCVKcEdL4naftsECQa3kkjItH4QWVkAPKblh1/nQzH6Ta1sUDEdV6Jhgyc/DQZsLV5Qxxhi/G7DemrRgnj5VpbqKLKNQ4h1TcoDqRYLA6FpAdO+vUj8Q2+PASVuee25sQMYBA9THzm5SoUEBBGPc7be5X7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788076099; c=relaxed/relaxed;
	bh=ZDX3fFvUV30DfDlbIstSg54b9CSxecAVNcamfzhjDpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2VK1+Pu6dfAedpEXQwrQ9e4vyewQLLm8hyBXzvhmS5jROq2dV1faeJs8FOQAIa//nbN005l2qLyFX72ZJfMqp3G8L+rFysN33zZ2WTDx1HAOcvO8X5FOWabT6pjV75XrOBKIK0skcTV/KCjYUqzX+hoYODqDUNIKN/VsR1lpwT1JnzxbBBcgOj0Jq3sIvtjPGMQMWkoxptzbvtdb8F/Rndn6Ly4SVCySH4zlMHXsXqUMu+dyXKR1bCqt2hzTp3raZ0zY/tr5Qc+SJr9YLAL5Dl/Klhqw34J9NJkIF6OFdhsSAIlpSj7Pv4TyN+lpGFrpaCL1L/Q7riSX1Kwi0FaFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zuz9PyXX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zuz9PyXX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXkkq1j9xz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 17:48:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 27A21600CB;
	Sun, 30 Aug 2026 07:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB531F00ACA;
	Sun, 30 Aug 2026 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076096;
	bh=ZDX3fFvUV30DfDlbIstSg54b9CSxecAVNcamfzhjDpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zuz9PyXXns1bfaGYR4gnsnrxBWaqJ2cC2WXfTQgmLJc4cO8fXpb7QJjDQGAxLBweW
	 njwG435meYvdRMmFjpASihIDRb48QGdry5/qkaq2Bpim1xqKDzu8ooUUuChsnpepSP
	 vwwc+zKhQKjIpM6/A6egaO7hrri8bIIpI25tyjU+LNBYikCYM/LcMQ8l5NyZLdhcU9
	 vdGjSE/yZUQxVqKSKjyWrw7g1+SUglzOKT/WSg7/xZtlZTiuOvVQhG77nEky66RL01
	 NO0eHmrDCvn816QISofFodN4Czd051W+EhaiJHQdBF7SgUCHsDXasr9K2WYziDqI5+
	 JsK2PWt2PH0Tw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 10:48:00 +0300
Subject: [PATCH 3/4] misc: ibmvmc: replace get_zeroed_page() with kzalloc()
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
Message-Id: <20260830-char-misc-v1-3-05e2ce44f291@kernel.org>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
In-Reply-To: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>, 
 Eli Billauer <eli.billauer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <michal.simek@amd.com>, Ritu Agarwal <rituagar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.17-dev

ibmvmc_init_crq_queue() allocates the CRQ message queue that is shared
with the hypervisor. The queue is mapped for DMA and registered with the
hypervisor by its DMA address.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/misc/ibmvmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index da82b1edb7c9..7d503ebd9f3c 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -154,7 +154,7 @@ static void ibmvmc_release_crq_queue(struct crq_server_adapter *adapter)
 	dma_unmap_single(adapter->dev,
 			 queue->msg_token,
 			 queue->size * sizeof(*queue->msgs), DMA_BIDIRECTIONAL);
-	free_page((unsigned long)queue->msgs);
+	kfree(queue->msgs);
 }
 
 /**
@@ -2130,7 +2130,7 @@ static int ibmvmc_init_crq_queue(struct crq_server_adapter *adapter)
 	int rc = 0;
 	int retrc = 0;
 
-	queue->msgs = (struct ibmvmc_crq_msg *)get_zeroed_page(GFP_KERNEL);
+	queue->msgs = kzalloc(PAGE_SIZE, GFP_KERNEL);
 
 	if (!queue->msgs)
 		goto malloc_failed;
@@ -2192,7 +2192,7 @@ static int ibmvmc_init_crq_queue(struct crq_server_adapter *adapter)
 			 queue->msg_token,
 			 queue->size * sizeof(*queue->msgs), DMA_BIDIRECTIONAL);
 map_failed:
-	free_page((unsigned long)queue->msgs);
+	kfree(queue->msgs);
 malloc_failed:
 	return -ENOMEM;
 }

-- 
2.53.0


