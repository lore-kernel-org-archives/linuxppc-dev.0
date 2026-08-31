Return-Path: <linuxppc-dev+bounces-26268-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1F0C61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:28:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMZB73mqz2yrm;
	Mon, 31 Aug 2026 18:28:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164882;
	cv=none; b=PWAmGaRNCxSX++oObCKHtszH/L9wjGaWTLwKcsaPSW2Dkqq/ZBx3SIW1NzURf1zmXLO83XLZCtexFV5Q0EQbFAOAhNKXpBSIA0SZYesGHB7fyUtnRQMcSGoEJa69JUFOJnJiE83qxjBmbKiwdwccVE5uALKRKDiscNATs9bBUx+LGVgRwBTA9JducZB6lmD1cK67F1lZknnw5Fc1MjWBsEpcXs3aSY00BpG7RvFzNz/G6PvbFFUMi7CpnR66HHsjoX5YOhHtJw6qs2gn9zUGJZWs6QBcT0gBYIHI6ZZcbG7eGlFIZYM+YW1ksGjPnhUMPD2fqiPAA5rMvkOoLcrXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164882; c=relaxed/relaxed;
	bh=UDLOrEWk8s8P9NPs/hJ9ReKcQQKs4DBoKeRaLa6eCp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VM4CYZzX1MCPxMmQGsYtA6n3+LomsDAvO3lDSR5V04kKPMvsXR3aPy2m9grFyHu8/llM9e62tHIUM+E/XRuCkt2wdfSqUeoyRosUIvDCpaGUaZ4mgsglcZNtcuIr/1oQ6xzY5DZmNy7AHo9ZtdAv2p5kxqHseSvpvqQ7oTf2IsLBrEItNUklJU7WaF2k0kgysg8YySqqlCZLot3DYervvZyt7tvEUBCPuJrArihd+nlPYIxVzNsq+iyEmXq1DEzuTe/tun5ItBL6r8PsWKC0HaH4yWh0n9qCJPWXx4F+6cVcJXpiNvXS0SxfVEDHE5r5z8K5tkJtYdDdI/ZmgIZtkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFigFzSX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFigFzSX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMZB1nD0z2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:28:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 45EFC6013A;
	Mon, 31 Aug 2026 08:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C251F00A3D;
	Mon, 31 Aug 2026 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164880;
	bh=UDLOrEWk8s8P9NPs/hJ9ReKcQQKs4DBoKeRaLa6eCp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CFigFzSXaYQh2+i8PwAo/W/QAkG/+QNSnIqgZ9uo6Z81XZPLznd8ZqutwbhR4DpQK
	 9kjtCiNQ3KnSwEBxI6ZijIBbLCjxEwXge/vi7LM/J0iLgdXtwg6rx+8Rc2FBmCOTyf
	 aSAnFL3rVGi88PgnzHO4Tt4XG4Zo8LByhZUhUAqvNBaS3UH0/Br64p8EBAYfyS1ywi
	 hykMJYf6b69ZxGswHh2qHgsLNdqp0XcZT/tBcEhyMw8BemGV26GLtUoMVrc1PVOwg6
	 IwcPobyIcnYYdgvmTsH6+qp22iSImRew9B4QAJqbH9ikBFYeSogG0srG6SPwZRu6JH
	 ftcvtOvQ09eCw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 31 Aug 2026 11:27:45 +0300
Subject: [PATCH v2 3/3] tty: hvcs: replace __get_free_page() with kmalloc()
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
Message-Id: <20260831-tty-v2-3-88cd58c3c640@kernel.org>
References: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
In-Reply-To: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
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
index d32b1e3c50bfd..b94d59fa36274 100644
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


