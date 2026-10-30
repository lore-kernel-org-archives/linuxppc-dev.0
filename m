Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79123606A32F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=vD350/tD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFCQ5WyZz2xqh;
	Fri, 30 Oct 2026 19:49:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:760:2e00:f0a1::32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793350178;
	cv=none; b=d61BYO+giXC55eMiulE68d3IAoxqJIO0s9zPOGOFk1zcUVpePkzMtbt13ad7Ns4exk/510QvGsvGWgq+1q0euA/w1Q8oaZpANhRRm5F1l2bWitr1YYQjmEZgJfuax1SDSHbJEUwt+y1DW60RXH6bpmpn4D7gX97gJYOui2MjghAblAaS3ewaK0r2GYLdO0+Bgh7phhyga47dEyH/vDcuOtPixpHiaIRoFnhmB0yOq73U1a8rW1/ALcWqbB3e5wQMeg/6C1a33KyKhpDfzFg18wSV7Xl5OLe1xGnBc61XWn8PL9kKUvnvXP5gBnpaZW+vzsxXKBQxjmQ4CPxof3fdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793350178; c=relaxed/relaxed;
	bh=8PFBa0453peGS7/Cs9P1PeciAx/a1xuZsr6ALPAf46o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfvEHg9K6xIxMPS26XgaQZIZ5XchevlyOhlEB60gZ/RvrxkXwT559Lvd5Wj0+gk+8SYrlBTo7f31RHKXT2f4540jaSZxCE71S4+CFvQ0YsoD0xkdKfBw9FCT71pkzInLCB9TS6scfhXWauDV3QJVyeohmllHujz1jH4ANZRVaPlwVAujNKvIrgQh8mul2K7GZFlUQzRpznbdibdnTYELwDKUjn6+M7Eh2SwQAMbkXrneqf2PWiWpaaAe+QacpfYvg/Z+QulqW+BCRk1rzVwYquFgRMZ2/EGDusQcc//5PNR04vVE+7rjN05LiOs0jLypz0lWytLTXWUj2Rg1bje4cQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=vD350/tD; dkim-atps=neutral; spf=pass (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=vD350/tD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [IPv6:2001:760:2e00:f0a1::32])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFCP6SSKz30WS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 19:49:37 +1100 (AEDT)
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 21EB41C025B;
	Fri, 30 Oct 2026 09:49:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1793350176;
	bh=ZygyKgWUKW+0GU3E/KOJede2S8o2FlDkM5rxc9dDDbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vD350/tDv92mYDYd3+MLAlQomWxgmhaj4OM8wOUOzShU0ha1u3SUwM2LTDWHQXs6y
	 K7LZrZeK/RVrJUU9R+h1BWgyT9NwQlfb92un0rwSeG+OG5BHfhjC87IqEMyB5PlZip
	 QBkHyJ5EeIGV+B7Z2myq2lqEuyxtGWbrE+UikHtM=
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
Subject: [PATCH v3 1/2] powerpc/syscall: Remove TIF_SYSCALL_RET
Date: Fri, 30 Oct 2026 09:49:24 +0100
Message-ID: <20261030084926.1068384-2-renzo@cs.unibo.it>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for
seccomp and ptrace") added TIF_SYSCALL_RET, set by
syscall_set_return_value(), so that system_call_exception() skips a
system call whose return value has already been set.

The flag is set with set_thread_flag(), i.e. on current rather than on
the task passed to syscall_set_return_value().  When the caller is a
tracer, as with PTRACE_SET_SYSCALL_INFO and op ==
PTRACE_SYSCALL_INFO_EXIT, the flag ends up on the tracer, and the next
system call of the tracer is silently not executed.  Setting it on the
right task would not be enough either: at a syscall-exit stop the flag
would then skip the next system call of the tracee.

The flag is not needed anymore.  Commit 05c033db7e9a ("entry, treewide:
Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
made syscall_enter_from_user_mode_randomize_stack() return false when
ptrace or seccomp skip the system call, and every in-kernel caller of
syscall_set_return_value() on the syscall entry path (SECCOMP_RET_ERRNO,
SECCOMP_RET_TRACE without a tracer, SECCOMP_RET_USER_NOTIF) also makes
it return false.  A system call with an invalid number, including
syscall(-1), still gets -ENOSYS.

Remove the flag.

Fixes: 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for seccomp and ptrace")
Cc: stable@vger.kernel.org # v7.3
Suggested-by: Michal Suchánek <msuchanek@suse.de>
Assisted-by: claude-opus-5-5
Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
 arch/powerpc/include/asm/syscall.h     | 6 ------
 arch/powerpc/include/asm/thread_info.h | 1 -
 arch/powerpc/kernel/syscall.c          | 4 +---
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 32be22b995cc..4b3c52ed6e9d 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -98,12 +98,6 @@ static inline void syscall_set_return_value(struct task_struct *task,
 			regs->gpr[3] = val;
 		}
 	}
-	/*
-	 * Mark that a return value has been explicitly set by seccomp or
-	 * ptrace so that system_call_exception() can skip the syscall
-	 * unconditionally, even when the user requested syscall(-1).
-	 */
-	set_thread_flag(TIF_SYSCALL_RET);
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 1e069a2e7ce8..0487e94d3416 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -120,7 +120,6 @@ void arch_setup_new_exec(void);
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
-#define TIF_SYSCALL_RET		21	/* syscall error value set */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index 8529827d697f..f7412556a9e8 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -18,9 +18,7 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	long ret;
 	syscall_fn f;
 
-	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0) ||
-			test_thread_flag(TIF_SYSCALL_RET))) {
-		clear_thread_flag(TIF_SYSCALL_RET);
+	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
 		return syscall_get_error(current, regs);
 	}
 
-- 
2.55.0


