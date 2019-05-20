Return-Path: <SRS0=EeCa=TU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603BDC04AAF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 06:07:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D872520815
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 06:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+f0EQyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D872520815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 456pMH5jH0zDqM7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 16:07:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+dfc7240828d5493a4f00+5748+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 456pDg2lwDzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2019 16:01:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qcNLeLvPH2g6VMTa9XX70nBLAss1SSxUJ+jGxGFYSuk=; b=T+f0EQySfnQT0LlYHxNbpq8uUj
 VRAZqBViMEjBlsL40GwqaObh/vaEPFPfLWKwxAsaOAlTnbWiilvcgdqq3bJ3uE23MMCHgccCaeVyQ
 D+YOMmD7ODS86K3TV2vF4umWMyTSclSOqGKaO4awpWiZpDgaMbyAmdGFM9KBuLT7KsvDyIeVSqFr6
 frqUVY3C70O/+9fy3VxPFgoei4V9vGTL7oezRDUd4xd0nUhCBWkc/C3q6tW+IISRnFm/k+KNyhjRz
 LrIy8NclaNhec2Rk8op2q9WhgVz5JIvYg5mKfdzQKQkoHkHwNVYBfaIkc/kIywJJUNko+ZxxG5elc
 sDewchow==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hSbMJ-0001VM-SF; Mon, 20 May 2019 06:01:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Oleg Nesterov <oleg@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/5] powerpc: don't use asm-generic/ptrace.h
Date: Mon, 20 May 2019 08:00:15 +0200
Message-Id: <20190520060018.25569-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520060018.25569-1-hch@lst.de>
References: <20190520060018.25569-1-hch@lst.de>
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

Doing the indirection through macros for the regs accessors just
makes them harder to read, so implement the helpers directly.

Note that only the helpers actually used are implemented now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/ptrace.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 6f047730e642..fc007d186a82 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -115,18 +115,33 @@ struct pt_regs
 
 #ifndef __ASSEMBLY__
 
-#define GET_IP(regs)		((regs)->nip)
-#define GET_USP(regs)		((regs)->gpr[1])
-#define GET_FP(regs)		(0)
-#define SET_FP(regs, val)
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return regs->nip;
+}
+
+static inline void instruction_pointer_set(struct pt_regs *regs,
+		unsigned long val)
+{
+	regs->nip = val;
+}
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->gpr[1];
+}
+
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return 0;
+}
 
 #ifdef CONFIG_SMP
 extern unsigned long profile_pc(struct pt_regs *regs);
-#define profile_pc profile_pc
+#else
+#define profile_pc(regs) instruction_pointer(regs)
 #endif
 
-#include <asm-generic/ptrace.h>
-
 #define kernel_stack_pointer(regs) ((regs)->gpr[1])
 static inline int is_syscall_success(struct pt_regs *regs)
 {
-- 
2.20.1

