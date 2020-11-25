Return-Path: <SRS0=IR6y=E7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11848C6379D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 03:17:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBD720897
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 03:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nP6zaA2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBD720897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CgmKL0sZmzDqTy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 14:17:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CgmHd3bgpzDqTy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 14:15:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=nP6zaA2q; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4CgmHc0TM8z9sSs; Wed, 25 Nov 2020 14:15:56 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CgmHb6p6qz9sT6; Wed, 25 Nov 2020 14:15:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606274155;
 bh=E7ysyP8mmt0pPr7FVpyC0nhoEuH0cp9FZmKohlYcncU=;
 h=From:To:Cc:Subject:Date:From;
 b=nP6zaA2qyTe28V4zSoGR0TeYTHlzDdHy5kr0hfjJFWDe32GC0DJ+KjThtaTXkGgVc
 vkmfPIQT8OtzeoIFH3KkNgMfF7ODYS1gU3ZhpDIQmgVFY4iO6DKpb+tJ6bjQ3UeVcS
 IO2RyDEeHEDX8scM35Ear2N4q9dRnsoTcIcprqF7mE3JG3ysrYORfxznVOQuHRJl9E
 UNCOev1LaBwUeZ/8nt6M3hRe3nQL0NhAQ9EvdQsjytS07H5KZ7NhJ8uN0dB7Sazap4
 CzJaRWTIOw5F1+OzuW3al8c+hRJexAx6qQM/ksaTrpSQgyY432a5UnKKZjx5pyvuGD
 l2sgbLnD1g/jg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/configs: Add ppc64le_allnoconfig target
Date: Wed, 25 Nov 2020 14:15:51 +1100
Message-Id: <20201125031551.2112715-1-mpe@ellerman.id.au>
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
Cc: dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a phony target for ppc64le_allnoconfig, which tests some
combinations of CONFIG symbols that aren't covered by any of our
defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile               | 5 +++++
 arch/powerpc/configs/ppc64le.config | 2 ++
 2 files changed, 7 insertions(+)
 create mode 100644 arch/powerpc/configs/ppc64le.config

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a4d56f0a41d9..26a17798c815 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -376,6 +376,11 @@ PHONY += ppc64le_allmodconfig
 	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/le.config \
 		-f $(srctree)/Makefile allmodconfig
 
+PHONY += ppc64le_allnoconfig
+ppc64le_allnoconfig:
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/ppc64le.config \
+		-f $(srctree)/Makefile allnoconfig
+
 PHONY += ppc64_book3e_allmodconfig
 ppc64_book3e_allmodconfig:
 	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/85xx-64bit.config \
diff --git a/arch/powerpc/configs/ppc64le.config b/arch/powerpc/configs/ppc64le.config
new file mode 100644
index 000000000000..14dca1062c1b
--- /dev/null
+++ b/arch/powerpc/configs/ppc64le.config
@@ -0,0 +1,2 @@
+CONFIG_PPC64=y
+CONFIG_CPU_LITTLE_ENDIAN=y
-- 
2.25.1

