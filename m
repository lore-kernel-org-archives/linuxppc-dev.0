Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8FAC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 19:07:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C65F2084F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 19:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZwDxj6NY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C65F2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rNqF08GqzDqbm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 05:07:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rasmusvillemoes.dk
 (client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=linux@rasmusvillemoes.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="ZwDxj6NY"; dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rNnL1BppzDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 05:06:11 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id j20so4015039edq.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nfeGW2KMz/FXR0Ak0qG/Xrz3Om6FI+VqPqCOac6VWK0=;
 b=ZwDxj6NYYQ0lVHEiRjePF7dVhtTjLZ4WRcCUvquHehKY5j9KkDfD0a3VZwVjXiyRyV
 2y/yxNs4ofqQH5vNKi3sZugsV46m0sQrlAAAktvDtboto/3NtDzq6Ij5ACCAgM/a7iGB
 PKBhHHtWEMlDuI6re7GK+sSxlktUbcte/LzXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nfeGW2KMz/FXR0Ak0qG/Xrz3Om6FI+VqPqCOac6VWK0=;
 b=lVqIu277JaU/ZFAkKtWrSTXgss5ToHsm2D8llrM4TngloYYoC22PbjMvHLNv/O3deX
 jMEj9wC+/DKM1MdldrR1YdJmr1EqSOh0sWUun5bONSfaufW5rzRJCxI6X96oGdF9jPOa
 bGAmsK8Yo7Dv4WIoYcRmuMpMrYpLyDzXdc7f9FEdZtocEu3WeU3cmnWDk1DtCvlsDDrZ
 ZcKb2d9zkTE6SFoei5Yn9SLUZrIxkfu4VD8fJ/iVsGpTpWB7uZioTx0sQtD5E++kfC9l
 PSLUPdjQHPztlCMOlP04ywPjny6/a9O0hGk/fxq0/LbF2boCDK8z096eKPrZcXUHo3G9
 y3LQ==
X-Gm-Message-State: APjAAAUcg35DzMFhfJ6j6RFANNsuJXoTDqqg5PsDo/rj+zHiHOwBEHuW
 cNeZr4GkP0tD8XsyzmzSMdjgzypHhFVpHIW4
X-Google-Smtp-Source: APXvYqye2nnuhIkpxJKAk+jx5GakviX0ROdF215GjoEpPacF9cRvIq9ChoYCfJw4i0+EsI04W92Zsg==
X-Received: by 2002:aa7:d30b:: with SMTP id p11mr15544232edq.295.1556305567686; 
 Fri, 26 Apr 2019 12:06:07 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk.
 [5.186.118.63])
 by smtp.gmail.com with ESMTPSA id k19sm2580862ejb.43.2019.04.26.12.06.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Apr 2019 12:06:07 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 12/10] powerpc: unbreak DYNAMIC_DEBUG=y build with clang
Date: Fri, 26 Apr 2019 21:06:03 +0200
Message-Id: <20190426190603.5982-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426190603.5982-1-linux@rasmusvillemoes.dk>
References: <20190426130015.GA12483@archlinux-i9>
 <20190426190603.5982-1-linux@rasmusvillemoes.dk>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Jason Baron <jbaron@akamai.com>, Nathan Chancellor <natechancellor@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Current versions of clang does not like the %c modifier in inline
assembly for targets other than x86, so any DYNAMIC_DEBUG=y build
fails on ppc64. A fix is likely to land in 9.0 (see
https://github.com/ClangBuiltLinux/linux/issues/456), but unbreak the
build for older versions.

Fixes: powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for PPC64
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Andrew, please apply and/or fold into 10/10.

 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6821c8ae1d62..8511137ab963 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -155,7 +155,7 @@ config PPC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
-	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if PPC64
+	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if PPC64 && (CC_IS_GCC || CLANG_VERSION >= 90000)
 	select DYNAMIC_FTRACE			if FUNCTION_TRACER
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
-- 
2.20.1

