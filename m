Return-Path: <SRS0=hyM8=TB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC2CC43219
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 17:49:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F0F2063F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 May 2019 17:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RABO2G/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F0F2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44vQr54W0wzDqNQ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 May 2019 03:49:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+fbe6eae7536a933b5243+5729+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="RABO2G/I"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44vQfD2wNHzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2019 03:40:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BP+beZIpsfJzRTclhTxlh59ZIpF33FvBmM7W8Ih0HvE=; b=RABO2G/IuKy4J3tWipYIJHjE9B
 uxwLURBh5ezJ7c3huUBhniLUMPlyKhx4UzwVYW8cOc8L1HKLjWst1Q8UNUwfOXKsx5D25z6Qe775K
 b9dUQVgo9XF7kh2S0iXYMejAEOML/e8lX2y1izzNelAk4bHQwcO15k+0zEyLIPjXfU4GFxzVSVlg1
 dTzs2i93pYAON1lmD2CuUwzzbTPBJA3NmvoSZ6MBc+DosI/TimZ49uBvw5QxGqqtmI+sHj6RBlMqK
 X9WC1TghHNSZGc1SuLVcfG0LmHRGoj3D30YI1INDasrGmwgPRxsGGdaq0OkWeaFgb7EEDfK539gUZ
 GkSLaLFw==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hLtDa-00061g-9E; Wed, 01 May 2019 17:40:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Oleg Nesterov <oleg@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/5] asm-generic: remove ptrace.h
Date: Wed,  1 May 2019 13:39:43 -0400
Message-Id: <20190501173943.5688-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501173943.5688-1-hch@lst.de>
References: <20190501173943.5688-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

No one is using this helper anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS                    |  1 -
 arch/mips/include/asm/ptrace.h |  5 ---
 include/asm-generic/ptrace.h   | 74 ----------------------------------
 3 files changed, 80 deletions(-)
 delete mode 100644 include/asm-generic/ptrace.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c38f21aee78..0d44b2369f42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12586,7 +12586,6 @@ F:	include/linux/regset.h
 F:	include/linux/tracehook.h
 F:	include/uapi/linux/ptrace.h
 F:	include/uapi/linux/ptrace.h
-F:	include/asm-generic/ptrace.h
 F:	kernel/ptrace.c
 F:	arch/*/ptrace*.c
 F:	arch/*/*/ptrace*.c
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index b6578611dddb..1e76774b36dd 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -56,11 +56,6 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 	return regs->regs[31];
 }
 
-/*
- * Don't use asm-generic/ptrace.h it defines FP accessors that don't make
- * sense on MIPS.  We rather want an error if they get invoked.
- */
-
 static inline void instruction_pointer_set(struct pt_regs *regs,
                                            unsigned long val)
 {
diff --git a/include/asm-generic/ptrace.h b/include/asm-generic/ptrace.h
deleted file mode 100644
index 82e674f6b337..000000000000
--- a/include/asm-generic/ptrace.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Common low level (register) ptrace helpers
- *
- * Copyright 2004-2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#ifndef __ASM_GENERIC_PTRACE_H__
-#define __ASM_GENERIC_PTRACE_H__
-
-#ifndef __ASSEMBLY__
-
-/* Helpers for working with the instruction pointer */
-#ifndef GET_IP
-#define GET_IP(regs) ((regs)->pc)
-#endif
-#ifndef SET_IP
-#define SET_IP(regs, val) (GET_IP(regs) = (val))
-#endif
-
-static inline unsigned long instruction_pointer(struct pt_regs *regs)
-{
-	return GET_IP(regs);
-}
-static inline void instruction_pointer_set(struct pt_regs *regs,
-                                           unsigned long val)
-{
-	SET_IP(regs, val);
-}
-
-#ifndef profile_pc
-#define profile_pc(regs) instruction_pointer(regs)
-#endif
-
-/* Helpers for working with the user stack pointer */
-#ifndef GET_USP
-#define GET_USP(regs) ((regs)->usp)
-#endif
-#ifndef SET_USP
-#define SET_USP(regs, val) (GET_USP(regs) = (val))
-#endif
-
-static inline unsigned long user_stack_pointer(struct pt_regs *regs)
-{
-	return GET_USP(regs);
-}
-static inline void user_stack_pointer_set(struct pt_regs *regs,
-                                          unsigned long val)
-{
-	SET_USP(regs, val);
-}
-
-/* Helpers for working with the frame pointer */
-#ifndef GET_FP
-#define GET_FP(regs) ((regs)->fp)
-#endif
-#ifndef SET_FP
-#define SET_FP(regs, val) (GET_FP(regs) = (val))
-#endif
-
-static inline unsigned long frame_pointer(struct pt_regs *regs)
-{
-	return GET_FP(regs);
-}
-static inline void frame_pointer_set(struct pt_regs *regs,
-                                     unsigned long val)
-{
-	SET_FP(regs, val);
-}
-
-#endif /* __ASSEMBLY__ */
-
-#endif
-- 
2.20.1

