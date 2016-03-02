Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 156381A06C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 11:33:00 +1100 (AEDT)
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 596E0140C03
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 11:32:59 +1100 (AEDT)
Received: by mail-pa0-x243.google.com with SMTP id yy13so11287756pab.1
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Mar 2016 16:32:59 -0800 (PST)
Date: Wed, 2 Mar 2016 11:32:47 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V10 17/28] selftests, powerpc: Add ptrace tests for EBB
Message-ID: <20160302113247.48a0e8d0@camb691>
In-Reply-To: <1455613198-5113-18-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455613198-5113-18-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 16 Feb 2016 14:29:47 +0530
Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> This patch adds ptrace interface test for EBB specific
> registers. This also adds some generic ptrace interface
> based helper functions to be used by other patches later
> on in the series.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/powerpc/Makefile           |   3 +-
>  tools/testing/selftests/powerpc/ptrace/Makefile    |   7 +
>  .../testing/selftests/powerpc/ptrace/ptrace-ebb.c  | 150 ++++++++++++++
>  .../testing/selftests/powerpc/ptrace/ptrace-ebb.h  | 103 ++++++++++
>  tools/testing/selftests/powerpc/ptrace/ptrace.h    | 225 +++++++++++++++++++++
>  5 files changed, 487 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.h
> 
> diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
> index 0c2706b..5b3c62c 100644
> --- a/tools/testing/selftests/powerpc/Makefile
> +++ b/tools/testing/selftests/powerpc/Makefile
> @@ -22,7 +22,8 @@ SUB_DIRS = benchmarks 		\
>  	   switch_endian	\
>  	   syscalls		\
>  	   tm			\
> -	   vphn
> +	   vphn			\
> +	   ptrace
>  
>  endif
>  
> diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
> new file mode 100644
> index 0000000..8666ac0
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/ptrace/Makefile
> @@ -0,0 +1,7 @@
> +TEST_PROGS := ptrace-ebb
> +all: $(TEST_PROGS)
> +
> +$(TEST_PROGS): ../harness.c ptrace.S ../utils.c
> +ptrace-ebb: ../pmu/event.c ../pmu/lib.c ../pmu/ebb/ebb_handler.S ../pmu/ebb/busy_loop.S
> +clean:
> +	rm -f $(TEST_PROGS) *.o

If you:
include ../../lib.mk

Then this Makefile just works with run_tests and install targets from the
base Makefile

> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
> new file mode 100644
> index 0000000..e1ca608
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
> @@ -0,0 +1,150 @@
> +/*
> + * Ptrace interface test for EBB
> + *
> + * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include "../pmu/ebb/ebb.h"
> +#include "ptrace.h"
> +#include "ptrace-ebb.h"
> +

Check out tools/testing/selftests/powerpc/utils.h which provides a nice (and
super hacky) FAIL_IF() macro.

> +void ebb(void)
> +{
> +	struct event event;
> +
> +	event_init_named(&event, 0x1001e, "cycles");
> +	event.attr.config |= (1ull << 63);
> +        event.attr.exclusive = 1;
> +        event.attr.pinned = 1;
> +	event.attr.exclude_kernel = 1;
> +	event.attr.exclude_hv = 1;
> +	event.attr.exclude_idle = 1;
> +
> +	if (event_open(&event)) {
> +		perror("event_open() failed");
> +		exit(1);
> +	}
> +
> +	setup_ebb_handler(standard_ebb_callee);
> +	mtspr(SPRN_BESCR, 0x8000000100000000ull);
> +
> +	mb();
> +
> +	if (ebb_event_enable(&event)) {
> +		perror("ebb_event_handler() failed");
> +		exit(1);
> +	}
> +
> +	mtspr(SPRN_PMC1, pmc_sample_period(SAMPLE_PERIOD));
> +	while(1)
> +		core_busy_loop();
> +	exit(0);
> +}
> +
> +int validate_ebb(struct ebb_regs *regs)
> +{
> +	#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +	struct opd *opd = (struct opd *) ebb_handler;
> +	#endif
> +
> +	printf("EBBRR: %lx\n", regs->ebbrr);
> +	printf("EBBHR: %lx\n", regs->ebbhr);
> +	printf("BESCR: %lx\n", regs->bescr);
> +	printf("SIAR:  %lx\n", regs->siar);
> +	printf("SDAR:  %lx\n", regs->sdar);
> +	printf("SIER:  %lx\n", regs->sier);
> +	printf("MMCR2: %lx\n", regs->mmcr2);
> +	printf("MMCR0: %lx\n", regs->mmcr0);
> +
> +	/* Validate EBBHR */
> +	#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +	if (regs->ebbhr != opd->entry)
> +		return TEST_FAIL;
> +	#else
> +	if (regs->ebbhr != (unsigned long) ebb_handler)
> +		return TEST_FAIL;
> +	#endif
> +
> +	/* Validate SIER */
> +	if (regs->sier != SIER_EXP)
> +		return TEST_FAIL;
> +
> +	/* Validate MMCR2 */
> +	if (regs->mmcr2 != MMCR2_EXP)
> +		return TEST_FAIL;
> +
> +	/* Validate MMCR0 */
> +	if (regs->mmcr0 != MMCR0_EXP)
> +		return TEST_FAIL;
> +
> +	return TEST_PASS;
> +}
> +
> +int trace_ebb(pid_t child)
> +{
> +	struct ebb_regs regs;
> +	int ret;
> +
> +	sleep(2);
> +	ret = start_trace(child);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = show_ebb_registers(child, &regs);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = validate_ebb(&regs);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = stop_trace(child);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	return TEST_PASS;
> +}
> +
> +int ptrace_ebb(void)
> +{
> +	pid_t pid;
> +	int ret, status;
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		perror("fork() failed");
> +		return TEST_FAIL;
> +	}
> +
> +	if (pid == 0)
> +		ebb();
> +
> +	if (pid) {
> +		ret = trace_ebb(pid);
> +		if (ret)
> +			return TEST_FAIL;
> +
> +		kill(pid, SIGKILL);
> +		ret = wait(&status);
> +		if (ret != pid) {
> +			printf("Child's exit status not captured\n");
> +			return TEST_FAIL;
> +		}
> +
> +		if (WIFEXITED(status)) {
> +			if(WEXITSTATUS(status))
> +				return TEST_FAIL;
> +		}
> +		return TEST_PASS;
> +	}
> +	return TEST_PASS;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(ptrace_ebb, "ptrace_ebb");
> +}
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
> new file mode 100644
> index 0000000..9b38edc
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
> @@ -0,0 +1,103 @@
> +/*
> + * Inspired mostly from the EBB selftest
> + *
> + * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#define SAMPLE_PERIOD 100	/* EBB event sample persiod */
> +
> +/* Standard expected values */
> +#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +#define MMCR0_EXP	0x8000008000000001
> +#else
> +#define MMCR0_EXP	0x180000080
> +#endif
> +
> +#define MMCR2_EXP	0
> +#define SIER_EXP	0x2000000
> +
> +struct opd
> +{
> +	u64 entry;
> +	u64 toc;
> +};
> +
> +void (*ebb_user_func)(void);
> +extern void ebb_handler(void);	/* Defined in ebb_handle.S */
> +
> +void ebb_hook(void)		/* Called by ebb_handler */
> +{
> +        if (ebb_user_func)
> +                ebb_user_func();
> +}
> +
> +void setup_ebb_handler(void (*callee)(void))
> +{
> +        u64 entry;
> +
> +#if defined(_CALL_ELF) && _CALL_ELF == 2
> +        entry = (u64)ebb_handler;
> +#else
> +	struct opd *opd;
> +
> +        opd = (struct opd *)ebb_handler;
> +        entry = opd->entry;
> +#endif
> +        ebb_user_func = callee;
> +
> +        /* Ensure ebb_user_func is set before we set the handler */
> +        mb();
> +        mtspr(SPRN_EBBHR, entry);
> +
> +        /* Make sure the handler is set before we return */
> +        mb();
> +}
> +
> +void reset_ebb_with_clear_mask(unsigned long mmcr0_clear_mask)
> +{
> +        u64 val;
> +
> +        /* 2) clear MMCR0[PMAO] - docs say BESCR[PMEO] should do this */
> +        /* 3) set MMCR0[PMAE]   - docs say BESCR[PME] should do this */
> +        val = mfspr(SPRN_MMCR0);
> +        mtspr(SPRN_MMCR0, (val & ~mmcr0_clear_mask) | MMCR0_PMAE);
> +
> +        /* 4) clear BESCR[PMEO] */
> +        mtspr(SPRN_BESCRR, BESCR_PMEO);
> +
> +        /* 5) set BESCR[PME] */
> +        mtspr(SPRN_BESCRS, BESCR_PME);
> +
> +        /* 6) rfebb 1 - done in our caller */
> +}
> +
> +void standard_ebb_callee(void)
> +{
> +	u64 val;
> +
> +	val = mfspr(SPRN_BESCR);
> +        if (!(val & BESCR_PMEO))
> +		printf("Spurious interrupt\n");
> +
> +	mtspr(SPRN_PMC1, pmc_sample_period(SAMPLE_PERIOD));
> +	reset_ebb_with_clear_mask(MMCR0_PMAO | MMCR0_FC);
> +}
> +
> +int ebb_event_enable(struct event *e)
> +{
> +	int rc;
> +
> +	mb();
> +
> +        rc = ioctl(e->fd, PERF_EVENT_IOC_ENABLE);
> +        if (rc)
> +                return rc;
> +        rc = event_read(e);
> +
> +        mb();
> +        return rc;
> +}
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.h b/tools/testing/selftests/powerpc/ptrace/ptrace.h
> new file mode 100644
> index 0000000..44256d2
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
> @@ -0,0 +1,225 @@
> +/*
> + * Ptrace interface test helper functions
> + *
> + * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include <inttypes.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <malloc.h>
> +#include <errno.h>
> +#include <time.h>
> +#include <sys/ptrace.h>
> +#include <sys/ioctl.h>
> +#include <sys/uio.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/signal.h>
> +#include <sys/ipc.h>
> +#include <sys/shm.h>
> +#include <sys/user.h>
> +#include <linux/elf.h>
> +#include <linux/types.h>
> +#include <linux/auxvec.h>
> +#include "../reg.h"
> +#include "utils.h"
> +
> +/* ELF core note sections */
> +#define NT_PPC_TAR	0x103		/* Target Address Register */
> +#define NT_PPC_PPR	0x104		/* Program Priority Register */
> +#define NT_PPC_DSCR	0x105		/* Data Stream Control Register */
> +#define NT_PPC_EBB	0x106		/* Event Based Branch Registers */
> +#define NT_PPC_TM_CGPR	0x107		/* TM checkpointed GPR Registers */
> +#define NT_PPC_TM_CFPR	0x108		/* TM checkpointed FPR Registers */
> +#define NT_PPC_TM_CVMX	0x109		/* TM checkpointed VMX Registers */
> +#define NT_PPC_TM_CVSX	0x10a		/* TM checkpointed VSX Registers */
> +#define NT_PPC_TM_SPR	0x10b		/* TM Special Purpose Registers */
> +#define NT_PPC_TM_CTAR	0x10c		/* TM checkpointed Target Address Register */
> +#define NT_PPC_TM_CPPR	0x10d		/* TM checkpointed Program Priority Register */
> +#define NT_PPC_TM_CDSCR	0x10e		/* TM checkpointed Data Stream Control Register */
> +
> +/* TEXASR register bits */
> +#define TEXASR_FC	0xFE00000000000000
> +#define TEXASR_FP	0x0100000000000000
> +#define TEXASR_DA	0x0080000000000000
> +#define TEXASR_NO	0x0040000000000000
> +#define TEXASR_FO	0x0020000000000000
> +#define TEXASR_SIC	0x0010000000000000
> +#define TEXASR_NTC	0x0008000000000000
> +#define TEXASR_TC	0x0004000000000000
> +#define TEXASR_TIC	0x0002000000000000
> +#define TEXASR_IC	0x0001000000000000
> +#define TEXASR_IFC	0x0000800000000000
> +#define TEXASR_ABT	0x0000000100000000
> +#define TEXASR_SPD	0x0000000080000000
> +#define TEXASR_HV	0x0000000020000000
> +#define TEXASR_PR	0x0000000010000000
> +#define TEXASR_FS	0x0000000008000000
> +#define TEXASR_TE	0x0000000004000000
> +#define TEXASR_ROT	0x0000000002000000
> +
> +#define TEST_PASS 0
> +#define TEST_FAIL 1
> +
> +struct ebb_regs {
> +	unsigned long	ebbrr;
> +	unsigned long	ebbhr;
> +	unsigned long	bescr;
> +	unsigned long	siar;
> +	unsigned long	sdar;
> +	unsigned long	sier;
> +	unsigned long	mmcr2;
> +	unsigned long	mmcr0;
> +};
> +
> +struct fpr_regs {
> +	unsigned long fpr[32];
> +	unsigned long fpscr;
> +};
> +
> +
> +/* Basic ptrace operations */
> +int start_trace(pid_t child)
> +{
> +	int ret;
> +
> +	ret = ptrace(PTRACE_ATTACH, child, NULL, NULL);
> +	if (ret) {
> +		perror("ptrace(PTRACE_ATTACH) failed");
> +		return TEST_FAIL;
> +	}
> +	ret = waitpid(child, NULL, 0);
> +	if (ret != child) {
> +		perror("waitpid() failed");
> +		return TEST_FAIL;
> +	}
> +	return TEST_PASS;
> +}
> +
> +int stop_trace(pid_t child)
> +{
> +	int ret;
> +
> +	ret = ptrace(PTRACE_DETACH, child, NULL, NULL);
> +	if (ret) {
> +		perror("ptrace(PTRACE_DETACH) failed");
> +		return TEST_FAIL;
> +	}
> +	return TEST_PASS;
> +}
> +
> +int cont_trace(pid_t child)
> +{
> +	int ret;
> +
> +	ret = ptrace(PTRACE_CONT, child, NULL, NULL);
> +	if (ret) {
> +		perror("ptrace(PTRACE_CONT) failed");
> +		return TEST_FAIL;
> +	}
> +	return TEST_PASS;
> +}
> +
> +/* EBB */
> +int show_ebb_registers(pid_t child, struct ebb_regs *regs)
> +{
> +	struct ebb_regs *ebb;
> +	struct iovec iov;
> +	int ret;
> +
> +	ebb = malloc(sizeof(struct ebb_regs));
> +	if (!ebb) {
> +		perror("malloc() failed");
> +		return TEST_FAIL;
> +	}
> +
> +	iov.iov_base = (struct ebb_regs *) ebb;
> +	iov.iov_len = sizeof(struct ebb_regs);
> +	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_EBB, &iov);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		goto fail;
> +	}
> +
> +	if (regs)
> +		memcpy(regs, ebb, sizeof(struct ebb_regs));
> +
> +	free(ebb);
> +	return TEST_PASS;
> +fail:
> +	free(ebb);
> +	return TEST_FAIL;
> +}
> +
> +/* Analyse TEXASR after TM failure */
> +inline unsigned long get_tfiar(void)
> +{
> +	unsigned long ret;
> +
> +	asm volatile("mfspr %0,%1" : "=r" (ret): "i" (SPRN_TFIAR));
> +	return ret;
> +}
> +
> +void analyse_texasr(unsigned long texasr)
> +{
> +	printf("TEXASR: %16lx\t", texasr);
> +
> +	if (texasr & TEXASR_FP)
> +		printf("TEXASR_FP  ");
> +
> +	if (texasr & TEXASR_DA)
> +		printf("TEXASR_DA  ");
> +
> +	if (texasr & TEXASR_NO)
> +		printf("TEXASR_NO  ");
> +
> +	if (texasr & TEXASR_FO)
> +		printf("TEXASR_FO  ");
> +
> +	if (texasr & TEXASR_SIC)
> +		printf("TEXASR_SIC  ");
> +
> +	if (texasr & TEXASR_NTC)
> +		printf("TEXASR_NTC  ");
> +
> +	if (texasr & TEXASR_TC)
> +		printf("TEXASR_TC  ");
> +
> +	if (texasr & TEXASR_TIC)
> +		printf("TEXASR_TIC  ");
> +
> +	if (texasr & TEXASR_IC)
> +		printf("TEXASR_IC  ");
> +
> +	if (texasr & TEXASR_IFC)
> +		printf("TEXASR_IFC  ");
> +
> +	if (texasr & TEXASR_ABT)
> +		printf("TEXASR_ABT  ");
> +
> +	if (texasr & TEXASR_SPD)
> +		printf("TEXASR_SPD  ");
> +
> +	if (texasr & TEXASR_HV)
> +		printf("TEXASR_HV  ");
> +
> +	if (texasr & TEXASR_PR)
> +		printf("TEXASR_PR  ");
> +
> +	if (texasr & TEXASR_FS)
> +		printf("TEXASR_FS  ");
> +
> +	if (texasr & TEXASR_TE)
> +		printf("TEXASR_TE  ");
> +
> +	if (texasr & TEXASR_ROT)
> +		printf("TEXASR_ROT  ");
> +
> +	printf("TFIAR :%lx\n", get_tfiar());
> +}
