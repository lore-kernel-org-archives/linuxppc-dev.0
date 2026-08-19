Return-Path: <linuxppc-dev+bounces-25991-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE438C5DF86
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:10:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMjn3b5Sz2yRZ;
	Thu, 20 Aug 2026 09:10:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181021;
	cv=none; b=D7bx61bnBByI6NLWouhmPiJ2RR6O8qMA8UYY3XJegd9vvYRk9grswsgnWkkCTUaYdQg62qAYgW/hFd1+HOtAuCsz/Yclx2tBUAV8NQHukmT6MHZA6oSnuygpZTEDactsbBQVqxj3uVdqYTOZKG03YkIYajRnkzgCJmZNH0chngQy5/myBkx4Awgk3bC77ZUtB3Cei4reTLiAjKWN0YOZiZdhfuo5YHDCoeC59WEHZKVrSmgFJLinhcFVwwZqb7zkdNBBVMf4xFxDiXE7DHoZDq5ZmWxgxkfCx7yMeO9ofsF/1NS8stW0thmFqSVv9wWOG51L6pW29FHKz3wCX7aRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181021; c=relaxed/relaxed;
	bh=ivPc/dtcW/97whhIcc40lJlLMO/RUpWFUvsYkOmQdfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2K2iSeFGnMBIbUOURyz1mwI3yfhaN4AR5wG/cbgowInBhrNRRmvnpZAXW/4Bh90Lgh9J8GCrnitRWwSBz4UabhI/JrDQIbE8CLfCT8C83MH8YgYvj5GpSNdgG3sj29lqsOgYidoj0wH61yC2WyQYd8TTrJ3HkUc9AtvKehIMCSyzpmDJQ5xpiexiyP5lAofoaLkbtpliBM5ou71yj/NyaR+t9wxShgHgSJG1jCpB9nuOvxUIfZfDi998yVZ7Y3k7BxVcc0zKhff6ZzgoYOFfi+qiHQIXtFWMu2XaZMDEW1ciIDU7eOJiFOsKb5XZqjXITeTlmHW8a7bVUxIf+Syhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6JWGD+W; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6JWGD+W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMjm3l0mz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:10:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9BDA26187F;
	Wed, 19 Aug 2026 23:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEF71F000E9;
	Wed, 19 Aug 2026 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181018;
	bh=ivPc/dtcW/97whhIcc40lJlLMO/RUpWFUvsYkOmQdfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K6JWGD+W555VcCnv/WfeQSB+QTrQbSBqmZ9f3ug7SqSUGzYbWr0dw66iiH8N56xB3
	 FVhtRLxW6JDZUa3YuUwlb9kGKhtvLUcxhU6d7R9+RD83f0WYxXybttNB3adLAvDfZx
	 cdl2qR5wwhP6/IQem4P/DhDavLdhnZfGQvoIXBDmhn2ucjkKPL8lVuji0h2Glg3S09
	 e/bA11p7IMAFLWhywPR4+fGjqwsZYLmbvb+kfG54EEBI9/GulE6lkFCq3hklGMCDgS
	 qrrz5HvMZLX0fyPeIhW1dc8zjIDKv+nb124YfIlTOyLZwA7auRxlmzONjbyM/Dkjwz
	 1ySXTCfRaRz8Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:21 +0200
Subject: [PATCH v2 04/22] selftests/coredump: discard the right amount
 after the coredump request
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
Message-Id: <20260820-work-coredump-sparse-v2-4-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dsu3ug1yJTi0SPZbLicDCFNStcMxXGAWYCl1/1v264s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+7pRe3+NMWjXSGn5lHmO/EKd9Leiq2r49pmuC9Z
 ynJFa9fdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkViYjw76XK//37H+/YW/U
 tHo7Lyn1ta89ou43Hp/Le/qinD/j4lhGhn9iWpqvbRasebPDKSth9Szdm0/0Mzj/7pdY5XOlfc4
 LHTYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

read_coredump_req() gets the leftover wrong twice.

It takes the absolute difference of the two sizes, so a test binary that
knows a larger struct coredump_req than the kernel sends tries to discard
bytes that were never sent. And it hands recv() sizeof(buffer) instead of
the number of bytes it wants. So MSG_WAITALL waits for a whole page.
Either one blocks until the kernel closes the socket. Which it won't
because it is waiting for the coredump ack...

It's benign today because struct coredump_req hasn't grown. But let's fix
it for the future. Compute the leftover as what the kernel sent beyond
what was consumed.

Fixes: 59cd658eaf40 ("selftests/coredump: add coredump server selftests")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_test_helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 2a20faf9cb0a..524fa5370593 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -235,10 +235,10 @@ bool read_coredump_req(int fd, struct coredump_req *req)
 	fprintf(stderr, "Read coredump request with size %u and mask 0x%llx\n",
 		req->size, (unsigned long long)req->mask);
 
-	if (user_size > kernel_size)
-		remaining_size = user_size - kernel_size;
-	else
+	if (kernel_size > user_size)
 		remaining_size = kernel_size - user_size;
+	else
+		remaining_size = 0;
 
 	if (PAGE_SIZE <= remaining_size)
 		return false;
@@ -250,7 +250,7 @@ bool read_coredump_req(int fd, struct coredump_req *req)
 	if (remaining_size) {
 		char buffer[PAGE_SIZE];
 
-		ret = recv(fd, buffer, sizeof(buffer), MSG_WAITALL);
+		ret = recv(fd, buffer, remaining_size, MSG_WAITALL);
 		if (ret != remaining_size)
 			return false;
 		fprintf(stderr, "Discarded %zu bytes of data after coredump request\n", remaining_size);

-- 
2.53.0


