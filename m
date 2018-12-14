Return-Path: <SRS0=/PaX=OY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1630EC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 06:26:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11BB2080F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 06:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vro+nVkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11BB2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Gy9m0pM4zDrHp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 17:26:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vro+nVkb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=paul-moore.com
 (client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com;
 envelope-from=paul@paul-moore.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=paul-moore-com.20150623.gappssmtp.com
 header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vro+nVkb"; 
 dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Ghcj19TrzDr86
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 07:15:29 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id e5-v6so5960840lja.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 12:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sJZBrB9/XSgeb+HOXRPwHt1KdGhg47e48PyGQrWz9sU=;
 b=vro+nVkbpDLyp+L906vEptqv5L2Q4p758Wla4jkIJK1DgPETJKcpDZMAf9UUBlUilC
 ljgDGQ+UNGLpo24zA8VkyDwh5dif5AIEtIiR/6v5azzQQDuu0KJr1bguLNmw585P76LM
 7ilLQNNZ7UEOAuamxYcDjtB85OiYAIgcTpBqzWjGaKMP6nGe6X1jD8dulr8pmE6h1Xj+
 gFwE1PVyolJykkyL+jmhT1omhdjDcMlcV0Szz+8c32bZH/8sqWA8BuhZPCiXiJDVYlmR
 7e/DYmm2zTpBer/LMwCi1xJ6OZ9/ywqxNKudTOPF+i7FtwyFIkOdqK1q45m40tq8F0Ys
 9y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sJZBrB9/XSgeb+HOXRPwHt1KdGhg47e48PyGQrWz9sU=;
 b=jPF0fPcG/h+LpzRixoMebUgB7GhT8j6754vbpIJgxmg2U15VSlA3lPCypf/lk5agFR
 AvPpruPqu5j16UYN702X5ac6zpDGN78i44cLy+VnE+nEQZOPVbxeveVDPA8dDJ8sF7nT
 Pt85eC1tyRdm+KQo/oRhMo1zGx/+mMcNIXDg7FSfV7EV+p9N5N3wH8GWd6E4SgmkoKDr
 hS4ygoOU7r28ZwiBivosJMeYY/Z1p30uaO/IpM4KJMKd7PRpQmd+rAHO4najd2Q07UeQ
 zOFpA2XKaQJXNZIuQhg3UXTO1lofFAhZqwugQ8BLzhTTXT3fdu3uyBK70ezz4nzd7rK1
 1VpA==
X-Gm-Message-State: AA+aEWZc9Qo/cCmtFa4V3zO5NYQRNZJO8t+L7YQVOcw7LEPgEqTh9wlQ
 jonqxlGYt8C0cO7KN+1FxLm8ZUmwdwQbdgK+XhB+
X-Google-Smtp-Source: AFSGD/U44mcq2GSl+Hmt3nhbu18QDcOeORGK8XT6rYOHidkeCc9EiEuLRYP5Npe7mKnZVhqv3WLxGPierFDCcpw8SZ4=
X-Received: by 2002:a2e:880a:: with SMTP id
 x10-v6mr2909588ljh.174.1544818525196; 
 Fri, 14 Dec 2018 12:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20181213171833.GA5240@altlinux.org>
In-Reply-To: <20181213171833.GA5240@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 14 Dec 2018 15:15:13 -0500
Message-ID: <CAHC9VhRKtEuSn64rqcUd_+y-jD+K0MY_1g7k2XZjCWHA=Ew9pA@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] ptrace: add PTRACE_GET_SYSCALL_INFO request
To: ldv@altlinux.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 15 Dec 2018 17:24:12 +1100
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
Cc: linux-snps-arc@lists.infradead.org, dalias@libc.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 alexey.brodkin@synopsys.com, heiko.carstens@de.ibm.com,
 linux-api@vger.kernel.org, jejb@parisc-linux.org, jcmvbkbc@gmail.com,
 guoren@kernel.org, ralf@linux-mips.org, linux-kselftest@vger.kernel.org,
 hpa@zytor.com, leitao@debian.org, linux@armlinux.org.uk,
 linux-riscv@lists.infradead.org, deanbo422@gmail.com, shuah@kernel.org,
 tglx@linutronix.de, paulus@samba.org, jonas@southpole.se,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 ysato@users.sourceforge.jp, linux-xtensa@linux-xtensa.org, deller@gmx.de,
 x86@kernel.org, linux-kernel@vger.kernel.org, esyr@redhat.com,
 linux-alpha@vger.kernel.org, lineprinter@altlinux.org, geert@linux-m68k.org,
 catalin.marinas@arm.com, jhogan@kernel.org, mattst88@gmail.com,
 linux-mips@vger.kernel.org, strace-devel@lists.strace.io,
 uclinux-h8-devel@lists.sourceforge.jp, fenghua.yu@intel.com,
 aou@eecs.berkeley.edu, keescook@chromium.org, arnd@arndb.de, jannh@google.com,
 will.deacon@arm.com, jdike@addtoit.com, msalter@redhat.com,
 linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 jacquiot.aurelien@gmail.com, linux-m68k@lists.linux-m68k.org,
 nios2-dev@lists.rocketboards.org, bp@alien8.de, green.hu@gmail.com,
 luto@kernel.org, lftan@altera.com, shorne@gmail.com,
 stefan.kristiansson@saunalahti.fi, gxt@pku.edu.cn, mingo@redhat.com,
 linux-arm-kernel@lists.infradead.org, rth@twiddle.net, chris@zankel.net,
 monstr@monstr.eu, tony.luck@intel.com, wad@chromium.org,
 linux-parisc@vger.kernel.org, vgupta@synopsys.com, oleg@redhat.com,
 Eric Paris <eparis@redhat.com>, rkuo@codeaurora.org, paul.burton@mips.com,
 linux-audit@redhat.com, palmer@sifive.com, richard@nod.at,
 schwidefsky@de.ibm.com, ink@jurassic.park.msu.ru,
 linux-hexagon@vger.kernel.org, davem@davemloft.net,
 openrisc@lists.librecores.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 13, 2018 at 12:18 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> PTRACE_GET_SYSCALL_INFO is a generic ptrace API that lets ptracer obtain
> details of the syscall the tracee is blocked in.
>
> There are two reasons for a special syscall-related ptrace request.
>
> Firstly, with the current ptrace API there are cases when ptracer cannot
> retrieve necessary information about syscalls.  Some examples include:
> * The notorious int-0x80-from-64-bit-task issue.  See [1] for details.
> In short, if a 64-bit task performs a syscall through int 0x80, its tracer
> has no reliable means to find out that the syscall was, in fact,
> a compat syscall, and misidentifies it.
> * Syscall-enter-stop and syscall-exit-stop look the same for the tracer.
> Common practice is to keep track of the sequence of ptrace-stops in order
> not to mix the two syscall-stops up.  But it is not as simple as it looks;
> for example, strace had a (just recently fixed) long-standing bug where
> attaching strace to a tracee that is performing the execve system call
> led to the tracer identifying the following syscall-exit-stop as
> syscall-enter-stop, which messed up all the state tracking.
> * Since the introduction of commit 84d77d3f06e7e8dea057d10e8ec77ad71f721be3
> ("ptrace: Don't allow accessing an undumpable mm"), both PTRACE_PEEKDATA
> and process_vm_readv become unavailable when the process dumpable flag
> is cleared.  On such architectures as ia64 this results in all syscall
> arguments being unavailable for the tracer.
>
> Secondly, ptracers also have to support a lot of arch-specific code for
> obtaining information about the tracee.  For some architectures, this
> requires a ptrace(PTRACE_PEEKUSER, ...) invocation for every syscall
> argument and return value.
>
> PTRACE_GET_SYSCALL_INFO returns the following structure:
>
> struct ptrace_syscall_info {
>         __u8 op;        /* PTRACE_SYSCALL_INFO_* */
>         __u32 arch __attribute__((__aligned__(sizeof(__u32))));
>         __u64 instruction_pointer;
>         __u64 stack_pointer;
>         union {
>                 struct {
>                         __u64 nr;
>                         __u64 args[6];
>                 } entry;
>                 struct {
>                         __s64 rval;
>                         __u8 is_error;
>                 } exit;
>                 struct {
>                         __u64 nr;
>                         __u64 args[6];
>                         __u32 ret_data;
>                 } seccomp;
>         };
> };
>
> The structure was chosen according to [2], except for the following
> changes:
> * seccomp substructure was added as a superset of entry substructure;
> * the type of nr field was changed from int to __u64 because syscall
> numbers are, as a practical matter, 64 bits;
> * stack_pointer field was added along with instruction_pointer field
> since it is readily available and can save the tracer from extra
> PTRACE_GETREGS/PTRACE_GETREGSET calls;
> * arch is always initialized to aid with tracing system calls
> * such as execve();
> * instruction_pointer and stack_pointer are always initialized
> so they could be easily obtained for non-syscall stops;
> * a boolean is_error field was added along with rval field, this way
> the tracer can more reliably distinguish a return value
> from an error value.
>
> strace has been ported to PTRACE_GET_SYSCALL_INFO, you can find it
> in [3] and [4].
>
> [1] https://lore.kernel.org/lkml/CA+55aFzcSVmdDj9Lh_gdbz1OzHyEm6ZrGPBDAJnywm2LF_eVyg@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/CAObL_7GM0n80N7J_DFw_eQyfLyzq+sf4y2AvsCCV88Tb3AwEHA@mail.gmail.com/
> [3] https://github.com/strace/strace/commits/ldv/PTRACE_GET_SYSCALL_INFO
> [4] https://gitlab.com/strace/strace/commits/ldv/PTRACE_GET_SYSCALL_INFO
>
> ---
>
> Notes:
>     v6:
>     * Add syscall_get_arguments and syscall_set_arguments wrappers
>       to asm-generic/syscall.h, requested by Geert.
>     * Change PTRACE_GET_SYSCALL_INFO return code: do not take trailing paddings
>       into account, use the end of the last field of the structure being written.
>     * Change struct ptrace_syscall_info:
>       * remove .frame_pointer field, is is not needed and not portable;
>       * make .arch field explicitly aligned, remove no longer needed
>         padding before .arch field;
>       * remove trailing pads, they are no longer needed.
>
>     v5:
>     * Merge separate series and patches into the single series.
>     * Change PTRACE_EVENTMSG_SYSCALL_{ENTRY,EXIT} values as requested by Oleg.
>     * Change struct ptrace_syscall_info: generalize instruction_pointer,
>       stack_pointer, and frame_pointer fields by moving them from
>       ptrace_syscall_info.{entry,seccomp} substructures to ptrace_syscall_info
>       and initializing them for all stops.
>     * Add PTRACE_SYSCALL_INFO_NONE, set it when not in a syscall stop,
>       so e.g. "strace -i" could use PTRACE_SYSCALL_INFO_SECCOMP to obtain
>       instruction_pointer when the tracee is in a signal stop.
>     * Patch all remaining architectures to provide all necessary
>       syscall_get_* functions.
>     * Make available for all architectures: do not conditionalize on
>       CONFIG_HAVE_ARCH_TRACEHOOK since all syscall_get_* functions
>       are implemented on all architectures.
>     * Add a test for PTRACE_GET_SYSCALL_INFO to selftests/ptrace.
>
>     v4:
>     * Do not introduce task_struct.ptrace_event,
>       use child->last_siginfo->si_code instead.
>     * Implement PTRACE_SYSCALL_INFO_SECCOMP and ptrace_syscall_info.seccomp
>       support along with PTRACE_SYSCALL_INFO_{ENTRY,EXIT} and
>       ptrace_syscall_info.{entry,exit}.
>
>     v3:
>     * Change struct ptrace_syscall_info.
>     * Support PTRACE_EVENT_SECCOMP by adding ptrace_event to task_struct.
>     * Add proper defines for ptrace_syscall_info.op values.
>     * Rename PT_SYSCALL_IS_ENTERING and PT_SYSCALL_IS_EXITING to
>       PTRACE_EVENTMSG_SYSCALL_ENTRY and PTRACE_EVENTMSG_SYSCALL_EXIT
>     * and move them to uapi.
>
>     v2:
>     * Do not use task->ptrace.
>     * Replace entry_info.is_compat with entry_info.arch, use syscall_get_arch().
>     * Use addr argument of sys_ptrace to get expected size of the struct;
>       return full size of the struct.
>
> Dmitry V. Levin (25):
>   asm-generic/syscall.h: prepare for inclusion by other files
>   asm-generic/syscall.h: turn syscall_[gs]et_arguments into wrappers
>   alpha: define remaining syscall_get_* functions
>   Move EM_ARCOMPACT and EM_ARCV2 to uapi/linux/elf-em.h
>   arc: define syscall_get_arch()
>   c6x: define syscall_get_arch()
>   elf-em.h: add EM_CSKY
>   csky: define syscall_get_arch()
>   h8300: define remaining syscall_get_* functions
>   Move EM_HEXAGON to uapi/linux/elf-em.h
>   hexagon: define remaining syscall_get_* functions
>   Move EM_NDS32 to uapi/linux/elf-em.h
>   nds32: define syscall_get_arch()
>   nios2: define syscall_get_arch()
>   m68k: add asm/syscall.h
>   mips: define syscall_get_error()
>   parisc: define syscall_get_error()
>   powerpc: define syscall_get_error()
>   riscv: define syscall_get_arch()
>   Move EM_XTENSA to uapi/linux/elf-em.h
>   xtensa: define syscall_get_* functions
>   Move EM_UNICORE to uapi/linux/elf-em.h
>   unicore32: add asm/syscall.h
>   syscall_get_arch: add "struct task_struct *" argument
>   selftests/ptrace: add a test case for PTRACE_GET_SYSCALL_INFO
>
> Elvira Khabirova (2):
>   powerpc/ptrace: replace ptrace_report_syscall() with a tracehook call
>   ptrace: add PTRACE_GET_SYSCALL_INFO request

As mentioned in the previous patchsets, this all looks fine to me from
an audit perspective (although there is not much audit code to really
comment on).  Feel free to add my ACK to the audit related patches.

Acked-by: Paul Moore <paul@paul-moore.com>

>  arch/alpha/include/asm/syscall.h              |  31 +-
>  arch/arc/include/asm/elf.h                    |   6 +-
>  arch/arc/include/asm/syscall.h                |  11 +
>  arch/arm/include/asm/syscall.h                |   2 +-
>  arch/arm64/include/asm/syscall.h              |   4 +-
>  arch/c6x/include/asm/syscall.h                |   7 +
>  arch/csky/include/asm/syscall.h               |   7 +
>  arch/h8300/include/asm/syscall.h              |  19 ++
>  arch/hexagon/include/asm/elf.h                |   6 +-
>  arch/hexagon/include/asm/syscall.h            |  22 ++
>  arch/ia64/include/asm/syscall.h               |   2 +-
>  arch/m68k/include/asm/syscall.h               |  42 +++
>  arch/microblaze/include/asm/syscall.h         |   2 +-
>  arch/mips/include/asm/syscall.h               |  12 +-
>  arch/mips/kernel/ptrace.c                     |   2 +-
>  arch/nds32/include/asm/elf.h                  |   3 +-
>  arch/nds32/include/asm/syscall.h              |   8 +
>  arch/nios2/include/asm/syscall.h              |   6 +
>  arch/openrisc/include/asm/syscall.h           |   2 +-
>  arch/parisc/include/asm/syscall.h             |  11 +-
>  arch/powerpc/include/asm/syscall.h            |  20 +-
>  arch/powerpc/kernel/ptrace.c                  |   7 +-
>  arch/riscv/include/asm/syscall.h              |  10 +
>  arch/s390/include/asm/syscall.h               |   4 +-
>  arch/sh/include/asm/syscall_32.h              |   2 +-
>  arch/sh/include/asm/syscall_64.h              |   2 +-
>  arch/sparc/include/asm/syscall.h              |   5 +-
>  arch/unicore32/include/asm/elf.h              |   3 +-
>  arch/unicore32/include/asm/syscall.h          |  46 +++
>  arch/x86/include/asm/syscall.h                |   8 +-
>  arch/x86/um/asm/syscall.h                     |   2 +-
>  arch/xtensa/include/asm/elf.h                 |   2 +-
>  arch/xtensa/include/asm/syscall.h             |  65 +++++
>  include/asm-generic/syscall.h                 |  85 ++++--
>  include/linux/tracehook.h                     |   9 +-
>  include/uapi/linux/audit.h                    |  16 ++
>  include/uapi/linux/elf-em.h                   |   8 +
>  include/uapi/linux/ptrace.h                   |  35 +++
>  kernel/auditsc.c                              |   4 +-
>  kernel/ptrace.c                               | 101 ++++++-
>  kernel/seccomp.c                              |   4 +-
>  tools/testing/selftests/ptrace/.gitignore     |   1 +
>  tools/testing/selftests/ptrace/Makefile       |   2 +-
>  .../selftests/ptrace/get_syscall_info.c       | 271 ++++++++++++++++++
>  44 files changed, 851 insertions(+), 66 deletions(-)
>  create mode 100644 arch/m68k/include/asm/syscall.h
>  create mode 100644 arch/unicore32/include/asm/syscall.h
>  create mode 100644 tools/testing/selftests/ptrace/get_syscall_info.c
>
> --
> ldv



--
paul moore
www.paul-moore.com
