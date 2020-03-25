Return-Path: <SRS0=ePRe=5K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ABFC54FCF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 16:45:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5728720740
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 16:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="R7PnGgOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5728720740
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nYrp61mkzDqf1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 03:45:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--maskray.bounces.google.com
 (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com;
 envelope-from=3oyp7xgckddyeskcjsqyggydw.ugedafmphhu-vwndaklk.grdstk.gjy@flex--maskray.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=R7PnGgOm; dkim-atps=neutral
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nYpq6wHPzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2020 03:43:41 +1100 (AEDT)
Received: by mail-pf1-x44a.google.com with SMTP id r13so2516806pfr.17
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=W+RJLtrYnjjpgBQ3gpQ7MHIpp5jjX2BBq7fApCfnQBg=;
 b=R7PnGgOmAt/76/+T2nkV1r1xC59C8Bdemi8JIs5vw+Ye4LdEvxPP7JVv6jC/3v4NCk
 CZ5Sk9JVEjn7Ez74xCB9YNJu4OHk/R/3OjhkWUC7V6EJHogw1c/xL2WnyBtbbi8YpNi/
 I+SEyFTn+jOaegYwmJJFLnYMt3nwQuDx2spCHwILmZ5zKe+yGIAKjBrg5F54/ZRzL8YW
 j4dOm5TztE62KMh+mURTAXERjgjQdti+Gv8+RT1gTeqE/wsUR6+glMQ/VkQyp9AAt/YA
 hvESOvJIelkUxc9UbAgwaCYzDXEaNLiNaiyPMY4cTy5klyGLEtd5yu/jGRZ1ro1wuMZS
 zkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=W+RJLtrYnjjpgBQ3gpQ7MHIpp5jjX2BBq7fApCfnQBg=;
 b=UwhvrVSWLjNcIhZwHYurEl+Qt6KvZISbPEZSu/G38JvYgPZWIhAaDOUQ2/ibtlMPiQ
 uRuYRsvLbxevWLhU0H+lA8zn3SPy5gEwjpboFirtJ0RfqQZpRCgfR+AGLB96G5p4ky+E
 zNhaokqpWJdnzJNCVUqLFUwSoUthMuqDBpzENU/LGFrJvYnovNTlAq6MZl5q7YoS1V/d
 rXqYMV5y/DK1cEr74szOyzF9fXgNS+A75VuOnkOgyttcyU2Wo0+RXsb9vGOQRkONLH+x
 gsUljNrea7Ok0q/fONbtDcbU4m5+6FXF419MRGI/xQE+z4tR1TtLdAL5Y599pD/B5Z83
 Kguw==
X-Gm-Message-State: ANhLgQ0gkIAgI59HuwDBVcm2VYi71mvkW2ivMkWQu5a6wICX8mEfbD1E
 0vIN+nQnuaza1eM/ePese00X5VueEUs3hKNj0yI6aQKhiOOiNYoxyfyp8Gf7nMsEOPv9T/uiD7A
 zRZfHue9UKrlubwuXifrFH/SIYGQf/EfLSQ1w8U225RY8A3TmIOPJ7YBjqrkZlCnX8Yh+EQ+4rw
 ==
X-Google-Smtp-Source: ADFU+vsbvA0bPKZuFuoyiAYYT2MAajBQClBv2FVQWpgTqGSwOk86q1wjxhji3lIrW877UAk2zXeS6eprXZB9
X-Received: by 2002:a17:90a:d101:: with SMTP id
 l1mr4885668pju.130.1585154617915; 
 Wed, 25 Mar 2020 09:43:37 -0700 (PDT)
Date: Wed, 25 Mar 2020 09:42:57 -0700
Message-Id: <20200325164257.170229-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2] powerpc/boot: Delete unneeded .globl _zimage_start
From: Fangrui Song <maskray@google.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: Fangrui Song <maskray@google.com>, Alan Modra <amodra@gmail.com>,
 Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com,
 Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

.globl sets the symbol binding to STB_GLOBAL while .weak sets the
binding to STB_WEAK. GNU as let .weak override .globl since binutils-gdb
5ca547dc2399a0a5d9f20626d4bf5547c3ccfddd (1996). Clang integrated
assembler let the last win but it may error in the future.

Since it is a convention that only one binding directive is used, just
delete .globl.

Fixes: cd197ffcf10b "[POWERPC] zImage: Cleanup and improve zImage entry point"
Fixes: ee9d21b3b358 "powerpc/boot: Ensure _zimage_start is a weak symbol"
Link: https://github.com/ClangBuiltLinux/linux/issues/937
Signed-off-by: Fangrui Song <maskray@google.com>
Cc: Alan Modra <amodra@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: clang-built-linux@googlegroups.com
---
 arch/powerpc/boot/crt0.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 92608f34d312..1d83966f5ef6 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -44,9 +44,6 @@ p_end:		.long	_end
 p_pstack:	.long	_platform_stack_top
 #endif
 
-	.globl	_zimage_start
-	/* Clang appears to require the .weak directive to be after the symbol
-	 * is defined. See https://bugs.llvm.org/show_bug.cgi?id=38921  */
 	.weak	_zimage_start
 _zimage_start:
 	.globl	_zimage_start_lib
-- 
2.25.1.696.g5e7596f4ac-goog

