Return-Path: <linuxppc-dev+bounces-24236-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEBCC44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01NB4Xzwz30HB;
	Wed, 15 Jul 2026 00:07:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784038058;
	cv=none; b=AIge7lP29KIbx/Wiw3irQIOmkPJ+yfnpnVZRwnRkH/Qa9+bK8nTTYWZC0zbrz5qaDZXvQLkGKrCo25DTK4cTxUMZ8PDt0aYjU2lEjDaus/BDPFFuyojX1NuHG7Sfeed3IeHuqAFlA6qGQrrvTER3Yh2KY8/C0LLKxcwb9mhz/6yT/IsuUt4S4hvraxedOoPIjzRhb+72VUX0BsbvFvecEkPb8v/0/ajPi+2wBp+M3IZIvBf2uQj5My6JpkYh6JZnhmyKKwiseC6peDLiSyz3PgmQqV3vNcSqoxzEMxeafDE0EVsnzngpsF4yH2suUb+0W68FsQCLhnRX/AP2C+5lFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784038058; c=relaxed/relaxed;
	bh=r2eT5LgtVDR1PdMidQbZQUNMVcJjW/kv+exPqkO9uaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g69eb9xKT7blA5W9yd5vkAVRvQi1XzH0CsNVuVKDYlMF62YDjv1kN/imrQKsjDECE1L80XjnM5oo82HO/fiA5qgP1QcjySTIsJNvZKzlE8gRbKPSuCdEyAKPHXj5IsOZDHTNA1pU2m1KeJP/TNTmTiSJBag6Jt8gVo9gz10IiVRYqrSbjP3P4OPWCDQt0M2sjwHzv/WEKE/6pZL/6JY8xkIzX2iWRJjK0hJeFxrBshLBJqs+cd2EZd/VWS5EGePjYZ373xrpIBlrVm0xbxbDyzrvL9H5VE5Sz9jJRbFWxpnwIK0eeZVDhyze7YvWNnR0+URHwMwABy4KGYZKYkVXMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CCHuQj4b; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CCHuQj4b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01N94bZxz30DH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:07:37 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE41D1576;
	Tue, 14 Jul 2026 07:07:01 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6BF83F7B4;
	Tue, 14 Jul 2026 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038026; bh=wRRvDY7vvj6o45l8yT2Q7WPIKaOL0Wfu1AKN4gUTBNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CCHuQj4boJkfZHO19ek7AVQhcn2j5x9Inj92YhvCDOQNMYxw1wJHqVP3lNtmrXDor
	 z8dfztuTF5HxmmtkzWEn0bGB/ntiIdARdTp3OUTIiy6d1Pv6qDLGuwuR1khXjO+Vzy
	 5ViCvZtIVrztie1QTQbSWYbDcViyYQGhZmv5eaSk=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:04 +0100
Subject: [PATCH 15/22] mm: only initialise pt_share_count for user pgtables
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
Message-Id: <20260714-remove_pgtable_cdtor-v1-15-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=1093;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=wRRvDY7vvj6o45l8yT2Q7WPIKaOL0Wfu1AKN4gUTBNM=;
 b=Ly1CUGmQU4MNOAvYijXTm6a0Oy5bg25WoXD9BoAv+N4SapepeLDfsykLmzz2cpJ5XS9tuoOVI
 p8vbo57maMnDOD6whiBPPJLuCq0Skgv9I5RprwD5SM3O65zdB1a2N0T
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

ptdesc_pmd_pts_init() initialises the pt_share_count ptdesc field.
That field is only used for hugetlb tracking purposes, so there is
no need to initialise it for kernel page tables. Skip the call for
kernel page tables, like pmd_ptlock_init().

From now on pagetable_*_ctor() and pagetable_dtor() do nothing for
kernel page tables.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 94f0fb1c662a..b217ccbed5a3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3905,9 +3905,12 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
 				      struct ptdesc *ptdesc)
 {
-	if (!mm_is_kernel(mm) && !pmd_ptlock_init(ptdesc))
-		return false;
-	ptdesc_pmd_pts_init(ptdesc);
+	if (!mm_is_kernel(mm)) {
+		if (!pmd_ptlock_init(ptdesc))
+			return false;
+		ptdesc_pmd_pts_init(ptdesc);
+	}
+
 	return true;
 }
 

-- 
2.51.2


