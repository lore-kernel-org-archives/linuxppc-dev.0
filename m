Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAB2C282E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 03:54:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F27D206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 03:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="t4SgPc4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F27D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44p8hw0hLlzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 13:54:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.74; helo=conuserg-07.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="t4SgPc4w"; 
 dkim-atps=neutral
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44p8cs0LrtzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 13:51:08 +1000 (AEST)
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id x3N3o2c9023044;
 Tue, 23 Apr 2019 12:50:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3N3o2c9023044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1555991404;
 bh=SmiVSvw93zT7NvPci9qgt4Vy7TfTUMkww9tsRFb3tZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t4SgPc4w5I7DdstRLSozscsSmaeNRAtph21jYtwDtmFtamYizi6vDPeUC6Z0iKtXS
 ioMNCexdryOpYpIu8ADFPEW5fWQXCgek+DwDlnwgZqq1UUROzUm/LvFAXy+RyM7MXV
 tFrYRfR4akVsfljiE/skpPYRp0LfRpj/LDfpLiVzDQFYTg8JtWiqTuMTArkTexZcny
 2LxkbPw8KNGxjz745TtsSqDM2gDhWWxwHLL2ZqpSPmEgOwnXEWyu8fMV46KvN+AaYI
 e1Y+LvNNpRlrTTL09XiEnvjziJs5EnfEatyNvENDoHyeEfbhxAo5Hfn9cl6Nxrn0Ng
 B5nPB6M1B9nlw==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arch <linux-arch@vger.kernel.org>
Subject: [RESEND PATCH v3 01/11] ARM: prevent tracing IPI_CPU_BACKTRACE
Date: Tue, 23 Apr 2019 12:49:49 +0900
Message-Id: <20190423034959.13525-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423034959.13525-1-yamada.masahiro@socionext.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
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
Cc: linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Malaterre <malat@debian.org>, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Arnd Bergmann <arnd@arndb.de>

When function tracing for IPIs is enabled, we get a warning for an
overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
as triggered by raise_nmi():

arch/arm/kernel/smp.c: In function 'raise_nmi':
arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
  trace_ipi_raise(target, ipi_types[ipinr]);

This is a correct warning as we actually overflow the array here.

This patch raise_nmi() to call __smp_cross_call() instead of
smp_cross_call(), to avoid calling into ftrace. For clarification,
I'm also adding a two new code comments describing how this one
is special.

The warning appears to have shown up after patch e7273ff49acf
("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI"), which
changed the number assignment from '15' to '8', but as far as I can
tell has existed since the IPI tracepoints were first introduced.
If we decide to backport this patch to stable kernels, we probably
need to backport e7273ff49acf as well.

Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[yamada.masahiro@socionext.com: rebase on v5.1-rc1]
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
This is a long-standing issue, and
Arnd posted this patch two years ago:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/409393.html

It is no longer applied, so I rebased it on top of the latest kernel.


Changes in v3: None
Changes in v2: None

 arch/arm/include/asm/hardirq.h | 1 +
 arch/arm/kernel/smp.c          | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index cba23eaa6072..7a88f160b1fb 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -6,6 +6,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
+/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
 #define NR_IPI	7
 
 typedef struct {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index facd4240ca02..c93fe0f256de 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -70,6 +70,10 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	/*
+	 * CPU_BACKTRACE is special and not included in NR_IPI
+	 * or tracable with trace_ipi_*
+	 */
 	IPI_CPU_BACKTRACE,
 	/*
 	 * SGI8-15 can be reserved by secure firmware, and thus may
@@ -797,7 +801,7 @@ core_initcall(register_cpufreq_notifier);
 
 static void raise_nmi(cpumask_t *mask)
 {
-	smp_cross_call(mask, IPI_CPU_BACKTRACE);
+	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
-- 
2.17.1

