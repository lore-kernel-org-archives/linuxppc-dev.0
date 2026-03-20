Return-Path: <linuxppc-dev+bounces-18524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC561099B37
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 19:41:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fctDx5ny5z3c2R;
	Sat, 21 Mar 2026 06:39:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774035585;
	cv=none; b=QpPj9eTe0CN4vrRrFykkD1QpPYA+WmCOjajBDsa759Vc+a23kzHAyQZcdnXG2vYEo4ZQlAii1VDhYyjISIXgrPSGFo3fiBjnrbusL16LHDdJupx+yBO4excrPJJ7p5vvLMnUz3vn0++6WuIIzNpFjbcjV9QPh1JLbVLtck2fjqAm8xpGhnycY1A7RVkBunP0tg30xppNFaedwoqsS0I004HRSbvZBzHMYEPaT9amoGTul5bC61Y5dZcB4ahdFjfYsGO7DHDGxJWP4xQC5td8To7QR2CAunfZitdpQkK8NBodZGIxIuYVcfo+KIpcTwMywN9qt2W7Hjl08peUYdOoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774035585; c=relaxed/relaxed;
	bh=MF3HDfZN/X2IuMlCa6w9U893UanxlzUmNuSBnCYYxSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzEzPSOJkCuOyg1HGROt/6YZmQeH4rxtwnzHiAWT3RcRo+qbwWN2GlAK+Scnk9cninrd5anoe8vR7qYD2rO2gqGPF1tr9tVUABHdVNEeIgVzvVXo6hiIQ7MqBwO2qxL/1+OIqo7NVKe/2SPscADYG3sVxv0gY73NQTEadZLYvJaK5++r3GP28azltmVjp4r3o1rp2ViIfLmq5XHmPYhMqZI2pMTKCaI+4G9yEMD1P6zrSpwdY550QyLGCyZ7J2EHkAuGk7j8NAzcvjdP9qUh+TTJK+EYBfKN3tM8rgzkXXynY9/XqEcjpRvjkfETOu2B4FmY+DYyjjnonqwu/SVZzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YNEQNMxC; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YNEQNMxC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fctDw6ppDz3bm3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 06:39:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 891DB61857;
	Fri, 20 Mar 2026 19:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57BFC2BCB4;
	Fri, 20 Mar 2026 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035582;
	bh=Zhv1fm6PGlE9I5DuXJBB0cLrVMXpxk9UQr3R6GGX2pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNEQNMxCWbltp4ulEcA/1pi0w9rAVKrTGQS8+v4PLs+aFYEzztK3IIefy1UFIkuOR
	 rTDQcWY0SioZrCgW7IXmcLKciwKlGXqabHTR/PcPYieqDzBPZ60XqkkxP5s59rZg1A
	 xan9A1ghdC6iIBLyXGYzuD8n0RYMLN+9ymJTqE/THx9LECKRwfgZYXza+nT86iX/k6
	 8p+GKYR5eQNho+Uv+ID2mHduFoCDPEsGOedTudZT9YZBqkya5QuQ6VKpjiS64ChS4F
	 YZzIJnzVkO0R7vQNfDQ1O4zJG1AtpdIzGw2MrsNefJt4teIMi0TcMEfp1mYeAj2lCz
	 AoksKkIoUqu0w==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 25/25] mm: simplify VMA flag tests of excluded flags
Date: Fri, 20 Mar 2026 19:38:42 +0000
Message-ID: <d395c5dd837a9864f5efcec42175910afbe3ce73.1774034900.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774034900.git.ljs@kernel.org>
References: <cover.1774034900.git.ljs@kernel.org>
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
Content-Transfer-Encoding: 8bit

We have implemented flag mask comparisons of the form:

if ((vm_flags & (VM_FOO|VM_BAR|VM_BAZ) == VM_FOO) { ... }

Like-for-like in the code using a bitwise-and mask via vma_flags_and() and
using vma_flags_same() to ensure the final result equals only the required
flag value.

This is fine but confusing, make things clearer by instead explicitly
excluding undesired flags and including the desired one via tests of the
form:

	if (vma_flags_test(&flags, VMA_FOO_BIT) &&
	    !vma_flags_test_any(&flags, VMA_BAR_BIT, VMA_BAZ_BIT)) { ... }

Which makes it easier to understand what is going on.

No functional change intended.

Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/mprotect.c | 12 ++++--------
 mm/vma.c      |  7 +++----
 mm/vma.h      |  6 ++----
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 007d9a72b2f0..110d47a36d4b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -784,14 +784,10 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
 	 * fault on access.
 	 */
-	if (vma_flags_test(&new_vma_flags, VMA_WRITE_BIT)) {
-		const vma_flags_t mask =
-			vma_flags_and(&old_vma_flags, VMA_WRITE_BIT,
-				      VMA_SHARED_BIT, VMA_LOCKED_BIT);
-
-		if (vma_flags_same(&mask, VMA_LOCKED_BIT))
-			populate_vma_page_range(vma, start, end, NULL);
-	}
+	if (vma_flags_test(&new_vma_flags, VMA_WRITE_BIT) &&
+	    vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT) &&
+	    !vma_flags_test_any(&old_vma_flags, VMA_WRITE_BIT, VMA_SHARED_BIT))
+		populate_vma_page_range(vma, start, end, NULL);
 
 	vm_stat_account(mm, vma_flags_to_legacy(old_vma_flags), -nrpages);
 	newflags = vma_flags_to_legacy(new_vma_flags);
diff --git a/mm/vma.c b/mm/vma.c
index c335f989586f..a4b30a069153 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2343,7 +2343,6 @@ void mm_drop_all_locks(struct mm_struct *mm)
 static bool accountable_mapping(struct mmap_state *map)
 {
 	const struct file *file = map->file;
-	vma_flags_t mask;
 
 	/*
 	 * hugetlb has its own accounting separate from the core VM
@@ -2352,9 +2351,9 @@ static bool accountable_mapping(struct mmap_state *map)
 	if (file && is_file_hugepages(file))
 		return false;
 
-	mask = vma_flags_and(&map->vma_flags, VMA_NORESERVE_BIT, VMA_SHARED_BIT,
-			     VMA_WRITE_BIT);
-	return vma_flags_same(&mask, VMA_WRITE_BIT);
+	return vma_flags_test(&map->vma_flags, VMA_WRITE_BIT) &&
+		!vma_flags_test_any(&map->vma_flags, VMA_NORESERVE_BIT,
+				    VMA_SHARED_BIT);
 }
 
 /*
diff --git a/mm/vma.h b/mm/vma.h
index adc18f7dd9f1..1bfe7e47f6be 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -529,10 +529,8 @@ static inline bool is_data_mapping(vm_flags_t flags)
 
 static inline bool is_data_mapping_vma_flags(const vma_flags_t *vma_flags)
 {
-	const vma_flags_t mask = vma_flags_and(vma_flags,
-			VMA_WRITE_BIT, VMA_SHARED_BIT, VMA_STACK_BIT);
-
-	return vma_flags_same(&mask, VMA_WRITE_BIT);
+	return vma_flags_test(vma_flags, VMA_WRITE_BIT) &&
+		!vma_flags_test_any(vma_flags, VMA_SHARED_BIT, VMA_STACK_BIT);
 }
 
 static inline void vma_iter_config(struct vma_iterator *vmi,
-- 
2.53.0


