Return-Path: <linuxppc-dev+bounces-25868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FDCC5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:31:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM5n660sZz2ykT;
	Sat, 15 Aug 2026 01:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786720446;
	cv=none; b=Dcgt6HGBtu3GveehEJo+UV6qRmndGOTWLESXSno3jhqpMWjT7l5flCsAN2gzUVcpV/kKZ9PXV4+kQlXvHEAumVuLvyWDJLZtbXOkhD88ZTgZcRUNcDITnwNjRhLBfZE6niLzOpJZk+3VUUg4+LJaYsS9cDor/A8w1VLMb8VVYCNpIL8qc/oYuNXwe+ZFOOHJW/x531tcCKJHvjLTRNTLTdJ3JpxdLYvWQW6KOqrGNDf2hd1wyYV40lAGizAmmr5qH95sVHtvgXoNe3CovOzV8pThqi6ko6ObMfBZ46QxsFp6u74+ouoIKWePAMf5hpBrq5S3oZw5ndXpgr/j55AwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786720446; c=relaxed/relaxed;
	bh=2AwaiBewPNb0w3Qz67JVI0ysWpkdHoufX6g1rsCJvXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwpN9i7cfTNBLOwt4YiNBSogwlOQMZDbQpRHVfuYpZM13KRK0fPfDxIq6jToHvMyAYuQHRO7SAJye8OcRF5txxJ/MfbplM63ZZHs6FCauu9Kt34B1dbLiQ8jQiZNciHUUDzVlScHDjY0ijOBVVR5OhGZjovQVK5Ge/K4EhS2TPNq0OAkosWyS9IqLhN5ozEWFWA8ZeUAaDPIQX3mc8ho6J+AG4lVReAx3AJYYjCNrrZWcfngxB8xSRUG6vgYV4tZj++QIYHqnpIbZ/0j61TmYWaAlFgOQL+232Zlk/1GqUFdKgI6cE3AAwJOfoxq1oXsffozvlsr1pG211zYXzI1Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZAN94n7r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZAN94n7r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM5NY3Wy8z2yRP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 01:14:05 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2cc73e322dbso17861715ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786720443; x=1787325243; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2AwaiBewPNb0w3Qz67JVI0ysWpkdHoufX6g1rsCJvXo=;
        b=ZAN94n7rY+Q4hG+7hGNvH+3EokjMq47FtOw8h0obTeswQhyzTa6XQmZ+sVDSvbu9df
         GX0iKit4sAVlWbhpIVnQLtCzPfZpsytqofScAtojA3jV62hKgv4v743I+XyPPm/khxZ5
         /5ALY6d2Mu0GehXcdiOpb9p/iBaCIDorJfcahNLFOAuOojqqDH0AfqcE7DD6md6rFoQs
         8dc0b0aEXecQOqmbwPN8RO36n5O0k65uqhEOniF37FmkvrPiYKT4d6EIB6GcOWSSlffg
         3ApUkMCuSJuM71I9upFDVvUywGheZn8nmkvlF5wyPFKWeYGoXgDSj1QEuqAmS9CHBy4n
         IO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720443; x=1787325243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2AwaiBewPNb0w3Qz67JVI0ysWpkdHoufX6g1rsCJvXo=;
        b=UuajYlfL3/ZfOtzYFSizynHkK3xNN5WD4OVbc3XTWakyISzIJUFZJIihJsdKw6IAaZ
         VQ/HPWo4/fbt5JnOo6yXFVQwwwg8FPdfbp5nCafsFDVIKriX+Fp2wi4GkwUAGW985u0V
         nQkHeB6l7hnbbfFU0fqAzbBtGnr0xHonBjkc/fv/n0h8UHxePRLQnj2PkkFwNSZ9rZxe
         mEcUZmuzOhGVjx8nfLOchUm5noP2K12fdCJjQTUO6uPzJgLiohCi2f1B57q5ZdM1VYgL
         O62y80h+WvCcI/yalj6gL47bOrKm9+AolCzTAkUcwkZdGoCb8BNhJKamXh/9SknypbgF
         U34w==
X-Gm-Message-State: AOJu0Yy8SyXcYzKIIcJVkL7l02TgpvMHnqFyhd4uwxz9RRqqk2nZHF9p
	RxyQFvXkrFqZOmWlBJCHBTuddtexG9gqargjOHxoxpI9uI9ipd8ATqir5Jep0g==
X-Gm-Gg: AR+sD10ZaKmN3tBtQdB5KNZe32Ow15lzvPjrRQ08qRe1oTFiSSnsNQFDGQ5eI/3cbmF
	7wd6Qkf+KnuGPxfqe9wNo5UPCFNNZFnkY+0hC4Z9dSa2J5f1zcFBttG+QAxwnEL4CZzJSHbYCas
	ATBOt3+gF3cE48SUQzWxDAAiSjvv6MXxuroAoryyBu/n3+E4jNvZkAzsWEltvtIVI6jRU2uduVJ
	Vmad481hbo1DAhR7EZ5ct1YmjHg+vP2iAHHQ38DZmmTTL+D1ISwrJhdG/ixxomQboiRJXG1l+4f
	bxD2G90gz1wHmwRU1XU47Ap0VPlqxxr6CnVifAqYbbsnhZyPzHuGVXzfb5KuoYZ833r0T77Qk7N
	axZnttw5lZkoGX7NF5K8/E80Rzse+UXmUJ9dy8FuwFnGG+v79PxhmAjsQkCaABRUSlJGd0Fd00k
	R5UYWBBAAiXWdVd7yC2jjwRvOrJUrq92hftnjf2Ou9uu7AHxuuXXMTTHNeuO4=
X-Received: by 2002:a17:902:fc4e:b0:2d5:2f49:b3de with SMTP id d9443c01a7336-2d52f49c24bmr37915325ad.0.1786720442919;
        Fri, 14 Aug 2026 08:14:02 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aec22f98sm11006395ad.84.2026.08.14.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:14:02 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 14 Aug 2026 23:13:39 +0800
Subject: [PATCH 1/3] powerpc/spufs: fix gang->alive double-decrement on
 context creation
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
Message-Id: <20260814-spufs-groupa-v1-1-f38f7549ce20@gmail.com>
References: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
In-Reply-To: <20260814-spufs-groupa-v1-0-f38f7549ce20@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@ozlabs.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786720431; l=1857;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=qpflxoDz4Q2LAuHcccN97A6fnIkF2G+PGjFWuzstZS0=;
 b=jOy/AYDd7EIMyxpncNLcvaCapZRp5eD3TFKXnXkKchB1tiySy2Lxb7xaouIDUj8swq8VvCdOl
 r2oHCGZedZqDRTjy8MjdP7EmQbMu6SA+ilnKvxfC4Uj5p9bBZZTcp9Z
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

spufs_create_context() takes a reference on the gang with gang->alive++
and is meant to hold it until the context directory is closed, at which
point spufs_dir_close() -> unuse_gang() drops it again.

The error epilogue instead reads:

	ret = spufs_context_open(&path);
	...
	if (ret && gang)
		gang->alive--; // can't reach 0

spufs_context_open() returns a non-negative file descriptor on success,
which is non-zero whenever the caller already holds an open fd. The
condition therefore fires on the success path too, dropping the
reference immediately; unuse_gang() then decrements it a second time at
close. The unbalanced double decrement can drive gang->alive to zero
prematurely, while contexts still reference the gang, triggering
simple_recursive_removal() of the gang directory too early.

Test the sign of the return value instead, so the reference is only
released on actual failure -- matching the idiom already used by
spufs_create_gang(), which calls unuse_gang() only on ret < 0.

Fixes: c134deabf478 ("spufs: fix gang directory lifetimes")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 2b54afb31529..23619fbe0bd9 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -436,7 +436,7 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 out_aff_unlock:
 	if (affinity)
 		mutex_unlock(&gang->aff_mutex);
-	if (ret && gang)
+	if (ret < 0 && gang)
 		gang->alive--; // can't reach 0
 	return ret;
 }

-- 
2.34.1


