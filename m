Return-Path: <linuxppc-dev+bounces-24232-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037CCC44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01Mb4gNGz3c52;
	Wed, 15 Jul 2026 00:07:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038027;
	cv=none; b=j/aYwztVdGBMsQzyyZ8DjgZEccNmtxHyxyGhwtCSGDgF8c6MYD5VmWnM9WUbSpejD21mVmb1XW1/ZDpd9oFTgavOBjMbydFRcC2eWfcs0lFSL64OCvr/cKwEoS23iUHiJ3VfjGqx7e0/689wX5R28hauaRa4rqt059KOBcu/RQFmNWJd8VVo2MPxBF7BwpGl7208D7X949YreIpXnZPqJkNMs0oI2E6j26/4iIDd5XjnEoaWPq9PpZdUZgoA3BD/Ow2bPLgxn2+Fx2PPrb4d14HzVFnaSXTyEfdWFq9HbQMtov5XV4vLwjXkcm3MelXz004lDLDbj1A+nKdmfyGajw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038027; c=relaxed/relaxed;
	bh=iM8SB61kZfRlZBBjK1HisTzxprKerLF7NioQQq06LHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAvOIRKshGNSZs2AeW9SWgijR+l0s8tga+17wM8KcOoxtOjUpxqkZ2W5ixCuHRb4VAuaabXvYWpu+vqVKUD7OfHKSKVF/Mg5b7SIVIJF/CQN+kAJ/niqbM7q0MgfBDWlM2sqlMmiouVnhq7nqfnacZUiIlxffNKt9P+2Tc0zDP8Q2+nw92gWrl+ZoOBzHdvNB7lo94T+KpFAOsnVd9RjISSxxSaIDQoyKqdZe2FWYEjlL1WKGVNV1vLFnw64BvsTSvxguMdNsdE4Vvwx2zmLkhvvdRo/6JQXlRv0Q/Xlq7HgegjqdHtAGzli9CoNQirp1j/Q/hSts/nvHR888IEShw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YzY9thwi; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YzY9thwi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01MZ4M3Wz3c4y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:07:06 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8A9E1BF3;
	Tue, 14 Jul 2026 07:06:30 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE3913F7B4;
	Tue, 14 Jul 2026 07:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037995; bh=brubU8ipNy1ujnPWOSJsU4D9Csfsl5oNxDWj3XnSBxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YzY9thwiHc65wNiUxU67y6/tJ7ZmfWCBeoA2a4LNQMo0O7ibHK6ctA9ComeTUEm9C
	 I/qi+0IpZSq41xPb+OZ7Z3/G4uCkw9cLd6IhSMUabwxmOQOqx2sF6D5jJAoetl8ck9
	 oA5zuyScXswzHCcI9ibhnX1aroPeO+YpvDY2p/3g=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:00 +0100
Subject: [PATCH 11/22] um: mm: use mm_is_kernel() in TLB sync
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-11-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=784;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=brubU8ipNy1ujnPWOSJsU4D9Csfsl5oNxDWj3XnSBxg=;
 b=/PzTb9tRgc6q7ZO/WLmLmpzghLV5CdRWiA/u95e31NiKnKwzFm+3cKJU2/zrnT5S/P+reJB4V
 ezvWWMbftRCD/SWI9ofvYfumKl5AhLTyCVWAwhB/2VFq3mOJHXdgNVl
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

The new MMF_KERNEL flag identifies kernel-owned mm's. Checking the
flag with mm_is_kernel() is preferred over comparing directly
against &init_mm.

No functional change, as only init_mm has MMF_KERNEL set for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/um/kernel/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 1f175716b474..fa34a710203e 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -171,7 +171,7 @@ int um_tlb_sync(struct mm_struct *mm)
 		return 0;
 
 	ops.mm_idp = &mm->context.id;
-	if (mm == &init_mm) {
+	if (mm_is_kernel(mm)) {
 		ops.mmap = kern_map;
 		ops.unmap = kern_unmap;
 	} else {

-- 
2.51.2


