Return-Path: <linuxppc-dev+bounces-20707-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB181CD37BE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 14:05:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDhMb1W1bz2yFQ;
	Tue, 12 May 2026 00:05:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778508347;
	cv=none; b=IvbrSuE2nZjBVhPWU53Rbs0fUAxdK5ctPzqwNBCna4Ov3B3Yhv7Zu7wRg4rxj2EysfgLCvAq8bK0s5USvFJ8b7kCKGCMFN4fY/9yL1ryB3XebRhg3Fd45664LS+VT78KGFD6yXh55S7EqXljuG3HVZGvRbyRX0dcKE+VwsWjuJdKkjF1RsTpee58mntfyYzKQIj40+QGRKDyb41Ar56uSCU6l/AIEtSVmDAC61jGiXWsfOPiP7aUeBirXG7ZIk9CKeNCYHmC1gpuKtUVnyz8/rKGR73huSvzuqsnrpwlOSAnlp0n0HgN4BZKJBWLaK07DaRCXLLJkqpv8+mHeF1LfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778508347; c=relaxed/relaxed;
	bh=uRHNmf93uQX2kBlaHb/fY571d6FVsWsidkKskPPh+yI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbWAPns8EIrm1oX27z70pNpBYlJp7t0nBH7jwlY1/vF3LmhrPCGqufDFgPnQGTqVnVu/kjpOeh/2hyR3Lo5BDFOIVhEO1yGlfs4O7RKeGTI22TMaJJGKhboKxA9cRpfNdqxb9aiklVauhOoWtKNpl4Q0pz2z0XI6bdtcNH8CSfQz2ZQh1NMN6VVNozZj4UlWUhYT/gQXarwcKvg1zP+WycxWiIEnOfppoLandajJEEZlK/RRQ1seOwqlqKEQv2PBVnQOkiS57/8txeCeMgF6LQsIT9IByCSh81roZVZBJjZD1VYSF3naGPP+wm1eKtjuvDPufItV2+nLd0J+DFshWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZVqW/8uB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZVqW/8uB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhMZ3pJdz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:05:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 147BC600CB;
	Mon, 11 May 2026 14:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD66C2BCB0;
	Mon, 11 May 2026 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508343;
	bh=zGEwXeQeeaa/yetEDRVp5+lm1X5UYQ4s449U39c7KOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZVqW/8uBvCQNuH1FvNzPpfFfOV3fXvq9+aGIjhZjuuGqpF1t7+7+jnJnz2fGIA+/D
	 yxYGeANt8K3XRNU9rBN3mNKFQ+2z65C4F0WaEymY9eIT42HUwFGIU35Eb4InQAFnZw
	 9tKd3WH7g8BdkcFMxeaxQoBX4UoNqEc/YvxkV3cx1VktE0HUZwsiTxNo4b95L8Va7o
	 QEBPTERhjBauEwb1ned73L8nMQCwv2VkyNbRrjtncsuhg7G7zOIjCHkibLXIpKONG4
	 1JdBvkGT+0r4+PiZFrgPk/5vVPlDICWGR2QQJJ3jB2zi39CRKDKza7z1iF9RCoh54s
	 M1DoU+naPhh3Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:29 +0200
Subject: [PATCH 1/8] sparc/mm: remove register_page_bootmem_info()
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
Message-Id: <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>
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

sparc does not select CONFIG_HAVE_BOOTMEM_INFO_NODE, therefore,
register_page_bootmem_info_node() is a nop.

Let's just get rid of register_page_bootmem_info().

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/sparc/mm/init_64.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 367c269305e5..3b679b1d1d72 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -27,7 +27,6 @@
 #include <linux/percpu.h>
 #include <linux/mmzone.h>
 #include <linux/gfp.h>
-#include <linux/bootmem_info.h>
 
 #include <asm/head.h>
 #include <asm/page.h>
@@ -2477,17 +2476,6 @@ int page_in_phys_avail(unsigned long paddr)
 	return 0;
 }
 
-static void __init register_page_bootmem_info(void)
-{
-#ifdef CONFIG_NUMA
-	int i;
-
-	for_each_online_node(i)
-		if (NODE_DATA(i)->node_spanned_pages)
-			register_page_bootmem_info_node(NODE_DATA(i));
-#endif
-}
-
 void __init arch_setup_zero_pages(void)
 {
 	phys_addr_t zero_page_pa = kern_base +
@@ -2498,14 +2486,6 @@ void __init arch_setup_zero_pages(void)
 
 void __init mem_init(void)
 {
-	/*
-	 * Must be done after boot memory is put on freelist, because here we
-	 * might set fields in deferred struct pages that have not yet been
-	 * initialized, and memblock_free_all() initializes all the reserved
-	 * deferred pages for us.
-	 */
-	register_page_bootmem_info();
-
 	if (tlb_type == cheetah || tlb_type == cheetah_plus)
 		cheetah_ecache_flush_init();
 }

-- 
2.43.0


