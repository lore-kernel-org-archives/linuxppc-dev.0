Return-Path: <linuxppc-dev+bounces-26007-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CDCC5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:12:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMlY3qPnz2yRP;
	Thu, 20 Aug 2026 09:11:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181113;
	cv=none; b=W+4wucqMZxGuz0XhmoFOUMmmVRFUUmFeAaQzfqIv07Kcc35ykz/GBbCA7tNYHWA3MF9NyU0C8e64LPFxscmqtKJEv5QdRq1KUOWSQxtgbWfQKUlQxSrtvcxCpampxp7J9P38izgl/j+eHQVrRDmSX6fzQoVrhBcio2LhCGTiJK6M/6Ke2ir7f2OdSzZyQfQgqSJ0NW6F0BDGfbCNkSwAQQ4eDmpjbo0eaEiLwlUwzJFcqnav437A6yiOvLbDPxSPfhjs02qL91QQUuIh605Y/TrJSlW5BxuKCinFGMVto61/BGJuwOTLf5Dgkb8sVVtfqUThwL9lFTyKUf2aZZyJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181113; c=relaxed/relaxed;
	bh=+eE/AORVX+nBzdLhuXTjCNB11etNcl4Di3dO/GDhzUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fl67wXIUzF3WWwKP/xlxAVK/UU6RTx1hTrEq0Ymh0D/kbSeDux/cqOlzULZKFzEwXxSxe2cQ6DDfIQD+vKvqfiXHf6cmr4QspXnGIA9AoPHtvRvdCYEchWQn6UEIt9evMouixZI0tUD55MXXeVIfm1x2bHtjRiEpRqVs8IRGV5T6YQ7NWHJt2vT9uK93a8JJHbNpWXHJbfFC7n23jALiRIOGtmbkCXGJK5xSEUXGFcoFDJCaugspITaDUQoQQQ+KO71QqcptcEK6Fsuem2+5vMvzpu01pNqnY0e0sn6uBqJBpptot4gYvpEl51D/p9r/LdvS0M7ab1sGfO9x4n0IDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEo/GcvL; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEo/GcvL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMlX5JsQz2yRC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:11:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3CB9240BF4;
	Wed, 19 Aug 2026 23:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF091F00A3D;
	Wed, 19 Aug 2026 23:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181111;
	bh=+eE/AORVX+nBzdLhuXTjCNB11etNcl4Di3dO/GDhzUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UEo/GcvLbLse8DiCCa3t7vPZHj60cEF3fZrSik9Od4RpIOFSFmMwo7fEUfZgZR7Pt
	 udxRLnjSlYQv3oQqouyBpSyVJ6zf6n9Gy6bkUImPErHml4pJMDGP/IlljQbGMNFE04
	 A9TSHt3Ty9JknWI0dDqGELgO+d9HDU+otlMyoh1+dmSL4Jm4iKqraFCz3Frums7sDZ
	 LJ/mF44Lqx0HvnRhIYyIVcXddqyH3nvErDW/W1fcMaloLXs84ii1v4U5HDOoHgdSz8
	 unuwJWVOrMcWushztXgAFusUL71pcM4wVr2qDXyb1WFG9jdw5B6V6rQhddIwtTMFNl
	 rF5qLRVxZxzvQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:37 +0200
Subject: [PATCH v2 20/22] selftests/coredump: put a hole in the middle of a
 sparse mapping
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
Message-Id: <20260820-work-coredump-sparse-v2-20-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CDf2/UuMc2XBowFgVdwGiPjPw3vkqMeWbhqWHKnJoXk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me9vF+H9di5sY8ORyo2Z2qz/hCYU/K/5+HdTcsiVe
 cuKvmaFdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkgz/DXznjj78+PZreIRbI
 +6nK0qx146GMc785hBbGqdUv+HuQOYnhv29pM/eVHcLM3xs938SYnmKtqXRtfqxaKHxaXU953YM
 8LgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The crashing_child_sparse() helper touches the first page of the
mapping. That forces everything behind it to be a trailing hole. This is
easy to handle. Make the test more difficult meaningful by also touchin
the last page. This causes the hole to sit between two populated pages.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_test_helpers.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 45d76fa0f469..89f3954c5607 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -58,14 +58,16 @@ void crashing_child_sparse(size_t size)
 	char *p;
 
 	/*
-	 * Touch the first page only. The whole mapping is dumped because
-	 * it has been written to, but all of it save that one page is a
-	 * hole.
+	 * Touch the first and the last page. This will cause the whole mapping
+	 * to be dumped because it has been written to. Everything between
+	 * those two pages is a hole though.
 	 */
 	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
 		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
-	if (p != MAP_FAILED)
+	if (p != MAP_FAILED) {
 		p[0] = 'x';
+		p[size - 1] = 'x';
+	}
 
 	/* crash on purpose */
 	*(volatile int *)NULL = 0;

-- 
2.53.0


