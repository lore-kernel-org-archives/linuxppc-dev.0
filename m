Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCFA606A331
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=aP3HwpnO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRj8M4gdCz3cCb;
	Sun, 15 Nov 2026 05:19:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:760:2e00:f0a1::32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794680387;
	cv=none; b=VwJNkaaVeG6w3PxbnyfEuz9qDdc3zreBDLYZsGgLZAIoL6JXCQcfenyf/78oY3eAMtC0rKVNLNLzM+ij3E7Vt0SPcyTgsP6iMNKHG5uDmP3DpJkDkQTuS6Mfifw8DHX5vpWPZXb+/V6RQbJ6mmRNcJNN/YF72Fu1nZN0JphaipOWHBsYLsOHb/vBQGAiPMhSrPoiClbCW3Dqf+2sJGFYbJq7V5rtddrPOWKP376mQdXHjAr7LddMbXl+t/4x2dmv+hjWJAqO4lgbD5cqJj71WW4mHGNopHHWb0nT+qtBJcHshPFiOQH9EZQL3FYbDJ1wZuunR44axoCOsEggB2SxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794680387; c=relaxed/relaxed;
	bh=fneCtoft1jE/z5cQICLaBJ4/CSSYpKeQ7A9soDkriNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oH4/OdRR7PE0W0bYjtmNGZCtSYVHhbHSmTCIMiq/GoXCzCo3LbPYEVx/MS4VGTTERRfuDZ7ZwUrUIKVq0cXDVn0lRO5Z+s8iUog+9i8P8/cw8agbGaS4HkStwnDRQ0JP7iCB3IsgZ0zMnp5T2xoSj+O/oN92JG1rzMvYG/hekHw8eMuHgvVPmS2d8wC5nsutOf8XFHrFp6eL3OTTc1eNktp7YNiTX7idzCXGnfh60p+hos4q0XRVp0lcKEteSSwiFbtkWsteMf8wYw78EWwkedZpgTAYGLko//z8KjZtMCH08ajn56521rxbw572xpGgFGCKQONCVw3G1hi/EqfEUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=aP3HwpnO; dkim-atps=neutral; spf=pass (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=aP3HwpnO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [IPv6:2001:760:2e00:f0a1::32])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRj8F42S0z3c7b
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 05:19:41 +1100 (AEDT)
Received: from eipi10.cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 1A4041C0145;
	Sat, 14 Nov 2026 19:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1794680374;
	bh=/jZX3I3Baf9Yzk43cr+jSHpUEb9Hel2mhebb/m9ZUaM=;
	h=From:To:Cc:Subject:Date:From;
	b=aP3HwpnOX9fpF9+uRHGXvdKP7vUX16c4N10VZUiROLKfGMrX+NF/miPeZY0ddycCi
	 y9PtbcODQIs8a7Kr+psTN05b3stH+J4nI/Sb76lKX22TQhwm/XKe/1+hWzgaSI667G
	 SHcQKQ5oWYN4513oBF60P4YDEtzE2tB26K6+hEbE=
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	Oleg Nesterov <oleg@redhat.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	strace-devel@lists.strace.io
Subject: [PATCH v11 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp syscall skipping
Date: Sat, 14 Nov 2026 19:19:19 +0100
Message-ID: <20261114181923.370930-1-renzo@cs.unibo.it>
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

PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
PTRACE_GET_SYSCALL_INFO by allowing a tracer to modify details of a
system call in which the tracee is currently blocked.

This patch set extends PTRACE_SET_SYSCALL_INFO with support for
skipping a system call at a PTRACE_EVENT_SECCOMP stop and setting its
return value.  To do this, the tracer changes 'op' from
PTRACE_SYSCALL_INFO_SECCOMP to PTRACE_SYSCALL_INFO_EXIT and fills in the
exit union fields (rval and is_error).

Michal pointed out in the review of v7 [1] that the register state alone
cannot tell whether a syscall has to be executed or skipped with a
preset return value, since on some architectures the return value
shares a register with the syscall number or the arguments, and that
the "already dispatched" information should be architecture
independent rather than an architecture-specific thread flag.

v8 does exactly that: the tracer no longer sets the syscall number to -1
and relies on syscall_get_nr() reading it back as negative.  Instead,
patch 1 adds a per-task flag owned by seccomp, which the tracer sets
while the tracee is stopped.  When the tracee resumes, seccomp skips the
system call just like for SECCOMP_RET_ERRNO, a path every architecture
already handles without touching the return value.  This also fixes
skipping on s390, where -1 is read back as syscall 65535.

On powerpc, a separate fix has been posted [2]:
syscall_set_return_value() currently sets TIF_SYSCALL_RET on the
*caller*, i.e. on the tracer when called from PTRACE_SET_SYSCALL_INFO,
and skipped system calls lose non-error return values.  These problems
are already present in the source tree and break the existing
set_syscall_info selftest and seccomp_bpf user_notification_basic on
ppc64le independently of this series, which therefore no longer
depends on [2].

[1] https://lore.kernel.org/lkml/apWFHkZnCMfxQCEk@kunlun.suse.cz/
[2] https://lore.kernel.org/lkml/20261030084926.1068384-1-renzo@cs.unibo.it/
[3] https://sashiko.dev/#/patchset/20261113165509.229869-1-renzo@cs.unibo.it?part=2

Testing (tools/testing/selftests/ptrace/set_syscall_info and
tools/testing/selftests/seccomp/seccomp_bpf):

v11, QEMU, v7.4-rc2:

                               x86_64 (KVM)
  ptrace/set_syscall_info      2/2
  seccomp/seccomp_bpf          142/142

v9, QEMU, v7.3-rc6 (the v11 change is architecture independent):

                               x86_64 (KVM)   ppc64le (TCG)   s390x (TCG)
  ptrace/set_syscall_info      2/2            2/2             2/2
  seccomp/seccomp_bpf          111/111        111/111         110/111 (*)

  Build-tested also with CONFIG_SECCOMP=n and CONFIG_SECCOMP_FILTER=n.

  Skipping getpid() at a PTRACE_EVENT_SECCOMP stop, with a filter that
  kills the process on unknown syscall numbers:

  op=SECCOMP, nr=-1 (before)   error          r3 left as is   SIGSYS kill
  op=SECCOMP->EXIT (this)      -ESRCH         -ESRCH          -ESRCH

  (*) user_notification_wait_killable_after_reply timed out under TCG
      while another VM was running; it passes 5/5 both with and without
      this series on an idle x86_64 KVM guest.

  ppc64le results were obtained with an earlier version of the powerpc
  fix [2] applied.

  Not tested: MIPS, arm64, riscv, loongarch, real hardware.

Changes in v11:
* once the system call is skipped, PTRACE_GET_SYSCALL_INFO reports the
  stop as a PTRACE_SYSCALL_INFO_EXIT one, as the syscall number and
  arguments may have been overwritten by the return value (reported by
  Sashiko [3]); a later PTRACE_SYSCALL_INFO_SECCOMP update is still
  rejected, now by the generic check on the stop type
* selftests/ptrace/set_syscall_info.c: check PTRACE_GET_SYSCALL_INFO
  after the system call is skipped

Changes in v10:
* rebased to Linux 7.4-rc2
* no longer depends on the powerpc fix [2], which addresses a bug
  already present in the source tree

Changes in v9:
* selftests/ptrace/set_syscall_info.c: check for seccomp filter support,
  fix failure report
* rebased to Linux 7.3

Changes in v8:
* skip the system call via a seccomp per-task flag instead of
  syscall_set_nr(-1), as suggested by Michal Suchánek
* new helper ptrace_set_syscall_info_seccomp_skip() instead of a bool
  argument to ptrace_set_syscall_info_exit() (Michal Suchánek)
* once the system call is skipped, reject further
  PTRACE_SYSCALL_INFO_SECCOMP updates during the same stop
* selftest: also test an error return value and the above
* dropped the Reviewed-by tags of Oleg and Dmitry, as patch 2 changed
  significantly

Changes in v7:
* rebased to Linux 7.3-rc1

Changes in v6:
* selftests/ptrace/set_syscall_info.c: improve messages in case of failure.

Changes in v5:
* reworded the explanation for not supporting PTRACE_SYSCALL_INFO_ENTRY yet.
* selftests/ptrace: removed a redundant check.

Changes in v4:
* Reworded the commit messages for clarity.
* Renamed the local variable child_op to op in ptrace_set_syscall_info()
* Clean up and improve the coding style of selftests/ptrace/set_syscall_info.c
  (suggested by Dmitry V. Levin)

Changes in v3:
* restrict the syscall skipping feature to PTRACE_SYSCALL_INFO_SECCOMP

Changes in v2:
bugfix: _NONE -> _EXIT transition was erroneously permitted

Davide Berardi (1):
  seccomp: let the tracer skip a syscall independently of its number

Renzo Davoli (2):
  ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
  selftests/ptrace: add a test case for PTRACE_SET_SYSCALL_INFO syscall
    skipping

 include/linux/seccomp.h                       |  33 +++
 include/linux/seccomp_types.h                 |   4 +
 kernel/ptrace.c                               |  49 +++-
 kernel/seccomp.c                              |  11 +-
 .../selftests/ptrace/set_syscall_info.c       | 249 +++++++++++++++++-
 5 files changed, 342 insertions(+), 4 deletions(-)

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.55.0


