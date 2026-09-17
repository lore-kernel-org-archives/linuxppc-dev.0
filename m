Return-Path: <linuxppc-dev+bounces-27555-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826ACC982D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 09:10:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlqhr4wcRz30T9;
	Thu, 17 Sep 2026 19:10:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789636204;
	cv=none; b=fBNGcmtOAZiqIx6GgSqGunb+wLAMYsRlD0eAWXtBj1F4BYetQ+/orqQGi7Ejb762UhTWi27aCZ1f0aC8ww1vho9cHIPE4lyTbr37C47Txl9/GxcGZxNkkwKmwN9ASd7AmKoFmH1apiPARzyuuZ5bvtee+70IrPhwgZHCrJfIrDKDy+HeGXWjyTbBtOclJQxu2DlXZOjsgMs3S5HgmoEoXStxFoGx63HsvPRQ4U7mGDRSy/8OGfmttrj2jPAAsLTYRL08TJSUqaNX8Dq3j+pQlZm9as++m1pwiED20nP8+VAOcqze9BJUlfbzn67Krk04H6lKSGOW0jVHq2r65uyuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789636204; c=relaxed/relaxed;
	bh=7Hss+tphsWYYElyG0udvHfxNWLscjSFYocLTPr6cLgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1ScRnrCwybMVzhNXhTekMoNK74V45mFncCUZuVvIdBp9F2bocTZeD8XoloPscsMdX3J5+rGb/wzE477Lt/9uF0fbf7drRmn01+eUi7e6rh3u/+fDAnSsOtJQpeYH8ZoVyiz1P+U8HE+sQGNbxXdwYCNwEHmFl2hokR8496XC1aV4E3GNg4w2bDz6uRWaKcEnV4rPm0iINUqB4RuHs+VB+Pw6XHM+OyfrPq/h8D3lTNWLMnmnhTwdbcTUCEb6wUCIkWjXv0NoK4/B+QS6L29ugsEJeIUscDyW9h3GYCSq9tnjUbTMbZ+tqEY1bnUN/+dTP9vPT9E+Nm2eZ6XD5eSmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3gjnXE7; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3gjnXE7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlqhq5lJvz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 19:10:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8AF5A60233;
	Thu, 17 Sep 2026 09:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812851F00898;
	Thu, 17 Sep 2026 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789636201;
	bh=7Hss+tphsWYYElyG0udvHfxNWLscjSFYocLTPr6cLgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l3gjnXE7hyT5hOLZNPuXtJreEraAnkHGYjZOWrcBMNjrzVCWdvetpyMslrwhSfAkO
	 dRQF4mzZw8Y2oBrhxgj1+KlIDVtCllYMWw6nEV2QDqvjo+PpIsY3F4eSkb7CFXTq5g
	 6ie6SAioCC9t3pGh2WqYiA1cVlB9RwhtH36z7l8mtgypnmlNz1f6coAtrJoiGo7Ic6
	 6bsNfAy8z4WRfiuNSoBwsbSg691wK9hc7SgDLYTu17XLnT1aSqTcvtkCnScw6mneEs
	 xNybY3vM3kCYqY6KHxfBrts0RxMC6vlY8bnK4wzq921kn+rwbhbK1xm5mfT6Le9Y7q
	 2xoHozTmkIevA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 11:09:43 +0200
Subject: [PATCH 2/4] file: declare the FD_PREPARE() variable with
 __cleanup() directly
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
Message-Id: <20260917-work-file-fd_prepare-v1-2-b87534ca49f3@kernel.org>
References: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
In-Reply-To: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, 
 wine-devel@list.winehq.org, linux-xfs@vger.kernel.org, 
 io-uring@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=brauner@kernel.org;
 h=from:subject:message-id; bh=h8FDYLEJ2wCbTw+8dTetJhDBaeIOwFIz8qAAMf8e6eA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStXhe5uVx3TjxPZLCm+imW81Fc3kEKSm+U25QOvTeX1
 yj62pDUUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBEuTYb/Tue6jnQpfGRSycj4
 7OZ9mvk0u8L1e66vj/06JZdSrMvxleF/vLJdkGZv25roipfn7P9vT3sQN/f+5M0M00LYou33PPz
 OCgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The whole CLASS_INIT() detour isn't needed. Use __cleanup() directly and
give the destructor a private name.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/file.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 2b864f457211..926cc58d0b7f 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -146,9 +146,6 @@ struct fd_prepare {
 	struct file *__file; /* do not access directly */
 };
 
-/* Typedef for fd_prepare cleanup guards. */
-typedef struct fd_prepare class_fd_prepare_t;
-
 /*
  * Accessors for fd_prepare class members.
  * _Generic() is used for zero-cost type safety.
@@ -160,7 +157,7 @@ typedef struct fd_prepare class_fd_prepare_t;
 	(_Generic((_fdf), struct fd_prepare: (_fdf).__file))
 
 /* Do not use directly. */
-static __always_inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
+static __always_inline void __fd_prepare_cleanup(const struct fd_prepare *fdf)
 {
 	if (unlikely(fdf->__fd >= 0)) {
 		put_unused_fd(fdf->__fd);
@@ -199,10 +196,10 @@ static __always_inline struct fd_prepare __fd_prepare(int fd, struct file *file)
  * @_file_owned: struct file to take ownership of (can be expression)
  */
 #define FD_PREPARE(_fdf, _fd_flags, _file_owned)			\
-	CLASS_INIT(fd_prepare, _fdf, ({					\
+	struct fd_prepare _fdf __cleanup(__fd_prepare_cleanup) = ({	\
 		int __fd = get_unused_fd_flags(_fd_flags);		\
 		__fd_prepare(__fd, __fd < 0 ? NULL : (_file_owned));	\
-	}))
+	})
 
 /* Do not use directly. */
 static __always_inline int __fd_publish(struct fd_prepare *fdf)

-- 
2.53.0


