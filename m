Return-Path: <linuxppc-dev+bounces-25994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E519C5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 23:10:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQMk44CJ4z2ykn;
	Thu, 20 Aug 2026 09:10:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787181036;
	cv=none; b=OkGj5z8xT9o/pgfj9i+MgaLROzRBm7eRLS0PihqdIzRzwz0R/u8m1pKEcZj8sHolQOJEsIdamlBdwrFQBOUxTeOdFdXOclT5CcqfeV9ihbXFcFj4U4LbBdAuplxZVrBpchjQ4DrqlSGJLDnhX4EGUrxYO9eYq/r+hQRgRZTlG1tEK+kBOmSm/V5h6/AXKQNqXkH7XWIeRGHCY0A1lUjaA4oE8eq7B6tbUhX3JaS8EfmEVj573fHX9Zf3hlW/btMyBKN7gBDZbOSbyXHJn/KP7QCc+1Cmd3kWZ2qAYCWU0MGtexca67cOjD798dpp4ZjE76OLVqoEzbcsy5ZrxLgNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787181036; c=relaxed/relaxed;
	bh=fv8QyTU4RY8EKIZbQbAauqSD2AILso9hb2wl7UK1viQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OkcZ3gVUlpahAOz1hGcxo2cs/i3kmFytVOQcSc6e3Qy3wygrK5RXlDA3hSN0PpnAlW4OKVQtxyCVvCX6YN61SXKaEyDXyr4NjKAecxt9mNOOJtWhVGFZee1bbLmtqxPhsfdED7uCozmogOwHTdOqS0m6/9LR7uroLecRYxpkRm2Q+o9z5k3JXvLDaUvnGC+TlTDhGFxkGZCUpTJFKXzeD6K50HhTQrxn7BDo/3X2Zba5cH0/e/m88/mv7BJpuXG6RQhcq3veAukTgQbzd4QQhjgTH1hsknE9DxGzVyIPcx1py+aewsdfvAUibQG6H7s+5FN4/0x20Ra0iH7P8aPZwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aheTWAgb; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aheTWAgb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQMk35hBPz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 09:10:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B34C43628;
	Wed, 19 Aug 2026 23:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781B71F00A3A;
	Wed, 19 Aug 2026 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181034;
	bh=fv8QyTU4RY8EKIZbQbAauqSD2AILso9hb2wl7UK1viQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aheTWAgbYI11sVETqvJK2lIN/QCtKk+jUTksr8d38BZ1G7LXn5ciJU2kV1FMfrtmE
	 x5Nnq5XYF01D52VOCaFlhDDagPSgLf9ydeEXG3GKOAegFGirsAEQjyZMqmBVaqlSwI
	 pMwAwjK2lfA2z4C2jvG+KW1viiMGa5Sao32Hs3etES+osbUfbaYKUfkHjbsNwJnxAi
	 i3AtybIxeJJE8yvuUcmJNRePJL+PQ7fBmXoSEKynClLfVT3MSCErW7T8lCghlChbMP
	 tXhBq+ZxGanb0v3pCy6LWkCR8ljc2M14p/psUqtZ+tN63jM9P5d7T7xF9Alu0yONal
	 4itgWc3EmpRiQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:24 +0200
Subject: [PATCH v2 07/22] coredump: pin the protocol struct sizes
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
Message-Id: <20260820-work-coredump-sparse-v2-7-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hNfZLj4wkqR4WNDayaZ8RfIqHIoYlqBK8NeplKQdya8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+ruPdQcu/KV3delZuzLP6zVCXY77RHyZG1qzuUp
 7bbKjst6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI6nWMDKdaPMNPTbgbYhLi
 tExpbXfZXqfH7+b3BPyeeS3zD8esc7cZ/rvKPeP89C9O42WYhdi3Scq7956uZNLizXY+om1dYc9
 Swg4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

COREDUMP_REQ_SIZE_VER0 and COREDUMP_ACK_SIZE_VER0 define the initial
struct sizes.

Assert that both published sizes still match their structs. While at it
fix some issues with docs.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                 | 2 ++
 include/uapi/linux/coredump.h | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 24a6405ea242..c696b46c97ff 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -759,6 +759,8 @@ static inline bool coredump_sock_send(struct file *file, struct coredump_req *re
 	return ret == sizeof(*req);
 }
 
+static_assert(sizeof(struct coredump_req) == COREDUMP_REQ_SIZE_VER0);
+static_assert(sizeof(struct coredump_ack) == COREDUMP_ACK_SIZE_VER0);
 static_assert(sizeof(enum coredump_mark) == sizeof(__u32));
 
 static inline bool coredump_sock_mark(struct file *file, enum coredump_mark mark)
diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
index dc3789b78af0..662e0468da6e 100644
--- a/include/uapi/linux/coredump.h
+++ b/include/uapi/linux/coredump.h
@@ -30,11 +30,11 @@ enum {
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

-- 
2.53.0


