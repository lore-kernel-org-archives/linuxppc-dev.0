Return-Path: <linuxppc-dev+bounces-27617-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF24C982DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:38:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm1f25Fh9z3048;
	Fri, 18 Sep 2026 02:38:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789663098;
	cv=none; b=MhPdn+P27OELx2aSuJSiUu9aw6wsZnohGzf4JpXC+a0pjprpD4BeOxVjdbJuTakqnlKqf2lUomwjIkp/EutCHTZbe3kGfMKyhgS3bIjI1bC21DysyjRV0DBiGH5fpcrZSkB5R+NyFdFly1bdDgyo8Cjr7Pstxb17PMiVn8iLEazqi7VY/pjccC5J3AGY5Gqq9vSW16tGiC8V8gA0/7ceu5bpUDogMpaBoJF4MCKijX/jSBfxoLPrn7TASKwAbSJnjq7JNYgvdPDbYqwqbZhQhuQOvf6MlbaCteYYPf6rEjZdTjzt+aaon1TV2eoAxcojtpsFgGaKrc7gJjc4SscodA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789663098; c=relaxed/relaxed;
	bh=rpQUY90Yz1fvoWb/n9qt0DfA+MP9PvsomcDJoStRF6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMrNKy3/FVaNlWOoMA4uQjedqWnRoOrBBDZ3Cpis1gMuqGKbEABpuus7833RMxiBxtaFfWlXVYDH2fkRnXz29qAA5J1BNrz5K2woN+kZZD99eYp9uCpijzF7VKWKNXJrRBj796jmVD6yhUp2ANpkWqicnlOK59lSKyWH0n44Ko9gdGLJ0bos94iLIFcltF5WfheO78VVepxPmQd9JmibyaZ5WrkqV8qOtjzlq3an5zL35rMYLOwdfPG2hiR9wKZuvvCxH0w9jKwOrMAgLmEEuPF9j+gI/09LgyEhaK4GWc7RR4oMmpHGGmFDFzXsdRR4Y25ByKOYMgY6g8cWOsXu0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ll2Iicn3; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ll2Iicn3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm1f16C4Cz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 02:38:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D6A2960216;
	Thu, 17 Sep 2026 16:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02B21F00893;
	Thu, 17 Sep 2026 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663095;
	bh=rpQUY90Yz1fvoWb/n9qt0DfA+MP9PvsomcDJoStRF6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ll2Iicn3dYLgP4VwRxvy63UrleSMOQQihXo/WomzR/sIEgx5GaKP4U+NW4Lb0bdNp
	 uKjkDJge8PuQIeTx9lnMRLm03IMp1Usw/GKzwcJQy9xCKnuyLOibVtPP+3NaWmIfZT
	 ZxaOtwCuRFmWdwDLcRNeXUWweQKJVep+O0QYRR3W5MGGqwDUTXSmmaGOrV9k3gu/Fa
	 u4yjykT0wypyKnk5NYG7PJcfN5++PgNEyYQC0MtsFxZyVsHLk1xvjf6T0bH/rgeu5t
	 NRxxmzLWXr+qmM0VFyQYndVUgdCXL+qJqjapaQtC3XKXDw2eAGFrjqHohQPTZrDgH3
	 R+ck8e2+gcVKQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 17 Sep 2026 17:22:39 +0100
Subject: [PATCH v3 30/40] mm/madvise: update is_valid_guard_vma() to use
 vma_can_merge()
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
Message-Id: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-30-4583d8a23bca@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; i=ljs@kernel.org;
 h=from:subject:message-id; bh=sRYt0UudvtAxeO0KRMBxTGrVTVnQqrjgMi1gjOlaTgw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLWCB9WPht5l03vgd2TQ69yb55Xv/rEwXSmdfm3m/rap
 meO2wrLd5SyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiZzMZ/oq8MfRPzp0m6HHF
 2O+Uz78FWXzx1+YWB72v57T8UWDxaAIjwwxWiS8XZ3ObaDKydWiYvLkWGv19mpb787Ol671e/RL
 M4wMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

We currently disallow the installation of lightweight guard regions in VMAs
whose flags intersect VMA_SPECIAL_FLAGS or VMA_HUGETLB_BIT, or
VMA_LOCKED_BIT unless allow_locked is set.

hugetlb VMAs set VMA_DONTEXPAND_BIT so this was already redundant,
VMA_SPECIAL_FLAGS already sufficed.

However, now that VMA_IO_BIT is only set if VMA_PFNMAP or VMA_MIXEDMAP_BIT
is set, this check collapses to being the equivalent of
!vma_can_merge().

Update is_valid_guard_vma() to reflect this.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/madvise.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 467601a8525b..0922d5f07a12 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1221,19 +1221,25 @@ static long madvise_remove(struct madvise_behavior *madv_behavior)
 	return error;
 }
 
-static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
+static bool is_valid_guard_vma(const struct vm_area_struct *vma,
+			       bool allow_locked)
 {
-	vm_flags_t disallowed = VM_SPECIAL | VM_HUGETLB;
-
 	/*
-	 * A user could lock after setting a guard range but that's fine, as
+	 * A user could lock after setting a guard range but that's fine as
 	 * they'd not be able to fault in. The issue arises when we try to zap
 	 * existing locked VMAs. We don't want to do that.
 	 */
-	if (!allow_locked)
-		disallowed |= VM_LOCKED;
+	if (!allow_locked && vma_test(vma, VMA_LOCKED_BIT))
+		return false;
+	/*
+	 * Guard regions require a VMA whose page tables are managed solely by
+	 * the core, which is also what merging requires, so disallow any flags
+	 * that would prevent a merge.
+	 */
+	if (!vma_can_merge(vma))
+		return false;
 
-	return !(vma->vm_flags & disallowed);
+	return true;
 }
 
 static bool is_guard_pte_marker(pte_t ptent)

-- 
2.55.0


