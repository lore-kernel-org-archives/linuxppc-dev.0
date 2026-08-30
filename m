Return-Path: <linuxppc-dev+bounces-26199-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CBCC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 07:50:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hXkmf1dqqz3bsq;
	Sun, 30 Aug 2026 17:49:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788076194;
	cv=none; b=makZxtTRCvrY5o7dJFwX1PFFNuGT6Ucnl8qqVExsL4UR/ITIcybFT2h3SurgjKyX9LYhqwvEaBxf+Ig7qKqyAlXuaAmnJZy/Kk0IS8aJJvHhQdAMoU+NDaLViNfVU/sgPmRwo4nhz6aScP9t6JK9PwqkfBURVSbH5zKqd0aj4wIR0/h7pPDBO+Kg7TAiWW87Ni0xhj9a92W3zhhPn8wgq1tSksCENvuDIkodh17pxkPmZ9NvHxSwmg9yMkFrhOxQXxK9wf6YvSR+SzjSNjpmg45w+Mc1fo9hTbx3uy8APDm7vHCDAq8U60MLGsjGsmzKpHV7tLt5j2x1jcB2/Wlu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788076194; c=relaxed/relaxed;
	bh=N0aOUz6JVmh3kXeQM+NnLc75cSb7tkVgfwn6MO33S8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mA8MWM+/xeRemHwqm1D5smSnpXWSFr/CnkIDioZ1bH8asShcSSx2dlrSWw1OBCp74ucLnWz/0TTfZ/A8f2xG9d55gO51Tbfih/K1ZxEHpnFlBPa6cq8k57UzMQBI5PPhOHKU0Z5arIa0NSsS8w5dqi5Em3gwYGEkmEckQV5H86wcDnfHOaEOaLFrn5H5Il8uhEAHqw1KzAnAkwhcBOWqMnTKHszamKc8t6vBxXE/K3rnJQKnBfVzIs8U2shohrJBHIhPkbtLbvDRTJUdo48uXpVCcOSv9Vdf5WnjyAapdYqxNv0Jq/80denI4sewaRORH4Q0yHIXkshsQhIOuX3IfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5zBjU2S; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5zBjU2S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXkmd4zKdz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 17:49:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A256418A9;
	Sun, 30 Aug 2026 07:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19B91F00A3D;
	Sun, 30 Aug 2026 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076191;
	bh=N0aOUz6JVmh3kXeQM+NnLc75cSb7tkVgfwn6MO33S8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b5zBjU2SCdjNynbg16pje0gRmCFrD2lpThEIZpjQImPRVDgN5PG8PUs5Y+pWBNxWo
	 SkR/m95kAtKUgDcA7pG+mgK6GKoLUoKWkPLr9kQROsoJTVUBgu2Ndc1cdzAboL4mx+
	 zovU54HVU9Zx1PHAUtsimOlAdSLGtQjmx0gLUBAH7i/2KABKvH9Xj09UPoBpjvMOCk
	 4+bayv5WuWfiXFs03oJYXx59pFZ4H5N0YFuOjm06Cuoeabrrdcz5M1TV2MLy6uiajp
	 OA6KrwNHb1d6V9E+q2YZ/ONsT+E9yJ/CABRqr4QlKx4EgyThytkTlGLuzIBV25AijX
	 nRDHvVS1DfNIA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 10:49:39 +0300
Subject: [PATCH 3/3] tty: hvcs: replace __get_free_page() with kmalloc()
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
Message-Id: <20260830-tty-v1-3-0cbe6170649b@kernel.org>
References: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
In-Reply-To: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.17-dev

hvcs_initialize() allocates the buffer that receives the partner info
returned by the H_VTERM_PARTNER_INFO hypercall. The buffer is passed to
the hypervisor as a physical address and it must not cross a page
boundary.

kmalloc() guarantees that a power of two sized allocation is aligned to
its size, so a PAGE_SIZE allocation is page aligned as well.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/hvc/hvcs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index d32b1e3c50bf..b94d59fa3627 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1470,7 +1470,7 @@ static int hvcs_initialize(void)
 		goto register_fail;
 	}
 
-	hvcs_pi_buff = (unsigned long *) __get_free_page(GFP_KERNEL);
+	hvcs_pi_buff = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!hvcs_pi_buff) {
 		rc = -ENOMEM;
 		goto buff_alloc_fail;
@@ -1486,7 +1486,7 @@ static int hvcs_initialize(void)
 	return 0;
 
 kthread_fail:
-	free_page((unsigned long)hvcs_pi_buff);
+	kfree(hvcs_pi_buff);
 buff_alloc_fail:
 	tty_unregister_driver(hvcs_tty_driver);
 register_fail:
@@ -1528,7 +1528,7 @@ static void __exit hvcs_module_exit(void)
 	kthread_stop(hvcs_task);
 
 	spin_lock(&hvcs_pi_lock);
-	free_page((unsigned long)hvcs_pi_buff);
+	kfree(hvcs_pi_buff);
 	hvcs_pi_buff = NULL;
 	spin_unlock(&hvcs_pi_lock);
 

-- 
2.53.0


