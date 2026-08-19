Return-Path: <linuxppc-dev+bounces-26006-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578C3C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:12:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMlS73S0z2yrm;
	Thu, 20 Aug 2026 09:11:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181108;
	cv=none; b=gcr25DnpaWHorOXjK1+eBYOGaNeJcA89NdGXOzGMcF+/FViUQxp2NSAdYihktdGX6rmmIV8iZ39vc0M5zC8ZmH2fdXNpu7ZbJIS0JOxRuo4RwHujwAnj2AX571aiYF2Do44s+ujABHmHSOdhsz2tj7dwXdwa7uGL4ME97kfMcP1TPfOTDGCPBBiHmSGi1++7SeykX9B3K+hMT9CdobKMCJLn2CTRT2TuCd44v/zNqS+gjB7Gto9UcSNkO+U4VXeEChZ5GWAYwzJJb0x8VjmjddNQNh7xleSqtVYGNwSSUsfeiGYMIlNbV2XCzck0eDwsTqh0NGeVkYFQQc9nuRdQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181108; c=relaxed/relaxed;
	bh=3ngkM9Oaz3qZ9JVuRq/dp5g/I7D2Q9hkNa5ppx2l/UQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EcZcaBBopZqlJ9UIy5f08WbocRVehKeyiJahF/ujX72qnmgvZg8g/J7qHcLVPAbrzBK1fSmijNicmYlhXVA1hXv+Yr5F/QVxK3zWBnjldH9MgthKfqOxeh+dL3ct4Me7J6vlakmusRIafEu1TTwYaAW9anG1YU7yJiNsrtzRhsB5Oji/VouOltNps4lUkgRFGBco1dycxdqUeBYabPUjcs4TtnXLKzFslpZbAladJOHJWEQB+AQ31Jk9XG5dQZX90/W0OgyD224+8rKIcReIl4YcDgXdixKuGC7QLNkXkmTL7afl+sNhEvABvk467pbPxq/32EGTnIZEdEWCtoITOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhaaOEHt; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NhaaOEHt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMlS17KRz2yr9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:11:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3DA0961886;
	Wed, 19 Aug 2026 23:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA97F1F000E9;
	Wed, 19 Aug 2026 23:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181105;
	bh=3ngkM9Oaz3qZ9JVuRq/dp5g/I7D2Q9hkNa5ppx2l/UQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NhaaOEHtwvw356d89efWdTyo6WLhONId1GeRlgeNKc6fL09H1OVOSkP9AQyUFqb7+
	 hkOeIkzP4HmlZKJHZvWeohTl5KWjVCWSK3pge0Og7wU9QTOpMT52gY+j7AS8iVYdT4
	 kC8YBEYSj0Wb2OtspxUQg3waUa1X4yABSYDKOwaTMzClekn1CFAjnSonIHX6hDug5P
	 /bfbpYI+QqOiER/2zkK5UKzr59ChQsDGEVZbpzCkb0sNiDCbLirOT0csJqnEk/1Uqb
	 20kyPsQq7F2TDcbcVeDxsrTb4jAVE9Ngq6DDRihHuiU4q8TRZDZM4IdxvOLKeBi3W5
	 3K41fvSvHmI0A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:36 +0200
Subject: [PATCH v2 19/22] selftests/coredump: hand the record stream to a
 sink
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
Message-Id: <20260820-work-coredump-sparse-v2-19-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5672; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OoY9P4Eob33+iTwjahFotzQjtOS//tAlpJCMbN7MTWU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me9n0q56p3TqYqToKd8lqnpnp/3j2MNessHx/aHuB
 79S7AsYO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZifI2RYSljG4Nk7nKv2wfL
 J57avWib7Tz/9Sxqh/uFJpVpsX1k5GH4H2RpkTwn45DSsklLDVOuMSfrnD9VptrNwvDo2prUue+
 fcAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently recv_coredump_records() parses the record stream and dumps it
into a file. A coredump server may want to process the data it gets. So
split the parsing from the processing.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/coredump/coredump_test_helpers.c     | 91 +++++++++++++++++-----
 1 file changed, 72 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 5b2ffe17f7b7..45d76fa0f469 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -71,9 +71,19 @@ void crashing_child_sparse(size_t size)
 	*(volatile int *)NULL = 0;
 }
 
-/* Read @len bytes off the socket, writing them at @offset if @fd_out >= 0. */
-static ssize_t recv_record_bytes(int fd_coredump, __u64 len, int fd_out,
-				 off_t offset)
+/* Sink a reassembled record stream is handed to, record by record. */
+struct coredump_record_sink {
+	/* @len bytes of coredump data that belong at @offset. */
+	int (*data)(void *ctx, const void *buf, size_t len, __u64 offset);
+	/* @len zero bytes that belong at @offset. */
+	int (*zero)(void *ctx, __u64 offset, __u64 len);
+	void *ctx;
+};
+
+/* Read @len bytes off the socket and hand them to @sink, if there is one. */
+static ssize_t recv_record_bytes(int fd_coredump, __u64 len,
+				 const struct coredump_record_sink *sink,
+				 __u64 offset)
 {
 	ssize_t received = 0;
 
@@ -89,11 +99,8 @@ static ssize_t recv_record_bytes(int fd_coredump, __u64 len, int fd_out,
 			return -1;
 		}
 
-		if (fd_out >= 0 &&
-		    pwrite(fd_out, buffer, ret, offset + received) != ret) {
-			fprintf(stderr, "%s: pwrite failed: %m\n", __func__);
+		if (sink && sink->data(sink->ctx, buffer, ret, offset + received))
 			return -1;
-		}
 
 		received += ret;
 		len -= ret;
@@ -102,14 +109,34 @@ static ssize_t recv_record_bytes(int fd_coredump, __u64 len, int fd_out,
 	return received;
 }
 
+/* Put the data where the records say it goes and leave the holes alone. */
+static int file_sink_data(void *ctx, const void *buf, size_t len, __u64 offset)
+{
+	int fd = *(int *)ctx;
+
+	if (pwrite(fd, buf, len, offset) != (ssize_t)len) {
+		fprintf(stderr, "%s: pwrite failed: %m\n", __func__);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int file_sink_zero(void *ctx, __u64 offset, __u64 len)
+{
+	/* Nothing has to be written for a hole. */
+	return 0;
+}
+
 /*
- * Reassemble a record stream. If @fd_peer_pidfd is valid the task behind
- * it is killed once a data record has arrived, so the kernel has to cut
- * the coredump short with the stream already under way.
+ * Read a coredump strea and funnel it into @sink. Allow to pass in a
+ * @fd_peer_pidfd to simulate coredump truncation by killing it after having
+ * received a coredump record.
  */
-ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
-			      off_t *coredump_size, bool *truncated,
-			      int fd_peer_pidfd)
+static ssize_t __recv_coredump_records(int fd_coredump,
+				       const struct coredump_record_sink *sink,
+				       off_t *coredump_size, bool *truncated,
+				       int fd_peer_pidfd)
 {
 	ssize_t received = 0;
 	off_t size = 0;
@@ -169,7 +196,8 @@ ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
 		}
 
 		/* Discard any part of the header we have no use for. */
-		ret = recv_record_bytes(fd_coredump, record.size - known_size, -1, 0);
+		ret = recv_record_bytes(fd_coredump, record.size - known_size,
+					NULL, 0);
 		if (ret < 0)
 			return -1;
 		received += ret;
@@ -185,10 +213,12 @@ ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
 		switch (record.type) {
 		case COREDUMP_RECORD_ZERO:
 			/* A hole. It comes with no data and needs none. */
+			if (sink->zero(sink->ctx, record.offset, record.len))
+				return -1;
 			break;
 		case COREDUMP_RECORD_DATA:
-			ret = recv_record_bytes(fd_coredump, record.len,
-						fd_core_file, size);
+			ret = recv_record_bytes(fd_coredump, record.len, sink,
+						record.offset);
 			if (ret < 0)
 				return -1;
 			received += ret;
@@ -230,6 +260,32 @@ ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
 	if (truncated)
 		*truncated = is_truncated;
 
+	*coredump_size = size;
+
+	fprintf(stderr, "Received %zd bytes for a %s coredump of %llu bytes\n",
+		received, is_truncated ? "truncated" : "complete",
+		(unsigned long long)size);
+	return received;
+}
+
+/* Reassemble a record stream into the coredump it describes. */
+ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
+			      off_t *coredump_size, bool *truncated,
+			      int fd_peer_pidfd)
+{
+	struct coredump_record_sink sink = {
+		.data	= file_sink_data,
+		.zero	= file_sink_zero,
+		.ctx	= &fd_core_file,
+	};
+	ssize_t received;
+	off_t size = 0;
+
+	received = __recv_coredump_records(fd_coredump, &sink, &size, truncated,
+					   fd_peer_pidfd);
+	if (received < 0)
+		return -1;
+
 	/*
 	 * Nothing is written for a hole, so grow the file to the size the
 	 * records describe in case the coredump ended in one.
@@ -243,9 +299,6 @@ ssize_t recv_coredump_records(int fd_coredump, int fd_core_file,
 	if (coredump_size)
 		*coredump_size = size;
 
-	fprintf(stderr, "Received %zd bytes for a %s coredump of %llu bytes\n",
-		received, is_truncated ? "truncated" : "complete",
-		(unsigned long long)size);
 	return received;
 }
 

-- 
2.53.0


