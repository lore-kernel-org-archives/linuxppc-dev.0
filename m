Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCAC606A321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=B9LoJ2de
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFCN6rDtz2xwL;
	Fri, 30 Oct 2026 19:49:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:760:2e00:f0a1::32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793350176;
	cv=none; b=iB61IdeB3vFpMvSIrFy01enKP5wSlROAKeCO+SVqxqBydIS8nYFTufM9OPRHwV2vmp5C241zfXAeFv9fzazNVj+i1Q+0NYfxrJTTgvXU83yIJRRMrM9vteOhmilLhrFUtMgxMaXCzwLWv/WY6dCI4zAkCnh7XuIpTtrJtkVxGmllgY5p2ToVDBNe7a9HlbytlEnMkd2gSuBTApw6kZvM+I0EiT3BOaljmCWrD1idwiplkhRa3S+RbCpZ7V8co18eJpwUh97KhcA/MgZN4CV0Y7dlsZREzwSrJLq8vA3/Nk7zoq19wgWIpFWR4B9J3RTIHOjQ7WjhSQzcDoSHfImLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793350176; c=relaxed/relaxed;
	bh=ObwGFit3UU3D1k7FJoLE7Rk8Vud49AulHNT/pROT5iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KTjNbU21QwrJhYa12S3/mFgN1t7gpThsEQwFmuOEioacGiztCerRmH72lr0VrsqvC6e2nZnhDxSOyXq/p8utFygADoSO5kMCgDWudysj0jZry2V3Y02KVbdjNKkNGeHkS2YynQHSaSsJfky5H8Mv+dtqk4cWmjIUwzq1ndQ6gXqZqsI/dVYc362eAM+CX8w9+n07tH+ytUHvlc1DAWbRVZaaydprjhFO3GxHfjBhy2xjh4MzY+gpsqEcRE5hqQG/lQMLO00RoCka1tPwshy9h91iT8YRrBX/6BJUjJAVMyTNgk9adx7btqne62lMKcjTIxQZ+1qeL3GHDy7pIqvGfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=B9LoJ2de; dkim-atps=neutral; spf=pass (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=B9LoJ2de;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [IPv6:2001:760:2e00:f0a1::32])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGFCM6CPdz2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 19:49:35 +1100 (AEDT)
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id C348C1C0043;
	Fri, 30 Oct 2026 09:49:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1793350174;
	bh=o+9ASTpYwoNfBlSWNdqTGEVvnobhYXlVi0xXeRuWCfk=;
	h=From:To:Cc:Subject:Date:From;
	b=B9LoJ2dehm/kHnztNVkX6m++gYauePuZ9vsR5niYTBUPeA4z7srTslbx8Gi0zxGfv
	 hpe8d75Mk9YNxZZtfycHeDoubQVyUYuJjmDIcD+vTb0hKjF6BTBWfKCAMqcS8+oPZ1
	 jRvaNv/iF3zfeCskTZt3nxXmV3d3HFYjYZ4CCMvc=
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] powerpc/syscall: Fix the return value of skipped syscalls
Date: Fri, 30 Oct 2026 09:49:23 +0100
Message-ID: <20261030084926.1068384-1-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When ptrace or seccomp skip a system call on powerpc, the return value
they set is lost or the tracer is affected:

 - syscall_set_return_value() sets TIF_SYSCALL_RET on current, which is
   the tracer when called through PTRACE_SET_SYSCALL_INFO, so the next
   system call of the tracer is silently skipped (1/2);

 - system_call_exception() returns syscall_get_error() for a skipped
   system call, which is 0 for any non-error value, so a success value
   set by a tracer or by a SECCOMP_RET_USER_NOTIF listener is replaced
   with 0 (2/2).

Both problems are in v7.3.  1/2 does not apply as is to v7.3, which
still has the two separate TIF_SYSCALL_RET checks from before commit
66236558dfac ("powerpc/syscall: Avoid atomic test_and_clear_thread_flag
on fast path"); the code it leaves behind is the same, and 2/2 then
applies on top.

Tested on QEMU pseries (TCG, -cpu power9), ppc64le guest config, on
mainline 734bef548a96, with ppc_skip_repro.c [1] (a tracer sets the
return value with PTRACE_SET_SYSCALL_INFO and then makes a system call;
a tracer skips a system call at a PTRACE_EVENT_SECCOMP stop with
PTRACE_POKEUSER, with both "sc" and "scv 0") and with the ptrace and
seccomp selftests:

                                           mainline    + 1/2       + 2/2
  tracer syscall after SET_SYSCALL_INFO    not run     correct     correct
  skipped syscall, success value, sc/scv   returns 0   returns 0   correct
  skipped syscall, error value, sc/scv     correct     correct     correct
  selftests/ptrace set_syscall_info        FAIL        pass        pass
  selftests/seccomp/seccomp_bpf (*)        14 FAIL     14 FAIL     all pass

  failing in mainline and with 1/2 only:
  user_notification_{basic,child_pid_ns,sibling_pid_ns,fault_recv,addfd,
  addfd_opath,addfd_rlimit,addfd_send_interrupted,sync,fifo,
  wait_killable}, TRACE_syscall.seccomp.syscall_faked,
  notification_restart.{killable,both}.after_receive

(*) not counting user_notification_wait_killable_after_reply (100000
    notifications with a 1 ms itimer), which hits the 30 s harness
    timeout under emulation on all three kernels.

Build-tested with W=1: ppc64le guest config, ppc64_defconfig (BE),
pmac32_defconfig.

Changes in v3:
- Split in two patches, one per Fixes: tag: 1/2 removes TIF_SYSCALL_RET
  (suggested by Michal), 2/2 fixes the return value.
- 2/2 returns syscall_get_error() ?: regs->gpr[3] instead of
  regs->gpr[3], so the error path is unchanged (suggested by Mukesh).
- Applies unchanged to current mainline (d89e1d186ec9).
- Link to v2:
  https://lore.kernel.org/lkml/20261023180735.853655-1-renzo@cs.unibo.it/

Changes in v2:
- Rebased on mainline 734bef548a96, after commit 66236558dfac.
- Link to v1:
  https://lore.kernel.org/lkml/20261018151539.440213-1-renzo@cs.unibo.it/

[1] https://lore.kernel.org/lkml/ato6Tq0aKdqqdqyJ@cs.unibo.it/

Renzo Davoli (2):
  powerpc/syscall: Remove TIF_SYSCALL_RET
  powerpc/syscall: Return the preset value of skipped syscalls

 arch/powerpc/include/asm/syscall.h     |  6 ------
 arch/powerpc/include/asm/thread_info.h |  1 -
 arch/powerpc/kernel/syscall.c          | 13 +++++++++----
 3 files changed, 9 insertions(+), 11 deletions(-)


base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.55.0


