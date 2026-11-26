Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514F606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJyTKMIe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZv8R5p42z2xWt;
	Thu, 26 Nov 2026 22:14:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691687;
	cv=none; b=mbhbLVNeuu6V2fqMh/RjfBv6J9jEvbndoYSrw3PdPipLGRkS8TCLsHpxvFvBvydDoj7tTOhZSAxv3MEoP4M4SyCmminng9wJkBcPa7twMAzeG0LpNK7uzReyMwInvyYdWt6BO25mDlFlQAcFOifZG+dtDip7MdHDzWpYmnTJO11P2ImO6+8SWU0CNUeeQNhjKNEzWSiV/Bam55YJUF+ZhpPBA+aoqHZHNjVHCe8EIgm1DQkXI1IBoXJg2dvTTSlEF6FehoFk8tm74EoFfI8veBISS7rwk7umOLI8eZPDa0woN5uW1aqeJ8A40mtKpI4n7nm3pTRkiNX+L4/jb+qTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691687; c=relaxed/relaxed;
	bh=+zAN299vizOOPECPls5C9ly2hX7A6i/wCUYEhdWTrYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jqy21RFAN2/9SiuUd/BAcIZwxDm4lPD4j9tkgyNbRkZftsBfdkE7QlzdDD6oKauiYBbURruMikWUCR5TVLsAuV/niZze40YtSc6JBhtyRG83oVUFL0Ix2W7qEzEmCQ7KW0zgJz/20e5ycUtj4PtaqRPxNqVkRTqQEF3IKuR0qQHnQz1IicGT1thVBckLb9529arYzOVWBZXOJQxLVd6AGD8E+8yhw/2WU3/wlrtAixHaRfbn47AOV0m34AaIW/8wFi4nvDDSBmqPSrrHEZh9qmMnvPprKgJEQQBrX1JxzjkKuGo1XUcDFxSi3mqj+Gjx923y/39PW4vhU8x85T1UBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJyTKMIe; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJyTKMIe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZv8R0Ghsz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:14:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0FFB943B27;
	Thu, 26 Nov 2026 11:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488AA1F000C4;
	Thu, 26 Nov 2026 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691684;
	bh=+zAN299vizOOPECPls5C9ly2hX7A6i/wCUYEhdWTrYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kJyTKMIef9KUJ7TrzxTw1NFRlFaRrs8sShSVVpag23heJBC0+PbBRsR1oW1Wkkfe3
	 /BEDq5VE3iJDg9scZN+INRUCab6B1pQg4aSTRrJ64C0kKSQyJj5olaROHEH5iUjs+j
	 8wKpdu+jFo2YDtHGgaZw4V+6poffdw5Oag7Yqa5qdXG3V3GPOwPnZgPhV6dXf9v76W
	 Sb0W8VbJ3BmR3nLdG+OyaPztr9yMUdYv/loapVRW0yE+e+WYmM44YbzJciMR6VYcE8
	 wGiDHGR3bmNJb9AN7Zbx5mEvbwquRTkTxaAYZtEGd9VyUgt5DRG8mbCQoHnOAjKSOb
	 +bMedTT8QILgA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:14 +0200
Subject: [PATCH RFC v2 01/54] riscv: do not use P4D entries for the linear
 mapping
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-1-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The linear map uses P4D sized leaves with Sv57 since commit 3335068f8721
("riscv: Use PUD/P4D/PGD pages for the linear mapping"), but riscv has no
p4d_leaf() and the generic stub returns false.

As a result, kernel page table walks treat P4D leaves as tables and wrongly
descend to lower levels. This affects the split in set_memory_*(),
kernel_page_present(), ptdump and the hibernation page table copy.

Stop creating P4D leaves rather than teaching every walker about them, as
commit 629db01c64ff ("riscv: Don't use PGD entries for the linear mapping")
did for PGD leaves.

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/riscv/mm/init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 070ee69eabb3..e1bcc3a16129 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -717,10 +717,6 @@ static uintptr_t __meminit best_map_size(phys_addr_t pa, uintptr_t va, phys_addr
 	if (debug_pagealloc_enabled())
 		return PAGE_SIZE;
 
-	if (pgtable_l5_enabled() &&
-	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
-		return P4D_SIZE;
-
 	if (pgtable_l4_enabled() &&
 	    !(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
 		return PUD_SIZE;

-- 
2.53.0


