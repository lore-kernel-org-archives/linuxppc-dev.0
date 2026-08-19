Return-Path: <linuxppc-dev+bounces-26002-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E10FC5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:11:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMl11bx8z2yqs;
	Thu, 20 Aug 2026 09:11:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181085;
	cv=none; b=McMSfpBjQJKcQ3BcIyL4KOfRqEZVkz6pW8YtdIFycWHfCWwLcUTKIajdODSJ3XalXIxLswSbgSCJVJ1ovB4aWyEGG7E4UGOModF7NY3/EbMDabM23t5DBFM9xiz5pOM/b3G8+ID0crL0s8irOiPceNO+Cit/dMqSb8SeOv9rLePOX/hAww4UDKmsCax+I0kQMJDs3zgVSe/zIa/nRdgFnr7WkfumSF5CNgIyJl5utYf9r8/hSPN/tzuR1RRFkzmy5/exxRgU9Yob1++Ql1/sopWyhgGARzBL5YVzf1BVeemPCMFFbUrX0m63fThuehF1wivNM5kvRGU4yLZWwlgVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181085; c=relaxed/relaxed;
	bh=Og5LuYw9irwMf4vsrulJiBq5r2ZOIzyhhf4bBsBBJEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D76dBaJMuNfLTFpsa8vfBcQcjbXPmleH3nEIwXrY9uLW2nf5pI8JSqA29HAQa2hXVmt+DaJLVXVW/c/0queIkjPuf6ZAnhIV3HT/XWaXDHAHA5AoXEOMLIV7+/ZV4bWJyJRthOYU5d+LRyGSGflfg93E8smfL8Cl4NGgV5WDw0D9NqSadxoPhJXIjOIO17JmYTM8vq78rH9CNK9OJHK3T6uHdx0mivspnz2cpypvJleqa1ThsRYCCvxQuUjn1KLKNYPn173z/pfDZuwKsMIzWkBg83zYgVwG0X8jVMTUMBT6U9T5KPSsY5hwsXvAIu94djLWQHoStpjOKscu9GLGbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXG/YYTt; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXG/YYTt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMl01kwFz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:11:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0447141846;
	Wed, 19 Aug 2026 23:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2771F000E9;
	Wed, 19 Aug 2026 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181081;
	bh=Og5LuYw9irwMf4vsrulJiBq5r2ZOIzyhhf4bBsBBJEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RXG/YYTt+bkLrUqAYUwB6g56axFgy05P29XBUXezAJtgzZVVyUVZkN36+6yXpX22W
	 I1hQX/T/cq7k1ThGlK+TQDEqeGo76KNdBkw7zPmFtM/3SwSmLbTmmyeKcPvW8TaY3C
	 tANmQUAgDDRN5buaMPKPsD46HQ1g3ozGV8u0jD/Yt+pxvTEMOSJy0WReZ4fr9b+F9B
	 1xQjXQCSfwd3pWM/XS6sUEs4BiUMbvd0Fgju81yx5VAJE++X/XYbKg8P/0ZywvuatM
	 ow+PxpH17Kz3MzgazFkgOpltbBEuBsmT3P4pAQ77fCca/Bag/9t3ODPq29cHfQDTnR
	 Vc8PaEJyHdFqQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:32 +0200
Subject: [PATCH v2 15/22] tools: sync coredump.h header
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
Message-Id: <20260820-work-coredump-sparse-v2-15-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5096; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rV3/tTqmZ+vrXAlNo6OCI83xZSMJVfwz+jMpUuBEQ8I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me/fH6RpJn92km/suu9BMR/T81fcapsnKczaEin/v
 +DS7Qn1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5bcXwP/Ts57ZpZ1eZ11W0
 PbOvmZZq3LttW8qp6Q8jl0z+0Vd/0Ifhf3XA92Lb0vvZbd6M6jtSWjL3Msf2vF45tflaa1a1+qo
 LXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Sync the headers for the selftests.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/include/uapi/linux/coredump.h | 79 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/coredump.h b/tools/include/uapi/linux/coredump.h
index dc3789b78af0..f3771861ca48 100644
--- a/tools/include/uapi/linux/coredump.h
+++ b/tools/include/uapi/linux/coredump.h
@@ -11,12 +11,19 @@
  * @COREDUMP_USERSPACE: userspace writes coredump
  * @COREDUMP_REJECT: don't generate coredump
  * @COREDUMP_WAIT: wait for coredump server
+ * @COREDUMP_RECORDS: send the coredump as a sequence of records instead of
+ *                    as a plain byte stream, see struct coredump_record_header;
+ *                    requires COREDUMP_KERNEL
+ * @COREDUMP_SPARSE: describe the holes in the coredump as zero records
+ *                   instead of transferring them; requires COREDUMP_RECORDS
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
 	COREDUMP_USERSPACE	= (1ULL << 1),
 	COREDUMP_REJECT		= (1ULL << 2),
 	COREDUMP_WAIT		= (1ULL << 3),
+	COREDUMP_RECORDS	= (1ULL << 4),
+	COREDUMP_SPARSE		= (1ULL << 5),
 };
 
 /**
@@ -30,11 +37,11 @@ enum {
  * member is set to the size of struct coredump_req and provides a hint
  * to userspace how much data can be read. Userspace may use MSG_PEEK to
  * peek the size of struct coredump_req and then choose to consume it in
- * one go. Userspace may also simply read a COREDUMP_ACK_SIZE_VER0
+ * one go. Userspace may also simply read a COREDUMP_REQ_SIZE_VER0
  * request. If the size the kernel sends is larger userspace simply
  * discards any remaining data.
  *
- * The coredump_req->mask member is set to the currently know features.
+ * The coredump_req->mask member is set to the currently known features.
  * Userspace may only set coredump_ack->mask to the bits raised by the
  * kernel in coredump_req->mask.
  *
@@ -101,4 +108,72 @@ enum coredump_mark {
 	__COREDUMP_MARK_MAX		= (1U << 31),
 };
 
+/**
+ * enum coredump_record_type - Type of a coredump record
+ *
+ * @COREDUMP_RECORD_DATA: the header is followed by ->len bytes of data
+ * @COREDUMP_RECORD_END: the coredump ends here, the header is not followed
+ *                       by any data and no further record is sent
+ * @COREDUMP_RECORD_ZERO: the header stands for ->len zero bytes and is not
+ *                        followed by any data
+ * @__COREDUMP_RECORD_TYPE_MAX: the maximum coredump record type value
+ */
+enum coredump_record_type {
+	COREDUMP_RECORD_DATA		= 0U,
+	COREDUMP_RECORD_END		= 1U,
+	COREDUMP_RECORD_ZERO		= 2U,
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
+ * followed by @len bytes of actual coredump data. A
+ * COREDUMP_RECORD_ZERO record is followed by nothing and stands for
+ * @len zero bytes. A server that didn't raise COREDUMP_SPARSE never
+ * sees a zero record. Records arrive in order and leave no gaps. So
+ * @offset is the sum of the @len of all records before it.
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
+ * COREDUMP_RECORDS must be combined with COREDUMP_KERNEL, and
+ * COREDUMP_SPARSE with COREDUMP_RECORDS.
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


