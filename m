Return-Path: <linuxppc-dev+bounces-25992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F294C5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:10:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMjt6Scnz2ykT;
	Thu, 20 Aug 2026 09:10:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181026;
	cv=none; b=RLKMNZHbXfx53nuiQKNeWBXGtPzVZz/323cHxyUdujGvz0JqOTX9j8AV9Gjc87XWU70f/Y7JSI1rtOYHRt0DftWQJIsPZjhZ2Ge3OPinvtZmQDEzIqZxdM2cpgrFa8K3jNfrsOdzI944cektoctehykCn6WIS1zJkJfZxgsgsbOwdaaoaWIOT5/i918a/458b2DJI2NBIYiiz+xuAU8shx0zcDHAe9n18YYIHHv2rKVdUuK/YIIyR03nRZyikK3+qa3Bd9Y8MzUMfXGfQLunJtG+nFAcbHF+ZDq+GeyT3j9KJ7pTXzw2D8UlUoCU/cmxcAKZdbuORaI/IAVuYQVlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181026; c=relaxed/relaxed;
	bh=Mn//jld94IflaVCOAy9GNpJdqgXUD79h4mfVzAad5s8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4neRhMh/ocjlbP9ni2eX7AgBPwsYm6bC5QgyW7tzhd0+VtChqpnsaG94QiPjFCv54mMobFUHH5MFmO+rTq2fu8weYG8Tax/IkZp1yNsNWwZNEgGB9Hf17nbeCgahjz61xBCUGEkicq6VAzIooA8kDdem2VmZVuz00Vnq6iIpZKg6isxTzQeFrP8MG5+RQcKUt6NkUSPv7pN4Y7SNRRmNLYAf9I7wCa00GYxSWBoDgyAUjehBp5U0eb4w6E9hqDWwPhTd2vmr8nFTyy3ugjMcepES52615GNqWZ/u7bY4rOrMIxJkGzOVrwtU8rFt7a/CqQxf7n36vrB7X915WhWUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idyv5wfo; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idyv5wfo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMjs6m01z2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:10:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B20FF40524;
	Wed, 19 Aug 2026 23:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66891F00A3A;
	Wed, 19 Aug 2026 23:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181023;
	bh=Mn//jld94IflaVCOAy9GNpJdqgXUD79h4mfVzAad5s8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=idyv5wfo9Pmww74TbNZCqGyPDb7RpSVAboVaSmhSgyUpAlIUJN+LwzMf2o14VvrT4
	 MeeJtOWMMRLoOdr8xhdnor7vsCKMraQBXUdlQJccWLbBHFQNEKqekfu8lOV7IuoA8P
	 EWy8NWlYPDKAKgcynwhK8e1kBWbqtcNfTucMqjC+i6qX6V9gSVj5h/QyIa/is4+GtX
	 /tkKBSCHk+tvF4zqwTBhe8NceRWyprrE5mSouQVN6rGR3+Y1lHMHqO7ekJbkoNPTZ6
	 SUDIJONYkaDVQFzJPNJTkxbm28ODEsWtor+i2czbma9svlM5bYoB3AEKK+F8fOvH/a
	 KMkCwUbiK1CWw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:22 +0200
Subject: [PATCH v2 05/22] selftests/coredump: collapse the expected request
 check into the helper
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
Message-Id: <20260820-work-coredump-sparse-v2-5-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8202; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1cIdjFnIkK2Pl9ULrDuU5PzmspGiS0xBl42KkhmV1jU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+rPfDayTDxeJdF4lJTG4nfFi07W19NzlRcYGooH
 Hdl0vf9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOR02H4H1U1Wzv8wS2Dnw5S
 J3d+CZkae/KzsCyHQhXD/ZyKEKWrzowMkxed3GB5getIw2HjV6su3v/AGtISwLawZP1nZXn9mqK
 PnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

All nine callers spell the expected flags. So every new feature bit the
kernel learns has to be cargo culted.

The callers also all pass COREDUMP_ACK_SIZE_VER0 as the minimum request
size although what is being validated is coredump_req->size. And
read_coredump_req() makes the same mixup twice more.

Clean this all up.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../coredump/coredump_socket_protocol_test.c       | 36 ++++++----------------
 tools/testing/selftests/coredump/coredump_test.h   |  3 +-
 .../selftests/coredump/coredump_test_helpers.c     | 35 +++++++++++++--------
 3 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
index d9fa6239b5a9..60a357e628eb 100644
--- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
@@ -151,9 +151,7 @@ TEST_F(coredump, socket_request_kernel)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_kernel: check_coredump_req failed\n");
 			goto out;
 		}
@@ -301,9 +299,7 @@ TEST_F(coredump, socket_request_userspace)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_userspace: check_coredump_req failed\n");
 			goto out;
 		}
@@ -441,9 +437,7 @@ TEST_F(coredump, socket_request_reject)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_reject: check_coredump_req failed\n");
 			goto out;
 		}
@@ -581,9 +575,7 @@ TEST_F(coredump, socket_request_invalid_flag_combination)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_invalid_flag_combination: check_coredump_req failed\n");
 			goto out;
 		}
@@ -702,9 +694,7 @@ TEST_F(coredump, socket_request_unknown_flag)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_unknown_flag: check_coredump_req failed\n");
 			goto out;
 		}
@@ -822,9 +812,7 @@ TEST_F(coredump, socket_request_invalid_size_small)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_invalid_size_small: check_coredump_req failed\n");
 			goto out;
 		}
@@ -944,9 +932,7 @@ TEST_F(coredump, socket_request_invalid_size_large)
 			goto out;
 		}
 
-		if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-					COREDUMP_KERNEL | COREDUMP_USERSPACE |
-					COREDUMP_REJECT | COREDUMP_WAIT)) {
+		if (!check_coredump_req(&req)) {
 			fprintf(stderr, "socket_request_invalid_size_large: check_coredump_req failed\n");
 			goto out;
 		}
@@ -1355,9 +1341,7 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps, 500)
 				goto out;
 			}
 
-			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-						COREDUMP_KERNEL | COREDUMP_USERSPACE |
-						COREDUMP_REJECT | COREDUMP_WAIT)) {
+			if (!check_coredump_req(&req)) {
 				fprintf(stderr, "check_coredump_req failed for fd %d\n", fd_coredump);
 				goto out;
 			}
@@ -1509,9 +1493,7 @@ TEST_F_TIMEOUT(coredump, socket_multiple_crashing_coredumps_epoll_workers, 500)
 				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: read_coredump_req failed\n");
 				goto out;
 			}
-			if (!check_coredump_req(&req, COREDUMP_ACK_SIZE_VER0,
-						COREDUMP_KERNEL | COREDUMP_USERSPACE |
-						COREDUMP_REJECT | COREDUMP_WAIT)) {
+			if (!check_coredump_req(&req)) {
 				fprintf(stderr, "socket_multiple_crashing_coredumps_epoll_workers: check_coredump_req failed\n");
 				goto out;
 			}
diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
index ed47f01fa53c..a02809145e2d 100644
--- a/tools/testing/selftests/coredump/coredump_test.h
+++ b/tools/testing/selftests/coredump/coredump_test.h
@@ -51,8 +51,7 @@ bool read_marker(int fd, enum coredump_mark mark);
 bool read_coredump_req(int fd, struct coredump_req *req);
 bool send_coredump_ack(int fd, const struct coredump_req *req,
 		       __u64 mask, size_t size_ack);
-bool check_coredump_req(const struct coredump_req *req, size_t min_size,
-			__u64 required_mask);
+bool check_coredump_req(const struct coredump_req *req);
 int open_coredump_tmpfile(int fd_tmpfs_detached);
 void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file);
 
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 524fa5370593..306711e1b24d 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -200,7 +200,7 @@ bool read_marker(int fd, enum coredump_mark mark)
 bool read_coredump_req(int fd, struct coredump_req *req)
 {
 	ssize_t ret;
-	size_t field_size, user_size, ack_size, kernel_size, remaining_size;
+	size_t field_size, user_size, known_size, kernel_size, remaining_size;
 
 	memset(req, 0, sizeof(*req));
 	field_size = sizeof(req->size);
@@ -214,9 +214,9 @@ bool read_coredump_req(int fd, struct coredump_req *req)
 	}
 	kernel_size = req->size;
 
-	if (kernel_size < COREDUMP_ACK_SIZE_VER0) {
+	if (kernel_size < COREDUMP_REQ_SIZE_VER0) {
 		fprintf(stderr, "read_coredump_req: kernel_size %zu < min %d\n",
-			kernel_size, COREDUMP_ACK_SIZE_VER0);
+			kernel_size, COREDUMP_REQ_SIZE_VER0);
 		return false;
 	}
 	if (kernel_size >= PAGE_SIZE) {
@@ -225,11 +225,11 @@ bool read_coredump_req(int fd, struct coredump_req *req)
 		return false;
 	}
 
-	/* Use the minimum of user and kernel size to read the full request. */
+	/* Consume as much of the request as we know about. */
 	user_size = sizeof(struct coredump_req);
-	ack_size = user_size < kernel_size ? user_size : kernel_size;
-	ret = recv(fd, req, ack_size, MSG_WAITALL);
-	if (ret != ack_size)
+	known_size = user_size < kernel_size ? user_size : kernel_size;
+	ret = recv(fd, req, known_size, MSG_WAITALL);
+	if (ret != known_size)
 		return false;
 
 	fprintf(stderr, "Read coredump request with size %u and mask 0x%llx\n",
@@ -287,15 +287,24 @@ bool send_coredump_ack(int fd, const struct coredump_req *req,
 	return true;
 }
 
-bool check_coredump_req(const struct coredump_req *req, size_t min_size,
-			__u64 required_mask)
+/* Every option the kernel is expected to advertise in coredump_req->mask. */
+#define TEST_REQ_MASK_ALL					\
+	(COREDUMP_KERNEL | COREDUMP_USERSPACE |			\
+	 COREDUMP_REJECT | COREDUMP_WAIT)
+
+bool check_coredump_req(const struct coredump_req *req)
 {
-	if (req->size < min_size)
-		return false;
-	if ((req->mask & required_mask) != required_mask)
+	if (req->size < COREDUMP_REQ_SIZE_VER0) {
+		fprintf(stderr, "%s: size %u below minimum %d\n",
+			__func__, req->size, COREDUMP_REQ_SIZE_VER0);
 		return false;
-	if (req->mask & ~required_mask)
+	}
+	if (req->mask != TEST_REQ_MASK_ALL) {
+		fprintf(stderr, "%s: mask 0x%llx, expected 0x%llx\n",
+			__func__, (unsigned long long)req->mask,
+			(unsigned long long)TEST_REQ_MASK_ALL);
 		return false;
+	}
 	return true;
 }
 

-- 
2.53.0


