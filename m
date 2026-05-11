Return-Path: <linuxppc-dev+bounces-20714-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F338CD37BE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 14:06:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDhNF3CgRz2y8t;
	Tue, 12 May 2026 00:06:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778508381;
	cv=none; b=oV6zJL+TKH6HdXBah8pmhabqdUmxDYLvKNaI2RnNm2qEVUtG6AZ4qeFvE+5qED5fcB1LSf3ln/7CjGN+EgjUEDcb4lK/6Ky0kJJBsomQUxZdqxSK0LB4nSE0r7U9gqfXg411QkI7FLM2JLQhUnclZVqrNjlXFyK1S+fqvkBToLO2JFpdB0gKwpqD5a8PyOg7Y/JUxvm/XT2/AfLPbLqWon6ETsxGX16ln9qDuzU9QbZFPe56EBzwvbkg3/ADust82GPSve5I7S7pKrHmhgSC2UtOnAFA4QW0VorfQ4QLtlAnxELUunbCrRH5XWldiU/u2m9SLokDSYi6sPblQEIirg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778508381; c=relaxed/relaxed;
	bh=946HNQNfXuzzT50sg+6zOZh3cOdkYAiL2RkiOXSaKFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTphSEOy4jNHi+h/eD1OipWnIA9p31tTBjQgmBVDKmB9eNkT/FLdzmISPXvn1tcVr1ae60IlpgR06AnmHKJ/DR5UA3LMgLHoWClOZJuIAJ9iOaJsPifdPYvZ/n9pzSXSekgKXNb/Y34xttrXt+tQxnp7e3YrFlOw4ABv1R2iAiuDfYkeh9Neatp+3dpU7Csak7C5KE5cOUjysyaEySGN2PJtgO7ppvwNrUsDNuu8HFU4vsrC5n3SP2WqSdHuWbEYvXR+jYynNhZbQt8C71GF/Tpo9jKWbStu9dqOhtdB5UDHGo5SI7KIHIbFdUxOTiWIadINx7cbJDg3q3gmbHnAmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qpwR2/9i; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qpwR2/9i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhND3sYvz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:06:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7063360141;
	Mon, 11 May 2026 14:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C15C2BCFB;
	Mon, 11 May 2026 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508378;
	bh=9/8M2sHV8SgEK+1FMWV6SnFszJKpiz3SzVlMOl5S/UQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qpwR2/9iNsX4kETinr2qHODBsLGHsPUUZrTsmeM9AESKVpqbk81P30B5Y9V29uk9A
	 tXiVq2FwNHSyozJ2+Ri3cRbL1te3EmQaN+VS+XQYpJYTlcm4xAPX27yYLrh7nmMTrD
	 gA0MD1DSzhX+9wxHm5shlRSunGZB+V2A7zDp7v7yvUne5T/2ZCeEFG/K7hMiMRiRtQ
	 gX4ninWFuT2qb9iDdfMe862XUG6AnojfBtmLDvIdhyWwqMS4Ma3gvo6DH1pHILXIua
	 TT8+gJHZ/sGaRLC2K7SHzvggQ6ftTyvU53+mUI/B+NKg17cQzQP7qfBknfq8GwUGkw
	 60KofuPliv/dg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:36 +0200
Subject: [PATCH 8/8] powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
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
Message-Id: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
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

register_page_bootmem_info_node() essentially only calls
register_page_bootmem_memmap(). However, on powerpc that function is a
nop. So there is not benefit in using CONFIG_HAVE_BOOTMEM_INFO_NODE
anymore, let's just drop it.

We can stop including bootmem_info.h.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/powerpc/mm/init_64.c | 8 --------
 mm/Kconfig                | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index b6f3ae03ca9e..64f0df5bb5cd 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -41,7 +41,6 @@
 #include <linux/libfdt.h>
 #include <linux/memremap.h>
 #include <linux/memory.h>
-#include <linux/bootmem_info.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -388,13 +387,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 
 #endif
 
-#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
-void register_page_bootmem_memmap(unsigned long section_nr,
-				  struct page *start_page, unsigned long size)
-{
-}
-#endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
-
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/mm/Kconfig b/mm/Kconfig
index e221fa1dc54d..97b079372325 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -537,7 +537,7 @@ endchoice
 
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
-	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
+	select HAVE_BOOTMEM_INFO_NODE if X86_64
 	depends on MEMORY_HOTPLUG
 	select MIGRATION
 

-- 
2.43.0


