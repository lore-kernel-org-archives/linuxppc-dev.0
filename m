Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89E606A332
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgRHR6qi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLFsJ1qX5z3c96;
	Fri, 06 Nov 2026 08:32:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793914372;
	cv=none; b=XXFXKBEMQYBg35kX0/nL5VkXySSgDsSZqdNMcBTUJODc9RDo5OtxyT+dZtMzz6Ph+vNA0T+E4KWOwbNdIUWrl0EfQ+gIq7V8qjIsRRRHAuY3YkUAofMuuQG4w5USJXJmR9l6I1JgouK1/CUiiXr0aGJ1YpeG5VrFYk6y8UXjIZNj9Mi3dq9X7LjjS6ssEFayt34j4qRvnEYnS1UeXVoxbgirPjOCkryKRIdHYaxJ9ndfJnCcgtvwgeQfVtnfs0hhY0yd5YRLI34J6gKLOq9F+/bylPLzkfUGUf6oVE8ofxereBOWxg1PjmbWMpeGU/1qMqkOU1vCVuDXWwoGjeFzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793914372; c=relaxed/relaxed;
	bh=yc+BOM9zISLu8R7CpRSVrLcnosv916on5x7GIVL+p5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5ygPitlnvlV64MC/RHikMIhLxM0Lz1bD6UbpF5G1AVHHeXyAfc/OpzNxViYqcTGi8jqASc4jD1Tv60p5q2pGcD9thw8im9+miSz59fuD35Buf9YcS8Nwj0ZAiC/HuAGUbuQ/PtQgHNaHb3s20o83Zj8p056FY7IhYvoxsptUE/yzKJjWd+JavUh/CwQcCNnS99cqjZQuRO7V9guirGvOcHOY1yJN6Xj0T+FD2iYbhDeu+0NlNBBYNGdF16UUd7W2VTRybmvs+3gE9zXyyeClgGd6a5dHVvYFh+VuomrHunrqgzBe4lkSegoL+l1lbZa7sNAbySkxBUk0vuqD266Ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgRHR6qi; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgRHR6qi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLFsH31fBz3c8m
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 08:32:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2CDF343261;
	Thu,  5 Nov 2026 21:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DDB1F008A2;
	Thu,  5 Nov 2026 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914369;
	bh=yc+BOM9zISLu8R7CpRSVrLcnosv916on5x7GIVL+p5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cgRHR6qiWJTrG30pEeN7dxFVPc+dTV1adcqdwTD1LQxIFf5q0zcztQOCCuE0x3GV/
	 ZHgtlgNGSJS5GC6W3KxZ7f9IElfYH0FZjXVvUUKyz/AwCDgYx7heVhhqCSWhadN6KY
	 NEe92t8q/M/dK08zY/mQ1oV/ARSsEUIjFqVUPdsV2ROGQwui5lY7ZDcsJKHtaSdJ3d
	 +WiQAkG2/onWikpfbIj0XH1v/D+Qu5Q6DAMBppohnCrh2RINbMagM+nu5758asG2nt
	 zz8cJNisRYFgTY2Km3b1fascO6J0EfwRQOYbwweJYORpFsW+8e1RDtMk/fPELHEOvT
	 7xHp1SPTL/kLw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:30:55 +0000
Subject: [PATCH 04/13] mm/migrate: convert VMA flag tests to use
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
Message-Id: <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2848; i=ljs@kernel.org;
 h=from:subject:message-id; bh=0EzQPbq92vrt8Ov6q38P67V1mQozPkbuYDmCmE/yfh8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF32c9syHc3fJkcF57xf8CR5xnp+l7jg2seq6ywdJ
 bY++ef0v6OUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATmT6HkeF/3qE3W0Um7RYt
 /JsZ9l9HPWDqM8NnLeyiKcvM8087tlcyMlyYHn1t31Zdi9mvF8qt4pe4Z3x1tcCqoI47r8te8AV
 ks/IAAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
migration logic.

We retain the READ_ONCE() of vma->vm_flags in remove_migration_pte(), as
there is no vma_flags_t equivalent, and arch_make_huge_pte() continues to
take legacy flags for the time being.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/migrate.c        | 5 +++--
 mm/migrate_device.c | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 28a8d7734735..94033c222e04 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -310,7 +310,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	VM_BUG_ON_PAGE(pte_present(old_pte), page);
 	VM_WARN_ON_ONCE_FOLIO(folio_is_device_private(folio), folio);
 
-	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
+	if (folio_test_mlocked(folio) || vma_test(pvmw->vma, VMA_LOCKED_BIT) ||
 	    mm_forbids_zeropage(pvmw->vma->vm_mm))
 		return false;
 
@@ -2711,7 +2711,8 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		 * See folio_maybe_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
+		if (vma_test(vma, VMA_EXEC_BIT) &&
+		    folio_maybe_mapped_shared(folio))
 			return -EACCES;
 
 		/*
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9e19fadfa65c..c26acbbd2e31 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -842,7 +842,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 	if (folio_is_device_private(folio)) {
 		swp_entry_t swp_entry;
 
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			swp_entry = make_writable_device_private_entry(
 						page_to_pfn(page));
 		else
@@ -855,7 +855,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 			goto free_abort;
 		}
 		entry = folio_mk_pmd(folio, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			entry = pmd_mkwrite(pmd_mkdirty(entry), vma);
 	}
 
@@ -1043,7 +1043,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	if (folio_is_device_private(folio)) {
 		swp_entry_t swp_entry;
 
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			swp_entry = make_writable_device_private_entry(
 						page_to_pfn(page));
 		else
@@ -1057,7 +1057,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 			goto abort;
 		}
 		entry = mk_pte(page, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
+		if (vma_test(vma, VMA_WRITE_BIT))
 			entry = pte_mkwrite(pte_mkdirty(entry), vma);
 	}
 

-- 
2.56.0


