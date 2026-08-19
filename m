Return-Path: <linuxppc-dev+bounces-25998-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7A0C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:11:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMkX66zMz2ypW;
	Thu, 20 Aug 2026 09:11:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181060;
	cv=none; b=bMt3dLjNub18BCK2cuU1birSEkOZ5J1quAOVlcjq23RXCcnbV1RKWlO4yPvRv/YSg/4fRvEsa+uZO3vxmRg2K65cE3XM+5z2tlIvWfEtXgxviZegeBEiKgNg+PJVJD8E8hZK5QEo6DZtmGJqq16/nYxe8CIzFStWgbBZvK4IxrjVeiaz5ADnJLBm/m9UIPpNkou/wPxdFtoWbFlxfuKEtBSaIm2Dx1HYsQN+LbykBrLx3F3U+pMisY7l6XAAGNjq5f24VFrByxltNJbQAlD214kfegrSZ8CVgVxGlWHSjKExuCKggrRUem0sJSZKJBv1obgjOM6Sgba5no3StBCSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181060; c=relaxed/relaxed;
	bh=dfXAgoL+9LBeM/3gsj9qXNECM/y7xKAoBOAjrqptYLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bp64G7saow/COM/DkA9ziXRku3OuBnLKoRy/NSEdRRuHDYo6AcChhZIdFtLcWK8f4LlX51SVyd59LsSTkeuY/ZFsAlIfReoR4QHysBlkEEs3uaSS57+YErso9dLXCOpMV/S3vWZVlmQPqExEEcObiM6QmqyXFUNDeXRy9CwISGF4MIaepNMv5f41w+R/iyYZGTzA767wKcMcv1sQW7nc1ufLEUQ2PohfQJf+1611R5XmKrsQZk2DXF1za90behljrxo336Laqn3bEAy1d5zlTxMGrAA/0vW9TwVs582u3VPtMxAJAQClKOoPV2ExAX8yhKoK1g4MVjrx2Xk1DKfekQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7ly3cBX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7ly3cBX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMkW4kXZz2ynf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:10:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6CCB6439D9;
	Wed, 19 Aug 2026 23:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17171F00A3D;
	Wed, 19 Aug 2026 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181057;
	bh=dfXAgoL+9LBeM/3gsj9qXNECM/y7xKAoBOAjrqptYLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h7ly3cBXNdZl7hnrgTxPREaO8oFEfhc6DvRM7kPLZVg7S7AYOKvbSlD9lhr61Eply
	 6jOr4ONLrlIllToPvALfSQHXVeXm6QkRDJsyAJAwXh0P5oEm1qTk3f2Ur8CZH0XB31
	 QU++l1mZjfVPwqPjieBgTtwk3lSZCIwowoSOdYaXBlHHSg7sC04B1d8XT23AUS4xlr
	 pg+jQwMlNP1UfKYn/aeN27+I0aDebskxj5YMCLCEG6QgxJeBSAKlu8gf8J/9gscEcQ
	 WfK2J0wv1iUVT5UsUTnDaFTNMGeJE2I63alCUTI+iAxn3wJb323FOgOGRANuP8CQk2
	 RcEKGSk7x5o2A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:28 +0200
Subject: [PATCH v2 11/22] coredump: always chunk writes
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
Message-Id: <20260820-work-coredump-sparse-v2-11-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3072; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6lmk01oIrCpLddgF34l1qNeK7azUHFnu6/y3MNvc9fs=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGqGN7+jKg8nZ84IvdAkuVaAv3pB/3A8P2ohgfbcn0M9u/3qY
 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmqGN78ACgkQkcYbwGV43KIysgD/a+/5
 REHHWLX+2VlcBK70uw4E+bPFY60zOkDXluZRbuoBAKZwJlYA6NSqs/oHBznLIQErTWGeszoobly
 JDQFMN1YJ
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Right now dump_emit() is the only coredump helper that writes buffers
larger than a page in one call. For elf notes that can easily blow past
PAGE_SIZE. That's annoying because neither pipes nor af_unix sockets
take such writes in one piece.

If a signal arrives while the writer is waiting they drop a short write.
With the coredump records work coming up that means header and its data
are desynchronized. A write that fits in one pipe buffer or one skb
doesn't suffer from this.

So split all writes up, including elf notes, and cap every write at a
page. The coredump socket already raises sk_sndbuf far enough for a page
to fit a single skb and pipes always work that way.

That means dump_interrupted() is now checked once per page. So a large
coredump stops earlier (good). An empty write no longer issues a
zero-length write. The rlimit core check stays where it was. It
continues refusing whole writes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index d837819031ff..d61f36239f91 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1215,19 +1215,21 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
  * do on a core-file: use only these functions to write out all the
  * necessary info.
  */
-static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+/* One write, never more than a page. See __dump_emit(). */
+static bool dump_emit_chunk(struct coredump_params *cprm, const void *addr,
+			    int nr)
 {
 	struct file *file = cprm->file;
 	loff_t pos = file->f_pos;
 	ssize_t n;
 
-	if (cprm->written + nr > cprm->limit)
-		return false;
 	if (dump_interrupted())
 		return false;
+
 	n = __kernel_write(file, addr, nr, &pos);
 	if (n != nr)
 		return false;
+
 	file->f_pos = pos;
 	cprm->written += n;
 	cprm->pos += n;
@@ -1235,6 +1237,24 @@ static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	return true;
 }
 
+static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+{
+	if (cprm->written + nr > cprm->limit)
+		return false;
+
+	while (nr) {
+		int chunk = min_t(int, nr, PAGE_SIZE);
+
+		if (!dump_emit_chunk(cprm, addr, chunk))
+			return false;
+
+		addr += chunk;
+		nr -= chunk;
+	}
+
+	return true;
+}
+
 static bool __dump_skip(struct coredump_params *cprm, size_t nr)
 {
 	static char zeroes[PAGE_SIZE];
@@ -1247,13 +1267,16 @@ static bool __dump_skip(struct coredump_params *cprm, size_t nr)
 		return true;
 	}
 
-	while (nr > PAGE_SIZE) {
-		if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
+	while (nr) {
+		size_t chunk = min_t(size_t, nr, PAGE_SIZE);
+
+		if (!__dump_emit(cprm, zeroes, chunk))
 			return false;
-		nr -= PAGE_SIZE;
+
+		nr -= chunk;
 	}
 
-	return __dump_emit(cprm, zeroes, nr);
+	return true;
 }
 
 /* Flush the accumulated hole before writing data. */

-- 
2.53.0


