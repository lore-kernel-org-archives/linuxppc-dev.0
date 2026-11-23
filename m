Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A37606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xIytSaYS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2Pxz/VbW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY1MK3yvYz2yqs;
	Mon, 23 Nov 2026 20:47:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795427261;
	cv=none; b=QdygKBU6+CuVscB5KYUGMLKR/QZ/C+37+0die6HO5nb2yMEQGo4gq8ORF6wHLZxkD6LnJOz1y91wlr/FXVIRM7mLv9HExFXkVpHte8S9LZhIaUPD/4kc6atoskCwbdIWvWAs4mY6tUzJ6ODVuUB09pr5pZrSw4vkuIpRExQDnys9VeZiXjLlasdJZOOjNnnobsxzC994h+BLYHLuq89RrAsGZwU0MoLtzbo4RA6Itc8/gp4n2aJquv3maUxO1LahGwCta6wt4O4vwIVFh0qOPrpresmpEf3NN9AybVcx6Vd4Om0vIx+xV1cmgKl0CZm1hMmL1k0fMw24UrxTDTYJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795427261; c=relaxed/relaxed;
	bh=dCjIARJZuyF2MKvJaqs9gktLzUWSriQ88u2CMxFe+40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKZoKqeull6nbFphrfksJqlravnVynrU0WnRMlrMUc4Owet5T2hNPP92h+OBm5uybGAVwzCyNhCqLYda7bUQDuszhbYU9c+BqRXv/V/a30cHYBUdmQccuFlCYvmyhYkQzbMDBB0p75RtuS7+o4WsGoWMb/o+LIy05u2qmJUXb0I5DOg2i2HBArjjMVWxHb/7XBcvANzvtSlXCsSSxwsOYTZNTk72UQbiHRrg6v6teWh4EdaK0RLt02NSdHHXiSx/cZM/zU/OcUmlRpbBxMYwVwSu7D9Chr4NETR3er0O9gdXacRDvT36eRXhgq5etXvmc+hF1RWZuxuMX4/ExkRHCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xIytSaYS; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2Pxz/VbW; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=xIytSaYS;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=2Pxz/VbW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY1MH1XH5z2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 20:47:38 +1100 (AEDT)
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCjIARJZuyF2MKvJaqs9gktLzUWSriQ88u2CMxFe+40=;
	b=xIytSaYSFHN7/y9Cb6dzhLZoJdiOyeCxL5r4X+xqU1KFQodlzXHZ1+mdJGSlR3PQJg/1Uu
	fVEOi0x/TStTeHc0h3jLEkDxpbGD04A8mgZYbnKq9zmR2jvB8zm/yvcNnKATqqhSeRE4cs
	rbwbg8XerkQgAhVy0iuT2y0+x7S4fKS9pkrVkrtuYk0suVgPk0rhV4B6QeeuRr1V/2qiJK
	jJLheGc1xc/Ka1IE87KoIi9cqes27CLdqY+GeL9LX9NWEBINRVASPjjMH6az7WGiDShQU+
	qo0U9lTYqdekyvsiFR1cd6CavQlCKnS4Hj5w6SaaE4O6EZFYxKYRLwFmcf1K/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCjIARJZuyF2MKvJaqs9gktLzUWSriQ88u2CMxFe+40=;
	b=2Pxz/VbWqlx26KJWhfHWSW1lo3/0I1ylQ3IrkZhGN8RmXz3hJdqDbSsE/kFGz+dsGZWEYw
	0UR9RJ8W7uv7rIBA==
Date: Mon, 23 Nov 2026 10:37:08 +0100
Subject: [PATCH v3 03/15] asm-generic: add an in-kernel auxvec.h header
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
Message-Id: <20261123-at-vector-size-arch-v3-3-d342dae9e843@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=2500;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=bABQvj2R57kM1fjG2HzTA04qWWs5Q4Mt3h+20ozb1Bw=;
 b=c7YPyzew3rWzJzbI2YP0fm7hSzzpwV/lGlOxq0YhZpLxMX5aMMqlW9Ut22ftoTisF/UfC1sVF
 xSIj1kgJmJ8AVkpAm3KQ8rGCCmbjRYaF6z2sQQD5o8/QyTjOH9GD+al
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Upcoming changes will create architecture-specific asm/auxvec.h headers.
Add asm-generic infrastructure to handle the fallbacks for architectures
which are not migrated yet and those which won't require their own
definition.

Extend the list of includes in linux/auxvec.h to cover all potential
low-level auxvec.h headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 MAINTAINERS                  | 2 ++
 include/asm-generic/Kbuild   | 1 +
 include/asm-generic/auxvec.h | 7 +++++++
 include/linux/auxvec.h       | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a659c9bfb0f0..8cee58e323a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10073,12 +10073,14 @@ L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
 F:	Documentation/userspace-api/ELF.rst
+F:	arch/*/include/asm/auxvec.h
 F:	arch/*/include/uapi/asm/auxvec.h
 F:	fs/*binfmt_*.c
 F:	fs/Kconfig.binfmt
 F:	fs/exec.c
 F:	fs/tests/binfmt_*_kunit.c
 F:	fs/tests/exec_kunit.c
+F:	include/asm-generic/auxvec.h
 F:	include/linux/auxvec.h
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b7a388bef6ea..6dc54359c4b1 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -6,6 +6,7 @@
 
 mandatory-y += atomic.h
 mandatory-y += archrandom.h
+mandatory-y += auxvec.h
 mandatory-y += barrier.h
 mandatory-y += bitops.h
 mandatory-y += bug.h
diff --git a/include/asm-generic/auxvec.h b/include/asm-generic/auxvec.h
new file mode 100644
index 000000000000..b5f73f35e21c
--- /dev/null
+++ b/include/asm-generic/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_AUXVEC_H__
+#define __ASM_GENERIC_AUXVEC_H__
+
+#define AT_VECTOR_SIZE_ARCH 0
+
+#endif /* __ASM_GENERIC_AUXVEC_H__ */
diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index 4b364e639f08..de1c33c4a256 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -2,7 +2,9 @@
 #ifndef _LINUX_AUXVEC_H
 #define _LINUX_AUXVEC_H
 
+#include <uapi/asm/auxvec.h>
 #include <uapi/linux/auxvec.h>
+#include <asm/auxvec.h>
 
 #define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */

-- 
2.56.1


