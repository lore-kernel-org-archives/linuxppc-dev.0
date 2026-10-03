Return-Path: <linuxppc-dev+bounces-28832-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9C8CA5FEF
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 16:34:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxrpL3w77z2yQH;
	Sun, 04 Oct 2026 03:34:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791045274;
	cv=none; b=RwiTnMtG5iySjFmppJ/sWx7/A9M5dC6vHT+ghqf/SxeZ/qRkfgT8Po4Rf0efrUywUtY1cLz+FNGqDFIGbuo0WRxsmUbvT5Th2CiHSxqHnZiK0NDKVJebs4Zov10xctZG5sDb15SqC6jWIJARvrMaewrOBH3VPdRAJjFKWka9nUjnSbywKrSyTrpyWl79xQ/ISBNat1Jw/T7+vKuSvuoOFeZijjYGmzrbtxgmeXrDN1nfy1mWkhCTQZU/NTNwU9Mfz6HwxaJBZOTiK0mVrdhYcKxdMdK8Kdo9kMYl+x1jhRyqtV77MJwdSIA97abK9OSj3OhXIeRRVEIBLLEoypzHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791045274; c=relaxed/relaxed;
	bh=ogF7sgipSOPhVjajN8MlTmmNbNQMZnNTSMv4O0r0r7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0pxHduTyIcUetRh01jpqpMfWw0pc+kYBtfedf3z5LX5SEw9zV88cD1IruD5+3BAckMpLfx2creTzVNXKFIk7AgibtbzzZ1nkGFcB8XfZ8wcKoYHB6MpGS/41u3UcrOHUooqy9yX0yC1mA4b+K5LE4P/xwMyMGxoFk22VLaU5LdrkIa5gwqmAt40/b5eQjHrU+VSFHUnL9yKUiaGV5NLU2qb8ibKzFRfZZUP2YcM7A8pK5Xe+q++RMDc0aLxxIhJfM+cmc9Pzl2tMdUEujoucajdDLHqtQMvwZm+TNOX3iKzmbojPSn6c52sXtECZnIteI2iaWyI5D4n+z++9EKaWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PghLaNpJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PghLaNpJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxrpK4tcDz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 03:34:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A4B5643528;
	Sat,  3 Oct 2026 16:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABCF1F0089D;
	Sat,  3 Oct 2026 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791045271;
	bh=ogF7sgipSOPhVjajN8MlTmmNbNQMZnNTSMv4O0r0r7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PghLaNpJmUw3Jhc9TPFy+1pu1xx2zdCJJXHgjmydeyW2ajKRzZOraCVCpQtUl+/yH
	 rp/bFllFSfxANFVUTUfh1P6gNXYfaYSme+nNWeDNXAvs1ZnCzTnUVnv7/eevp9EY6N
	 x5z5Es+384FGRYpWKXY7+6kBpit3IPGlFOTqgZ176pCd+X09Mf1GMwu1ROHrV6YCJg
	 oBijAvpEx58XzD+qLpZuxOh0WPKuQOwKx+btZqiiXdYsH/KoddNwF5eIeY8C2FZ1kk
	 /yGhJHMF/q2PN1nW2C3nYhyyximXIf+fvl+4GOXUA1LEG+XiK7FyFJHFXlM+RFm+si
	 uIuwWENWK0XMQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 03 Oct 2026 17:32:35 +0100
Subject: [PATCH v4 04/38] mm/vma: ensure mmap_prepare doesn't set actions
 on a mergeable vma
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
Message-Id: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-4-a1f052500fd7@kernel.org>
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
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
 "Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712; i=ljs@kernel.org;
 h=from:subject:message-id; bh=A0TtP+WEaYFM4Xa70Fpr782oGFOYjP8XY0ipqE17dfw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIO6qn93yjwaI1s2uRV7nEzv3S25j++vonDzjvIrofHr
 lu19BFbRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACaSuYLhf7nsGXkrYfVfH6d6
 5hQubZmn+t5372WtC5xcio/fXbm4pZiR4UT+9q8TjLLE1ANkVmX4vucuL8z3DZVbJypWp/W662k
 jPwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

When a user requests an mmap_action be performed in mmap_prepare, this
involves populating the VMA range with data.

However, if the VMA is mergeable, it might then mistakenly be merged with
another VMA without having populated the range.

Every mmap action currently available sets VMA flags such that the VMA
cannot be merged.

However, to ensure that no future mmap action falls foul of this, assert
that this is the case upon mmap_prepare validation.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/vma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index 159fd3ff8560..a9532bbd4ee2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2812,6 +2812,18 @@ static int mmap_validate(unsigned long orig_start, unsigned long orig_end,
 int mmap_prepare_validate(const struct vm_area_desc *orig_desc,
 			  const struct vm_area_desc *desc)
 {
+	/*
+	 * It is not valid to execute mmap actions for VMAs which can be merged,
+	 * as any such merge would leave portions of the mapping incorrectly
+	 * unmapped.
+	 *
+	 * This is checked after mmap_action_prepare(), as it may update the VMA
+	 * flags and therefore whether the VMA can be merged.
+	 */
+	if (vma_flags_can_merge(&desc->vma_flags) &&
+	    WARN_ON_ONCE(desc->action.type != MMAP_NOTHING))
+		return -EINVAL;
+
 	return mmap_validate(orig_desc->start, orig_desc->end,
 			     desc->start, desc->end,
 			     &orig_desc->vma_flags, &desc->vma_flags);

-- 
2.55.0


