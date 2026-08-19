Return-Path: <linuxppc-dev+bounces-25999-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1C6C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:11:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMkf1Xklz3brB;
	Thu, 20 Aug 2026 09:11:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181066;
	cv=none; b=Opds95zHhHC/wqthRwC07jgeZET2bZCPV4Wi/xUMwO2hrsCnG798RkDgyeya0igjUdseVaWL43wSaQdGv8NIEVMIedJUxcveQxqQGMQI75dnouXLi6EO/aU1W/XC1YASGognU74Ak9zasXY9EmmynKiAgTDCjwB5N4FfTZAuw73mbQ9pFQuCkZ2nWUnQKN2Nuk9cgHE4s4A7xMCdokB/KTS8YBXFIid0A/w5kiS4PH5iX5O25Z0FU9j3VyJSx5VwJjsaLtd9LnAZSbG/97JXfcs2F3pgy1kdcgHXAu+hz86B1EApH4EW4VZOfQUTitoIqOjZBu3qpNdhSrL+bRfAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181066; c=relaxed/relaxed;
	bh=sGDQ3YmCTojuSJbjn27N+fr9efe+etjDeNqh262Gj7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANBMDtHZX9Ox5i8WIZpyPfdVxVXrUGsWaihK5IM/pFHIynlJx9/qNbawUbDFlW7ikRQW9WbDtIa/sILMS7vZf1mb5Lo/3qXW3C87EWdIZIQGgNkYd/Tkh1Qmre+ZXQRuFZr/fQWeJItRa3di3KsiIsxQ+U5hkPt2fqnsKXrIfAYIpfYTJd2rCRGfUx5BUIOA2t42Dt/4GABkzQMyw8W0sVIPwF3NBOLuGJOGd6ru69j45PWb8VjU2pIcqiXrzW2xhg11kK16I/raOBglzO8MW1rfenvZTxKQBzGUQZ+pFFpBb2ufjXwC/253Udrt1C4c+ALu07sIogQW/PRlP8Lpng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSGVtS7Q; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSGVtS7Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMkd2D04z3000
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:11:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F9986187F;
	Wed, 19 Aug 2026 23:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D301F000E9;
	Wed, 19 Aug 2026 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181063;
	bh=sGDQ3YmCTojuSJbjn27N+fr9efe+etjDeNqh262Gj7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OSGVtS7Q3C1PiY1DwysMyvWOxe3EMCG9C328C7WP41XjGBHCkSGVQaBmnh1qX/B/T
	 sf+QzWo36bcLP/++gImDSa2r3YyzKV8t2Cdw3x/zVL8A+IWPuwEzsjb1saXT+Ui1jj
	 Dcs5c8bU9Cpd5XujvUkErNzsiFNHNp6UlKye1VQqGEEZrC2QF4SrrGOoc8hWitVnev
	 KU+taCNdZbbGk06BCBg0OqtJgBfMzqdtDc5h5XBDlh5YXBKK9Jg5im78rEQb244tAu
	 YTItg6bX5zAE/xs1HXfFZCUYrfK66AMLUmRo0P0VWR0Nw9qPd6+sil/mQQmUeJEyP4
	 WFXbMYkXRKXZw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:29 +0200
Subject: [PATCH v2 12/22] coredump: clean up coredump state handling
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
Message-Id: <20260820-work-coredump-sparse-v2-12-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9559; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JHAlDqfsPwl09HuEN7hMd7/TH3T1BllgiDVBecbZIZk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me8PmyLBVBTTmND4KyzVs7Pt6F3mhV/tFrBoHDL9v
 ++T+ZqgjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn0TGdkeLzsXTifptJ2hie6
 rvOCpiSGS/TPNuq6X/JMOXDDWWW+bQz/a+QrBU5GNrReUPP9bsjiHn89YabaVdHPDWHnz191zVz
 DAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Right now coredump state handling is messy. The binfmt->core_dump::
methods return 1 when the coredump method did anything at all which
means that a partial write counts as having dumped core. This is fine as
the state is really only used to indicate that a coredump event occurred
in the exit status of the task. That should obviously be indicated even
if the actual writeout of the coredump failed.

But it means the coredump method of the binary formats is different from
all the other coredump helpers. And there's no way to communicate to
userspace that a coredump was truncated. We'll add support for that in a
second. For now, clean this up.

Add a flag member into struct coredump_params. Let the coredump method
raise COREDUMP_STATE_STARTED. This is what coredump_finish() will end up
using to splice in the coredump bit into the exit status.

This allows us to let the return value mean success or failure and align
it with the other coredump helpers. We also start raising
COREDUMP_STATE_TRUNCATED. This will be used in the next patches to
communicate truncation to userspace via the coredump socket.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_elf.c          | 12 +++++++-----
 fs/binfmt_elf_fdpic.c    | 12 +++++++-----
 fs/coredump.c            | 31 +++++++++++++++++--------------
 include/linux/binfmts.h  |  3 ++-
 include/linux/coredump.h | 12 ++++++++++++
 5 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 16a56b6b3f6c..f85b2137bdb9 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -74,7 +74,7 @@ static int load_elf_binary(struct linux_binprm *bprm);
  * don't even try.
  */
 #ifdef CONFIG_ELF_CORE
-static int elf_core_dump(struct coredump_params *cprm);
+static bool elf_core_dump(struct coredump_params *cprm);
 #else
 #define elf_core_dump	NULL
 #endif
@@ -1990,9 +1990,9 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
  * and then they are actually written out.  If we run out of core limit
  * we just truncate.
  */
-static int elf_core_dump(struct coredump_params *cprm)
+static bool elf_core_dump(struct coredump_params *cprm)
 {
-	int has_dumped = 0;
+	bool ret = false;
 	int segs, i;
 	struct elfhdr elf;
 	loff_t offset = 0, dataoff;
@@ -2023,7 +2023,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	if (!fill_note_info(&elf, e_phnum, &info, cprm))
 		goto end_coredump;
 
-	has_dumped = 1;
+	cprm->state |= COREDUMP_STATE_STARTED;
 
 	offset += sizeof(elf);				/* ELF header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
@@ -2118,11 +2118,13 @@ static int elf_core_dump(struct coredump_params *cprm)
 			goto end_coredump;
 	}
 
+	ret = true;
+
 end_coredump:
 	free_note_info(&info);
 	kfree(shdr4extnum);
 	kfree(phdr4note);
-	return has_dumped;
+	return ret;
 }
 
 #endif		/* CONFIG_ELF_CORE */
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index fe0b5c5ed2bc..252eb155965b 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -75,7 +75,7 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *,
 					     struct file *, struct mm_struct *);
 
 #ifdef CONFIG_ELF_CORE
-static int elf_fdpic_core_dump(struct coredump_params *cprm);
+static bool elf_fdpic_core_dump(struct coredump_params *cprm);
 #endif
 
 static struct linux_binfmt elf_fdpic_format = {
@@ -1476,9 +1476,9 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm,
  * and then they are actually written out.  If we run out of core limit
  * we just truncate.
  */
-static int elf_fdpic_core_dump(struct coredump_params *cprm)
+static bool elf_fdpic_core_dump(struct coredump_params *cprm)
 {
-	int has_dumped = 0;
+	bool ret = false;
 	int segs;
 	int i;
 	struct elfhdr *elf = NULL;
@@ -1535,7 +1535,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	/* Set up header */
 	fill_elf_fdpic_header(elf, e_phnum);
 
-	has_dumped = 1;
+	cprm->state |= COREDUMP_STATE_STARTED;
 	/*
 	 * Set up the notes in similar form to SVR4 core dumps made
 	 * with info from their /proc.
@@ -1655,6 +1655,8 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 		       cprm->file->f_pos, offset);
 	}
 
+	ret = true;
+
 end_coredump:
 	while (thread_list) {
 		tmp = thread_list;
@@ -1665,7 +1667,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	kfree(elf);
 	kfree(psinfo);
 	kfree(shdr4extnum);
-	return has_dumped;
+	return ret;
 }
 
 #endif		/* CONFIG_ELF_CORE */
diff --git a/fs/coredump.c b/fs/coredump.c
index d61f36239f91..6af3ff0e19a6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -98,7 +98,6 @@ struct core_name {
 	char *corename __counted_by_ptr(size);
 	int used, size;
 	unsigned int core_pipe_limit;
-	bool core_dumped;
 	enum coredump_type_t core_type;
 };
 
@@ -250,7 +249,6 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 	cn->used = 0;
 	cn->corename = NULL;
 	cn->core_pipe_limit = 0;
-	cn->core_dumped = false;
 	if (*pat_ptr == '|')
 		cn->core_type = COREDUMP_PIPE;
 	else if (*pat_ptr == '@')
@@ -549,13 +547,13 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	return core_waiters;
 }
 
-static void coredump_finish(bool core_dumped)
+static void coredump_finish(enum coredump_state state)
 {
 	struct core_thread *curr, *next;
 	struct task_struct *task;
 
 	spin_lock_irq(&current->sighand->siglock);
-	if (core_dumped && !__fatal_signal_pending(current))
+	if ((state & COREDUMP_STATE_STARTED) && !__fatal_signal_pending(current))
 		current->signal->group_exit_code |= 0x80;
 	next = current->signal->core_state->dumper.next;
 	current->signal->core_state = NULL;
@@ -1045,19 +1043,23 @@ static bool coredump_pipe(struct core_name *cn, struct coredump_params *cprm,
 	return true;
 }
 
-static bool coredump_write(struct core_name *cn,
-			  struct coredump_params *cprm,
-			  const struct linux_binfmt *binfmt)
+static bool coredump_write(struct coredump_params *cprm,
+			   const struct linux_binfmt *binfmt)
 {
 
-	if (dump_interrupted())
+	if (dump_interrupted()) {
+		cprm->state |= COREDUMP_STATE_TRUNCATED;
 		return true;
+	}
 
-	if (!dump_vma_snapshot(cprm))
+	if (!dump_vma_snapshot(cprm)) {
+		cprm->state |= COREDUMP_STATE_TRUNCATED;
 		return false;
+	}
 
 	file_start_write(cprm->file);
-	cn->core_dumped = binfmt->core_dump(cprm);
+	if (!binfmt->core_dump(cprm))
+		cprm->state |= COREDUMP_STATE_TRUNCATED;
 	/*
 	 * Ensures that file size is big enough to contain the current
 	 * file postion. This prevents gdb from complaining about
@@ -1066,7 +1068,8 @@ static bool coredump_write(struct core_name *cn,
 	 */
 	if (cprm->to_skip) {
 		cprm->to_skip--;
-		dump_emit(cprm, "", 1);
+		if (!dump_emit(cprm, "", 1))
+			cprm->state |= COREDUMP_STATE_TRUNCATED;
 	}
 	file_end_write(cprm->file);
 	free_vma_snapshot(cprm);
@@ -1082,7 +1085,7 @@ static void coredump_cleanup(struct core_name *cn, struct coredump_params *cprm)
 		atomic_dec(&core_pipe_count);
 	}
 	kfree(cn->corename);
-	coredump_finish(cn->core_dumped);
+	coredump_finish(cprm->state);
 }
 
 static inline bool coredump_skip(const struct coredump_params *cprm,
@@ -1136,14 +1139,14 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	if (unshare_files())
 		return;
 
-	if ((cprm->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
+	if ((cprm->mask & COREDUMP_KERNEL) && !coredump_write(cprm, binfmt))
 		return;
 
 	coredump_sock_shutdown(cprm->file);
 
 	/* Let the parent know that a coredump was generated. */
 	if (cprm->mask & COREDUMP_USERSPACE)
-		cn->core_dumped = true;
+		cprm->state |= COREDUMP_STATE_STARTED;
 
 	/*
 	 * When core_pipe_limit is set we wait for the coredump server
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 2c77e383e737..64f82fb642bf 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -94,7 +94,8 @@ struct linux_binfmt {
 	struct module *module;
 	int (*load_binary)(struct linux_binprm *);
 #ifdef CONFIG_COREDUMP
-	int (*core_dump)(struct coredump_params *cprm);
+	/* Returns true if the whole coredump was written. */
+	bool (*core_dump)(struct coredump_params *cprm);
 	unsigned long min_coredump;	/* minimal dump size */
 #endif
 } __randomize_layout;
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 943bddfb22bf..709388dd5659 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -9,6 +9,16 @@
 #include <asm/siginfo.h>
 
 #ifdef CONFIG_COREDUMP
+/**
+ * enum coredump_state - what happened while the coredump was written
+ * @COREDUMP_STATE_STARTED: the dumper committed to writing a coredump
+ * @COREDUMP_STATE_TRUNCATED: the dumper stopped before it had written all of it
+ */
+enum coredump_state {
+	COREDUMP_STATE_STARTED		= (1U << 0),
+	COREDUMP_STATE_TRUNCATED	= (1U << 1),
+};
+
 struct core_vma_metadata {
 	unsigned long start, end;
 	vm_flags_t flags;
@@ -28,6 +38,8 @@ struct coredump_params {
 	int cpu;
 	/* COREDUMP_* options negotiated with the coredump server. */
 	u64 mask;
+	/* COREDUMP_STATE_* raised while the coredump is written. */
+	enum coredump_state state;
 	loff_t written;
 	loff_t pos;
 	loff_t to_skip;

-- 
2.53.0


