Return-Path: <linuxppc-dev+bounces-25995-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FF2C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:11:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMk94DQCz304N;
	Thu, 20 Aug 2026 09:10:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181041;
	cv=none; b=mZiTZgrJ2T974S44/lDD/xibXG/X2UZ2JvWd1W9m+yfJYSNt2BQZYXlLPRcsr3AlIgqaT8YSaVjPq49eD9OfeWmIc2y1gkFxHPLZokqk558v8lzuUTXKmWh56+xpyQrMLwkzQYLnWIaerV+Ql7n8CHnAPUmniutYjAH5OW0IFHLhDHxtZXQxJPPKkiGkaxGVdP9RNhzaPzJ8I7/WCQhDvqxGQDVXmO/sGvQ7MX6gKM30w84VuQGNotrD8Cz6Vya/A0O/o5wSP91QfQmxKhugow+4SW2IBs/r18CjW75lQ5re0lX7wLzgEXYDvloQJF7AIkBttviL3ZgnVmgmLxoHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181041; c=relaxed/relaxed;
	bh=aaMUb6PaGUkY1uYWWgN3cAeUq6l9h+PWt5o9AmFAt0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nj9AvLGioVhqdsno+GFcGUEClVpM6Iq7vAO71kamkNFnQjcBEJTMwWRk9DvYnu/Qt2F2/J3FMhF0SXPw2AtD/vgeYDl7qXeCKbyVF1p+iSqt3Ke00a3ZysGtxOBE/inNTF/9PxvXFWBinXUaqj7nSrij4oPPQ8L2xEFUQ7mqBAha+si4E8mmUo307TdTKKJN5PUPZRfuPlvf3Nv9PDjadyqFMMt7XRGWDqadfw5TRdYnezlQT7h81d1WsbSrxJrZix/SOIb4581ZqeLk6XJbI4B56UHTUyE4X0EET0pkj/dDQ/o2r3gW3QdQAxowpP9XDJLWJX4aeSioqmA23edlMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Heen4TOm; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Heen4TOm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMk900gKz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:10:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C6F940876;
	Wed, 19 Aug 2026 23:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49BC1F000E9;
	Wed, 19 Aug 2026 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181039;
	bh=aaMUb6PaGUkY1uYWWgN3cAeUq6l9h+PWt5o9AmFAt0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Heen4TOmnIFtyQjYyv7+PIzwbbZz42Npc0GW51hx4ud6x7Rqf5vC43y2nUEyf6ECq
	 pcOtUTCa4JHCyEcCor01N2FsrVzY4Xjm7i7SOASr/nhmsgg1panWWpwognCtck7bki
	 amyCR7G/xgubDR7CnBmNhnmShiSOXhCZV/EmhjyDGMOd6gpBaEBfm+7WrYTH4VOLe6
	 tXsyvPISipyoCmNDuotbnVIf6lTR6kOjJNL3xCZyYHZMVbKMd4DQD80VHObnZVHCMI
	 1Y1SlAo5BoouEupVho6PfMbHhNiwNVamHrCRweaUELDn/awZxVfgZVA4v7U39hHat8
	 ey9XD16ZR5ocA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:25 +0200
Subject: [PATCH v2 08/22] coredump: move the negotiated mask into struct
 coredump_params
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
Message-Id: <20260820-work-coredump-sparse-v2-8-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xonH5OEmjGZ0T+LJRAZWyQJ2cLCDz3LlxuOJfpmUo8A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me978e91/5SSmW3Hd9p4NXx6qdCyYpr/+dqUjoUst
 1Q28tkKd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkdCIjw42MXtMq5yP82dzF
 ZmKXY/pZpcJSc2XNFfnOrl+sa7iJkeF/EmfJzMjNwrER+n7NRrdtNXuSDntrCy5pULGROCMwcx0
 HAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The coredump server negotiates a set of COREDUMP_* options with the
kernel. The core dump path cannot see them though.

Move the mask into struct coredump_params to make them available.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c            | 15 +++++++--------
 include/linux/coredump.h |  2 ++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index c696b46c97ff..156688be3df0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -100,7 +100,6 @@ struct core_name {
 	unsigned int core_pipe_limit;
 	bool core_dumped;
 	enum coredump_type_t core_type;
-	u64 mask;
 };
 
 static int expand_corename(struct core_name *cn, int size)
@@ -245,9 +244,9 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 	int pid_in_pattern = 0;
 	int err = 0;
 
-	cn->mask = COREDUMP_KERNEL;
+	cprm->mask = COREDUMP_KERNEL;
 	if (core_pipe_limit)
-		cn->mask |= COREDUMP_WAIT;
+		cprm->mask |= COREDUMP_WAIT;
 	cn->used = 0;
 	cn->corename = NULL;
 	cn->core_pipe_limit = 0;
@@ -860,7 +859,7 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		return false;
 	}
 
-	cn->mask = ack.mask;
+	cprm->mask = ack.mask;
 	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
 }
 
@@ -1129,7 +1128,7 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	}
 
 	/* Don't even generate the coredump. */
-	if (cn->mask & COREDUMP_REJECT)
+	if (cprm->mask & COREDUMP_REJECT)
 		return;
 
 	/* get us an unshared descriptor table; almost always a no-op */
@@ -1137,13 +1136,13 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	if (unshare_files())
 		return;
 
-	if ((cn->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
+	if ((cprm->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
 		return;
 
 	coredump_sock_shutdown(cprm->file);
 
 	/* Let the parent know that a coredump was generated. */
-	if (cn->mask & COREDUMP_USERSPACE)
+	if (cprm->mask & COREDUMP_USERSPACE)
 		cn->core_dumped = true;
 
 	/*
@@ -1151,7 +1150,7 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	 * or usermodehelper to finish before exiting so it can e.g.,
 	 * inspect /proc/<pid>.
 	 */
-	if (cn->mask & COREDUMP_WAIT) {
+	if (cprm->mask & COREDUMP_WAIT) {
 		switch (cn->core_type) {
 		case COREDUMP_PIPE:
 			wait_for_dump_helpers(cprm->file);
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 7b38ee2e7913..dc7a05b1bb0a 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -26,6 +26,8 @@ struct coredump_params {
 	/* Snapshot of dumpable at dump start. */
 	enum task_dumpable dumpable;
 	int cpu;
+	/* COREDUMP_* options negotiated with the coredump server. */
+	u64 mask;
 	loff_t written;
 	loff_t pos;
 	loff_t to_skip;

-- 
2.53.0


