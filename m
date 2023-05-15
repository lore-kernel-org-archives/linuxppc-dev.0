Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071E5C77B75
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 May 2023 12:48:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QKfLY1qwKz3f7R
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 May 2023 22:48:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=FuUop0Vv;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QKfKd0RKJz3bbP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2023 22:47:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=FuUop0Vv;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKfKX3rbCz4x3m;
	Mon, 15 May 2023 22:47:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1684154864;
	bh=cqK44GGxZdyBfjMJKf6ex1FS3+3bFTQ4sP/FHOUrRLE=;
	h=From:To:Cc:Subject:Date:From;
	b=FuUop0VvSFHT9nQHS4s8aYiCh8CqHtGR9WFkK/KZ9gxMv37/inXcY8kQsTH1xqNiv
	 KHc2ortNrTF/f620ZN8cRnbI5stIvJhZfWwP9PrHRHQ6TTToeW/Wzqx2VC16wWXJLS
	 MifXLukJSchcRPS+90Oj2lM+Wc4gjAT9XMxV+s9278kQMXN9wLa0gpo8mOxvNnq/u0
	 oeuYOs9Gsl/yXVu5z0I25qpsvS7/Urtwf9m1W8rXi8u7jlivkyMkS0kDFFaNzEx++z
	 edQgEqCsMKKh3XK9l0Se4iajO1cnOG7v5O5wZwd82sP9Rnsa3ZL7A+hmxol409lRDq
	 yj3+eInPRhIXg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/crypto: Fix aes-gcm-p10 build when VSX=n
Date: Mon, 15 May 2023 22:47:31 +1000
Message-Id: <20230515124731.122962-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: dtsen@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When VSX is disabled, eg. microwatt_defconfig, the build fails with:

  In function ‘enable_kernel_vsx’,
      inlined from ‘vsx_begin’ at arch/powerpc/crypto/aes-gcm-p10-glue.c:68:2,
      inlined from ‘p10_aes_gcm_crypt.constprop’ at arch/powerpc/crypto/aes-gcm-p10-glue.c:244:2:
  ...
  arch/powerpc/include/asm/switch_to.h:86:9: note: in expansion of macro ‘BUILD_BUG’
     86 |         BUILD_BUG();
        |         ^~~~~~~~~

Fix it by making the p10-aes-gcm code depend on VSX.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 7113f9355165..ad1872518992 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -96,7 +96,7 @@ config CRYPTO_AES_PPC_SPE
 
 config CRYPTO_AES_GCM_P10
 	tristate "Stitched AES/GCM acceleration support on P10 or later CPU (PPC)"
-	depends on PPC64 && CPU_LITTLE_ENDIAN
+	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
 	select CRYPTO_LIB_AES
 	select CRYPTO_ALGAPI
 	select CRYPTO_AEAD
-- 
2.40.1

