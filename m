Return-Path: <linuxppc-dev+bounces-27626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555A5C982D7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:43:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm1lW6M26z2ynZ;
	Fri, 18 Sep 2026 02:43:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789663383;
	cv=none; b=a0KjdXQLyo8dif4yC84cNEOpHmfWgVqenisG5wBOkICOXhwDxSR0b3rQnIfoFQJM+REOGCePmQgeZ8gOk84SDtWSANj4yOsotBXzxdEGUUJwODidiC8Vn1cXNRKtV5/RJyyY3ONVX17whXeYHIYifjAoa+1YkfVajxDBZ1aZr8nN/QgkLfWtpMWceQQTg7ynxkJcHDKc6Y3znVfd8bGTCrn7m1zOyWjCVdVtzswR1QLofcVG8jSK5kwTdDHKIAA/8OfwpxiZSDoqaWUwLjXpPjsRP9obc6J4YMmvGEKTVXmrVbGOtIrlbwvLBG1dVKPAkU6I5oENiEch1ls1t8oDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789663383; c=relaxed/relaxed;
	bh=6Dab/JGj5h11GJwmfZC2qp9KBu5kIrwqs5kjA45qPyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJcBGDBdSHOuKNusbvJD+QpwRZuAX9sY4nPX41HCtKuVEe8sOGbpD6+Evbp7Q67FusDv3aDs2udMYajYAt+CU+SiEfgn6fVfpiQG47mX2cD0MoR6pRPPiaDBNGQhoPad93jFo6GEiKLg2YQfUACS4hGqoOolKn2PUywOWhX+hFBHFoS/pQMDbVbBAt8gwsTNFEJ2OpsuFCLdNwePhUmKn4KOfdQBE+2hDS2zvaC2ZEOIZP74O56G7nkIDfiKtgZtfp25PD8t+QgR6bUHh80RTtap2RoIk2/jI9dReuGqIr/p8RkeqkV6rYkEXD6ht4SWVE336ouPzBQ2sHsThD/ydA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VX8sd0/6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VX8sd0/6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm1lW0PQPz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 02:43:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CB8F960230;
	Thu, 17 Sep 2026 16:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A367C1F00893;
	Thu, 17 Sep 2026 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663380;
	bh=6Dab/JGj5h11GJwmfZC2qp9KBu5kIrwqs5kjA45qPyk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VX8sd0/66chGwBSXTRN6xewgRxbkdbYKvu8TXFtU97j1gbO5MtY4GA3FuN4pxa8kQ
	 sJFEbTFNFVlyAMa8Na6QNMRSq4oSA2gdS7Gui7OgLAi4IQQEmsyqhalKYGXl/bRxNX
	 D/3ycl79FQ5ht15gqYWhPEtIXytHr54JCpZjtE74fYeYcilBPDWfVgMKr2V1oU/68Z
	 G8QA8UvvCFGiQf+kJvlF9KEewMqtI6KFQNL2DNfh1SCDpC9shan+s0AyJYsTXjtS55
	 kKPDtzbkzQHcQvlV0ZfbpqeyZW2rJ1hQkTlYasEVZKlfMcTqdFSz8jOjTnyvV7i/MB
	 wwiohy6LPq+FQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 17 Sep 2026 17:22:48 +0100
Subject: [PATCH v3 39/40] mm/huge_memory: remove vma_is_special_huge()
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
Message-Id: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-39-4583d8a23bca@kernel.org>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, 
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
 Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Michal Hocko <mhocko@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Xu Xin <xu.xin@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
 linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 fuse-devel@lists.linux.dev, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897; i=ljs@kernel.org;
 h=from:subject:message-id; bh=2A3Cmsn/41H3VCQe0yUXH8gcl1gq+lw+YTsrD11Z3Vo=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLWCB9lesOuX7ti9tWy2c9VHG+vaQz+v+5YpsmCpzf36
 +yddNxVv6OUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATSSxiZPgjojDnQIHWZ/7i
 7KigVRu+qSZ3zDwz3WZ1X3jD3fN2uzkY/tdPWPJHbRnXvkl3jv1m+3NH3lmwI/DhuRfzVp0wPNM
 WvJEDAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

vma_is_special_huge() tests whether either the VMA_PFNMAP_BIT or
VMA_MIXEDMAP_BIT is set (i.e. whether the VMA is a kernel-owned mapping),
but with a DAX carve-out.

DAX however no longer sets VMA_MIXEDMAP_BIT, so this carve-out is no longer
required.

Therefore test for vma_is_kernel_owned() instead and also drop the
VMA_IO_BIT check, as it is now redundant since it is enforced that only
kernel-owned mappings can set this flag.

This also eliminates another overloaded use of 'special' within mm.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c3c98ea672c3..3cb8e2d4d65c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -110,14 +110,6 @@ static inline bool file_thp_enabled(const struct vm_area_struct *vma)
 	return S_ISREG(inode->i_mode);
 }
 
-/* If returns true, we are unable to access the VMA's folios. */
-static bool vma_is_special_huge(const struct vm_area_struct *vma)
-{
-	if (vma_is_dax(vma))
-		return false;
-	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
-}
-
 static bool vma_file_bypass_thp_tuneables(const struct vm_area_struct *vma,
 		enum tva_type type)
 {
@@ -192,7 +184,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	/* Check the intersection of requested and supported orders. */
 	if (vma_is_anonymous(vma))
 		supported_orders = THP_ORDERS_ALL_ANON;
-	else if (vma_is_dax(vma) || vma_is_special_huge(vma))
+	else if (vma_is_dax(vma) || vma_is_kernel_owned(vma))
 		supported_orders = THP_ORDERS_ALL_SPECIAL_DAX;
 	else
 		supported_orders = THP_ORDERS_ALL_FILE_DEFAULT;
@@ -3066,7 +3058,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	orig_pud = pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
 	arch_check_zapped_pud(vma, orig_pud);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
-	if (vma_is_special_huge(vma)) {
+	if (vma_is_kernel_owned(vma)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
 	} else {
@@ -3222,7 +3214,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
-		if (vma_is_special_huge(vma))
+		if (vma_is_kernel_owned(vma))
 			return;
 		if (unlikely(pmd_is_migration_entry(old_pmd))) {
 			const softleaf_t old_entry = softleaf_from_pmd(old_pmd);
@@ -4765,9 +4757,7 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 {
 	if (vma_is_dax(vma))
 		return true;
-	if (vma_is_special_huge(vma))
-		return true;
-	if (vma_test(vma, VMA_IO_BIT))
+	if (vma_is_kernel_owned(vma))
 		return true;
 	if (vma_is_hugetlb(vma))
 		return true;

-- 
2.55.0


