Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207AE606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kEyAOZ+f;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lIn2F/rY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY1MQ1Zpnz3blk;
	Mon, 23 Nov 2026 20:47:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795427265;
	cv=none; b=kJlQ0oxlvmrwwSosnoE5CV6HE8/efzFutAj/DecKF49kJw52xzLzlAqCLbfE41rjJqqqGwjiOspQs31zCExszKavRZzbgMsFcLmaW5LXwk4dYwepzNxzqn5muhkSwZ93uaX0VsSHSN6JhkTsA2aIcpVnckyZ6rlcANITR7V+kzoAecaOF/DA/Nr0fER+wEXquc+1qDB8MrwDHzS+jY9n7pOkdzxcjwl44JEfDdAVhSS/ssdLfNJ3FZIJY95eRQfWYSu8N2UMGTO0xBbes8tkAwr4jw1201WDJ6ZJ6Nz0ecZf1AF/lLtrROFkTne9T1RJOrVSCSqo0fYXXfcz0RFGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795427265; c=relaxed/relaxed;
	bh=E1kpH9qtmZAMmYTBOk6CnIKFezpBGJI84FmVahSpOrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evhAvhmDOJJyQ8cod3ysHexip7A/4bdSwyDdf6W3tFs6fgcwQYFzlGLgcyGWskCatgChQV2w0SvZl5HfeWo1yU3SIUceGNwcCJV2tnc8r8k8vNahTYF2ZQZ0r4ef4RGIPAVokl4ZKx57nk1dTbV+j8kTYbJiONj9OXnvH3dAcB/TQVmYETAK3AYHrSz76RJmtSk33bb7Mb6r/H5V1uomcvWootoaeftjTrOUM8cWc9ETRw/eXdrgvpGngqkycs4OnD3leKN9+HYermh4DKC59Gw1p3INQxDujWPQuHEO8xkkJt0u/oQhy2ztADgTx2zyvNyRQdE9teDGb19hP699Zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kEyAOZ+f; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lIn2F/rY; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kEyAOZ+f;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lIn2F/rY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY1MN4CXyz3bgl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 20:47:44 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1kpH9qtmZAMmYTBOk6CnIKFezpBGJI84FmVahSpOrc=;
	b=kEyAOZ+fXfpEFfXli9cKb4jaOvep+YD+wGpQAMUQQojZWoFAqgtWYb70a2ykA+VO1bRedq
	xJ1z/x/EoR0vCb1RSKcWCP09fC16ImShi/WU9K9AboAh6Pl6VYOpQX7L3Va0rbVF8sRgwZ
	j1VkZWwgTUUpmxL3P+j222I9Hpz4yBmTIIBjdDdZJBGCITy12dETeke7yfjVz6eOwfrX2T
	qwIgn0zPKXkYeYkzAhQRrFUZf3oInFDCx1beSUFl6BqCyxq769Dp3hpWe19ngJScL2Wjxr
	jwMUd1tmM8P3eypY0Zj/ISZvHtFUuVCqtBxqaoGWMGH3MzUX5NwVGjxH9YMJBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1kpH9qtmZAMmYTBOk6CnIKFezpBGJI84FmVahSpOrc=;
	b=lIn2F/rYSSMxABLTJM4B3AbW/3uEZC8vK5/mSmfekSgDDXw9MHlSZZVoCJyH3+Wc1EX+Zc
	QINruovqqc4qHEBA==
Date: Mon, 23 Nov 2026 10:37:06 +0100
Subject: [PATCH v3 01/15] MAINTAINERS: exec: Add more auxvec.h variants
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-at-vector-size-arch-v3-1-d342dae9e843@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
In-Reply-To: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=979;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hyCnjfQwzbLi6OQVQUQL35+BD4s52Bt4na4vvI8iM88=;
 b=Yd3vnnMHSBep+pRQRmyi1AA40DEVjxA2c8/dBeFWV4J0rKudeRDSHvhOeNFfw6AFADdjfzkJf
 OYY7DU1b6DAAWfLpRxBPgKDgCI6NtpX+tyAlSPU38iJqHr9hcKiFypZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There are quite a few auxvec.h headers. Mark all of them maintained
as part of 'EXEC & BINFMT API, ELF'.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..a659c9bfb0f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10073,13 +10073,16 @@ L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
 F:	Documentation/userspace-api/ELF.rst
+F:	arch/*/include/uapi/asm/auxvec.h
 F:	fs/*binfmt_*.c
 F:	fs/Kconfig.binfmt
 F:	fs/exec.c
 F:	fs/tests/binfmt_*_kunit.c
 F:	fs/tests/exec_kunit.c
+F:	include/linux/auxvec.h
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
+F:	include/uapi/asm-generic/auxvec.h
 F:	include/uapi/linux/auxvec.h
 F:	include/uapi/linux/binfmts.h
 F:	include/uapi/linux/elf.h

-- 
2.56.1


