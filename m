Return-Path: <linuxppc-dev+bounces-26000-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FF7C5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:11:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMkn0V0Pz3046;
	Thu, 20 Aug 2026 09:11:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181073;
	cv=none; b=eRYYRn1elpt+Hoid1S0cpvpRc6zs5fIk+jYRe+6uZdZO8WRA2jA31Lqyy8jAL44ybVcFls9zzi1fbAb9vGKp5bbSOoXDUjSQGXdokA+PfoT7HHXaOkUVRicrp2DNQCycNfjDGjeivuKt/CJHFWpv58PRNhaQWiwXNXDtazQCXlKXbkEupSSz30URJ2+g1xc+giBcViA9rjl3Glz+7UndAk/K76B/vPAywMKA+U+zhrpZ787qfBOaG6GMZicdV4Pz7oAOXB/yQfgsbU7rSEsYK+ZST8TSQBzqqlHyFiMm4y/906fIWhVvFE61raXjlgmf0tHm0+fzZAqlnKJ5nQqa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181073; c=relaxed/relaxed;
	bh=jCUvWFr7gPW9ynmwtqLqLk7sLgqWKyJVLH5+/uw4b/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mG+EbzFUJ/BZEcjkYsLzwJbAg7yriYaygkoQqhC5DF0oo/tEUvKehnUfb0geh0CZYejCnN10a2W0Lx46AtVMd0JCnySRrpHprGVF67D1hmKdAaxmY2oIzUHM2GxoAdGXGNvwNhlwMj+I1aPU8KS10uR9s3I2xVso6Pos8Kaw5WHug6MrpFC6s9j6ieGu4inFDsYpn3jLot9mmM5CbYsNBmpkDDkkQ608xwU2BkTW7YQx2w1pbwf5fZOuIdiUX/ajPale4o+rOdkmsEfUg3LUYQ4P15rMCnKY6KTJgMsMomGadtrzms8Foy0kbX3RwAcll4yOgbYuTnShtElGD/eERg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQBRGmLy; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQBRGmLy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMkm0xhhz2yqd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:11:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E7BD243BD1;
	Wed, 19 Aug 2026 23:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECFE1F00A3D;
	Wed, 19 Aug 2026 23:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181069;
	bh=jCUvWFr7gPW9ynmwtqLqLk7sLgqWKyJVLH5+/uw4b/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XQBRGmLyQq+gFdTAfXJTbo4gh1jXQzfreWedQazCzjs87t7/N+VKU6T9W+qUn38ZR
	 j57ezN5YX/+dNb2pl+ZLvK0Hdx+iF15DU/zpG8wiAXOQBlC5VUuqWfpFZaqn3Uavig
	 dFJnnTLx5cHdFsMpBHg/EKrLaUEvdXMD+LnlttUDvAHHSwaOPpXoX4p9rL+k5CqryN
	 K1hxF94nl58Lx3koPf/d5lzpiQ0UavvwTnwGQwI/mWHjlTQoDQiIY90bXwAIm/oMRB
	 PZ8YYwSWT5U6u+c8KAIOOXLW7rxcDRD04zZ3ZosFQdDTa2c/JZkOxNN0sdcFeWyAX4
	 fTcZUi2YIX2HQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:30 +0200
Subject: [PATCH v2 13/22] coredump: add COREDUMP_RECORDS to the coredump
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
Message-Id: <20260820-work-coredump-sparse-v2-13-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4628; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r1vIA9hpNEqv9L3LrgExsab6+Vxj9iHA3Av+wMJZgnw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+P1N8vecCyR3bxmp9b1X6zrvxbmSh4bm2mgIReo
 naBw8+6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMfsvwTyvFasLKOTm/GH+9
 r9Sv+/7jzp/yNe7FL798/XCbrSXtFj/D/zyvH2/uzv7MNlW68YuvmZ9eikOUSdCrxb8XTmJ5V7T
 EnBMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently a coredump sent over a socket is raw data. The kernel knows
things about the data it's sending that are useful for a coredump
server. For example, it knows where the unpopulated parts of a mapping
are. We can't communicate this to userspace currently though.

Add a COREDUMP_RECORDS feature bit and a struct coredump_record_header
so userspace can negotiate that feature. Instead of a byte stream it
gets a header plus data. Reassembling the records yields the same
coredump that would have been sent without them.

The record itself is also versioned and thus extensible with the same
protocol as the ack-req sync.

A record stream ends explicitly. A COREDUMP_RECORD_END record closes it,
carries no data and reports the size of the coredump. It is only sent
once the whole coredump has been written. If it's missing the coredump
should be treated as truncated.

This just adds the infrastructure.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/uapi/linux/coredump.h | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
index 662e0468da6e..0bd5c8662ebe 100644
--- a/include/uapi/linux/coredump.h
+++ b/include/uapi/linux/coredump.h
@@ -11,12 +11,16 @@
  * @COREDUMP_USERSPACE: userspace writes coredump
  * @COREDUMP_REJECT: don't generate coredump
  * @COREDUMP_WAIT: wait for coredump server
+ * @COREDUMP_RECORDS: send the coredump as a sequence of records instead of
+ *                    as a plain byte stream, see struct coredump_record_header;
+ *                    requires COREDUMP_KERNEL
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
 	COREDUMP_USERSPACE	= (1ULL << 1),
 	COREDUMP_REJECT		= (1ULL << 2),
 	COREDUMP_WAIT		= (1ULL << 3),
+	COREDUMP_RECORDS	= (1ULL << 4),
 };
 
 /**
@@ -101,4 +105,66 @@ enum coredump_mark {
 	__COREDUMP_MARK_MAX		= (1U << 31),
 };
 
+/**
+ * enum coredump_record_type - Type of a coredump record
+ *
+ * @COREDUMP_RECORD_DATA: the header is followed by ->len bytes of data
+ * @COREDUMP_RECORD_END: the coredump ends here, the header is not followed
+ *                       by any data and no further record is sent
+ * @__COREDUMP_RECORD_TYPE_MAX: the maximum coredump record type value
+ */
+enum coredump_record_type {
+	COREDUMP_RECORD_DATA		= 0U,
+	COREDUMP_RECORD_END		= 1U,
+	__COREDUMP_RECORD_TYPE_MAX	= (1U << 31),
+};
+
+/**
+ * struct coredump_record_header - header of a coredump record
+ * @size: size of struct coredump_record_header
+ * @type: one of enum coredump_record_type
+ * @flags: modifiers for this record
+ * @offset: offset in the coredump this record starts at
+ * @len: number of coredump bytes this record accounts for
+ *
+ * If the coredump server raises COREDUMP_RECORDS in coredump_ack->mask
+ * the kernel doesn't send the coredump as a plain byte stream. It sends
+ * a sequence of records instead. A COREDUMP_RECORD_DATA record is
+ * followed by @len bytes of actual coredump data. Records arrive in
+ * order and leave no gaps. So @offset is the sum of the @len of all
+ * records before it.
+ *
+ * The last record is a COREDUMP_RECORD_END record. It is followed by
+ * nothing. Its @len is zero. Its @offset is the size of the coredump.
+ * The kernel only sends it once it has written the whole coredump. A
+ * server that hits end-of-file without having seen an end record must
+ * treat the coredump as incomplete.
+ *
+ * The @size member is set to the size of struct coredump_record_header
+ * the kernel knows and lets the header grow later. It comes first so it
+ * can be peeked. Userspace must consume @size bytes and discard
+ * anything beyond what it knows. It must refuse a @size smaller than
+ * COREDUMP_RECORD_HEADER_SIZE_VER0. @size covers the header alone.
+ * @offset and @len count coredump bytes.
+ *
+ * The @flags member carries modifiers that change how the record is to
+ * be interpreted. No flag is defined yet. Userspace must refuse a
+ * record carrying a flag or a type it doesn't know. Every new record
+ * type is raised in coredump_req->mask as a feature of its own. A
+ * server only ever sees the types it asked for.
+ *
+ * COREDUMP_RECORDS must be combined with COREDUMP_KERNEL.
+ */
+struct coredump_record_header {
+	__u32 size;
+	__u32 type;
+	__u64 flags;
+	__u64 offset;
+	__u64 len;
+};
+
+enum {
+	COREDUMP_RECORD_HEADER_SIZE_VER0 = 32U, /* size of first published struct */
+};
+
 #endif /* _UAPI_LINUX_COREDUMP_H */

-- 
2.53.0


