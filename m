Return-Path: <linuxppc-dev+bounces-24237-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B218C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01NL2d2Tz3c78;
	Wed, 15 Jul 2026 00:07:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038066;
	cv=none; b=Z3fLCRIU08Gdzlts2EoxMx7djauje+3q2JLOjp5PPbbKFQ1HC+WUw9w7hNk61yFKyRay0gUe3PiU49YkHkbaOpE3U++YxHnUbQCYnh3w5RtMBBXjLl9YS3+RDUAZ1jKIbBWDB0dWxanSvsTZ8oyMSgcHK4NrIcJ4lzpuTfdhn0mNXGL+iOHYSnfsKXgyPbd22BSPt+34jeXTAeU2GmK5pQCz3IczJEjD4g2jqqJKrCTT3JqGhYV5XmwkT4VeROd/8I4vGEE4HIJvRzQ8KkqTKKo8Bbqo0kQIg3U8alGoqVuTAvYzuQFUI4W0Raiqp+DpS1D+MO6mWFMK0HxtyHwIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038066; c=relaxed/relaxed;
	bh=biZLC3R/yhMAmfYncffmcVjM/UrFKnhHBc/APXxn250=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TMd6rvspeJEH5zgU7UH74iFuxnNx5SNBR/uBp1c4EC1SCqBW15KRAymYZTy+kDGb8NECu52QfbRlKahendkeBzVWN2Qetonf0h+5gVv72OQgUbXjB91pr6527R+uDMqIvIrJfv4KmKTTMXplU7sJwZlya4kzEYYD9lqFKmJRnfkT2FCcGy4Rtq0aZES2TfZD7O2DG6RaBJFd43UJTrE1AytQqiv3ABRbwpSVTi8Fn3ewNHrB1Ovc5ISfi62ixsRlqYGP9DgDu0rF5BAFItk6qdqKf/s45HQ3PRr3me5wlhEcNgRN2FhG3pUwNd6CZXLhUcb9yTe2tzMEsn8xyN7lZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=P+LRFNmi; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=P+LRFNmi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01NK2YBqz30NF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:07:45 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF3A1CC4;
	Tue, 14 Jul 2026 07:07:09 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 645503F7B4;
	Tue, 14 Jul 2026 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038033; bh=rJhmHjtmDwxS2CewudUO1k4saVZojxZevQnlJp6OZ7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P+LRFNmiDvhW3q79+Et/h/V1cKdtJE0WCcRDkD/ESazXMLOt5jc8Kgt41NbWh4J4L
	 irPYHd6dn5v2zgZP369nbxfm7fp2OsfV6xC2C9cTmmDmdF9sgXDGCBBMWKG6COr/1p
	 x9UUMt3JnkFOkdtZWVFuRaLX87Bjnkvu74XTX8nc=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:05 +0100
Subject: [PATCH 16/22] efi: mark efi_mm as a kernel mm
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-16-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1355;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=rJhmHjtmDwxS2CewudUO1k4saVZojxZevQnlJp6OZ7c=;
 b=xEbohehI3oM6XdwxICHsVginMSV7tAi9MA1ZH+OAmyTQN4j1iQ5NsQqwBRdPZXQYf6lyJ7RCE
 SjcaLPZMgbgBfEX879PTsxhhu4WlXQHubYLk+EEaXhOv3f1B8VSkhhq
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

efi_mm is a kernel-owned address space used for EFI runtime
mappings, but it is currently treated like a user address space when
manipulating its page tables. There does not seem to be a good
reason for this, and it creates unnecessary complications when
creating its page tables.

Mark it with the new MMF_KERNEL flag so that the page table handling
treats it like init_mm. In particular, this means that:

* Split page table locks are no longer initialised or used for
  efi_mm's page tables.

* pagetable_*_ctor() and pagetable_dtor() no longer need to be
  called for efi_mm's page tables.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 drivers/firmware/efi/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 0327a39d31fa..e5ca45bdc890 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -69,6 +69,7 @@ struct mm_struct efi_mm = {
 	.mm_mt			= MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
+	.flags			= MM_FLAGS_INIT(MMF_KERNEL_MASK),
 	.write_protect_seq      = SEQCNT_ZERO(efi_mm.write_protect_seq),
 	MMAP_LOCK_INITIALIZER(efi_mm)
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),

-- 
2.51.2


