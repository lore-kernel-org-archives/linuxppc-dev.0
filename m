Return-Path: <linuxppc-dev+bounces-21440-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E779CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 May 2026 21:31:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gNsdN32cmz2yMl;
	Mon, 25 May 2026 07:31:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779658264;
	cv=none; b=CdKUxz2QG6Y8c8/pxiBQwLOx7Nmg4KMW2FlDSI7iyG6GqI5wW4XGfVGQTrnRtpwNRRr2HLleSWVh7gAC983E8Y9q8c0qiC//6ivd2GkvfHnaK4iRSlW+UGcFlhYI6sP6ddlP91w+Q261MSvkkRFa88DcgZGehFWbmd6ZBzZQgAksp3ZAOHbXnSXmtQbQhFp3Vl05eVnsxEbEfN6C6+w1bRONjTssagKBICchr9S3Dc2Nk+6Re43pYhMK7BffgbsoRK+7NFxr+OoYE+cgY2aOqAqKQelQQWmZP5HwjNyoB+0sRVII4afLkOVv13XURA65VEJxdpiyy3FHPbQCdi2unQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779658264; c=relaxed/relaxed;
	bh=9a9YmhOCMXCdtmBjQ+c3tIWRUeS6et3diSyOkSzdMjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D658CslYMWHa5/mLzJN6zP+Q+hLdxBB1A6Jhn8Ul2iw3wGTs/jFYcywu10ye5pkqM4sJ6Ax6EAXxdxNxpmekVg36w9nc8JQAs9D5WMZfMEoczSa3ZE1Heqjh8+f8qVqSvH62KxgEujVqUlFD5ZPSgzPzuLRYEKt8pdOOaWlozkSnA52vCHh+42JtmhO30Nw0grcPKeGrxz34QBNM4J89LAiys1fXQ76lXn1fjhuPLyqDmm7GTLmTzNVPLA6DdBoo//MJ9Q0WnaGA8Y6Yssf2v+IAZzIoDD0hwsyqO5fiQYsWaJc8+C7EI73NVvPz8j3YZl6kZ1ulXMnRYwzhFQBEhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CMOXgSwD; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b8; helo=out-184.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CMOXgSwD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b8; helo=out-184.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 30541 seconds by postgrey-1.37 at boromir; Mon, 25 May 2026 07:31:01 AEST
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gNsdK1zsCz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 07:30:59 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779658235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9a9YmhOCMXCdtmBjQ+c3tIWRUeS6et3diSyOkSzdMjQ=;
	b=CMOXgSwDG0TJmSezRu5hp0o52kttpkinATv/up81d1a0uLK6EJHSy4N8uHxdc3d5gAQD27
	CXja7J4X3NPetR2yR1XaxTyzwQ71zAQTD0wr+xalOULW3dpkw62OGRgc5AaTXbGJFQGKXN
	JkRlLmD6IxFsZjPKYNvi/TqkFck6j5s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
	Nayna Jain <nayna@linux.ibm.com>,
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH] MAINTAINERS: powerpc: update VMX AES entries
Date: Sun, 24 May 2026 23:29:45 +0200
Message-ID: <20260524212943.799757-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=thorsten.blum@linux.dev; h=from:subject; bh=qGi5JkH0/9nqzEpO+GWiB18MbRy1xh7/jEpBaJ6mNB4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnCuSdeGsnPZfY4WZV/++7m+9//Hln+dD+3SJxKp+WLh eV3DD7ZdpSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEmucy/HeXczjC2Hiw8tDJ BanrBarm8luYid3PTQor+C6w9mFgtgwjw1G5yxcm3Aw8sbiHcfvxBIlE9o9CS22vakdczPzFvfH TVy4A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized
code into library") removed arch/powerpc/crypto/aes.c and moved
arch/powerpc/crypto/aesp8-ppc.pl to lib/crypto/powerpc/.

However, the "IBM Power VMX Cryptographic instructions" entry still
references the removed file and no longer covers the moved aesp8-ppc.pl.

Remove the stale entry, add lib/crypto/powerpc/aesp8-ppc.pl, and tighten
the arch/powerpc/crypto/aesp8-ppc.* pattern to match the remaining
header only.

Fixes: 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized code into library")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b539be153f6a..c48cdb05e6dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12349,13 +12349,13 @@ L:	linux-crypto@vger.kernel.org
 S:	Supported
 F:	arch/powerpc/crypto/Kconfig
 F:	arch/powerpc/crypto/Makefile
-F:	arch/powerpc/crypto/aes.c
 F:	arch/powerpc/crypto/aes_cbc.c
 F:	arch/powerpc/crypto/aes_ctr.c
 F:	arch/powerpc/crypto/aes_xts.c
-F:	arch/powerpc/crypto/aesp8-ppc.*
+F:	arch/powerpc/crypto/aesp8-ppc.h
 F:	arch/powerpc/crypto/ppc-xlate.pl
 F:	arch/powerpc/crypto/vmx.c
+F:	lib/crypto/powerpc/aesp8-ppc.pl
 F:	lib/crypto/powerpc/gf128hash.h
 F:	lib/crypto/powerpc/ghashp8-ppc.pl
 

