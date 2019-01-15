Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE316C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 06:38:57 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD3820656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 06:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD3820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43f0zf5hXbzDqTK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 17:38:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43f0y45Dy0zDqc2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 17:37:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43f0y43hM2z9s3q; Tue, 15 Jan 2019 17:37:32 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43f0y436Jvz9sBQ; Tue, 15 Jan 2019 17:37:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/syscalls: Fix syscall tracing
Date: Tue, 15 Jan 2019 17:37:28 +1100
Message-Id: <20190115063728.3524-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: firoz.khan@linaro.org, arnd@arndb.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Recently in commit fbf508da7440 ("powerpc: split compat syscall table
out from native table") we changed the layout of the system call
table. Instead of having two entries for each syscall number, one for
the regular entry point and one for the compat entry point, we now
have separate tables for regular and compat entry points.

This inadvertently broke syscall tracing (CONFIG_FTRACE_SYSCALLS),
because our implementation of arch_syscall_addr() knew about the
layout of the table (it did nr * 2).

We can fix it just by dropping our version of arch_syscall_addr() and
using the generic version which does:

	return (unsigned long)sys_call_table[nr];

Fixes: fbf508da7440 ("powerpc: split compat syscall table out from native table")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/trace/ftrace.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 29746dc28df5..517662a56bdc 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -967,13 +967,6 @@ unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-#if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_PPC64)
-unsigned long __init arch_syscall_addr(int nr)
-{
-	return sys_call_table[nr*2];
-}
-#endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_PPC64 */
-
 #ifdef PPC64_ELF_ABI_v1
 char *arch_ftrace_match_adjust(char *str, const char *search)
 {
-- 
2.20.1

