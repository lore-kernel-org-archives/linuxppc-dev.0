Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF9606A32F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkIx7WqT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLFrx5pDCz3c8n;
	Fri, 06 Nov 2026 08:32:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793914353;
	cv=none; b=I4Zyy6L7cNCfdo9ZYnHzoifYte9p+UZsdJoyJXPyX/Kg/MmoqBrEri+fRok6WN1Btu0aFjFoWgoH3V+GHD1m78yDXYLldW17gNAN5/biF2whvQXRx5DwXyx9t6oQEkNOjhzvZmKr0Euc4w8kuzpXg0E1Jv85nD0P1rfk3UGqvQAWyoMvZ//wO7SJIzXp0eBjiU+kqn8QU7rdojbAAGkOuVA8TtnnqSputLvIBTAFp5UG10kNl6fEhVYY1xfr01tRb5SGQZ36ngZIhn6NeG2gXVz9RL+JHMSrU+oBkMcGAmsHJc/7ZyrwG7zNlVTXcwM+gijDLY+r5/7TYfkncSCTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793914353; c=relaxed/relaxed;
	bh=R9gbDgDsUJAtxTTttS67Zy6QBKff1k+BGmZ9q8ms4as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3TYQyja6WVNRNlD2lAYsQFrGcrZd30gYJNwKSga9jx7d2Bbyi4kQkTSSTNPiS2/soB5RbUqLuTyzD/ZXvjTKwSP+EcCs+l93H5m8XQqAhReAgPjU+9jbJjweDtsNFjNXidbCLXkWCfLd8Gg9oQfbW0imuej5gXFLG3r46ctFOyaNpRds9JVeHNfaZCcAZ/aPSXg/AbBa1q8ddv1Gy9iKK1928XoYoWpuh8rO8hXw9/wQCd8cir2lA0VUvdxLiWVihibuTGcBCp2Sb6y5+B1wJNgjklQZVivAYmNLk7fnE3GwhQMH8dENNbszqqnompC3aaVFGie0ZDBy3J2d4s/zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkIx7WqT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkIx7WqT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLFrx0p07z3c8h
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 08:32:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 80D4E41402;
	Thu,  5 Nov 2026 21:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CD71F008A1;
	Thu,  5 Nov 2026 21:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914351;
	bh=R9gbDgDsUJAtxTTttS67Zy6QBKff1k+BGmZ9q8ms4as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZkIx7WqTlWLTCBt9NpIoUSUzWdaGj1sZTB/NJl369icVHSJO1jDaGZYx9ZI0V3ngf
	 NS/Z25C5Vs19d6ihk3w8C7/oUqqe7K1X+FB3u7R9B4uFGPgsZ4o0NBNDpRc2THUVb3
	 YkarJXljffQrrFjkCSeJk3R7eEWO27dzmcz7apYY0Nmwm6IP1anOsY1CUhI73l3eJ4
	 CRpGJYjjhMGN2rrNn3vNOs2zqyDLTDI5G6ndMz8NUUszR2XbiFwVcW4PxtfSNJPcO7
	 RIKm77NsGvQDigbGTMtdIKn8KwNNkqm7Sk4pc7DPIzfEkdFiNAbLMI/R2RkXQqgwh8
	 3vRlOOITx0Kiw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:30:54 +0000
Subject: [PATCH 03/13] mm/rmap: convert remaining VMA flag tests to use
 vma_flags_t
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=ljs@kernel.org;
 h=from:subject:message-id; bh=eZl8Nv0dTN3HlhfbDsqgjylQKfweYHLkfOK2djhDL8M=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF1mJfT2QdPRhoV88qcu77rHLbdvR7JH9HZHWcvUt
 Zb/rtkxdpSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAin+8wMvSLM4R/t0nQTnVV
 f612NLDw5tS57Hc6+SZ6ftJWcE8sW8rwT2vzspehQh9PXindsm3+zgqliazNBicUtrCbn1vpy7J
 0OgsA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the remaining uses of the legacy vm_flags_t flags in the rmap logic
with vma_flags_t values.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/rmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 1131b76bbbc2..cdc97fec8586 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1196,7 +1196,7 @@ static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 
 static bool invalid_mkclean_vma(struct vm_area_struct *vma, void *arg)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_test(vma, VMA_SHARED_BIT))
 		return false;
 
 	return true;
@@ -1660,7 +1660,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	 * VM_DROPPABLE mappings don't swap; instead they're just dropped when
 	 * under memory pressure.
 	 */
-	if (!folio_test_swapbacked(folio) && !(vma->vm_flags & VM_DROPPABLE))
+	if (!folio_test_swapbacked(folio) &&
+	    !vma_test_single_mask(vma, VMA_DROPPABLE))
 		__folio_set_swapbacked(folio);
 	__folio_set_anon(folio, vma, address, exclusive);
 
@@ -2094,7 +2095,8 @@ static bool ttu_anon_lazyfree_folio(struct vm_area_struct *vma,
 	 */
 	smp_rmb();
 
-	if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
+	if (folio_test_dirty(folio) &&
+	    !vma_test_single_mask(vma, VMA_DROPPABLE)) {
 		/*
 		 * redirtied either using the page table or a previously
 		 * obtained GUP reference.

-- 
2.56.0


