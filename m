Return-Path: <linuxppc-dev+bounces-26374-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D690BC624D1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 11:07:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ33D402kz2xpn;
	Tue, 01 Sep 2026 21:07:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788260824;
	cv=none; b=i5KTp+VLCXW7StzL6yZKWrmveiJZrjZpQYlQUgr9yO0Yn/QVUdsa/J7gwrc5aCTxoI118Cnnmju745BDUaDQa22LZDT0UDQyKp2MUFopEG5CWQBg8T4nskNG1ZRVguJQVDcWMEGOcM7HcCUssygNHZUW0WUePZO0Vhy6aanFrBl3ERAm9lxvkxAQh/rQJ1uxverh7CA8hMoUC8G+CGGS6rFOe/wn20vtPxNKpO2OVQtk4p8D5qP7x6mERelHEt8UcSf0bSIBzx17FpFEdCDWDQ2dQwdskkk9P4MqZotqLoZXMGIcXzU48zys2KuGQaPrh8MJz68BV63xYKIR+kQ9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788260824; c=relaxed/relaxed;
	bh=1aimUPxzYaTPXtJhtWkzW57/+8qeslpkAUz+f7GK8/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nxa/9IM3SLo9NOs0C5gCeVWT9ywYqxaIu0tOKg9eajsFXC0tWkMKZxd12b8VpgUBWr2aZVaUgNa+p6GEVm7iZazIrxGvPyk5jZ/1MoVfGv+3hajLHTLPTGuiT4f0+oAIidLSw8nLRKWmw4v1gQ7aGkHwD8rfNTPwCLCrx0gvVmDL1ZFQwMepf8AyqYwI4qebUXkgSX3uhECYBLr5n1R9sY4L7dfqSKUmd+BYN0dQhpe9/VJfTeM1PFKWissVY7sGWdiE8jv5MTtcqjRtI0m34k0DYZicQC5FsfnMmEP05v010Cg0DrKQ7I47iy2yT84zVzC9C7g+f4Kc6h2hED/kFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XD3oyzIY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XD3oyzIY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ33C3zsjz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 21:07:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E781403FE;
	Tue,  1 Sep 2026 11:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FFE1F000E9;
	Tue,  1 Sep 2026 11:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788260819;
	bh=1aimUPxzYaTPXtJhtWkzW57/+8qeslpkAUz+f7GK8/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XD3oyzIY4msLPQ772JhwLo0AmvI8pJiExLU3e3acDjohAHfqAlS9rlSLlt64WVSfM
	 r3kRTCUYRFXtwdrLXLd4zIwibTfWMnW/NDIIYUE6lAId+LAAlnedVWBr2YfRCEVFnh
	 NaU4l0p6UGv9r8gy6ABLmcwKqZFw1aYx2Pz8fy8/zPMOSd7woDX9/45BsOq29uxCFH
	 t67glyPsR7yypFVn1RgslLR+rEAEHQj1J/iNjz4RcFE6+mZcsM+M0zD52vr+Us6TCk
	 T4FBgX6sN7RoaCrUvJ6hGpa6JR9artGVasWEmFWwFE4AH8UoYRgRo/FGT9ifPsbukd
	 aB6GG57pdUC3g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 01 Sep 2026 12:01:27 +0100
Subject: [PATCH 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-coldfire
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
Message-Id: <20260901-rcu-pagetable-freeing-v1-7-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, 
 Qi Zheng <qi.zheng@linux.dev>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=ljs@kernel.org;
 h=from:subject:message-id; bh=qTT+GrBJ7CN/0g7aihQa6c1ZdVlLMdQ0LNJ7aV+6CtQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKmbfQIULyUGXJvk7x6z/RM7Xe7feOXy31ul/W6IvyVo
 XSrazZ/RykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACbSGsnw33vZ/N1+HBlPyg4d
 Z9inYfllvWvq5p/7s6qbX3+3iw4rCWRkmG8v0yi5/9js5G+fUmMi34cp/96XPWefUlWg8e7Pkmm
 cjAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Similar to sun3, the coldfire variant of m68k uses 2-level page tables.

Update its __pte_free_tlb() function to use tlb_remove_ptdesc() in order
that, with CONFIG_MMU_GATHER_RCU_TABLE_FREE, page tables are freed under
RCU.

The page tables occupy a page each and have no odd semantics, so this
change suffices to allow enabling of CONFIG_MMU_GATHER_RCU_TABLE_FREE for
m68k-coldfire, so do so.

This forms part of an overall effort to switch every architecture to this
mode.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/m68k/Kconfig                   | 2 +-
 arch/m68k/include/asm/mcf_pgalloc.h | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index e29610fd1240..6b8ec67c86fd 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -36,7 +36,7 @@ config M68K
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_UID16
 	select MMU_GATHER_NO_RANGE if MMU
-	select MMU_GATHER_RCU_TABLE_FREE if MMU && SUN3
+	select MMU_GATHER_RCU_TABLE_FREE if MMU && (SUN3 || COLDFIRE)
 	select MODULES_USE_ELF_REL
 	select MODULES_USE_ELF_RELA
 	select NO_DMA if !MMU && !COLDFIRE
diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index fc5454d37da3..b53ff0950db2 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -39,10 +39,7 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
-
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pgtable));
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)

-- 
2.55.0


