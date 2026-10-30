Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743A606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=dQidhxzT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFCS1PGjz30WS;
	Fri, 30 Oct 2026 19:49:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:760:2e00:f0a1::32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793350180;
	cv=none; b=dmk1w6VwJxun0qfCol+BM4jC/WBsFNPjo3ISKHx5z2iXdm7vuJCXEflW8UcJMwiWZxq1mbXZtMR5M0DHiGNMRh0KeG4/lsrLW/2UstAxF7lOd2BtEEf/2BUnWQPhYJLHexc00p1spuUGkCpWwjLT4nF6M2WzCuQmLnUtaDO3emcIR++xO9ctG7dBdkLzGK++H2yFdoQMnlKrXeGeTTZFt2FrlAevJzp5dQ87fPpIN6yTbMWt4AYcjHcImxNzlG1CdyVPE2gg0v+jlpkNF52o7jhm1bw65/qdp8WTUo/u2XbR79x8LrpDj0VvKufWbH1HQTp0RfQBnSuzs4n30Vn1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793350180; c=relaxed/relaxed;
	bh=yjMdRQDa0BKiCjyBLxfnEtlG7A95NJovK+UaME+7Qrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Th0fM0+GuYSNSWrM4y3/SrnmZKT9GDgfUAQEbZ/ucW5a/vmwC+LDeEbtTIwjTtGn+0bV0cB9AZpgMs9t0lWqNftoaAaE+kYCuUy2rGTJCou124GFSr9EQJrs72dRToM4yNOa9+i9XxC/tPwf29eTxgwzkcQNXdBJBL8CJja19RLoTBfuU70VYbie2h+Ce13xMAuOXZrOsrTiIIdp+JEHM7M0SoMH+8nunPRjkg2Otb0e4CWSxaL6aXuQ2vRsC0XNbnMh4ybR8Z42b2MiHx+1E1PfQWMASMETn1ZrVtZaePD9gMqS0I8iSIiTMMzX/rdHldm2hq4JJwO8FB/c/pG0mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=dQidhxzT; dkim-atps=neutral; spf=pass (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=dQidhxzT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [IPv6:2001:760:2e00:f0a1::32])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFCR2kfHz30gC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 19:49:39 +1100 (AEDT)
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 2D96A1C025D;
	Fri, 30 Oct 2026 09:49:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1793350177;
	bh=nAKASWeLvsdxgMY7KJmCSMlmE5AQrN3mfo3HXClaYIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQidhxzTAJZ2Z8XUUUbgPOCm9zpmY7boSUY9h9rxbTpGWRum+I27qOoWJsEa5NJhu
	 hZvPmcCZ2ilUKxhjOrp3sbKnmYiSsz0A3Tsm3IuRyOYTkBmsFXYg/10hFn9McXNTAp
	 vmFhWdetaz6QgEXdyKZXJbYm6Y3QeBpZHX26ZDfA=
From: Renzo Davoli <renzo@cs.unibo.it>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] powerpc/syscall: Return the preset value of skipped syscalls
Date: Fri, 30 Oct 2026 09:49:25 +0100
Message-ID: <20261030084926.1068384-3-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030084926.1068384-1-renzo@cs.unibo.it>
References: <20261030084926.1068384-1-renzo@cs.unibo.it>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When ptrace or seccomp skip a system call, r3 (and CR0.SO for "sc")
already hold its return value, set either through
syscall_set_return_value() or directly by a tracer, e.g. with
PTRACE_POKEUSER at a PTRACE_EVENT_SECCOMP stop.

Since commit 05c033db7e9a ("entry, treewide: Make
syscall_enter_from_user_mode[_work]() indicate syscall execution"),
system_call_exception() returns syscall_get_error() for a skipped system
call.  syscall_get_error() is 0 for any non-error value, so a success
value is replaced with 0: the value set by a tracer, or the val of a
SECCOMP_RET_USER_NOTIF response.  Among others, the seccomp_bpf
user_notification_* and TRACE_syscall.seccomp.syscall_faked selftests
fail.

Return the error from syscall_get_error() if there is one, and the value
in r3 otherwise.  The error path is unchanged, and a success value is
returned as it was before the conversion to GENERIC_ENTRY, when
system_call_exception() returned regs->gpr[3] for a skipped system call.

Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
Cc: stable@vger.kernel.org # v7.3
Suggested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Assisted-by: claude-opus-5-5
Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
 arch/powerpc/kernel/syscall.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index f7412556a9e8..7b35b895b70c 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -19,7 +19,14 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	syscall_fn f;
 
 	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
-		return syscall_get_error(current, regs);
+		/*
+		 * The syscall was skipped by seccomp or ptrace. r3 (and CR0.SO
+		 * for "sc") already hold the return value, set either through
+		 * syscall_set_return_value() or directly by the tracer. Hand
+		 * it back in the form syscall_exit_prepare() expects: -errno
+		 * on failure, else the value in r3.
+		 */
+		return syscall_get_error(current, regs) ?: regs->gpr[3];
 	}
 
 	if (unlikely(r0 >= NR_syscalls)) {
-- 
2.55.0


