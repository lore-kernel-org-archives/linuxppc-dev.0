Return-Path: <SRS0=8EsE=5O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118B3C43331
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2020 18:02:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D01820714
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2020 18:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D01820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48r3MY2pmFzDqW9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2020 05:02:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=canonical.com
 (client-ip=91.189.89.112; helo=youngberry.canonical.com;
 envelope-from=cascardo@canonical.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=canonical.com
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48r3KJ2YwczDqVP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2020 05:00:18 +1100 (AEDT)
Received: from 1.general.cascardo.us.vpn ([10.172.70.58]
 helo=localhost.localdomain) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <cascardo@canonical.com>)
 id 1jIcEH-0001gP-PI; Sun, 29 Mar 2020 18:00:14 +0000
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/ptrace: Do not return ENOSYS if invalid syscall
Date: Sun, 29 Mar 2020 14:59:57 -0300
Message-Id: <20200329175957.24264-1-cascardo@canonical.com>
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
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

If a tracer sets the syscall number to an invalid one, allow the return
value set by the tracer to be returned the tracee.

The test for NR_syscalls is already at entry_64.S, and it's at
do_syscall_trace_enter only to skip audit and trace.

After this, two failures from seccomp_bpf selftests complete just fine,
as the failing test was using ptrace to change the syscall to return an
error or a fake value, but were failing as it was always returning
-ENOSYS.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 arch/powerpc/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 25c0424e8868..557ae4bc2331 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3314,7 +3314,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 
 	/* Avoid trace and audit when syscall is invalid. */
 	if (regs->gpr[0] >= NR_syscalls)
-		goto skip;
+		return regs->gpr[0];
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gpr[0]);
-- 
2.17.1

