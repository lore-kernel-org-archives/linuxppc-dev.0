Return-Path: <linuxppc-dev+bounces-17413-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCDBFD9E3A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 20:10:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMzwB4JfSz3bkq;
	Sat, 28 Feb 2026 07:10:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772223034;
	cv=none; b=ewy4Wh4AnyIZaUnPa1UB6JvPvoLguT0FexiFR52iW81apQmL8xA6fSHdKGFmawDcSGu0tbeFrJLeDV40e0SSlSBDPGwwDO1LwZwfBlPRnrcl/2sgTC2etZzNqdQl+4vng2Ejt4Qgu4PR2oEjqYIFtdREGncATkJ+P6wqjE+qi8HFl84deTQvgGZr5LktlarzDeIGkKFG8kFQSfnkfUAop8YrEP+i1QhmWZ1tWF5IqncxGAXRhKKKZCXVFEafybNNMeSr3cLJDrFH34MKj4WPvJVi+sf3W9420U3PLKY+ifulq3/GsxlomXKi7rpCL/Ue/Hqw1MpnN4rG587+FrBp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772223034; c=relaxed/relaxed;
	bh=adBcRZ6N/feIVBkm9Rv6T28TMxfba+nAFWMcJGZNc9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/b/sijmf5acPG7alO0zcfSNvSw1oOiWCf/BhCmO+aF57RzfRmoyK9Bdn7oWcC7TKyhdidCto39sfiaVWzacPeMPpZX/aNTuIz2K5vBn9/cLKnIdQneMphLezGlEwFBTVUDwr3dGZplsEvqnqglj+1bzjo9LRewvynXqjvbttveZQAz9kUm9CDMj3ajQWUZqCaJY/HCkKuS/IqChBd24bCIywfvNy2XTv9vO9D0rcihU5m0ip0bomIyIqEqGdtYuqmXZ+dznDYe2WfS2MYwDvs0o6o1smr+UYOWMfQ1ubT1heA3kVQS7jAEbn1qbt+zH7n3FzsLxoqtRQ9iYtRnJMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DBRHRg84; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DBRHRg84;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMzw9422Zz3bjb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 07:10:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4A4DA432F8;
	Fri, 27 Feb 2026 20:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5E5C2BCB0;
	Fri, 27 Feb 2026 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772223031;
	bh=GDIsuZYm2zKYxLFzdJGIwkOaoBFqEdMRlEhHeQ3/4/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DBRHRg84mUFFa5j1Ap08A/NiDuF3TUvfcRS7C3+9hv775NpD/8NroucXGTumCDp/q
	 yrfW9Y3j7L6NHLbxDVoLPnwidDlbqQx43JL5ql1ycR4JGKaqhcycHzZzwNzJlcvc02
	 dllhdtIOUZfDuMDJj+LoTseNq6O5uagn4G64tCcqE5fAIbrOu0ko0XkUr7ircdpbQh
	 bXRyXmVj6xEUhwSFjMMxmlipUHZ264tacuMAwtSvAd5grFuLAF6s73NejFFuX4hEaz
	 JPFck19AXo77usRat6V50+er5SScDpOmDuKTSvIT6gz+N5E8JF7nu9dERR/ctItvMT
	 m5GfMgiKzWHMQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "linux-mm @ kvack . org" <linux-mm@kvack.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v1 05/16] mm/oom_kill: use MMU_NOTIFY_CLEAR in __oom_reap_task_mm()
Date: Fri, 27 Feb 2026 21:08:36 +0100
Message-ID: <20260227200848.114019-6-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227200848.114019-1-david@kernel.org>
References: <20260227200848.114019-1-david@kernel.org>
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
Content-Transfer-Encoding: 8bit

In commit 7269f999934b ("mm/mmu_notifier: use correct mmu_notifier events
for each invalidation") we converted all MMU_NOTIFY_UNMAP to
MMU_NOTIFY_CLEAR, except the ones that actually perform munmap() or
mremap() as documented.

__oom_reap_task_mm() behaves much more like MADV_DONTNEED. So use
MMU_NOTIFY_CLEAR as well.

This is a preparation for further changes.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/oom_kill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5c6c95c169ee..0ba56fcd10d5 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -551,7 +551,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
 			struct mmu_notifier_range range;
 			struct mmu_gather tlb;
 
-			mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0,
+			mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0,
 						mm, vma->vm_start,
 						vma->vm_end);
 			tlb_gather_mmu(&tlb, mm);
-- 
2.43.0


