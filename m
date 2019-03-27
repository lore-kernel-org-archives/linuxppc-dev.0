Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D55C10F00
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:29:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112E72177E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1KLjW7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112E72177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TxP12n64zDqR3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 05:29:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="J1KLjW7C"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TwvS0THpzDqHS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 05:07:32 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 49FA32070B;
 Wed, 27 Mar 2019 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553710050;
 bh=tl42kwFAFR+iPHn8laL8wOEP4kiIf0qgujs/5nh7pQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J1KLjW7CgWLYY77gDtyL1u3v1iwUFagi+syGiBeLS6BaB3M6V7MOXH8sVMZy/wejc
 HexcngFiOuXLdwyMYDV/YtfOKS8f7YubfJoZh5sH6MWxd5HDHKBGenAI1+RLnLxkEj
 C8iYnPnrbx2S5LvNsZpL3MWpLqOiL6ipcsuAY+RM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 174/262] powerpc/ptrace: Mitigate potential
 Spectre v1
Date: Wed, 27 Mar 2019 14:00:29 -0400
Message-Id: <20190327180158.10245-174-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
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
Cc: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org,
 Sasha Levin <sashal@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Breno Leitao <leitao@debian.org>

[ Upstream commit ebb0e13ead2ddc186a80b1b0235deeefc5a1a667 ]

'regno' is directly controlled by user space, hence leading to a potential
exploitation of the Spectre variant 1 vulnerability.

On PTRACE_SETREGS and PTRACE_GETREGS requests, user space passes the
register number that would be read or written. This register number is
called 'regno' which is part of the 'addr' syscall parameter.

This 'regno' value is checked against the maximum pt_regs structure size,
and then used to dereference it, which matches the initial part of a
Spectre v1 (and Spectre v1.1) attack. The dereferenced value, then,
is returned to userspace in the GETREGS case.

This patch sanitizes 'regno' before using it to dereference pt_reg.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/ptrace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 53151698bfe0..d9ac7d94656e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -33,6 +33,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/perf_event.h>
 #include <linux/context_tracking.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
@@ -274,6 +275,8 @@ static int set_user_trap(struct task_struct *task, unsigned long trap)
  */
 int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 {
+	unsigned int regs_max;
+
 	if ((task->thread.regs == NULL) || !data)
 		return -EIO;
 
@@ -297,7 +300,9 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 	}
 #endif
 
-	if (regno < (sizeof(struct user_pt_regs) / sizeof(unsigned long))) {
+	regs_max = sizeof(struct user_pt_regs) / sizeof(unsigned long);
+	if (regno < regs_max) {
+		regno = array_index_nospec(regno, regs_max);
 		*data = ((unsigned long *)task->thread.regs)[regno];
 		return 0;
 	}
@@ -321,6 +326,7 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
 		return set_user_dscr(task, data);
 
 	if (regno <= PT_MAX_PUT_REG) {
+		regno = array_index_nospec(regno, PT_MAX_PUT_REG + 1);
 		((unsigned long *)task->thread.regs)[regno] = data;
 		return 0;
 	}
-- 
2.19.1

