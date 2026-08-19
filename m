Return-Path: <linuxppc-dev+bounces-26001-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D234C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:11:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMkv0Fntz2yqx;
	Thu, 20 Aug 2026 09:11:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181078;
	cv=none; b=RvGB+wKKgIQU4JAMD5JPRuu/8GyTDrGXYXolU1pEGevqZarN2xw9imDQlatYDSD4BbeVSoB/5ciBu779OdmrkkCias3f5EeB0M25BfcPJGLrmDB/FHk+j5DxRhdGD6G2q+C+Y6KGFUMMLox0KTql5skhTxKmSis0wy0vX6+8qI0Npew5j68OAkHmdCZlad1xYXnZkM6341CmaW/ULOVICow/yQ+qeJE9wHO3ODXYW+I/ouDs3Dpvl8RYr80Rtj2OpZxUnD/R3ugbhS1QXKowS8oogrqq0EOkXlTPv/kpCpgpc5+820qrP2YFvnA5WwK8ruSva8ASfDQ+E8yPj4S1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181078; c=relaxed/relaxed;
	bh=JF2Cv/1cFUsibF4vKLKqolVzkMLtjHIoXV+phkJR8ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LJOheUpHBzBbZr1DKcYzpLW6YW+jLZOByjdChmsTQTSWgQ+v7/2vVRGtoTx7+vOc/JlojEuuGrkWlftNhWaWJjRmfSlGb2HwvjQBMyx6Zm7rW5cfGxr/BE1tn7bioz3Mewg/diI2eR6qduEcaLrrBiBh1vvRRvUJ/MWzl/NK/IFTxUdj/NKFnCvZZ0BJFQ0kqdxyMxXsb02O5DulghlqOFH1v7YYdzxaqoBIjCQ75TAmdQnmO32YC/lgT71ZVqwtR3GMUmtOL2HywvpihMth4fKPBQaHgRBWSfKTcPUFecSYISNxe1Mx7cjJKnmR/a4kKXp+Qu7e9pl9scznFsYMNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KF9/ILc2; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KF9/ILc2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMkt1Tklz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:11:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3FE866187F;
	Wed, 19 Aug 2026 23:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB0F1F00A3F;
	Wed, 19 Aug 2026 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181076;
	bh=JF2Cv/1cFUsibF4vKLKqolVzkMLtjHIoXV+phkJR8ho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KF9/ILc2D0PoNxY2cOsk2dUUA3Zo69sxGjc7MEd/cmiBteotJleRH3pGeUfU9AGsC
	 nVBubLd/AGEayMkQw20+bZqzRFjvmLh4nqthH9pwrx7sLlNchZ1sDxUhMsrfWv/bKq
	 8PQN++OfysKGQR3oz8KrJF8KyV9DwGJLftxbwSNbAdx9AWPjsrvnyCNwRCdubJp+i3
	 uEU586QZ8EjEJGhxoaCWrO4eSOqvuWC/zlWUVDyEI1Gx4td0k7p2/gljBWMCyffecP
	 nMZeMLB2aW0Gge2gDn1liwrI2kJ4vVPW7kJU1XGhH46WScL0CRiEcZ0aUT1GWnRPKN
	 nFygd/fD2EIJw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:31 +0200
Subject: [PATCH v2 14/22] coredump: add COREDUMP_SPARSE to the coredump
 socket protocol
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
Message-Id: <20260820-work-coredump-sparse-v2-14-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3626; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LOn4l248r2Ldl72jQF/dgDVrzs5g3Esgmh1gwmYjZiw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me/fpjv7/p+XG8zq9bpvCk9jm3NGa5+1yeqwI0wVL
 2z8871+d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk/SYjw7N2lSvlBhVeRV4J
 Gvv+tDf7nv3xYK27PH9/V2hM5U6Nfoa/MlXLD9ycEnDse/+16NMiJh3PvgdMEtNgTdDvW6Wa//o
 uPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A coredump with a lot of unpopulated mappings sends useless amounts of
zero data to userspace. This is nonsensical. While __dump_skip() can
seek over them when the target is a regular file a socket cannot do
this. COREDUMP_RECORDS put the zeroes in records but it didn't get rid
of them.

Add a COREDUMP_SPARSE feature bit and a COREDUMP_RECORD_ZERO record
type. A zero record is a bare header that tells userspace how many zero
bytes were skipped.

So a hole crosses the socket as one header no matter how long it is. The
coredump server can recreate this sparsely. Zero records only exist
inside a record stream. COREDUMP_SPARSE requires COREDUMP_RECORDS.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/uapi/linux/coredump.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
index 0bd5c8662ebe..f3771861ca48 100644
--- a/include/uapi/linux/coredump.h
+++ b/include/uapi/linux/coredump.h
@@ -14,6 +14,8 @@
  * @COREDUMP_RECORDS: send the coredump as a sequence of records instead of
  *                    as a plain byte stream, see struct coredump_record_header;
  *                    requires COREDUMP_KERNEL
+ * @COREDUMP_SPARSE: describe the holes in the coredump as zero records
+ *                   instead of transferring them; requires COREDUMP_RECORDS
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
@@ -21,6 +23,7 @@ enum {
 	COREDUMP_REJECT		= (1ULL << 2),
 	COREDUMP_WAIT		= (1ULL << 3),
 	COREDUMP_RECORDS	= (1ULL << 4),
+	COREDUMP_SPARSE		= (1ULL << 5),
 };
 
 /**
@@ -111,11 +114,14 @@ enum coredump_mark {
  * @COREDUMP_RECORD_DATA: the header is followed by ->len bytes of data
  * @COREDUMP_RECORD_END: the coredump ends here, the header is not followed
  *                       by any data and no further record is sent
+ * @COREDUMP_RECORD_ZERO: the header stands for ->len zero bytes and is not
+ *                        followed by any data
  * @__COREDUMP_RECORD_TYPE_MAX: the maximum coredump record type value
  */
 enum coredump_record_type {
 	COREDUMP_RECORD_DATA		= 0U,
 	COREDUMP_RECORD_END		= 1U,
+	COREDUMP_RECORD_ZERO		= 2U,
 	__COREDUMP_RECORD_TYPE_MAX	= (1U << 31),
 };
 
@@ -130,9 +136,11 @@ enum coredump_record_type {
  * If the coredump server raises COREDUMP_RECORDS in coredump_ack->mask
  * the kernel doesn't send the coredump as a plain byte stream. It sends
  * a sequence of records instead. A COREDUMP_RECORD_DATA record is
- * followed by @len bytes of actual coredump data. Records arrive in
- * order and leave no gaps. So @offset is the sum of the @len of all
- * records before it.
+ * followed by @len bytes of actual coredump data. A
+ * COREDUMP_RECORD_ZERO record is followed by nothing and stands for
+ * @len zero bytes. A server that didn't raise COREDUMP_SPARSE never
+ * sees a zero record. Records arrive in order and leave no gaps. So
+ * @offset is the sum of the @len of all records before it.
  *
  * The last record is a COREDUMP_RECORD_END record. It is followed by
  * nothing. Its @len is zero. Its @offset is the size of the coredump.
@@ -153,7 +161,8 @@ enum coredump_record_type {
  * type is raised in coredump_req->mask as a feature of its own. A
  * server only ever sees the types it asked for.
  *
- * COREDUMP_RECORDS must be combined with COREDUMP_KERNEL.
+ * COREDUMP_RECORDS must be combined with COREDUMP_KERNEL, and
+ * COREDUMP_SPARSE with COREDUMP_RECORDS.
  */
 struct coredump_record_header {
 	__u32 size;

-- 
2.53.0


