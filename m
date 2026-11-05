Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48B606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE+anxcK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLFqy1twgz3c8h;
	Fri, 06 Nov 2026 08:31:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793914302;
	cv=none; b=PaFrNGmyEA9FEjS5x6/Hlm0SQneXBeqk9yBpZyp5yDObgcTplbgFAvMftcK5oTzUwc1V5rIVVXd5zibYDJy9byiyQBvgk6ZO1frqU4plcsdO6fzit6UMSdZlHryv6fBb/Pv3m284JKb1qn0N7Vq0DShbLO5VtV/MW77JSyWiNH0cyFkzJAUWqX1O0dpAzojaexd2e05TKVbN7jzl2oU9/PBCLQRZ75roTjETOJ6DAkxkyoedXDK0olCoSqRqUy7tbvq4gnu1Y4BiBfse8+Ds7b8sjetWAP+H0pO+6vqTiwDKRhOJ1TzLPhAcs4D3ZEwC3m8W8a3T5P+GFr2nWzQAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793914302; c=relaxed/relaxed;
	bh=l/XBPzIruKyaT68fHsJTL6/0Y1whGy5OpPSy6WgTELw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TFt2EurlFJJzDPBJtHufc57IHF5qyig/rBFOZTJlDzkveBUdmJDAeb8n9ceIeNEZcUvlyMd6IJJQeDKGOAa1W5fSwNpNEjeR+bWYmMw15/p/bop1MLK6YyATsoOXOu8MJNnN/1ujlxCypRlah1EmK0BcHakYeN5fL67JSJhxu5NvYIOQF+6EX9gI/BINE6E4pbCAv6bzRUOi6x/WS9Rxpa6tAYculuQRXkLYZZMZhdqUaEYu+2SGiBBHWBEblqCDCEZExMOmhE6m7q8zxug27xoMf8YrtQHZ8iBKlU8a+JGvd3Zq9dEhnyjLRhtI5eCoa8O+7RajlEAPWrYXYIU5Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE+anxcK; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aE+anxcK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLFqx3T7Rz3c7n
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 08:31:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4864140649;
	Thu,  5 Nov 2026 21:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747CB1F0089F;
	Thu,  5 Nov 2026 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914298;
	bh=l/XBPzIruKyaT68fHsJTL6/0Y1whGy5OpPSy6WgTELw=;
	h=From:Subject:Date:To:Cc;
	b=aE+anxcK5DVd4PxfaPeug+8Go7oXIkkyd0cr7QF/UCjgq9jQl+bNK0q+4BhKrFU6l
	 nH9TpbM/0AmUyIRXZfMR7+ZGUYkgq1BDmA0gMwCZlN+dq+z3ta162TfttOjx4fBrgt
	 5jqDEBSY60zS13wAtaGgurmcThNfq1GYkCiTlr6kkqTQkdSz/nP1SkszH09Zyo8Vxs
	 gkd/MAkUnyzsOIfsT4YNgixR1lw3gB/K4VRz5l4xVnYXGhfODUOU8wO+APAcsQd4VM
	 pobOy+eE76XoFeivYZrQgxoRdn9FhNGDUTwlg2/ulGNDaKNWkzGWtu8Q8T+PXTf1Xg
	 PFYf3vnSp0ZNg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 00/13] mm: continue vma_flags_t conversion
Date: Thu, 05 Nov 2026 21:30:51 +0000
Message-Id: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gaMlQpeRVyEmtaAP1oRQby71
 eVbzNyQJKok6IobopyadFszqCzATbwGQR2zoa5qS1QRznwIfsJzYfQzh4SNpdYQW2OdgVzuUbx
 e/7UfnucF8MbcSGUAAAA=
X-Change-ID: 20261101-late-2026-vma-flags-461731a636c3
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; i=ljs@kernel.org;
 h=from:subject:message-id; bh=dw144I8hKInR8Qv8iKnjrU9/3cK4949dnMwWVIcVGbg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF0a6K1vw5BxVPUqn46M6rZ32+yPLM/K3OK58Z/1t
 UlJ376qdZSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiQn8Y/scXBihtmHE7PkF4
 5fTvjHX5lf8yagzLot8b3ry68ZZUJgcjw8Jnxy6ELVt+JnMKc9vFq+wXXtq4lq3/3aB8muuMQpi
 TOR8A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Continue the conversion of legacy vm_flags_t flags to the new vma_flags_t
bitmap type.

Do some more core mm conversion (we really should be the first to
completely move to the new scheme :), but also update some mm-adjacent and
otherwise straightforward cases - /proc/$pid/maps and friends, the coredump
VMA dump size logic, uprobes, perf and LSM mmap/mprotect hooks.

This series only makes strictly mechanical changes to keep things gentle
during this very busy cycle.

No functional change intended.

Build tested on x86-64 (allmodconfig, each patch individually), i386,
arm64, riscv nommu and ppc64le.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (13):
      mm/gup: convert GUP code to use vma_flags_t
      mm/filemap: convert fault and readahead logic to use vma_flags_t
      mm/rmap: convert remaining VMA flag tests to use vma_flags_t
      mm/migrate: convert VMA flag tests to use vma_flags_t
      mm: convert THP VMA flag tests to use vma_flags_t
      mm/ksm: convert VMA flag tests to use vma_flags_t
      mm/madvise: convert madvise_vma_behavior() to use vma_flags_t
      mm: convert miscellaneous VMA flag tests to use vma_flags_t
      fs/proc/task_mmu: convert VMA flag tests to use vma_flags_t
      fs/coredump: convert vma_dump_size() to use vma_flags_t
      uprobes: convert VMA flag tests to use vma_flags_t
      perf: convert VMA flag tests to use vma_flags_t
      security: convert VMA flag tests to use vma_flags_t

 arch/powerpc/kvm/book3s_hv_uvmem.c | 10 ++++----
 fs/coredump.c                      | 16 ++++++-------
 fs/proc/task_mmu.c                 | 43 +++++++++++++++++-----------------
 include/linux/huge_mm.h            |  4 ++--
 include/linux/ksm.h                |  4 ++--
 include/linux/mm_inline.h          |  2 +-
 kernel/events/core.c               | 26 +++++++++++----------
 kernel/events/uprobes.c            | 12 ++++++----
 lib/test_hmm.c                     |  4 ++--
 mm/damon/vaddr.c                   |  2 +-
 mm/filemap.c                       | 24 ++++++++++---------
 mm/gup.c                           | 45 +++++++++++++++++++-----------------
 mm/hmm.c                           |  6 ++---
 mm/huge_memory.c                   | 32 +++++++++++++-------------
 mm/internal.h                      |  2 +-
 mm/khugepaged.c                    | 18 ++++++++-------
 mm/ksm.c                           | 22 ++++++++++--------
 mm/madvise.c                       | 47 ++++++++++++++++++++------------------
 mm/mempolicy.c                     |  4 ++--
 mm/migrate.c                       |  5 ++--
 mm/migrate_device.c                |  8 +++----
 mm/mmap_lock.c                     |  4 ++--
 mm/mremap.c                        |  2 +-
 mm/msync.c                         |  4 ++--
 mm/oom_kill.c                      |  4 ++--
 mm/pagewalk.c                      |  2 +-
 mm/rmap.c                          |  8 ++++---
 mm/vma.h                           |  4 ++--
 security/apparmor/lsm.c            |  2 +-
 security/integrity/ima/ima_main.c  |  2 +-
 security/ipe/hooks.c               |  2 +-
 security/selinux/hooks.c           | 14 ++++++------
 32 files changed, 202 insertions(+), 182 deletions(-)
---
base-commit: b61fa14ce6bcbba2cb9a96feea31b760226d6b43
change-id: 20261101-late-2026-vma-flags-461731a636c3

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>


