Return-Path: <linuxppc-dev+bounces-20708-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18A4CD37BE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 14:05:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDhMg0Cg2z2yN8;
	Tue, 12 May 2026 00:05:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778508350;
	cv=none; b=jsuXXZpwmTb9KBcss7cbXQL47SvS3bfvPH7aH+uNs0vnY7XROzIAuu6XG0gHb0J49qRLzZjUNj0TMm2DF3aKzWq5qRQQkHzNX4/QcZXlH+lsNvzuUUaiZldM/y8xqemsIxQr6eJNB512PBF41KVNTFPt9CAw6UqtBYmwCeWAEMc+MsrHOJIRMyXBQDUzWzG2/68i9pb1i6XA+7Kdp/4GKMuUvcsKkKwru034E8aeB/rDsFfrgZ1u/7hTMS4cihKprEsp/pTbGGgsN4OdgzNeVyKkZ0nJ25KZphAet7shwCqYKpRyTXctRb5E0w+DXvitlQkLCICQYOFOxEJrxi4DqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778508350; c=relaxed/relaxed;
	bh=qI0Uz/9XXXc8IlcXlbD3ad0VmEZHBkxihS3lSDL524Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P12By0rPYVFRVS9QjLuELXN1BgCz+6PuQF5/aCio6yLJ2bZKY322cZY4LlrPIWMbg6+gV0hhJUS7BzTvOddFZn5lGzUdc9Z1YRvc7fDZLDk5+hsTPTm7OVf02KMi3AmUvH5eEVJqf3meADxHUGfaPQqQoLwZiXdhSQkhbE16H27UCoR9MjxSmA9ywC1rVa+1KzJuf41NFbKauLVmyBUnMcVm81onGSAS8XJuY4IupS6vAQF+/jN8NVjaBkpaUQGYUwIiDpXI0oNTvSC2MSpOMswJ83RjN+Y2z2x+vgjb3X/7O2rvexDrrxc1AGk2DtDfqjjeo7jk1PrBmI6/uavUcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hOgjHA25; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hOgjHA25;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhMf3SRJz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:05:50 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C8D5E42DA3;
	Mon, 11 May 2026 14:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3921EC2BCF7;
	Mon, 11 May 2026 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508348;
	bh=VMme4hNP/eM+ancPCzgwcEMKJqVdjI2yHAw5rPRUmE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hOgjHA251N+AuGQAcHY49+GihQZEWt/kPQGVzFkJ1DoPGaWOYf2DJxFRf0DdPUImS
	 7AIus401fPM2QGs3iwxv6jpqlJe4Ake+N9+d++Dh5t+N4IfV/drPMm1XsSzGr6sec7
	 kSweIR6wwM/Gp0bdaj9g9Trvk2DFZELNPRVBiNsZDa4Tw5gNDgJzIg2l7Jq735fDrr
	 voxt/4ejanfokwg4xolHAwo6eqyi5y95IaMOZ2YO15ilj5nVYqFpZJdXg+FKQzzJv8
	 tCFCjZjobllgHLhyqv2zRnfJ30612QxGV6mbMINrfWztiOi5qzTmqUoCZbQO7mC6Ih
	 oNuEdbrf0mpjg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:30 +0200
Subject: [PATCH 2/8] mm/bootmem_info: drop initialization of page->lru
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
Message-Id: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

In the past, we used to store the type in page->lru.next, introduced by
commit 5f24ce5fd34c ("thp: remove PG_buddy"). The location changed over
the years; ever since commit 0386aaa6e9c8 ("bootmem: stop using
page->index"), we store it alongside the info in page->private.

Consequently, there is no need to reset page->lru anymore.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/bootmem_info.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 3d7675a3ae04..a0a1ecdec8d0 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -34,7 +34,6 @@ void put_page_bootmem(struct page *page)
 	if (page_ref_dec_return(page) == 1) {
 		ClearPagePrivate(page);
 		set_page_private(page, 0);
-		INIT_LIST_HEAD(&page->lru);
 		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
 		free_reserved_page(page);
 	}

-- 
2.43.0


