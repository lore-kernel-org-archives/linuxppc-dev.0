Return-Path: <linuxppc-dev+bounces-28073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0BAC9830D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 23:47:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqtsv4JDjz2yqL;
	Thu, 24 Sep 2026 09:46:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790186352;
	cv=none; b=FQXM3srpsqgj/7u7ImbFHclE5hpICMp6skY05BLoWS+4/dA7eKXwt+KWciio4rZxD4sRdRW/9wpVZkQkaLY+9Efpne8IbKIHE+DWToK6WLaQucLtN3g58L7NLOZ7jTiOyOQDuaW5AeHI288zm9Hq1Js1m/xKmAQQThPjhvkgvueGodcvqdqXBU3L5HuLDZilWTo5HvWyj0bf81J8DQV+KLyxCBMK2aZ6t9Mx2ZhQX/Ht0N8xGRkRQRiQtee3LCQt8ZAUSdESh+MYinaheEsNa9twZIX4Y7aR4mLYZTqFn7dX/hKPYzIvtK3gxxtO2DtPDTT7WX1HcoAn5ui0OnSrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790186352; c=relaxed/relaxed;
	bh=141VReK+zgrUNEQ7SKZlJPmSQ/VGClgbDdQxKbNBjLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nL8f3mn9VIxRRKD9cEFpxOYnFNI1egj/CEfcDGjJ+41Tk0cj4zj7RtLiV6D5T3+wjgm1tSIIc/r3WBBs03YrMIga71vqrVoFnh1rQaT1HWytFUFopOb3knuF1nqQCVAy4xMi3ZGWin6o3wSbBPVoDDidCzO3rXpSDMs/G/imeODLpR0tVXOyW6ikYjebih5P7/DCt339SiH6/Zsd5DV33OH3kAGG54RuDbb0I8yWGnjU0HQgmAcrn/nxB8fxH/wOgBkHBYCLeSzd/jeg7l8/ul+Der64PGQEliPjYV6CKcuZTHKxM0Ayk7M1z/ldr6Rm+Emx4/fPIVg9LGGnvxLdhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=lzr4J4by; dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=X21p5EiV; dkim-atps=neutral; spf=pass (client-ip=5.75.144.95; helo=mail.mainlining.org; envelope-from=brads@mainlining.org; receiver=lists.ozlabs.org) smtp.mailfrom=mainlining.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=lzr4J4by;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=X21p5EiV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mainlining.org (client-ip=5.75.144.95; helo=mail.mainlining.org; envelope-from=brads@mainlining.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 124 seconds by postgrey-1.37 at boromir; Thu, 24 Sep 2026 03:59:09 AEST
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hql8Y4szDz3017
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 03:59:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790186193; bh=141VReK+zgrUNEQ7SKZlJPm
	SQ/VGClgbDdQxKbNBjLE=; b=lzr4J4bypeIYRjdzpmrqq1YnKH2YkWTxci5DjZV9Yt6OD25mO+
	IWyzHetWMqiT4tOtS7lYRUyd6xW6V/0leILZ8jlQIwDqL9vNvyrT2M5UIeT6TTpNlEfGqBvBJ+C
	0tS59piqD2TPcvLJf0wrkdOphJD6P/a5We6XF8qwuUYmKVTbud6Zd/RZG1NisSpSSu/nl1XifnP
	4ablrrgRls6ctfxIIL9pSLvxRFs1nkU6NXkrkO0goWv6AFPlXQCSKCLANHNl4iNfQ4CSH0q+4P1
	YtWirSuY8XnI0T5YMdqhmW8VcAmZx+OB33AW1kTzD3ZT+iwFvPcW4Tw1GXzojB0Zr5g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1790186193; bh=141VReK+zgrUNEQ7SKZlJPm
	SQ/VGClgbDdQxKbNBjLE=; b=X21p5EiVfQXmq9KUBAMYUqzGLw9lrbnOmZsJ+g8QoUwP5hG73k
	r7MGLHqOdgmLfnwv1ghgRPaSN07rBbQelrBQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org
Subject: [PATCH] powerpc32/modules: Reserve a PLT entry for ftrace_regs_caller
Date: Wed, 23 Sep 2026 17:56:31 +0000
Message-ID: <20260923175631.235276-1-brads@mainlining.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7dfbfb87c243 ("powerpc/ftrace: Activate
HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32") made count_relocs()
undercount the PLT entries the loader
consumes: module_finalize_ftrace() now creates two trampolines
(mod->arch.tramp for ftrace_caller() and mod->arch.tramp_regs for
ftrace_regs_caller()), while count_relocs() reserves only one entry
for ftrace.

So the core .plt ends up one ppc_plt_entry (16 bytes) short. The
walk in do_plt_call() scans for a free slot with
"while (entry->jump[0])" and has no bound check, so once the last
reserved slot is used up, the walk steps past the end of the section
and patch_instruction() writes the 4-instruction trampoline into
whatever module memory follows the .plt.

Count the second entry, mirroring what module_64.c does for the same
pair of stubs.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/kernel/module_32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index f930e3395a7f..61152deffc55 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -41,6 +41,9 @@ static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int num)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	_count_relocs++;	/* add one for ftrace_caller */
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	_count_relocs++;	/* add one for ftrace_regs_caller */
+#endif
 #endif
 	return _count_relocs;
 }
-- 
2.53.0


