Return-Path: <linuxppc-dev+bounces-24242-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE17C44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:08:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01P46FZ3z2yY0;
	Wed, 15 Jul 2026 00:08:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038104;
	cv=none; b=ZYymYmgebFVhmE+zNqgRE+vo3E2+nqdQcYGG8lWFgyfU5fsoZBLsi/k0aCjxNBJAqoyxZYjBeyA/u2xERPsoP3Yymz4c/dcrWm9AeiK6stKtkRPb4GAPbJR1qmQ6BeKqD15sHSL4RYmM8FFcPGvEblFOeKWFGM4xzj4Yww2c0njmfnQinFSutktPI3RQJSXFelwSEJfVLsujipCA9zjGBQdEdZr25dFGJ7qalOGM8oN5bLFw+es+t1uAfIKMcDC69c8wZwujbmC2EqRxjU9oC51m3FfqBbT3ljSDs8y10s6ScSalam0FOtvAoGPBAm+VtEdK6DAsJS7KZNXffG0+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038104; c=relaxed/relaxed;
	bh=NDua9YY87aM7LX6RKGHHq5cosBzReZwnFG+9/6p63CY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5hvlEiHGVvbniN6rqgEc9TWr/V4w1RecmEC3BW6Mixw7TGrMCCNGR/10vqlpj5pDeM21ZTtOkILShlhzwEz8bc1kE9YC5Pjs2fKUA0ezyDsvTVq4bwiBeSxWwBFpLXG7/je8CVvCYI3PjrTNOkM7h/5UNqY+XxSiWmtEZ8BM0Es6MXnSAh4du9qJgRP2ufV3/4LJRlI4HosoVagU6SlLb2rXdLxbWhHQ0rbOfJ9L8CPtk4R7P44HnLimeIDJvVe3fq3O31ofqj7yaUsF9nkWIQPAmJefrAkEN4U4GhKIUtzjvWd8KEP+2HKOCRxFBbtqfiMTvdmoxuqFR4nKW3dRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vjhfq5hu; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vjhfq5hu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01P34d8Gz3brH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:08:23 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DE4E1CE0;
	Tue, 14 Jul 2026 07:07:48 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A8183F7B4;
	Tue, 14 Jul 2026 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038072; bh=8oYQ9MXuYWmm90weLSF/t4FrSgRMmgMLSgcdK785vME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vjhfq5hujZgmkhySuJNw6Ovi0ZDPllrwytdpUl1CFaMMmQ7YlrA+FTdxr6ytaSSAO
	 1u9NsJ08KRRDg8iJcOgusKSxciglroRswKdfyUOkoGu8QXjmncAKV2aqeRer5z/ygB
	 q8OYyTsSmA+9Qr1jQYJQdHlBqhCMBgipf8FFPhm0=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:10 +0100
Subject: [PATCH 21/22] arm: mm: drop ctor call for kernel page tables
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-21-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=861;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=8oYQ9MXuYWmm90weLSF/t4FrSgRMmgMLSgcdK785vME=;
 b=nhPVpPwxc0Tgep45F4r22gVJiYH4IqNiA/Z9S3Ix77hbH+m9X9zzxN6EovZVFIEF1e8oAreuL
 YHrL6dXW1utB0IBYjmbnRvx5pXQ0zPIU5EqMprfu37YqfA5Aaxh0XUC
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Thanks to recent changes:

* pagetable_pte_ctor() does nothing for kernel page tables.

* efi_mm is also treated like a kernel mm by the page table logic,
  including ctors.

We can therefore drop the ctor call when allocating special kernel
page tables in mmu.c.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm/mm/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 23b87b5ef7f1..c8de77a6f01e 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -728,8 +728,7 @@ static void *__init late_alloc(unsigned long sz)
 	void *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM,
 			get_order(sz));
 
-	if (!ptdesc || !pagetable_pte_ctor(NULL, ptdesc))
-		BUG();
+	BUG_ON(!ptdesc);
 	return ptdesc_address(ptdesc);
 }
 

-- 
2.51.2


