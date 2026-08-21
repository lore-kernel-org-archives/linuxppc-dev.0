Return-Path: <linuxppc-dev+bounces-26034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E900C5DF87
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 11:52:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRJZl0r78z2yRF;
	Fri, 21 Aug 2026 21:52:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787313151;
	cv=none; b=BEN7ZsqMEfeGlIvpUxi+J89JhQSMsGfEQ2jH/KSsFDdZWjBV/3bzzLteLT8b/sJCxzazIPKYkN+3t0GR+MxshJ3UrTbLugzCTv0seNpQQvSvMTLvo28x3kVnZjQgqvEfeVzBlVIjS3JNzOZaUHqMiEiAGyEbDiXdGoJh4FcmFnif0k87yojFvvWW+qpPXjVAhsw88VXXs0EnzS38YNG4SzUw8N3iGvw8tGt+MqW/bSCCz+rmIRIsu89FQWdY6pNZMLS8mvdNHJm2Bn0Ul3G4P5Y7lGp+Pfwks/enTob3T80FSbX7hG9kC5QkR5gZF6L5mt5QyBxOEBVqSx9zzuf9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787313151; c=relaxed/relaxed;
	bh=tyH7GKEaXuJ9X0Hbu/1Vcoc95AeKVCwNJoJJoiZxZMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvVj9FduAOsY96sQFcq2hhrg+zWh5WfNfNke+1oSe2y2JuVDFwjJbSKB7KtZ7y2oY+Z6gvJjy0v61+OCQQji725ojJk8t3Ze6drHkMlIYryOyT2TAaJgWnsrLGym68OObC2yLNDnBjNggDHERmCa79Up+13YtqI8H+lfPFHVK7/9U4aCVcC4noEX/w7r+jEk22qhRbnEU/5dROT2j+Dx7AFTNy+rDurIRWz+NWqb1gfd+YCIj1nIGHlGWplG3bUNVfieZqrrsczSL9Cu5rVwrUs6YD6g6OigrCadt68YD4gLP0475ETbyj7InPAtH3d7wBcuFyiRVs5LzWXHPmXqsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlCpUL3Y; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlCpUL3Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRJZj63xTz2xtt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 21:52:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 51239401BF;
	Fri, 21 Aug 2026 11:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938691F00A3D;
	Fri, 21 Aug 2026 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787313148;
	bh=tyH7GKEaXuJ9X0Hbu/1Vcoc95AeKVCwNJoJJoiZxZMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MlCpUL3YHNY8i/T2KcFgMf4toxYa7wj+fj4gyNcySVoIzbBq5Lp8PDw5Y/nuQTvuP
	 RQmvVIruspYceHv0wZo73OJEWkoZTkqLvKI7bIvnXnpSuMdEmMZSyYgoltQlf3uLZY
	 O5cBd0VWSL1eJ+R08lZbZHVwKjmuoGTSP8Oo9pRKpc5C2ZHoMgO93/dOz43JilesGW
	 0OYNjlhDuT1tnrZzRjkxkXRBAQ0Z2oTgAEe8vnhzyAJcKJomWJ1vFZLOu069AA7bW6
	 cVgDg6gLk2Yq7TbScfCJ81zB+03MgTqq9K629rfzjclxmP7U22XNzctYoWgJz0UtHt
	 zGKNezjApUS+Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Aug 2026 13:52:02 +0200
Subject: [PATCH 1/6] coredump: select memory types to include
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
Message-Id: <20260821-work-coredump-filter-v1-1-91f9a73ef03e@kernel.org>
References: <20260821-work-coredump-filter-v1-0-91f9a73ef03e@kernel.org>
In-Reply-To: <20260821-work-coredump-filter-v1-0-91f9a73ef03e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=17987; i=brauner@kernel.org;
 h=from:subject:message-id; bh=swfUMBam/a8GOcCxALCqNMAsj5RQwWUKye2hNWQCWAU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR1WH9cb5sq8nztNEOvuvUfxa8xXioUjLjYXycqyLu+p
 TZ52ddNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5uJzhD0dtp4XKxCnnJ+7c
 7baMO12M1TnCkW959rvHksXLtU+nazMy7OsPefbiymv1/b/il93z/3xkn2PRD0nf2YXmpowt0S0
 PeAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently /proc/<pid>/coredump_filter determines what types of memory
are included in a coredump produced by <pid>. This is fairly static. The
coredump server has no easy way to configure what memory to dump even
though it can figure out all the necessary details to make an informed
decision.

Add a new COREDUMP_MEMORY_TYPES feature bit. If the coredump server
raises it the kernel will dump memory types raised in the
coredump_ack->memory_types member. Zero is valid and causes the creation
of a coredump that just includes the program headers and notes but no
memory apart from the mappings that are always dumped.

struct coredump_req gains @memory_types which is set to the default
memory types that are included in the coredump. This can be overridden by
raising bits in coredump_ack->memory_types. It also gains
@memory_types_mask which contains a bitmask of all memory types the
kernel knows about. A coredump server may only raise bits in
coredump_ack->memory_types that are raised in
coredump_req->memory_types_mask.

struct coredump_ack grows too. If COREDUMP_MEMORY_TYPES is raised in
@mask the kernel dumps the memory types set in the @memory_types mask.
Zero is valid and dumps no memory apart from the mappings that are
always dumped. A coredump server wanting to add or drop memory types
instead of outright replacing it should simply copy
coredump_req->memory_types and then mask off or raise types as needed.

@memory_types must be zero if COREDUMP_MEMORY_TYPES isn't raised.
COREDUMP_MEMORY_TYPES requires COREDUMP_KERNEL and an ack of at least
COREDUMP_ACK_SIZE_VER1 bytes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/filesystems/proc.rst |   4 ++
 fs/coredump.c                      | 114 +++++++++++++++++++++++++++++--------
 include/linux/coredump.h           |   4 +-
 include/uapi/linux/coredump.h      |  70 ++++++++++++++++++++++-
 4 files changed, 165 insertions(+), 27 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2ccd5b2dfdd3..3a309e8ee96b 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1962,6 +1962,10 @@ For example::
   $ echo 0x7 > /proc/self/coredump_filter
   $ ./some_program
 
+If the coredump socket protocol is used a coredump server can select memory
+types to include dynamically. See COREDUMP_MEMORY_TYPES in
+include/uapi/linux/coredump.h.
+
 3.5	/proc/<pid>/mountinfo - Information about mounts
 --------------------------------------------------------
 
diff --git a/fs/coredump.c b/fs/coredump.c
index 7b568d25887c..ec9359e382ea 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -759,10 +759,39 @@ static inline bool coredump_sock_send(struct file *file, struct coredump_req *re
 	return ret == sizeof(*req);
 }
 
-static_assert(sizeof(struct coredump_req) == COREDUMP_REQ_SIZE_VER0);
-static_assert(sizeof(struct coredump_ack) == COREDUMP_ACK_SIZE_VER0);
+static_assert(sizeof(struct coredump_req) == COREDUMP_REQ_SIZE_VER1);
+static_assert(sizeof(struct coredump_ack) == COREDUMP_ACK_SIZE_VER1);
 static_assert(sizeof(enum coredump_mark) == sizeof(__u32));
 
+/* Every memory type this kernel knows. */
+#define COREDUMP_MEMORY_ALL						\
+	(COREDUMP_MEMORY_ANON_PRIVATE | COREDUMP_MEMORY_ANON_SHARED |	\
+	 COREDUMP_MEMORY_FILE_PRIVATE | COREDUMP_MEMORY_FILE_SHARED |	\
+	 COREDUMP_MEMORY_ELF_HEADERS |					\
+	 COREDUMP_MEMORY_HUGETLB_PRIVATE | COREDUMP_MEMORY_HUGETLB_SHARED | \
+	 COREDUMP_MEMORY_DAX_PRIVATE | COREDUMP_MEMORY_DAX_SHARED)
+
+#define COREDUMP_MEMORY_TYPE_BIT(mmf) BIT((mmf) - MMF_DUMP_FILTER_SHIFT)
+static_assert(COREDUMP_MEMORY_ALL == (MMF_DUMP_FILTER_MASK >> MMF_DUMP_FILTER_SHIFT));
+static_assert(COREDUMP_MEMORY_ANON_PRIVATE ==
+	      COREDUMP_MEMORY_TYPE_BIT(MMF_DUMP_ANON_PRIVATE));
+static_assert(COREDUMP_MEMORY_ANON_SHARED ==
+	      COREDUMP_MEMORY_TYPE_BIT(MMF_DUMP_ANON_SHARED));
+static_assert(COREDUMP_MEMORY_FILE_PRIVATE ==
+	      COREDUMP_MEMORY_TYPE_BIT(MMF_DUMP_MAPPED_PRIVATE));
+static_assert(COREDUMP_MEMORY_FILE_SHARED ==
+	      COREDUMP_MEMORY_TYPE_BIT(MMF_DUMP_MAPPED_SHARED));
+static_assert(COREDUMP_MEMORY_ELF_HEADERS ==
+	      COREDUMP_MEMORY_TYPE_BIT(MMF_DUMP_ELF_HEADERS));
+static_assert(COREDUMP_MEMORY_HUGETLB_PRIVATE ==
+	      COREDUMP_MEMORY_TYPE_BIT(MMF_DUMP_HUGETLB_PRIVATE));
+static_assert(COREDUMP_MEMORY_HUGETLB_SHARED ==
+	      COREDUMP_MEMORY_TYPE_BIT(MMF_DUMP_HUGETLB_SHARED));
+static_assert(COREDUMP_MEMORY_DAX_PRIVATE ==
+	      COREDUMP_MEMORY_TYPE_BIT(MMF_DUMP_DAX_PRIVATE));
+static_assert(COREDUMP_MEMORY_DAX_SHARED ==
+	      COREDUMP_MEMORY_TYPE_BIT(MMF_DUMP_DAX_SHARED));
+
 static inline bool coredump_sock_mark(struct file *file, enum coredump_mark mark)
 {
 	struct msghdr msg = { .msg_flags = MSG_NOSIGNAL };
@@ -804,11 +833,14 @@ static inline void coredump_sock_shutdown(struct file *file)
 static bool coredump_sock_request(struct core_name *cn, struct coredump_params *cprm)
 {
 	struct coredump_req req = {
-		.size		= sizeof(struct coredump_req),
-		.mask		= COREDUMP_KERNEL | COREDUMP_USERSPACE |
-				  COREDUMP_REJECT | COREDUMP_WAIT |
-				  COREDUMP_RECORDS | COREDUMP_SPARSE,
-		.size_ack	= sizeof(struct coredump_ack),
+		.size			= sizeof(struct coredump_req),
+		.mask			= COREDUMP_KERNEL | COREDUMP_USERSPACE |
+					  COREDUMP_REJECT | COREDUMP_WAIT |
+					  COREDUMP_RECORDS | COREDUMP_SPARSE |
+					  COREDUMP_MEMORY_TYPES,
+		.size_ack		= sizeof(struct coredump_ack),
+		.memory_types		= cprm->memory_types,
+		.memory_types_mask	= COREDUMP_MEMORY_ALL,
 	};
 	struct coredump_ack ack = {};
 	ssize_t usize;
@@ -873,6 +905,30 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		return false;
 	}
 
+	if (ack.mask & COREDUMP_MEMORY_TYPES) {
+		/* The memory types need the whole field. */
+		if (usize < COREDUMP_ACK_SIZE_VER1) {
+			coredump_sock_mark(cprm->file, COREDUMP_MARK_MINSIZE);
+			return false;
+		}
+
+		/* The memory types only select what the kernel writes. */
+		if (!(ack.mask & COREDUMP_KERNEL)) {
+			coredump_sock_mark(cprm->file, COREDUMP_MARK_CONFLICTING);
+			return false;
+		}
+
+		/* Refuse unknown memory types. */
+		if (ack.memory_types & ~req.memory_types_mask) {
+			coredump_sock_mark(cprm->file, COREDUMP_MARK_UNSUPPORTED);
+			return false;
+		}
+	} else if (ack.memory_types) {
+		/* Like @spare the field must be zero when it isn't used. */
+		coredump_sock_mark(cprm->file, COREDUMP_MARK_UNSUPPORTED);
+		return false;
+	}
+
 	/* Record header scratch; a bvec can't point at the stack. */
 	if (ack.mask & COREDUMP_RECORDS) {
 		cprm->record_hdr = kmalloc_obj(*cprm->record_hdr);
@@ -880,6 +936,10 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 			return false;
 	}
 
+	/* The server's selection replaces the task's entirely. */
+	if (ack.mask & COREDUMP_MEMORY_TYPES)
+		cprm->memory_types = ack.memory_types;
+
 	cprm->mask = ack.mask;
 	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
 }
@@ -1200,6 +1260,10 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	}
 }
 
+#define COREDUMP_TASK_MEMORY_TYPES(mm)                         \
+	((__mm_flags_get_word((mm)) & MMF_DUMP_FILTER_MASK) >> \
+	 MMF_DUMP_FILTER_SHIFT)
+
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
 	size_t *argv __free(kfree) = NULL;
@@ -1211,8 +1275,8 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	struct coredump_params cprm = {
 		.siginfo = siginfo,
 		.limit = rlimit(RLIMIT_CORE),
-		/* Snapshot MMF_DUMP_FILTER_* (unlocked) and dumpable for the dump. */
-		.mm_flags = __mm_flags_get_word(mm),
+		/* Snapshot the memory types (unlocked) and dumpable for the dump. */
+		.memory_types = COREDUMP_TASK_MEMORY_TYPES(mm),
 		.dumpable = task_exec_state_get_dumpable(current),
 		.vma_meta = NULL,
 		.cpu = raw_smp_processor_id(),
@@ -1746,15 +1810,15 @@ static bool always_dump_vma(struct vm_area_struct *vma)
 }
 
 #define DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER 1
+#define COREDUMP_MEMORY_TYPE_INCLUDE(types, type) \
+	((types) & COREDUMP_MEMORY_##type)
 
 /*
  * Decide how much of @vma's contents should be included in a core dump.
  */
 static unsigned long vma_dump_size(struct vm_area_struct *vma,
-				   unsigned long mm_flags)
+				   u64 memory_types)
 {
-#define FILTER(type)	(mm_flags & (1UL << MMF_DUMP_##type))
-
 	/* always dump the vdso and vsyscall sections */
 	if (always_dump_vma(vma))
 		goto whole;
@@ -1764,18 +1828,22 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 
 	/* support for DAX */
 	if (vma_is_dax(vma)) {
-		if ((vma->vm_flags & VM_SHARED) && FILTER(DAX_SHARED))
+		if ((vma->vm_flags & VM_SHARED) &&
+		    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, DAX_SHARED))
 			goto whole;
-		if (!(vma->vm_flags & VM_SHARED) && FILTER(DAX_PRIVATE))
+		if (!(vma->vm_flags & VM_SHARED) &&
+		    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, DAX_PRIVATE))
 			goto whole;
 		return 0;
 	}
 
 	/* Hugetlb memory check */
 	if (is_vm_hugetlb_page(vma)) {
-		if ((vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_SHARED))
+		if ((vma->vm_flags & VM_SHARED) &&
+		    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, HUGETLB_SHARED))
 			goto whole;
-		if (!(vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_PRIVATE))
+		if (!(vma->vm_flags & VM_SHARED) &&
+		    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, HUGETLB_PRIVATE))
 			goto whole;
 		return 0;
 	}
@@ -1787,25 +1855,27 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 	/* By default, dump shared memory if mapped from an anonymous file. */
 	if (vma->vm_flags & VM_SHARED) {
 		if (file_inode(vma->vm_file)->i_nlink == 0 ?
-		    FILTER(ANON_SHARED) : FILTER(MAPPED_SHARED))
+			    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, ANON_SHARED) :
+			    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, FILE_SHARED))
 			goto whole;
 		return 0;
 	}
 
 	/* Dump segments that have been written to.  */
-	if ((!IS_ENABLED(CONFIG_MMU) || vma->anon_vma) && FILTER(ANON_PRIVATE))
+	if ((!IS_ENABLED(CONFIG_MMU) || vma->anon_vma) &&
+	    COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, ANON_PRIVATE))
 		goto whole;
 	if (vma->vm_file == NULL)
 		return 0;
 
-	if (FILTER(MAPPED_PRIVATE))
+	if (COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, FILE_PRIVATE))
 		goto whole;
 
 	/*
 	 * If this is the beginning of an executable file mapping,
 	 * dump the first page to aid in determining what was mapped here.
 	 */
-	if (FILTER(ELF_HEADERS) &&
+	if (COREDUMP_MEMORY_TYPE_INCLUDE(memory_types, ELF_HEADERS) &&
 	    vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ)) {
 		if ((READ_ONCE(file_inode(vma->vm_file)->i_mode) & 0111) != 0)
 			return PAGE_SIZE;
@@ -1821,8 +1891,6 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 		return DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER;
 	}
 
-#undef	FILTER
-
 	return 0;
 
 whole:
@@ -1907,7 +1975,7 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
 		m->start = vma->vm_start;
 		m->end = vma->vm_end;
 		m->flags = vma->vm_flags;
-		m->dump_size = vma_dump_size(vma, cprm->mm_flags);
+		m->dump_size = vma_dump_size(vma, cprm->memory_types);
 		m->pgoff = vma->vm_pgoff;
 		m->file = vma->vm_file;
 		if (m->file)
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index b252bb2843b3..74af57b9406b 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -32,8 +32,8 @@ struct coredump_params {
 	const kernel_siginfo_t *siginfo;
 	struct file *file;
 	unsigned long limit;
-	/* MMF_DUMP_FILTER_* bits, snapshot of mm->flags at dump start. */
-	unsigned long mm_flags;
+	/* COREDUMP_MEMORY_* types to dump, the task's or the server's. */
+	u64 memory_types;
 	/* Snapshot of dumpable at dump start. */
 	enum task_dumpable dumpable;
 	int cpu;
diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
index f3771861ca48..6d0c53b534ea 100644
--- a/include/uapi/linux/coredump.h
+++ b/include/uapi/linux/coredump.h
@@ -16,6 +16,9 @@
  *                    requires COREDUMP_KERNEL
  * @COREDUMP_SPARSE: describe the holes in the coredump as zero records
  *                   instead of transferring them; requires COREDUMP_RECORDS
+ * @COREDUMP_MEMORY_TYPES: dump the memory types in
+ *                          coredump_ack->memory_types instead of the ones
+ *                          the task selected; requires COREDUMP_KERNEL
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
@@ -24,6 +27,37 @@ enum {
 	COREDUMP_WAIT		= (1ULL << 3),
 	COREDUMP_RECORDS	= (1ULL << 4),
 	COREDUMP_SPARSE		= (1ULL << 5),
+	COREDUMP_MEMORY_TYPES	= (1ULL << 6),
+};
+
+/**
+ * coredump memory types
+ * @COREDUMP_MEMORY_ANON_PRIVATE: anonymous private memory
+ * @COREDUMP_MEMORY_ANON_SHARED: anonymous shared memory
+ * @COREDUMP_MEMORY_FILE_PRIVATE: file-backed private memory
+ * @COREDUMP_MEMORY_FILE_SHARED: file-backed shared memory
+ * @COREDUMP_MEMORY_ELF_HEADERS: the first page of a file-backed private
+ *                               mapping that starts an ELF file
+ * @COREDUMP_MEMORY_HUGETLB_PRIVATE: hugetlb private memory
+ * @COREDUMP_MEMORY_HUGETLB_SHARED: hugetlb shared memory
+ * @COREDUMP_MEMORY_DAX_PRIVATE: DAX private memory
+ * @COREDUMP_MEMORY_DAX_SHARED: DAX shared memory
+ *
+ * A bitmask of memory types a coredump may request to be included. New
+ * memory type bits must ensure that they do not steal memory from an
+ * existing one so a coredump server will continue to get the same
+ * coredumps even if a new bit is introduced.
+ */
+enum {
+	COREDUMP_MEMORY_ANON_PRIVATE	= (1ULL << 0),
+	COREDUMP_MEMORY_ANON_SHARED	= (1ULL << 1),
+	COREDUMP_MEMORY_FILE_PRIVATE	= (1ULL << 2),
+	COREDUMP_MEMORY_FILE_SHARED	= (1ULL << 3),
+	COREDUMP_MEMORY_ELF_HEADERS	= (1ULL << 4),
+	COREDUMP_MEMORY_HUGETLB_PRIVATE	= (1ULL << 5),
+	COREDUMP_MEMORY_HUGETLB_SHARED	= (1ULL << 6),
+	COREDUMP_MEMORY_DAX_PRIVATE	= (1ULL << 7),
+	COREDUMP_MEMORY_DAX_SHARED	= (1ULL << 8),
 };
 
 /**
@@ -31,6 +65,8 @@ enum {
  * @size: size of struct coredump_req
  * @size_ack: known size of struct coredump_ack on this kernel
  * @mask: supported features
+ * @memory_types: the memory types the task selected
+ * @memory_types_mask: the memory types this kernel knows
  *
  * When a coredump happens the kernel will connect to the coredump
  * socket and send a coredump request to the coredump server. The @size
@@ -49,15 +85,27 @@ enum {
  * struct coredump_ack the kernel knows. Userspace may only send up to
  * coredump_req->size_ack bytes to the kernel and must set
  * coredump_ack->size accordingly.
+ *
+ * @memory_types is set to the default memory types that are included in
+ * the coredump. This can be overridden by raising bits in
+ * coredump_ack->memory_types.
+ *
+ * @memory_types_mask contains a bitmask of all memory types the kernel
+ * knows about. A coredump server may only raise bits in
+ * coredump_ack->memory_types that are raised in
+ * coredump_req->memory_types_mask.
  */
 struct coredump_req {
 	__u32 size;
 	__u32 size_ack;
 	__u64 mask;
+	__u64 memory_types;
+	__u64 memory_types_mask;
 };
 
 enum {
 	COREDUMP_REQ_SIZE_VER0 = 16U, /* size of first published struct */
+	COREDUMP_REQ_SIZE_VER1 = 32U, /* memory_types and memory_types_mask added */
 };
 
 /**
@@ -65,6 +113,8 @@ enum {
  * @size: size of the struct
  * @spare: unused
  * @mask: features kernel is supposed to use
+ * @memory_types: memory types to dump, only with COREDUMP_MEMORY_TYPES
+ *                 in @mask
  *
  * The @size member must be set to the size of struct coredump_ack. It
  * may never exceed what the kernel returned in coredump_req->size_ack
@@ -74,15 +124,30 @@ enum {
  * The @mask member must be set to the features the coredump server
  * wants the kernel to use. Only bits the kernel returned in
  * coredump_req->mask may be set.
+ *
+ * If COREDUMP_MEMORY_TYPES is raised in @mask the kernel dumps the
+ * memory types set in the @memory_types mask. Zero is valid and dumps
+ * no memory apart from the mappings that are always dumped.
+ *
+ * Note that memory a task excluded via MADV_DONTDUMP is always left
+ * out. A coredump server wanting to add or drop memory types instead of
+ * outright replacing it should simply copy coredump_req->memory_types
+ * and then mask off or raise types as needed.
+ *
+ * Note that @memory_types must be zero if COREDUMP_MEMORY_TYPES isn't
+ * raised. COREDUMP_MEMORY_TYPES requires COREDUMP_KERNEL and an ack of
+ * at least COREDUMP_ACK_SIZE_VER1 bytes.
  */
 struct coredump_ack {
 	__u32 size;
 	__u32 spare;
 	__u64 mask;
+	__u64 memory_types;
 };
 
 enum {
 	COREDUMP_ACK_SIZE_VER0 = 16U, /* size of first published struct */
+	COREDUMP_ACK_SIZE_VER1 = 24U, /* memory_types added */
 };
 
 /**
@@ -90,11 +155,12 @@ enum {
  *
  * The kernel will place a single byte on the coredump socket. The
  * markers notify userspace whether the coredump ack succeeded or
- * failed.
+ * failed. After any marker other than COREDUMP_MARK_REQACK the kernel
+ * closes the connection and no coredump is generated.
  *
  * @COREDUMP_MARK_MINSIZE: the provided coredump_ack size was too small
  * @COREDUMP_MARK_MAXSIZE: the provided coredump_ack size was too big
- * @COREDUMP_MARK_UNSUPPORTED: the provided coredump_ack mask was invalid
+ * @COREDUMP_MARK_UNSUPPORTED: the provided coredump_ack mask or memory types were invalid
  * @COREDUMP_MARK_CONFLICTING: the provided coredump_ack mask has conflicting options
  * @COREDUMP_MARK_REQACK: the coredump request and ack was successful
  * @__COREDUMP_MARK_MAX: the maximum coredump mark value

-- 
2.53.0


