Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920766082BCD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7WzdCq4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLFwT21YSz3cDf;
	Fri, 06 Nov 2026 08:35:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793914537;
	cv=none; b=TAbTQSxjIS26fGIB42lpVxpQqD76xkn0VBYBYj+sxHTtO86SPzYbr8iqpA/aCS41iXMrCDEkZHplaQNB5q6UjjWyFMRXvUjh7iUUyQc7GrQyzlPDWxnDT8frKJqWvr+Cg55GhtXuQK2F4Z3lB+1m3oL+Db/xDMdXjvWLmcq7SlQ0NblRs2Sz1xbOs0upeMt2N7MR8siaLmA4guHblgGCA4v8E1o+y/W64pxECLMtY9swixeGzEWl20VQNT2+ufbNCs02YowwGsg6GuHn7LoYDADF1JtCUFX5BrScNwk+YXOn6lknIjb6eqb9FmdJJrGF8HwRRf8QHkFoFMjbUQCXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793914537; c=relaxed/relaxed;
	bh=y5JuvNnNeOh9oIZYUQiD2mrwwH6GN2Nh0rxsj2kJwUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpeuURSlYvhPK9xBFmZY+TiR7O7cDVJby3xSwKToUZ6KKddUzrqGLD8jFeR7/8hd7d/DgBx7QwyU73zSlEsfDdYZ0Fp7xmis3zREfBXJp2jhdt/gPBkTg7BwnqZeoTNjw0GM/1OyXISLzkGmz7/A4GW0yA92+eqXmBk+VE9dFfOHHLtLbAg1aLbQnK4Hp5FuUZHxDCbRQiPQ1QVO4z7amsFfYV2oCMwVTewz8j28grJk/zc52LV+/NDhLJeXzFQqB8rAjOGVCgqRJLTprBiWfwuDhdr6AtvNJq5UBIVlM7CADUyMaBxKKlWyhQZP3NgslivvwEzYZVpVhZgFtTP0wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7WzdCq4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7WzdCq4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLFwS3Swjz3cBx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 08:35:36 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 602C44379B;
	Thu,  5 Nov 2026 21:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89E21F008A1;
	Thu,  5 Nov 2026 21:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914534;
	bh=y5JuvNnNeOh9oIZYUQiD2mrwwH6GN2Nh0rxsj2kJwUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=R7WzdCq4szIDwvRrpAHhITrD0LMGL2Ayr/ooKvmMdyGasXQKDcBboripakmO01VxQ
	 YV6gWg3WzYXJGaP9RBXms9q1o/TSZwVLLaVEZfqLw0xiVgCNumabu3VK3l05YjGAQ2
	 46aaByM/B5ZaXGXlsVEhPqLim2HZXmKUrYtuwr1dNrHF5yB482YZP9OW2Jtvu422ao
	 6Tt1yTUQ1HqeI4mlyuzXFRXgFr1sp/lZYoZRhG5yDHjZjw0XlC4zm1FOELcAb2B6lS
	 fn9rEaS0KIp/p1dGwSwtWV76kVBTvwe1On76u9GWkFrWldtHLna5zrVfRdVYH5SYVu
	 GuO5/2y1sU0NA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:31:04 +0000
Subject: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
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
Message-Id: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3517; i=ljs@kernel.org;
 h=from:subject:message-id; bh=mMkVa3Aus9iq3GDDk7CXNqU7B+d35DdB8d1OJciXJ/o=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF0x/4mS2NVe3nd/9p3ZfnzOaYGJvjo5O8+kJ13ud
 1ZPNlAr7ChlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBE5Ccz/PeSFiq94GRiJT4r
 cM9y7UAJQ5np05894OaeezEhc0k9mwIjw9qZtm6zPV99FD/eVGBjuExiZXPoVpMpufynsmSe/N6
 dxwEA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 security/apparmor/lsm.c           |  2 +-
 security/integrity/ima/ima_main.c |  2 +-
 security/ipe/hooks.c              |  2 +-
 security/selinux/hooks.c          | 14 +++++++-------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c73681d820a0..00099a32b3f6 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -590,7 +590,7 @@ static int apparmor_file_mprotect(struct vm_area_struct *vma,
 				  unsigned long reqprot, unsigned long prot)
 {
 	return common_mmap(OP_FMPROT, vma->vm_file, prot,
-			   !(vma->vm_flags & VM_SHARED) ? MAP_PRIVATE : 0);
+			   !vma_test(vma, VMA_SHARED_BIT) ? MAP_PRIVATE : 0);
 }
 
 #ifdef CONFIG_IO_URING
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index fed80da3ee09..92032afe4cd1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -556,7 +556,7 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 
 	/* Is mprotect making an mmap'ed file executable? */
 	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
-	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
+	    !(prot & PROT_EXEC) || vma_test(vma, VMA_EXEC_BIT))
 		return 0;
 
 	security_current_getlsmprop_subj(&prop);
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d878b52ceec8..247b07748b1d 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -112,7 +112,7 @@ int ipe_file_mprotect(struct vm_area_struct *vma,
 	struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
 
 	/* Already Executable */
-	if (vma->vm_flags & VM_EXEC)
+	if (vma_test(vma, VMA_EXEC_BIT))
 		return 0;
 
 	if (prot & PROT_EXEC) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6168dd5f91c2..1bf78c2a6aba 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4206,16 +4206,16 @@ static int selinux_mmap_backing_file(struct vm_area_struct *vma,
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
 
@@ -4229,13 +4229,13 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
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
2.56.0


