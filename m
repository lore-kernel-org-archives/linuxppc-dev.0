Return-Path: <linuxppc-dev+bounces-25996-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DABC5DF88
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:11:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMkJ3HgQz2yll;
	Thu, 20 Aug 2026 09:10:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181048;
	cv=none; b=YB2FuwjvibrS8H8+RO3wzVqGW1mgyov7lIqZZ53N+/ljg0Noc4RKrFJx6Dxnk6TX2ITOxgdAyuc8adZBl6wg7h8tWqgv4dWFNX2CmmxN0mgy+uxN8rWCqfb1ES6bbgHdeZKM9NPcFc+2g2ZIjfAxTve+VoPvk+7P+6bbtZOpY3bsKqIVu2f6MqPfw5r/0l//PwtTCXiJ50+wzfJIkbitMmeMMpPa2FLDIuM1Y38nMveMPO07v1JYBcbTlBhaQeWCwfXM23N3/o+wMxMepo9RlaJRDxFpDVIX/EXQoMmi9HMj2UnvZc5enoVgQWsFuwDL5pMdBuZ4V9mYzQCcq0C6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181048; c=relaxed/relaxed;
	bh=aXCeFRO1r0hB0+8jo/097AeX5zU9p1RIeHyMY6Gqagw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pt1W5T5Vlz2rtHPgQgee4/v96IYn0U0QZCQxVUPWO8yjhwwlD73wXT1JwaKeFOPByNrfesy1yDPhejO8pnJafHuEXhhwRmfv+UcW/OTtrndPqB0q04TV6jepwZ+BHyu0KGHJGt+ErLiR+0Dz3PgshAmYiCnwHw/pNicwWX07gnqkeGtWs7ollvz11dfQHJpmiEO+X4adh233HRDg6mWx8PMTx1j32NmZOunMIondH/TLKLmLYFqn6AVHiJO2eRWpb3fSCNe5B3byBDBfJznbwaGq0LNFw18MpKq90c8XqS71sfERpyPm7agfq4gT/YcLHpVWz0A7rhiA8rJZ7dsu2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npJLhXeQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npJLhXeQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMkH3mTtz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:10:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6BCB361890;
	Wed, 19 Aug 2026 23:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76061F00A3A;
	Wed, 19 Aug 2026 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181045;
	bh=aXCeFRO1r0hB0+8jo/097AeX5zU9p1RIeHyMY6Gqagw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=npJLhXeQ/IhG/+xAo/mjKtSc3G9BXlgXjQH4PjRqutdnX5peq2Nb0g350sJgmLW31
	 s7nW1fZTCAWEOV02aDamCCA7OnVHMt3/8PYOv+2ooyKorkp92y3M1IbvY+2VOhnn3c
	 Rql9x/J8AT1PJmW7lYRZFVbrrxMjFU6ss2GHkylFXuw9vHwOhtyccBcOiHWKseSBir
	 bDadGtBVR5S+Y0CToo2UjrcVSJgqPxHoB1NfH4+TIfRbf1uuSnt9x0aJmbxBdMndTY
	 Bdf2XQEqKWgZ/t9qiKUtbN/s0s3uiyg5QyQMLAkfn34/IOWtw3b+svvtxJyFoPE6QJ
	 5WVqP1YzDqhwg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:26 +0200
Subject: [PATCH v2 09/22] coredump: deduplicate the to_skip flush
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
Message-Id: <20260820-work-coredump-sparse-v2-9-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QcTKefttEJ4tcHQFZJxvLhTEIvEaSI31GPP914rVvoI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me/b2di18GR/1eFdZf0CM6pf/jhn7NE3o91oG/ulh
 feNfzwQ6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI/1WGfyrqXP6z/RRY9dJf
 npzw5vKU39nneQTWthU/DeTov3ansoXhn+LSGdNrfecfqOB3WFNjfEAna8Jk5fzD2TenGXde8Th
 8lR0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

dump_emit() and dump_emit_page() open-code the same flush of the
accumulated cprm->to_skip. Move it into a helper.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 156688be3df0..cd36a72be445 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1256,13 +1256,21 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	return __dump_emit(cprm, zeroes, nr);
 }
 
-int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+/* Flush the accumulated hole before writing data. */
+static int dump_flush_skip(struct coredump_params *cprm)
 {
 	if (cprm->to_skip) {
 		if (!__dump_skip(cprm, cprm->to_skip))
 			return 0;
 		cprm->to_skip = 0;
 	}
+	return 1;
+}
+
+int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+{
+	if (!dump_flush_skip(cprm))
+		return 0;
 	return __dump_emit(cprm, addr, nr);
 }
 EXPORT_SYMBOL(dump_emit);
@@ -1293,11 +1301,8 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	if (!page)
 		return 0;
 
-	if (cprm->to_skip) {
-		if (!__dump_skip(cprm, cprm->to_skip))
-			return 0;
-		cprm->to_skip = 0;
-	}
+	if (!dump_flush_skip(cprm))
+		return 0;
 	if (cprm->written + PAGE_SIZE > cprm->limit)
 		return 0;
 	if (dump_interrupted())

-- 
2.53.0


