Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3208C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 00:32:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEEC206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 00:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ayci3/g1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEEC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pxn04XXQzF38c
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 10:32:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ayci3/g1";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Pxk24CpdzF384
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 10:30:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ayci3/g1"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1010)
 id 42Pxk21gDmz9sB4; Wed,  3 Oct 2018 10:30:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538526602; bh=MmO061WBnD6KIYb+Wo11vJVYbaFz1PHe3Qq2f/QGros=;
 h=From:To:Cc:Subject:Date:From;
 b=ayci3/g1tEtH7iI8ZBFUnhYs1J8HkohFh9gA5IqjoAtwy2EpTeWxcnYl3yzQwSDyA
 zCugKZQ+IFfXaPHsh8Dah2AfwEXrEjbq3u97R8JQHU25fiVTJ8/TYE+BoVmHBuQVvY
 MsuQdJWJHM3I06D6lGS0Tu5ivSSxdqobn8gaJv/ykoLKlG7YIbzJ6oTvznXNPasfVn
 D6HeYdc5XPWFMl70OB1NUn+2Bw6oten9Z6quql3dA6n2ejcuBVPKyKoCOswKk52Lf8
 Mf+/D4+r2puuyUpxdhkorDG1tvsBC398x/NIvc445wRBuKOoQKtMe6QZvCMRVxD1F3
 dol5a21FewHjw==
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Subject: [PATCH] powerpc: Add doorbell tracepoints
Date: Wed,  3 Oct 2018 10:29:57 +1000
Message-Id: <20181003002957.7711-1-anton@ozlabs.org>
X-Mailer: git-send-email 2.17.1
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When analysing sources of OS jitter, I noticed that doorbells cannot be
traced.

Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---
 arch/powerpc/include/asm/trace.h | 16 ++++++++++++++++
 arch/powerpc/kernel/dbell.c      |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index d018e8602694..eb9aa0f1561e 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -54,6 +54,22 @@ DEFINE_EVENT(ppc64_interrupt_class, timer_interrupt_exit,
 	TP_ARGS(regs)
 );
 
+#ifdef CONFIG_PPC_DOORBELL
+DEFINE_EVENT(ppc64_interrupt_class, doorbell_exception_entry,
+
+	TP_PROTO(struct pt_regs *regs),
+
+	TP_ARGS(regs)
+);
+
+DEFINE_EVENT(ppc64_interrupt_class, doorbell_exception_exit,
+
+	TP_PROTO(struct pt_regs *regs),
+
+	TP_ARGS(regs)
+);
+#endif
+
 #ifdef CONFIG_PPC_PSERIES
 extern int hcall_tracepoint_regfunc(void);
 extern void hcall_tracepoint_unregfunc(void);
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index b6fe883b1016..5ec3b3835925 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -18,6 +18,7 @@
 #include <asm/dbell.h>
 #include <asm/irq_regs.h>
 #include <asm/kvm_ppc.h>
+#include <asm/trace.h>
 
 #ifdef CONFIG_SMP
 
@@ -81,6 +82,7 @@ void doorbell_exception(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	irq_enter();
+	trace_doorbell_entry(regs);
 
 	ppc_msgsync();
 
@@ -91,6 +93,7 @@ void doorbell_exception(struct pt_regs *regs)
 
 	smp_ipi_demux_relaxed(); /* already performed the barrier */
 
+	trace_doorbell_exit(regs);
 	irq_exit();
 	set_irq_regs(old_regs);
 }
-- 
2.17.1

