Return-Path: <linuxppc-dev+bounces-25993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C8FC5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:10:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMk00Hbkz2ywn;
	Thu, 20 Aug 2026 09:10:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181032;
	cv=none; b=VrRuRre5f+CDtXickstuCgzCvvqzBzbv7KhgZkJId/j4GIqHrL1+O4ivlAd90N8mYZUkohuQPEhVjckljEH7NemfGqsNHxVP2kzb6Z8P+pM8i/mleanbqpXTiO3cU7M16Y38tvfP42mGV9Og5AgW6rETD4eJdYQhm3qRwagS3aQ4F3Kf8qLUQQQfXKefIe9jbtF6ndhSjxZU+0rHoRMA1t9Kugb7R1ZSgAj7sFMgo6nstXhA90R0/xNZVFgtKV4M80HB6OM/RTKGMtuE9XEdKUCsVz35Bc7mAt1IEkTTSNjeR0VMeVZoShZHp4chZf8ehtSMSc+vB3w4n5riQ8d/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181032; c=relaxed/relaxed;
	bh=YdXiWhIfB4/T9Skkykrd3/nKKqeoThgdVH++ESCo2VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BcU4R3h3ug+4Fuzi+gtpSdDpq6wk+I3Wyhlk+TSdU8zJt90FwqouC7kIB8wYTQc06VKJhZJisz5ZSoGNj9fRx7sF3XmsoO7xR/GGyzh8W8P9tmHuo7zQINpg2dAtYo6qjx81LcyHfkka8b758F7JqlSe8YCSL5UpZTjion0TQCs82dZ2irtw5I8jNuBr0sLitjcO9L5kioWwzQzSHYRFUHNjz4823LknFhVaTQM5ZsLMtaxwk+PeK1PoP5XKW3TJfghB3vt0Vnodcb2BeceunK9gSYR1IlbrbdW0CDMj+jOvZTNWBMfDjtMyk21urLek6xUa28WLHc3EanncBFIsaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyZeAj5g; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyZeAj5g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMjz1LBZz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:10:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B53E44016;
	Wed, 19 Aug 2026 23:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170201F000E9;
	Wed, 19 Aug 2026 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181028;
	bh=YdXiWhIfB4/T9Skkykrd3/nKKqeoThgdVH++ESCo2VU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QyZeAj5glCUzDjsxZE4JmbH5umochvY1cH28IICIMq+PVSNqs9f6uqzC3leCeKYeB
	 rfl/IBBdVwxU7IoZVCZk5U9aoMplnYPpsIRtSkZukDs9OzsIxCLpUdPh0RvEOuVohi
	 aPrB8VGlKZcBGkxy+NdZblHbunV0YNE0LJJngP4XBwkFXWjRgVDsk++j9VDR4YCUIP
	 F3a5HrJBM/Q/lJcKDMFOf5fWOe2ji9o/OeX3mhG8bepd2E0y5DVtZ2ONC5k+5VT52i
	 MDtcev4gHFqi35z6p3F3Ciy87B0Vi5vrvLU9DBq2wPALAkbyuovP9CBjRVq7gdXamp
	 /jf8Dukonc+rA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:23 +0200
Subject: [PATCH v2 06/22] selftests/coredump: add a separate helper header
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
Message-Id: <20260820-work-coredump-sparse-v2-6-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4984; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nsuGWse/lAGPONW5/zPiRodF4aWWrgZOlUZ3HMqmnYU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+7qZKzWDv62wNhQ4FbqkVrA5z2f2iLbmV44Hffz
 2jyP3O/jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInIpjAyLPfN5Nk1U+fxDK+7
 ldo5fxJlvIJ871syHZ0lp/tU/In3E0aG3SmJPrszs04dFfu1f//hXI2t9wwsN1ir/97jk/ticbE
 KLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Right now we have coredump_test.h which pulls in the test harness.
So it can't be included in coredump_test_helpers.c and it hand-rolls a
bunch of stuff that is not needed.

Instead of this mess, split everything out into a separate
coredump_test_helpers.h header and make both coredump_test.h and
coredump_test_helpers.c include it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_test.h   | 30 +-----------------
 .../selftests/coredump/coredump_test_helpers.c     | 17 +---------
 .../selftests/coredump/coredump_test_helpers.h     | 37 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
index a02809145e2d..8d99b5cb2f12 100644
--- a/tools/testing/selftests/coredump/coredump_test.h
+++ b/tools/testing/selftests/coredump/coredump_test.h
@@ -3,18 +3,9 @@
 #ifndef __COREDUMP_TEST_H
 #define __COREDUMP_TEST_H
 
-#include <stdbool.h>
-#include <sys/types.h>
-#include <linux/coredump.h>
-
 #include "../kselftest_harness.h"
-#include "../pidfd/pidfd.h"
-
-#ifndef PAGE_SIZE
-#define PAGE_SIZE 4096
-#endif
 
-#define NUM_THREAD_SPAWN 128
+#include "coredump_test_helpers.h"
 
 /* Coredump fixture */
 FIXTURE(coredump)
@@ -24,15 +15,6 @@ FIXTURE(coredump)
 	int fd_tmpfs_detached;
 };
 
-/* Shared helper function declarations */
-void *do_nothing(void *arg);
-void crashing_child(void);
-int create_detached_tmpfs(void);
-int create_and_listen_unix_socket(const char *path);
-bool set_core_pattern(const char *pattern);
-int get_peer_pidfd(int fd);
-bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
-
 /* Inline helper that uses harness types */
 static inline void wait_and_check_coredump_server(pid_t pid_coredump_server,
 						   struct __test_metadata *const _metadata,
@@ -45,14 +27,4 @@ static inline void wait_and_check_coredump_server(pid_t pid_coredump_server,
 	ASSERT_EQ(WEXITSTATUS(status), 0);
 }
 
-/* Protocol helper function declarations */
-ssize_t recv_marker(int fd);
-bool read_marker(int fd, enum coredump_mark mark);
-bool read_coredump_req(int fd, struct coredump_req *req);
-bool send_coredump_ack(int fd, const struct coredump_req *req,
-		       __u64 mask, size_t size_ack);
-bool check_coredump_req(const struct coredump_req *req);
-int open_coredump_tmpfile(int fd_tmpfs_detached);
-void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file);
-
 #endif /* __COREDUMP_TEST_H */
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 306711e1b24d..570fc2e005c2 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -20,23 +20,8 @@
 #include <unistd.h>
 
 #include "../filesystems/wrappers.h"
-#include "../pidfd/pidfd.h"
 
-/* Forward declarations to avoid including harness header */
-struct __test_metadata;
-
-/* Match the fixture definition from coredump_test.h */
-struct _fixture_coredump_data {
-	char original_core_pattern[256];
-	pid_t pid_coredump_server;
-	int fd_tmpfs_detached;
-};
-
-#ifndef PAGE_SIZE
-#define PAGE_SIZE 4096
-#endif
-
-#define NUM_THREAD_SPAWN 128
+#include "coredump_test_helpers.h"
 
 void *do_nothing(void *arg)
 {
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.h b/tools/testing/selftests/coredump/coredump_test_helpers.h
new file mode 100644
index 000000000000..45904bd177b8
--- /dev/null
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __COREDUMP_TEST_HELPERS_H
+#define __COREDUMP_TEST_HELPERS_H
+
+#include <stdbool.h>
+#include <sys/types.h>
+#include <linux/coredump.h>
+
+#include "../pidfd/pidfd.h"
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE 4096
+#endif
+
+#define NUM_THREAD_SPAWN 128
+
+/* Shared helper function declarations */
+void *do_nothing(void *arg);
+void crashing_child(void);
+int create_detached_tmpfs(void);
+int create_and_listen_unix_socket(const char *path);
+bool set_core_pattern(const char *pattern);
+int get_peer_pidfd(int fd);
+bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
+
+/* Protocol helper function declarations */
+ssize_t recv_marker(int fd);
+bool read_marker(int fd, enum coredump_mark mark);
+bool read_coredump_req(int fd, struct coredump_req *req);
+bool send_coredump_ack(int fd, const struct coredump_req *req,
+		       __u64 mask, size_t size_ack);
+bool check_coredump_req(const struct coredump_req *req);
+int open_coredump_tmpfile(int fd_tmpfs_detached);
+void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file);
+
+#endif /* __COREDUMP_TEST_HELPERS_H */

-- 
2.53.0


