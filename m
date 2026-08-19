Return-Path: <linuxppc-dev+bounces-25990-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F9EC5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:10:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMjg4dsmz2yRC;
	Thu, 20 Aug 2026 09:10:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181015;
	cv=none; b=dk9qPky6U7FDY0XGrovqyyWUU1q/y2zMxCGAu+1HkSJaY1B8dh4ju/6KZJIFRzq+j58rm8Ar5l1CWE+obsX+VlcyLE9S1hAtcrR9sclXbBRzxj2X7z9tdhcNua6HpQmNkMMTIyRpd3njU3lB1u0y1deLLDNBo1GQgqTg4t09cHewkacWqQGr4MdH8PYua6pLZaNqzQrQsbVkOof2pw01ldvTTyorjPfrmwnvXxNTOXcTqeywyMSmT0XJhyMKFW10Ju+pJ4wX9c5IaHVGYqGaRhpSvB+rs8usp7+xnSwzay2sStQ9yOjx94U0lVlWr2m+LlqM76jiXZItZssHbOaOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181015; c=relaxed/relaxed;
	bh=0RC2YxYzQBAU6npYN6xnbM7sVbfE8POELBDVIx12dQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fq5mTXN4xFAOzZMKX7ILBHlcfu2fPVTiwEFyvymEBtCF29Ne8NiLnVPl4f+psrpRf5PGC21ZJzD5U/e0kYtGddyvJxWYwd2fY+Mf6dPvSR8q5P6tW9R0SGYsun2CV1XTtBTwSem8md0JIxhXn45BsjF6FjnVcKS+RrwZE9ealjjUvVYuCt3kRkNIYg8nVF4LKvlzqGN1iaQMFNPXkqjn1NkptRkutxfP48KqAnouk4i7KoEpnbNu7NU08ehFsAaYPfUWUB/Pywx6KVauitIeRCHN3xC9QP8jKlHrtWLUE+hXk8d5a6ZNlHY0iH3/RUYk2SDJjzFW0YnEI//fwWX+KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oAI6Ih3E; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oAI6Ih3E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMjf5vWJz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:10:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 526D240524;
	Wed, 19 Aug 2026 23:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ABF1F00A3D;
	Wed, 19 Aug 2026 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181013;
	bh=0RC2YxYzQBAU6npYN6xnbM7sVbfE8POELBDVIx12dQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oAI6Ih3ES/uFGIJgmiQTn7WY/aZkn/AmM5u9fkKnyStjUi5sXMyjRKOtSV5LDe940
	 7wihflb810Z+L9Ww4j7YrE8EejKnI6YrxR4rECv8TzgORD9meFSPK+LjfG/oSYFWLC
	 6vsnvLC4hn1ofgJ7jtXSxaJL35SXJnVtwb4tWWg/egX0jbQmfm7BhPxfbbRF8iiVZw
	 PalTaJOSi03ConwvdOQZfr0rrSv8vPIXC7y4mv38CBQxMR5h4+4LjCxroelASoaXzv
	 9zh1A+0jgLLMWzoIQoZ9mKRhWi/Fo/js7nQJb+oLreuUtRaSdzXx90mtVuRx/bt2T4
	 yPwURA42dZGog==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:20 +0200
Subject: [PATCH v2 03/22] coredump: set the minimum send buffer size
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
Message-Id: <20260820-work-coredump-sparse-v2-3-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5Qwhyl+9KLUXcn7sqhHlco4XV14G2yqAc5quiUYCHt8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me8TeBZ77qmlydyE53qlJxOEfibmzdt/tU1OvC3v2
 LHf31YrdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEVISRoVPG1XmbU4xXxda6
 P7ovat3kLVoWdwuXsnMvDFOOcrv1iOEXs+T5eW+uTLjurOJqYFRRsmHCi7ULJ++9HRoYU2ka8iW
 fFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The send buffer of the coredump socket is subject to the limit in
net.core.wmem_default. af_unix uses sk_sndbuf / 2 - 64 bytes for a
single skb. That means a send buffer below that would split a page-sized
write into multiple skbs. Raise the send buffer to leave room for a
page-sized write plus the header. The default value is well above that.
So we really change it when it's below our minimum.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index ac4e922c9cb9..24a6405ea242 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -665,6 +665,9 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 }
 
 #ifdef CONFIG_UNIX
+/* af_unix halves the send buffer to size a single skb. */
+#define COREDUMP_SOCK_SNDBUF_MIN (3 * PAGE_SIZE)
+
 static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *cprm)
 {
 	struct file *file __free(fput) = NULL;
@@ -690,6 +693,10 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
 	if (retval < 0)
 		return false;
 
+	/* Don't let a page-sized write split into several skbs. */
+	socket->sk->sk_sndbuf = max_t(int, socket->sk->sk_sndbuf,
+				      COREDUMP_SOCK_SNDBUF_MIN);
+
 	file = sock_alloc_file(socket, 0, NULL);
 	if (IS_ERR(file))
 		return false;

-- 
2.53.0


