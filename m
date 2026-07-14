Return-Path: <linuxppc-dev+bounces-24240-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DF7C44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:08:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Nn2hCGz3cJG;
	Wed, 15 Jul 2026 00:08:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038089;
	cv=none; b=YcX5MPTo4ErmNT9M8V3OsqMVK9Ujjb3WlMJ6XKXhC4xgpUr8XVkyr0d/i+62qIhp+5oXNAd2oAOViXo3134WneIjYpPkvWm0lKxpmJQb+tigpqarqdV6MzAHQa13HDPCVRUgFE5i5Tosb4D59DPOrigKX3MDRmhqhW6W2hQbMpbLtx5pbsiavPfcjwFBmViKr+W/8Z2T8hoHdPaauw1RAXtHk+4hcz300qFVoTcorQUebT0sBUojALVNUEH9yleZJVR9cW1qh/sE/orABYNPvWunNUb280zu5OtfvIL7JzBvA8Khdz66GaldK6FV0UKiDTOxRLs4kWqh61OwWcJVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038089; c=relaxed/relaxed;
	bh=KoCRR95PLYnVxjBQ0+K98Mlg61rzeKsyaOHBI9FlQ+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMhvzgp2ZB29c7cDbMj8yb6r+a9a/OAsMoAFgBwXGPnMQWR5eLKs/PszrDCFNEcJP2+iiLRAEf1ms8vlVXtngqpSFtHcBTRdaFyZ/CMoQUSh6DrJ0Oz+A5SeitwIvnQjSLEFNbD52mcj7OC7mc7liBMOybnajEWHQQva51ewNA72I4/Zx+KzPU6Z2V/6vVF/g2T9jVfjiwgsgglsinFmbRhE648vfg38OQiWqrv1iqPFFQCcnN4QnS/LPeWaGe5jH2hJbkpW+8vNEa4uwhSI7SST51rz15U/07t+jVwTqFDEs4Xf1k2PjNq5xt6i+rZwGY6piyjK4FLy3VFNOKJD6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X2EPALpi; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X2EPALpi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Nm2X5sz3bpx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:08:08 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B74CB1D14;
	Tue, 14 Jul 2026 07:07:32 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FA7E3F7B4;
	Tue, 14 Jul 2026 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038057; bh=VrWlMtHqgM/vx22jiN3vYsU+W1Lh9jxCM8/DJ3H1HHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X2EPALpiGXj7jZ//umW0i2ZiscPs5c3b9FVhjQsTjSc/roIUOCw5ccwKbAM8AZVT0
	 R190qpIisEqdGcWQOaI8LP3WSMdBvOg2L0DaCq9z+740FCzemmIORnkMA6TGphJBf+
	 c9VjfZElkzX4N0E1s95w/Vtd50JJkhxZY+d0MtYw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:08 +0100
Subject: [PATCH 19/22] x86/tboot: mark tboot_mm as a kernel mm
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-19-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>, 
 x86@kernel.org, tboot-devel@lists.sourceforge.net, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
 Vishal Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1553;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=VrWlMtHqgM/vx22jiN3vYsU+W1Lh9jxCM8/DJ3H1HHw=;
 b=m8zZWjxysI7gu08ZC5WjroF8ppS2XmCi+NSg9AchPnK6c6wz3EcnLIwt4UrkZ1Tknhd8Uq+lO
 humwu8pswzNB3IZSFZsQqWeKm+RG8SsPRg6CN1eLU7ZKufXomLaUKal
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

tboot_mm is a kernel-owned address space used to build the
identity map for tboot shutdown. Mark it with MMF_KERNEL so
page table allocation and initialisation code treats its page tables
as kernel page tables.

Having marked tboot_mm as a kernel mm, we also need to convert
pte_alloc_map() (user PTE) to pte_alloc_kernel() (kernel PTE), and
drop the matching pte_unmap().

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/kernel/tboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 46b8f1f16676..08c899f88e41 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -99,6 +99,7 @@ static struct mm_struct tboot_mm = {
 	.pgd            = swapper_pg_dir,
 	.mm_users       = ATOMIC_INIT(2),
 	.mm_count       = ATOMIC_INIT(1),
+	.flags          = MM_FLAGS_INIT(MMF_KERNEL_MASK),
 	.write_protect_seq = SEQCNT_ZERO(tboot_mm.write_protect_seq),
 	MMAP_LOCK_INITIALIZER(init_mm)
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
@@ -129,11 +130,10 @@ static int map_tboot_page(unsigned long vaddr, unsigned long pfn,
 	pmd = pmd_alloc(&tboot_mm, pud, vaddr);
 	if (!pmd)
 		return -1;
-	pte = pte_alloc_map(&tboot_mm, pmd, vaddr);
+	pte = pte_alloc_kernel(pmd, vaddr);
 	if (!pte)
 		return -1;
 	set_pte_at(&tboot_mm, vaddr, pte, pfn_pte(pfn, prot));
-	pte_unmap(pte);
 
 	/*
 	 * PTI poisons low addresses in the kernel page tables in the

-- 
2.51.2


