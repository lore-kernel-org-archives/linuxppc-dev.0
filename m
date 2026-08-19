Return-Path: <linuxppc-dev+bounces-25989-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A95C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:10:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMjb6Gn3z2yqx;
	Thu, 20 Aug 2026 09:10:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181011;
	cv=none; b=i8oBqbTjFWErVwqmTxzVtaQZocOwl2U0s3+5JAyeK068AMSmBGsI6nCRlvw1DSAC7RNMuoza8rkfZ/Xfa5Wcgx/rAa9ERWlEIFR4RjjRvR5xQO7ldijtFH9zNeYQwHnXGu3eFfh0asydWGEx6ehEHc6LrZmZNBLkEA1GaMoFJBlkvU7nlHq4d0zrJaSv42Za5NDlB2cEIkxf3g+W8gUw5v5SIBuq3jer7/DB5HBHUlV65nGNUyPpYBKKcXlwhKacdZ2g+S3O1bs7rPQ6gDNJRAi4ykW4ddFj4Cw1olI1v0ZjPrHXnXIL9L6N7+nsCpUlsXFS6VWOXQoVzxfYNTNQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181011; c=relaxed/relaxed;
	bh=0bW5IEgJKmSIJtwmTEEMkv73JLFJ3IXzsjpXfuyidoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y8ZJ8SGp8GDcQfEt2RgkfPzggI8NXHHYcZasmoJOE+G4TJ56oIbTgm48nvWXbvX4aN52USEYOrxwL4JBDE5GhFpKMV9yqReuBlNvVAD7ZvrDRozn7edKLRN+2LhMVB+Ea41m6lxePImLBnS1j41klU66nUL6LWrdAh2P/CrMemVkoWW1uS7zx/qM5RrKKmksar8/XT5AC+sd8hE6A2UHZecsFjxJIJNXc9QWSZYOP+ZMFDPAyLUfOhly9T6Es1Bfr2NacBHLLQnkZyEFE4dOdzY/TCzIWpntKqiLjh1lGmtw0JD1qpPLTihsK//A2c7ehjAKkTlw8bLefylAuQHHOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEuB932n; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEuB932n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMjb1Y8Tz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:10:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5858061887;
	Wed, 19 Aug 2026 23:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D71A1F000E9;
	Wed, 19 Aug 2026 23:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181008;
	bh=0bW5IEgJKmSIJtwmTEEMkv73JLFJ3IXzsjpXfuyidoc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LEuB932nM/UQEfWfWfw+dOgybuedzZaOhO1071ixqoQoMGoiYm2QscBoR/y1Lezs+
	 NvT56PSoLqff/NUiucZuYKdzV49MAfi00OrwzpOdkarTrTs7Pry9k1zO3t1p9eF89Y
	 awmjvXy/9IWizfJB3QQe5eIL2qWXTcU0fV+UNqvKIzzwNT2mbySQ19T8c/NqinCiLA
	 ow6UDBbGwBpzydM9cL+k3npIWi4glJWVz4PlywMdvwup0S5lpZwSBYlnLwxAiLfFAu
	 WeJ6kcitLnoLnFQxYwGiquxV/WtjI0r396xQBGdFFvQMjxH6aFWOLhRaa3lLWqgBcJ
	 Dmx30y1DHJEUA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:19 +0200
Subject: [PATCH v2 02/22] coredump: refuse negative skips
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
Message-Id: <20260820-work-coredump-sparse-v2-2-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=brauner@kernel.org;
 h=from:subject:message-id; bh=g0a1kYV53viXcxL/lVIPR2fuUykenxBNOGfzhwh0UJQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me9TP7f+9yQT8+WvJ+wQ0jY2mNB/LONcQnJeyOkDJ
 24lCISXdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE/xrD/0q2Cxy3aozfKVUX
 5X0+Zqu+eOeEHYf2dJ5SnJnv351ec5eR4fgWa6cL2ksdZ3KVXt50XN92X1DWlz9iInYXiq5Kt3w
 /zQwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The dump_skip_to() helper calculates a relative skip based on the
absolute positon of the coredump:

	cprm->to_skip = pos - cprm->pos;

That's easy to mess up for callers and one already did. This risk
endless zero PAGE_SIZE loops or overwriting already written coredump
data thereby corrupting the dump.

I don't think skipping backwards has any meaning. So warn and refuse.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index e68a76ff92a3..ac4e922c9cb9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1261,6 +1261,8 @@ EXPORT_SYMBOL(dump_emit);
 
 void dump_skip_to(struct coredump_params *cprm, unsigned long pos)
 {
+	if (WARN_ON_ONCE(pos < cprm->pos))
+		return;
 	cprm->to_skip = pos - cprm->pos;
 }
 EXPORT_SYMBOL(dump_skip_to);

-- 
2.53.0


