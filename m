Return-Path: <linuxppc-dev+bounces-24238-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F73C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01NT6bLXz30NF;
	Wed, 15 Jul 2026 00:07:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038073;
	cv=none; b=gSeblVywm1m/tdpPZPC086IovONt84HOpSnRwrxmZ0s/NBRxH8S7y3uLLndMKmJTDMLRmItQ5jl+0B5sX3CRt7FiyASCBPuE31Ms9HKWS2fVGUDsuCDY0T2t6z+7pygZJQ/yUnsYB22PhLoxviZsOM67QTXZDfI7yz/HY1Xxf5kIpqKEju1W4RpH6TyCWz/T9HVn4Pl0aMv53LovQBjYmN+wl/hZR+OaAZTTBBvt0yO35QzGHO2HKr9j+8z1Dy+xp+f4pUCJ8Eg1g8bon8+wVIt0FHzP8mWq0XaU/qpPxSY7jQPaUWeVWCM+mySvEcRS1gUfxRpNqcuwc6qa4Cvx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038073; c=relaxed/relaxed;
	bh=2AtuGnMkKUmg5Fcb42sI1/yhBOPgS1GscsBtzFqMWqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZUm3dQgDqzTwrTyFqPkH7AQWr08xYDr13J2Qy6/i/wjm9PPlro1cVsTjnxt8BDzK85bFzv39Fw3YGz51pDlb3ct+i48mOESdJlAp1Ow9Tb3c4ZcsFJo1F4jWYXfiFCWDoygQ36d+KzuejeMnOOKQOcwn7z/DzWtyviYpI3xvOsOgRfXUkLvHYgkoJ9dGvCCSQIG3zI0/hx7ATXDNRt0RhH33N4TR0U/N1ZlJsDuUL24+sVgzHLTUpoluQsFKbI1mqpSqiNLSfnjoJ0zZ4kJtcWjovuTGSr5AuRwVFM6aP6kFYO5cL9Ti3vDvkwXkE7bMyIMmOqbKFcJ8dAhp22rfpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tcs2QjbO; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tcs2QjbO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01NS5c38z2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:07:52 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49CFE1CDD;
	Tue, 14 Jul 2026 07:07:17 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211913FBB1;
	Tue, 14 Jul 2026 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038041; bh=W5yMHnXfWcnH1ZpiyUJxzPFiGyzR0nmofTO/4v3XglM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tcs2QjbOfi2UrOaEb3Be0yDpY6GZomCe7QbbhuAt79rvxsFv0nPzL+CWkgYpCVks/
	 ogkFHzzFifaJTeH1MCRm+XyD/611Im1Ut2kp5sQ9dzHO1o7eUkGFrrRiH6Z4V/RDtz
	 /vlFqoX8JwYVcEUc2qvYwpr+Gn4LoNg3DQ/uWfI4=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:06 +0100
Subject: [PATCH 17/22] mm: pagewalk: drop redundant address check for
 kernel mm walks
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-17-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1902;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=W5yMHnXfWcnH1ZpiyUJxzPFiGyzR0nmofTO/4v3XglM=;
 b=TFBgeJD80Ix+w11MAOvfP3+Vh87dI14Hnq0FHr8NrSRBwD9XPKoZw/aAqVJc1+sG5OV8cIA+P
 hlg2L1E8nGiAdR9B4tzknmDLhA26Dhv64+3Fs4YGAcZ8Y3UcdoWIKP6
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Commit 8b1cb4a2e819 ("mm/pagewalk: fix EFI_PGT_DUMP of
espfix area") made no-VMA page table walks use
pte_offset_kernel() for any address above TASK_SIZE. This avoided
pte_offset_map() validation on EFI page table dumps, where efi_mm
could walk x86 espfix PMDs that intentionally look bad to pmd_bad().

efi_mm is now marked with MMF_KERNEL, and no-VMA walks use
mm_is_kernel() to select pte_offset_kernel() for kernel mm's. As a
result we no longer need to handle the EFI_PGT_DUMP case explicitly.The
address check is therefore redundant for EFI_PGT_DUMP and makes the
condition harder to reason about.

Remove the address check and associated comment; mm_is_kernel()
should be sufficient on its own.

Tested by booting x86 QEMU with CONFIG_EFI_PGT_DUMP=y and reading
/sys/kernel/debug/page_tables/efi.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 mm/pagewalk.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index a3f47d1de3c5..0dd9d4ad9b68 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -68,17 +68,14 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (walk->no_vma) {
 		/*
 		 * pte_offset_map() might apply user-specific validation.
-		 * Indeed, on x86_64 the pmd entries set up by init_espfix_ap()
-		 * fit its pmd_bad() check (_PAGE_NX set and _PAGE_RW clear),
-		 * and CONFIG_EFI_PGT_DUMP efi_mm goes so far as to walk them.
 		 */
-		if (mm_is_kernel(walk->mm) || addr >= TASK_SIZE)
+		if (mm_is_kernel(walk->mm))
 			pte = pte_offset_kernel(pmd, addr);
 		else
 			pte = pte_offset_map(pmd, addr);
 		if (pte) {
 			err = walk_pte_range_inner(pte, addr, end, walk);
-			if (!mm_is_kernel(walk->mm) && addr < TASK_SIZE)
+			if (!mm_is_kernel(walk->mm))
 				pte_unmap(pte);
 		}
 	} else {

-- 
2.51.2


