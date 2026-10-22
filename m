Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD284606A319
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=L6UX1lfY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9Wqx6n9gz2y7W;
	Fri, 23 Oct 2026 03:31:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:760:2e00:f0a1::32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792686685;
	cv=none; b=oGgFfJbmCmH3p9QmAkoDYOzshRrjxSX9txb0YrESdSBiIzfuipYjx0149UzWwJzsFEa/2ywGjiGjMR+Q+xbvbLOZSrbJ82yCGWiwGbeNeIhydBUwfvYQ0wpA2uCI45NKf+WB7Wn0l2G62rVXfZ23fu6F/tbiDPmj7hIui30nfS605jt7+1KPAT3Oo7VKNawggMzW2Y+e7404nXplzkvb+KEe3E0+BkIpm8Zoib/c/asVfXUtR5g2Ym4nAOJU+Oph2mX5wCakEAD/A53TzcPiv3OqoC90O2o2ljXoQFmvyJmZwuBFLI/618BbHrgYatGAOYHTuVGqj9ebGSEXFFe+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792686685; c=relaxed/relaxed;
	bh=dqBO/1DhScXJoH993IsuLEdQfKPtaBI5+DWNmPettbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzG/l82MnqbxYxYRvoja6a74h8zGC4yviI6qNwUMEDTkJV+n5BrGhNTp1352K178TsdEojmFV8RIj7oMEJy7iDyqmbr8P0FkWMXPYZJAgRamLvHIe9p+cpEwa7+03BTtZeUTZS/wAvO55j7HrEbw9E/kshQ5JG4y+drHht1YNFyEX9830aybmBiqL13OUHoCRkviFR38siK6mTmcLbGGSzzV15dBuJjUOW9WmUAt/40J9X0e2weDlDseotiEkGoYejcL6xLOdVH8b+mHB4CIsk0ESbqgGlmAYjldFCx3JpZ4ig7MPCcLj9ykhLZ/d2ZtBxggKjfue28cwGXv9IsqSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=L6UX1lfY; dkim-atps=neutral; spf=pass (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=L6UX1lfY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=2001:760:2e00:f0a1::32; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [IPv6:2001:760:2e00:f0a1::32])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9Wqt4X77z2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 03:31:20 +1100 (AEDT)
Received: from cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 458301C006E;
	Thu, 22 Oct 2026 18:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792686672;
	bh=fdZnlNUu/aR/LPydmbT6dOU/LEaViX/83I6GrIBSCF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6UX1lfY57HUSj+8GXZxBmjuuST2IC1mvYEsQe5689C4RG9qb9mBx5nOxsSZYCybd
	 Lkk+JYywkjb69COHqqJJ+JkeXYQ2vVzXBgAaIBfIYYEUnQv6vkowR2/rfgAAzrhiJm
	 sx0WjDPzcHAxHCV3tIue7at48Kipb/HpEvFn4+uA=
Date: Thu, 22 Oct 2026 18:31:10 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Davide Berardi <berardi.dav@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] powerpc/syscall: Return the preset value of skipped
 syscalls
Message-ID: <ato6Tq0aKdqqdqyJ@cs.unibo.it>
References: <20261018151539.440213-1-renzo@cs.unibo.it>
 <athm2nYVnq6vYBY3@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
Content-Type: multipart/mixed; boundary="3g9jXhBakJsc42lj"
Content-Disposition: inline
In-Reply-To: <athm2nYVnq6vYBY3@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--3g9jXhBakJsc42lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 21, 2026 at 12:47:36PM +0530, Mukesh Kumar Chaurasiya wrote:
> > How this was found and tested: QEMU pseries (TCG, -cpu power9), ppc64le
> > guest config, v7.3-rc6 (7b63ef2d55f2), with a small reproducer
> > (ppc_skip_repro.c, available on request) which
> > 
> Hey,
> Can you share the reproducer?
> 
> Regards,
> Mukesh

sure, it is here attached.

The output here follows.

before patch:
tracer syscall after PTRACE_SET_SYSCALL_INFO(EXIT)         FAIL (got 0, want 1)
tracee sees value set at syscall-exit stop                 PASS (got 0, want 0)
    tracee got 0
seccomp skip via regs, success value, sc                   FAIL (got 1, want 0)
seccomp skip via regs, error value,   sc                   PASS (got 0, want 0)
    tracee got 0
seccomp skip via regs, success value, scv                  FAIL (got 1, want 0)
seccomp skip via regs, error value,   scv                  PASS (got 0, want 0)
FAIL: 3 failure(s)

after patch:
tracer syscall after PTRACE_SET_SYSCALL_INFO(EXIT)         PASS (got 1, want 1)
tracee sees value set at syscall-exit stop                 PASS (got 0, want 0)
seccomp skip via regs, success value, sc                   PASS (got 0, want 0)
seccomp skip via regs, error value,   sc                   PASS (got 0, want 0)
seccomp skip via regs, success value, scv                  PASS (got 0, want 0)
seccomp skip via regs, error value,   scv                  PASS (got 0, want 0)
OK: 0 failure(s)

Thank you, Regards,
	renzo

--3g9jXhBakJsc42lj
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename=ppc_skip_repro.c

// SPDX-License-Identifier: GPL-2.0
/*
 * Reproducer for two powerpc syscall-skip problems introduced with
 * GENERIC_ENTRY / TIF_SYSCALL_RET (commit 69cb2be898be):
 *
 *  1. syscall_set_return_value() sets TIF_SYSCALL_RET on current, so when a
 *     tracer uses PTRACE_SET_SYSCALL_INFO (op == EXIT) the flag lands on the
 *     *tracer*, whose next system call is silently skipped.
 *
 *  2. When a syscall is skipped, system_call_exception() returns
 *     syscall_get_error(), so a non-error return value set by a tracer
 *     (or by SECCOMP_RET_USER_NOTIF) is replaced by 0.
 *
 * Test 2 is run with both the "sc" and the "scv 0" system call instructions
 * on powerpc.  On x86_64 the same tests are run with "syscall" as a control.
 *
 * Build: $CC -static -O2 -o ppc_skip_repro ppc_skip_repro.c
 */
#define _GNU_SOURCE
#include <errno.h>
#include <signal.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/auxv.h>
#include <sys/prctl.h>
#include <sys/ptrace.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <linux/filter.h>
#include <linux/seccomp.h>

#ifndef PTRACE_GET_SYSCALL_INFO
# define PTRACE_GET_SYSCALL_INFO 0x420e
#endif
#ifndef PTRACE_SET_SYSCALL_INFO
# define PTRACE_SET_SYSCALL_INFO 0x4212
#endif
#define PSI_ENTRY	1
#define PSI_EXIT	2

struct psi {
	unsigned char op, reserved;
	unsigned short flags;
	unsigned int arch;
	unsigned long long ip, sp;
	union {
		struct { unsigned long long nr, args[6]; } entry;
		struct { long long rval; unsigned char is_error; } exit;
		struct { unsigned long long nr, args[6]; unsigned int ret_data, reserved2; } seccomp;
	};
};

#define MAGIC 42

#if defined(__powerpc64__)
# define PT_R0		0
# define PT_R3		3
# define PT_CCR		38
# define PT_TRAP	40
# define CR0_SO		0x10000000UL
# ifndef PPC_FEATURE2_SCV
#  define PPC_FEATURE2_SCV 0x00100000
# endif

/* getpid via "sc": error is reported in CR0.SO with a positive errno */
static long sys_getpid_sc(void)
{
	register long r0 __asm__("r0") = __NR_getpid;
	register long r3 __asm__("r3");
	unsigned long cr;

	__asm__ volatile(".long 0x44000002\n\tmfcr %2"		/* sc */
			 : "+r"(r0), "=r"(r3), "=r"(cr)
			 :
			 : "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11",
			   "r12", "ctr", "xer", "cr0", "memory");
	return (cr & CR0_SO) ? -r3 : r3;
}

/* getpid via "scv 0": error is reported as a negative value */
static long sys_getpid_scv(void)
{
	register long r0 __asm__("r0") = __NR_getpid;
	register long r3 __asm__("r3");

	__asm__ volatile(".long 0x44000001"			/* scv 0 */
			 : "+r"(r0), "=r"(r3)
			 :
			 : "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11",
			   "r12", "lr", "ctr", "xer", "cr0", "cr1", "cr5",
			   "cr6", "cr7", "memory");
	return r3;
}

/* Skip the syscall the old-fashioned way: r0 = -1, r3/ccr = return value */
static int poke_skip(pid_t pid, long val)
{
	long trap = ptrace(PTRACE_PEEKUSER, pid, PT_TRAP * 8, 0);
	long ccr = ptrace(PTRACE_PEEKUSER, pid, PT_CCR * 8, 0);

	if ((trap & 0xfff0) != 0x3000)	/* "sc": positive errno + CR0.SO */
		ccr = val < 0 ? (ccr | CR0_SO) : (ccr & ~CR0_SO);
	if ((trap & 0xfff0) != 0x3000 && val < 0)
		val = -val;
	return ptrace(PTRACE_POKEUSER, pid, PT_R0 * 8, -1L) ||
	       ptrace(PTRACE_POKEUSER, pid, PT_R3 * 8, val) ||
	       ptrace(PTRACE_POKEUSER, pid, PT_CCR * 8, ccr);
}
#elif defined(__x86_64__)
static long sys_getpid_sc(void)
{
	long ret;

	__asm__ volatile("syscall" : "=a"(ret) : "a"((long)__NR_getpid)
			 : "rcx", "r11", "memory");
	return ret;
}

static int poke_skip(pid_t pid, long val)
{
	return ptrace(PTRACE_POKEUSER, pid, 15 * 8 /* orig_rax */, -1L) ||
	       ptrace(PTRACE_POKEUSER, pid, 10 * 8 /* rax */, val);
}
#else
# error unsupported architecture
#endif

static int failures;

static void report(const char *name, long got, long want)
{
	printf("%-58s %s (got %ld, want %ld)\n", name,
	       got == want ? "PASS" : "FAIL", got, want);
	if (got != want)
		failures++;
}

static pid_t start_tracee(void)
{
	pid_t pid = fork();

	if (pid == 0) {
		if (ptrace(PTRACE_TRACEME, 0, 0, 0))
			_exit(90);
		raise(SIGSTOP);
	}
	return pid;
}

static int wait_stop(pid_t pid)
{
	int status;

	if (waitpid(pid, &status, 0) != pid || !WIFSTOPPED(status))
		return -1;
	return status >> 8;
}

static long child_result(pid_t pid)
{
	int status;

	if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status))
		return -1000;
	return WEXITSTATUS(status);
}

/*
 * Test 1: the tracer sets the getpid() return value at the syscall-exit
 * stop with PTRACE_SET_SYSCALL_INFO, then makes a system call of its own.
 */
static void test_tracer_flag(void)
{
	pid_t me = getpid(), pid = start_tracee();
	struct psi info;
	long mine;

	if (pid == 0)
		_exit(syscall(__NR_getpid) == MAGIC ? 0 : 1);

	wait_stop(pid);
	ptrace(PTRACE_SETOPTIONS, pid, 0, PTRACE_O_TRACESYSGOOD);
	for (;;) {
		ptrace(PTRACE_SYSCALL, pid, 0, 0);
		if (wait_stop(pid) != (SIGTRAP | 0x80))
			break;
		memset(&info, 0, sizeof(info));
		ptrace(PTRACE_GET_SYSCALL_INFO, pid, sizeof(info), &info);
		if (info.op == PSI_EXIT)
			break;
	}
	info.exit.rval = MAGIC;
	info.exit.is_error = 0;
	if (ptrace(PTRACE_SET_SYSCALL_INFO, pid, sizeof(info), &info))
		perror("PTRACE_SET_SYSCALL_INFO");

	/* The very next syscall of the tracer must not be affected. */
	mine = sys_getpid_sc();
	report("tracer syscall after PTRACE_SET_SYSCALL_INFO(EXIT)", mine, me);

	ptrace(PTRACE_CONT, pid, 0, 0);
	report("tracee sees value set at syscall-exit stop", child_result(pid), 0);
}

/*
 * Test 2: seccomp RET_TRACE on getpid; at the seccomp stop the tracer skips
 * the syscall by setting the number to -1 and the return value with
 * PTRACE_POKEUSER (what existing ptrace users do).
 */
static void test_seccomp_skip(const char *name, long (*do_getpid)(void), long val)
{
	struct sock_filter filter[] = {
		BPF_STMT(BPF_LD | BPF_W | BPF_ABS, offsetof(struct seccomp_data, nr)),
		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, __NR_getpid, 0, 1),
		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRACE),
		BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
	};
	struct sock_fprog prog = { .len = 4, .filter = filter };
	pid_t pid = start_tracee();

	if (pid == 0) {
		long ret;

		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) ||
		    syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog))
			_exit(91);
		ret = do_getpid();
		/* exit status: 0 if correct, 1 otherwise; print what we got */
		if (ret != val)
			fprintf(stderr, "    tracee got %ld\n", ret);
		_exit(ret == val ? 0 : 1);
	}

	wait_stop(pid);
	ptrace(PTRACE_SETOPTIONS, pid, 0, PTRACE_O_TRACESECCOMP);
	ptrace(PTRACE_CONT, pid, 0, 0);
	if (wait_stop(pid) != (SIGTRAP | (PTRACE_EVENT_SECCOMP << 8))) {
		report(name, -1, 0);
		return;
	}
	if (poke_skip(pid, val))
		perror("poke");
	ptrace(PTRACE_CONT, pid, 0, 0);
	report(name, child_result(pid), 0);
}

int main(void)
{
	setvbuf(stdout, NULL, _IONBF, 0);
	test_tracer_flag();
	test_seccomp_skip("seccomp skip via regs, success value, sc", sys_getpid_sc, MAGIC);
	test_seccomp_skip("seccomp skip via regs, error value,   sc", sys_getpid_sc, -ENOENT);
#ifdef __powerpc64__
	if (getauxval(AT_HWCAP2) & PPC_FEATURE2_SCV) {
		test_seccomp_skip("seccomp skip via regs, success value, scv", sys_getpid_scv, MAGIC);
		test_seccomp_skip("seccomp skip via regs, error value,   scv", sys_getpid_scv, -ENOENT);
	} else {
		printf("scv not available, skipping scv tests\n");
	}
#endif
	printf("%s: %d failure(s)\n", failures ? "FAIL" : "OK", failures);
	return !!failures;
}

--3g9jXhBakJsc42lj--

