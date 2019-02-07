Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC041C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:20:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885812175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885812175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w6842rrGzDqPk
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 16:20:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w64S3DRFzDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 16:16:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43w64R5ct0z9sN8; Thu,  7 Feb 2019 16:16:55 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43w64R5TzGz9sN6; Thu,  7 Feb 2019 16:16:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Fix defconfig choice logic when cross compiling
Date: Thu,  7 Feb 2019 16:16:52 +1100
Message-Id: <20190207051652.11380-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207051652.11380-1-mpe@ellerman.id.au>
References: <20190207051652.11380-1-mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Our logic for choosing defconfig doesn't work well in some situations.

For example if you're on a ppc64le machine but you specify a non-empty
CROSS_COMPILE, in order to use a non-default toolchain, then defconfig
will give you ppc64_defconfig (big endian):

  $ make CROSS_COMPILE=~/toolchains/gcc-8/bin/powerpc-linux- defconfig
  *** Default configuration is based on 'ppc64_defconfig'

This is because we assume that CROSS_COMPILE being set means we
can't be on a ppc machine and rather than checking we just default to
ppc64_defconfig.

We should just ignore CROSS_COMPILE, instead check the machine with
uname and if it's one of ppc, ppc64 or ppc64le then use that
defconfig. If it's none of those then we fall back to ppc64_defconfig.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 70e6e8119aeb..81563986a30e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -34,11 +34,10 @@ ifdef CONFIG_PPC_BOOK3S_32
 KBUILD_CFLAGS		+= -mcpu=powerpc
 endif
 
-ifeq ($(CROSS_COMPILE),)
-KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
-else
-KBUILD_DEFCONFIG := ppc64_defconfig
-endif
+# If we're on a ppc/ppc64/ppc64le machine use that defconfig, otherwise just use
+# ppc64_defconfig because we have nothing better to go on.
+uname := $(shell uname -m)
+KBUILD_DEFCONFIG := $(if $(filter ppc%,$(uname)),$(uname),ppc64)_defconfig
 
 ifdef CONFIG_PPC64
 new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)
-- 
2.20.1

