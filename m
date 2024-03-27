Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D71C54E67
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2024 12:25:14 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kT5EQ0JM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V4QqD5J31z3vgZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2024 23:25:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kT5EQ0JM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V4Qns5jlfz3vbn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2024 23:24:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DDC1B614BA;
	Wed, 27 Mar 2024 12:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DBDC433C7;
	Wed, 27 Mar 2024 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542239;
	bh=UAD1UidXUE1/xojuOHsvPucGi6ZvT8vO1Nl3SmyVnjw=;
	h=From:To:Cc:Subject:Date:From;
	b=kT5EQ0JMsEjDpROLLGuKEEKU1sEjZD8dOU8OxAbjFc2Rey413e2wP8NpcLMMJrwAg
	 6A9als6z+uQ9CoBcL2nclTDs7tKKMvdRN7/wIwQ6Yh8JzS5adQk4EVA/g8k643OWvS
	 QUo0HLBWySIMlh2Bcw3TXD5oAaHmzDH+S/xuCSdrFwvGoN6EeT3xaMOcLZvfSr6w87
	 M6/ggiSvNzApP4V7LRi8NfKllHsKpRe2bS8wge0kKOLGWoNUsN3kLLxUr019SpQE+R
	 7rXFR0SnmOwpiF0NzEYKl4s8llGauQ9YZFasZymakkZo+WRQimlOFEA4FGugqMP1AX
	 QCFUWmEs1sCrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	nathan@kernel.org
Subject: FAILED: Patch "powerpc: xor_vmx: Add '-mhard-float' to CFLAGS" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:57 -0400
Message-ID: <20240327122358.2838999-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
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
Cc: llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 35f20786c481d5ced9283ff42de5c69b65e5ed13 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 27 Jan 2024 11:07:43 -0700
Subject: [PATCH] powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

arch/powerpc/lib/xor_vmx.o is built with '-msoft-float' (from the main
powerpc Makefile) and '-maltivec' (from its CFLAGS), which causes an
error when building with clang after a recent change in main:

  error: option '-msoft-float' cannot be specified with '-maltivec'
  make[6]: *** [scripts/Makefile.build:243: arch/powerpc/lib/xor_vmx.o] Error 1

Explicitly add '-mhard-float' before '-maltivec' in xor_vmx.o's CFLAGS
to override the previous inclusion of '-msoft-float' (as the last option
wins), which matches how other areas of the kernel use '-maltivec', such
as AMDGPU.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1986
Link: https://github.com/llvm/llvm-project/commit/4792f912b232141ecba4cbae538873be3c28556c
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240127-ppc-xor_vmx-drop-msoft-float-v1-1-f24140e81376@kernel.org
---
 arch/powerpc/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 6eac63e79a899..0ab65eeb93ee3 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -76,7 +76,7 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
-CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
+CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
 # Enable <altivec.h>
 CFLAGS_xor_vmx.o += -isystem $(shell $(CC) -print-file-name=include)
 
-- 
2.43.0




