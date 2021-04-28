Return-Path: <SRS0=n52k=JZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FB5C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 13:27:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B1F61151
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 13:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B1F61151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FVfZK21nCz30D5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 23:27:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=kDpPbUW6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=kDpPbUW6; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FVfYt3pSdz2xfl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Apr 2021 23:27:13 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FVfYr4G6Gz9sXG; Wed, 28 Apr 2021 23:27:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1619616432;
 bh=SMaq3UiRPe8/XeZ7xL3W1rZuFuVaptJvlgl81x0N5eQ=;
 h=From:To:Cc:Subject:Date:From;
 b=kDpPbUW68pLZND/VsSGitFl0TGjPvDSsddcK88foLAQ7PTADOXp3E43TGoSItAHVM
 PEbzo3J1dQbVtf03rV4esyVP02PkAQjCCVgBAOhG04CEfT3OqT1wkRizWySf7+5fsN
 5CMV8AQPeMsMxRVpgZ2sOY47m+WcxNCGpY3V9SqvayBACUFrLuJb/6q4exFgNagJzV
 EgXx3Z1yOSzgjfZYmLPQh56gk0Qwv87mvM6ow6Z+8rovRXUUL4Nt9I6bcjNu0aL8IO
 Me9gkfPz+s7oR0vi19qZk2BjkyxJEyDQwQjhgfP2iAhhZimGqiBJoeIVtn9p5wrNUR
 yEzdN5BpjiPDw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/Makefile: Add ppc32/ppc64_randconfig targets
Date: Wed, 28 Apr 2021 23:27:00 +1000
Message-Id: <20210428132700.3426100-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: masahiroy@kernel.org, rdunlap@infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Make it easier to generate a 32 or 64-bit specific randconfig.

Requested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile              | 10 ++++++++++
 arch/powerpc/configs/32-bit.config |  1 +
 arch/powerpc/configs/64-bit.config |  1 +
 3 files changed, 12 insertions(+)
 create mode 100644 arch/powerpc/configs/32-bit.config
 create mode 100644 arch/powerpc/configs/64-bit.config

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 3212d076ac6a..712c5e8768ce 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -376,6 +376,16 @@ PHONY += ppc64_book3e_allmodconfig
 	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/85xx-64bit.config \
 		-f $(srctree)/Makefile allmodconfig
 
+PHONY += ppc32_randconfig
+ppc32_randconfig:
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/32-bit.config \
+		-f $(srctree)/Makefile randconfig
+
+PHONY += ppc64_randconfig
+ppc64_randconfig:
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/64-bit.config \
+		-f $(srctree)/Makefile randconfig
+
 define archhelp
   @echo '* zImage          - Build default images selected by kernel config'
   @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
diff --git a/arch/powerpc/configs/32-bit.config b/arch/powerpc/configs/32-bit.config
new file mode 100644
index 000000000000..ad6546850c68
--- /dev/null
+++ b/arch/powerpc/configs/32-bit.config
@@ -0,0 +1 @@
+# CONFIG_PPC64 is not set
diff --git a/arch/powerpc/configs/64-bit.config b/arch/powerpc/configs/64-bit.config
new file mode 100644
index 000000000000..0fe6406929e2
--- /dev/null
+++ b/arch/powerpc/configs/64-bit.config
@@ -0,0 +1 @@
+CONFIG_PPC64=y
-- 
2.25.1

