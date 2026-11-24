Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE7606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2oxXXw5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYq8b3jgKz2yS4;
	Wed, 25 Nov 2026 04:11:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795540271;
	cv=none; b=LHeg2we3oCq0tzWNngJ9XXEq5/eE7qdedTZ9M9nXxYFaYTlvyeC5o2pBSGFhPwU607U4kA7gT8U0yKvf10nucD0jW7qhoedlTPygdEN4IPRJhJWuFpkGkpypHjFi3G/5h3+zvNQs99NgCNkjVR+CslBtOvyNpGY168NbNupTCG2nvQHiaD7FrSXS6XN7+hKGsGz4kRU7vsdBsUKEjd/pbfAmnB6TB3cMqU6YET5q/VOMbUFOFWV69mmzXC7MbwjfSjemQXATN4MPYogcsWeYWXhJ9y6Tjy8MCakif3w4VhQXeBFjfaOFYpH0sh+tUiP62pJd+T7jeeChZoQDTetFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795540271; c=relaxed/relaxed;
	bh=kZ3jLbZRJ/VHth5eaJGnJSAc1BSxLfXRApAmbg64kWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DX7w0ET5JOmhe8jCrdofNYoeCJzCev0cxaRmnAhhmI5zCCrdPOxrGNriYj3Hbed0QjP0UMO+472dBaQeETty+A6LltJ07PjhE+az43wc2q2rItM4T0Jqjpy/1xwecKRMBkNGGezvMuI5EahuSNfeszWnzOdBvrTdFx9Pga+7HTVOtUPPAERe/CGxvoOrgAIVLoU7B0ZL5PWNwoXaEjOrmqB91bBPmvuwT+dTaoL+5WZ8T6og10yCzqZWJtiHQlD4NrILwucJmopNzWFjLEpXw96+grGXlwzHeSmqK4H3eHMAnWONK0I4K/k2jSQ4ncxI2mq6Q3COVXG5Hu4oMF66Bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2oxXXw5; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2oxXXw5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYq8Z5fCJz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 04:11:10 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A9104429A;
	Tue, 24 Nov 2026 17:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB03A1F000D1;
	Tue, 24 Nov 2026 17:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540269;
	bh=kZ3jLbZRJ/VHth5eaJGnJSAc1BSxLfXRApAmbg64kWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j2oxXXw5aycUKNOMG1/DLAxgqIp8Sjh0cy1uPDzj0VsLoLzP39KcAhPEhZa91ZbU0
	 H8EWAkRDjjvmeMoDjewdq6ZKK544u5JaiRV4qMMeZJmeHaFIEPNj1UH233/FuATQZm
	 Qdf1Uax5gYT0AAImCi7AZH6Q0Clf8dLZxDGQwMxBZAX/hKNmSBFqQKHZIoPnOSnDDQ
	 2GWVFQHmnLVbUFRtgsGjd/DH82/mDkeubJc+OBMpeUry1qEzZkDHUC8IUi2lj+GwtX
	 dSxYVPdtOe0VauPrsUWxIhV2mkMwY71xKEtg+G7v5M5SGq9FeEfJfWTcp474LhBtqb
	 b5DXkSHEmddVw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 17:08:00 +0000
Subject: [PATCH v2 08/11] selinux: convert VMA flag tests to use
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
Message-Id: <20261124-late-2026-vma-flags-v2-8-bf3fade93064@kernel.org>
References: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
In-Reply-To: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Uj1h40qu7RJJAsenD1k9bntx12XC9vbZ3RhmualmjYU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZj+SFmM5Y1Pzgkp2azP5dryY4Rs/LY1tiWxhjPEPJc
 SdLquGfjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExk5VaGf5ZFPTIJ1j1MqvNL
 +sNOd9kt+LBAykL2/5nEi1OCDskHyTMybJnstzHxS/78s/cuWP3pjDfnLdNZL3TE4PfRJ3/ZN0S
 /ZAcA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
SELinux mmap backing file and mprotect LSM hooks.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
---
 security/selinux/hooks.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9950f89dfaa2..5198a66b624b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4205,16 +4205,16 @@ static int selinux_mmap_backing_file(struct vm_area_struct *vma,
 {
 	unsigned long prot = 0;
 
-	/* translate vma->vm_flags perms into PROT perms */
-	if (vma->vm_flags & VM_READ)
+	/* translate VMA flag perms into PROT perms */
+	if (vma_test(vma, VMA_READ_BIT))
 		prot |= PROT_READ;
-	if (vma->vm_flags & VM_WRITE)
+	if (vma_test(vma, VMA_WRITE_BIT))
 		prot |= PROT_WRITE;
-	if (vma->vm_flags & VM_EXEC)
+	if (vma_test(vma, VMA_EXEC_BIT))
 		prot |= PROT_EXEC;
 
 	return selinux_mmap_file_common(backing_file, prot,
-					vma->vm_flags & VM_SHARED,
+					vma_test(vma, VMA_SHARED_BIT),
 					true);
 }
 
@@ -4228,13 +4228,13 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 	u32 av;
 	const struct file *file = vma->vm_file;
 	bool backing_file;
-	bool shared = vma->vm_flags & VM_SHARED;
+	bool shared = vma_test(vma, VMA_SHARED_BIT);
 
 	/* check if we need to trigger the "backing files are awful" mode */
 	backing_file = file && (file->f_mode & FMODE_BACKING);
 
 	if (default_noexec &&
-	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
+	    (prot & PROT_EXEC) && !vma_test(vma, VMA_EXEC_BIT)) {
 		/*
 		 * We don't use the vma_is_initial_heap() helper as it has
 		 * a history of problems and is currently broken on systems

-- 
2.56.1


