Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A85A1A06C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 11:40:14 +1100 (AEDT)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6BE591401B5
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 11:40:13 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id w128so11799345pfb.2
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Mar 2016 16:40:13 -0800 (PST)
Date: Wed, 2 Mar 2016 11:40:01 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V10 18/28] selftests, powerpc: Add ptrace tests for
 GPR/FPR registers
Message-ID: <20160302114001.64f8adbb@camb691>
In-Reply-To: <1455613198-5113-19-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455613198-5113-19-git-send-email-khandual@linux.vnet.ibm.com>
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

On Tue, 16 Feb 2016 14:29:48 +0530
Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> This patch adds ptrace interface test for GPR/FPR registers.
> This adds ptrace interface based helper functions related to
> GPR/FPR access and some assembly helper functions related to
> GPR/FPR registers.
> 

I wonder if with a bit of thought we could share our assembly helper
functions... https://patchwork.ozlabs.org/patch/589703/

Let me know, happy to meet in the middle and augment my series if needed.

Thanks,

Cyril

> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
>  .../testing/selftests/powerpc/ptrace/ptrace-gpr.c  | 191 +++++++++++++++++++
>  .../testing/selftests/powerpc/ptrace/ptrace-gpr.h  |  73 ++++++++
>  tools/testing/selftests/powerpc/ptrace/ptrace.S    | 131 +++++++++++++
>  tools/testing/selftests/powerpc/ptrace/ptrace.h    | 208 +++++++++++++++++++++
>  5 files changed, 605 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-gpr.h
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.S
> 
> diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
> index 8666ac0..f5f62d0 100644
> --- a/tools/testing/selftests/powerpc/ptrace/Makefile
> +++ b/tools/testing/selftests/powerpc/ptrace/Makefile
> @@ -1,4 +1,5 @@
> -TEST_PROGS := ptrace-ebb
> +TEST_PROGS := ptrace-ebb ptrace-gpr
> +
>  all: $(TEST_PROGS)
>  
>  $(TEST_PROGS): ../harness.c ptrace.S ../utils.c
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c
> new file mode 100644
> index 0000000..f84f0e4
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-gpr.c
> @@ -0,0 +1,191 @@
> +/*
> + * Ptrace test for GPR/FPR registers
> + *
> + * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include "ptrace.h"
> +#include "ptrace-gpr.h"
> +
> +/* Tracer and Tracee Shared Data */
> +int shm_id;
> +volatile int *cptr, *pptr;
> +
> +extern void store_gpr(unsigned long *addr);
> +extern void store_fpr(float *addr);
> +
> +float a = FPR_1;
> +float b = FPR_2;
> +float c = FPR_3;
> +
> +void gpr(void)
> +{
> +	unsigned long gpr_buf[18];
> +	float fpr_buf[32];
> +
> +	cptr = (int *)shmat(shm_id, NULL, 0);
> +
> +	asm __volatile__(
> +		"li 14, %[gpr_1];"
> +		"li 15, %[gpr_1];"
> +		"li 16, %[gpr_1];"
> +		"li 17, %[gpr_1];"
> +		"li 18, %[gpr_1];"
> +		"li 19, %[gpr_1];"
> +		"li 20, %[gpr_1];"
> +		"li 21, %[gpr_1];"
> +		"li 22, %[gpr_1];"
> +		"li 23, %[gpr_1];"
> +		"li 24, %[gpr_1];"
> +		"li 25, %[gpr_1];"
> +		"li 26, %[gpr_1];"
> +		"li 27, %[gpr_1];"
> +		"li 28, %[gpr_1];"
> +		"li 29, %[gpr_1];"
> +		"li 30, %[gpr_1];"
> +		"li 31, %[gpr_1];"
> +
> +		"lfs 0, 0(%[flt_1]);"
> +		"lfs 1, 0(%[flt_1]);"
> +		"lfs 2, 0(%[flt_1]);"
> +		"lfs 3, 0(%[flt_1]);"
> +		"lfs 4, 0(%[flt_1]);"
> +		"lfs 5, 0(%[flt_1]);"
> +		"lfs 6, 0(%[flt_1]);"
> +		"lfs 7, 0(%[flt_1]);"
> +		"lfs 8, 0(%[flt_1]);"
> +		"lfs 9, 0(%[flt_1]);"
> +		"lfs 10, 0(%[flt_1]);"
> +		"lfs 11, 0(%[flt_1]);"
> +		"lfs 12, 0(%[flt_1]);"
> +		"lfs 13, 0(%[flt_1]);"
> +		"lfs 14, 0(%[flt_1]);"
> +		"lfs 15, 0(%[flt_1]);"
> +		"lfs 16, 0(%[flt_1]);"
> +		"lfs 17, 0(%[flt_1]);"
> +		"lfs 18, 0(%[flt_1]);"
> +		"lfs 19, 0(%[flt_1]);"
> +		"lfs 20, 0(%[flt_1]);"
> +		"lfs 21, 0(%[flt_1]);"
> +		"lfs 22, 0(%[flt_1]);"
> +		"lfs 23, 0(%[flt_1]);"
> +		"lfs 24, 0(%[flt_1]);"
> +		"lfs 25, 0(%[flt_1]);"
> +		"lfs 26, 0(%[flt_1]);"
> +		"lfs 27, 0(%[flt_1]);"
> +		"lfs 28, 0(%[flt_1]);"
> +		"lfs 29, 0(%[flt_1]);"
> +		"lfs 30, 0(%[flt_1]);"
> +		"lfs 31, 0(%[flt_1]);"
> +
> +		:
> +		:[gpr_1]"i"(GPR_1), [flt_1] "r" (&a)
> +		: "memory", "r6", "r7", "r8", "r9", "r10",
> +		"r11", "r12", "r13", "r14", "r15", "r16", "r17", "r18", "r19", "r20",
> +		"r21", "r22", "r23", "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31"
> +		);
> +
> +	while(!cptr[0]);
> +
> +	store_gpr(gpr_buf);
> +	store_fpr(fpr_buf);
> +
> +	if (validate_gpr(gpr_buf, GPR_3))
> +		exit(1);
> +
> +	if (validate_fpr_float(fpr_buf, c))
> +		exit(1);
> +
> +	exit(0);
> +}
> +
> +int trace_gpr(pid_t child)
> +{
> +	unsigned long gpr[18];
> +	unsigned long fpr[32];
> +	int ret;
> +
> +	sleep(1);
> +	ret = start_trace(child);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = show_gpr(child, gpr);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = validate_gpr(gpr, GPR_1);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = show_fpr(child, fpr);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = validate_fpr(fpr, FPR_1_REP);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = write_gpr(child, GPR_3);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = write_fpr(child, FPR_3_REP);
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
> +int ptrace_gpr(void)
> +{
> +	pid_t pid;
> +	int ret, status;
> +
> +	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 1, 0777|IPC_CREAT);
> +	pid = fork();
> +	if (pid < 0) {
> +		perror("fork() failed");
> +		return TEST_FAIL;
> +	}
> +	if (pid == 0)
> +		gpr();
> +
> +	if (pid) {
> +		pptr = (int *)shmat(shm_id, NULL, 0);
> +		ret = trace_gpr(pid);
> +		if (ret) {
> +			kill(pid, SIGTERM);
> +			return TEST_FAIL;
> +		}
> +
> +		pptr[0] = 1;
> +		shmdt((void *)pptr);
> +
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
> +	return test_harness(ptrace_gpr, "ptrace_gpr");
> +}
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-gpr.h b/tools/testing/selftests/powerpc/ptrace/ptrace-gpr.h
> new file mode 100644
> index 0000000..6d49f1f
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-gpr.h
> @@ -0,0 +1,73 @@
> +/*
> + * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#define GPR_1	1
> +#define GPR_2	2
> +#define GPR_3	3
> +#define GPR_4	4
> +
> +#define FPR_1	0.001
> +#define FPR_2	0.002
> +#define FPR_3	0.003
> +#define FPR_4	0.004
> +
> +#define FPR_1_REP 0x3f50624de0000000
> +#define FPR_2_REP 0x3f60624de0000000
> +#define FPR_3_REP 0x3f689374c0000000
> +#define FPR_4_REP 0x3f70624de0000000
> +
> +/* Buffer must have 18 elements */
> +int validate_gpr(unsigned long *gpr, unsigned long val)
> +{
> +	int i, found = 1;
> +
> +	for (i = 0; i < 18; i++) {
> +		if (gpr[i] != val) {
> +			printf("GPR[%d]: %lx Expected: %lx\n", i+14, gpr[i], val);
> +			found = 0;
> +		}
> +	}
> +
> +	if (!found)
> +		return TEST_FAIL;
> +	return TEST_PASS;
> +}
> +
> +/* Buffer must have 32 elements */
> +int validate_fpr(unsigned long *fpr, unsigned long val)
> +{
> +	int i, found = 1;
> +
> +	for (i = 0; i < 32; i++) {
> +		if (fpr[i] != val) {
> +			printf("FPR[%d]: %lx Expected: %lx\n", i, fpr[i], val);
> +			found = 0;
> +		}
> +	}
> +
> +	if (!found)
> +		return TEST_FAIL;
> +	return TEST_PASS;
> +}
> +
> +/* Buffer must have 32 elements */
> +int validate_fpr_float(float *fpr, float val)
> +{
> +	int i, found = 1;
> +
> +	for (i = 0; i < 32; i++) {
> +		if (fpr[i] != val) {
> +			printf("FPR[%d]: %f Expected: %f\n", i, fpr[i], val);
> +			found = 0;
> +		}
> +	}
> +
> +	if (!found)
> +		return TEST_FAIL;
> +	return TEST_PASS;
> +}
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.S b/tools/testing/selftests/powerpc/ptrace/ptrace.S
> new file mode 100644
> index 0000000..193beea
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace.S
> @@ -0,0 +1,131 @@
> +/*
> + * Ptrace interface test helper assembly functions
> + *
> + * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#include <ppc-asm.h>
> +#include "../reg.h"
> +
> +
> +/* Non volatile GPR - unsigned long buf[18] */
> +FUNC_START(load_gpr)
> +	ld	14, 0*8(3)
> +	ld	15, 1*8(3)
> +	ld	16, 2*8(3)
> +	ld	17, 3*8(3)
> +	ld	18, 4*8(3)
> +	ld	19, 5*8(3)
> +	ld	20, 6*8(3)
> +	ld	21, 7*8(3)
> +	ld	22, 8*8(3)
> +	ld	23, 9*8(3)
> +	ld	24, 10*8(3)
> +	ld	25, 11*8(3)
> +	ld	26, 12*8(3)
> +	ld	27, 13*8(3)
> +	ld	28, 14*8(3)
> +	ld	29, 15*8(3)
> +	ld	30, 16*8(3)
> +	ld	31, 17*8(3)
> +	blr
> +FUNC_END(load_gpr)
> +
> +FUNC_START(store_gpr)
> +	std	14, 0*8(3)
> +	std	15, 1*8(3)
> +	std	16, 2*8(3)
> +	std	17, 3*8(3)
> +	std	18, 4*8(3)
> +	std	19, 5*8(3)
> +	std	20, 6*8(3)
> +	std	21, 7*8(3)
> +	std	22, 8*8(3)
> +	std	23, 9*8(3)
> +	std	24, 10*8(3)
> +	std	25, 11*8(3)
> +	std	26, 12*8(3)
> +	std	27, 13*8(3)
> +	std	28, 14*8(3)
> +	std	29, 15*8(3)
> +	std	30, 16*8(3)
> +	std	31, 17*8(3)
> +	blr
> +FUNC_END(store_gpr)
> +
> +/* Single Precision Float - float buf[32] */
> +FUNC_START(load_fpr)
> +	lfs 0, 0*4(3)
> +	lfs 1, 1*4(3)
> +	lfs 2, 2*4(3)
> +	lfs 3, 3*4(3)
> +	lfs 4, 4*4(3)
> +	lfs 5, 5*4(3)
> +	lfs 6, 6*4(3)
> +	lfs 7, 7*4(3)
> +	lfs 8, 8*4(3)
> +	lfs 9, 9*4(3)
> +	lfs 10, 10*4(3)
> +	lfs 11, 11*4(3)
> +	lfs 12, 12*4(3)
> +	lfs 13, 13*4(3)
> +	lfs 14, 14*4(3)
> +	lfs 15, 15*4(3)
> +	lfs 16, 16*4(3)
> +	lfs 17, 17*4(3)
> +	lfs 18, 18*4(3)
> +	lfs 19, 19*4(3)
> +	lfs 20, 20*4(3)
> +	lfs 21, 21*4(3)
> +	lfs 22, 22*4(3)
> +	lfs 23, 23*4(3)
> +	lfs 24, 24*4(3)
> +	lfs 25, 25*4(3)
> +	lfs 26, 26*4(3)
> +	lfs 27, 27*4(3)
> +	lfs 28, 28*4(3)
> +	lfs 29, 29*4(3)
> +	lfs 30, 30*4(3)
> +	lfs 31, 31*4(3)
> +	blr
> +FUNC_END(load_fpr)
> +
> +FUNC_START(store_fpr)
> +	stfs 0, 0*4(3)
> +	stfs 1, 1*4(3)
> +	stfs 2, 2*4(3)
> +	stfs 3, 3*4(3)
> +	stfs 4, 4*4(3)
> +	stfs 5, 5*4(3)
> +	stfs 6, 6*4(3)
> +	stfs 7, 7*4(3)
> +	stfs 8, 8*4(3)
> +	stfs 9, 9*4(3)
> +	stfs 10, 10*4(3)
> +	stfs 11, 11*4(3)
> +	stfs 12, 12*4(3)
> +	stfs 13, 13*4(3)
> +	stfs 14, 14*4(3)
> +	stfs 15, 15*4(3)
> +	stfs 16, 16*4(3)
> +	stfs 17, 17*4(3)
> +	stfs 18, 18*4(3)
> +	stfs 19, 19*4(3)
> +	stfs 20, 20*4(3)
> +	stfs 21, 21*4(3)
> +	stfs 22, 22*4(3)
> +	stfs 23, 23*4(3)
> +	stfs 24, 24*4(3)
> +	stfs 25, 25*4(3)
> +	stfs 26, 26*4(3)
> +	stfs 27, 27*4(3)
> +	stfs 28, 28*4(3)
> +	stfs 29, 29*4(3)
> +	stfs 30, 30*4(3)
> +	stfs 31, 31*4(3)
> +	blr
> +FUNC_END(store_fpr)
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.h b/tools/testing/selftests/powerpc/ptrace/ptrace.h
> index 44256d2..439fb65 100644
> --- a/tools/testing/selftests/powerpc/ptrace/ptrace.h
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
> @@ -157,6 +157,214 @@ fail:
>  	return TEST_FAIL;
>  }
>  
> +/* FPR */
> +int show_fpr(pid_t child, unsigned long *fpr)
> +{
> +	struct fpr_regs *regs;
> +	int ret, i;
> +
> +	regs = (struct fpr_regs *) malloc(sizeof(struct fpr_regs));
> +	ret = ptrace(PTRACE_GETFPREGS, child, NULL, regs);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +
> +	if (fpr) {
> +		for (i = 0; i < 32; i++)
> +			fpr[i] = regs->fpr[i];
> +	}
> +	return TEST_PASS;
> +}
> +
> +int write_fpr(pid_t child, unsigned long val)
> +{
> +	struct fpr_regs *regs;
> +	int ret, i;
> +
> +	regs = (struct fpr_regs *) malloc(sizeof(struct fpr_regs));
> +	ret = ptrace(PTRACE_GETFPREGS, child, NULL, regs);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +
> +	for (i = 0; i < 32; i++)
> +		regs->fpr[i] = val;
> +
> +	ret = ptrace(PTRACE_SETFPREGS, child, NULL, regs);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +	return TEST_PASS;
> +}
> +
> +int show_ckpt_fpr(pid_t child, unsigned long *fpr)
> +{
> +	struct fpr_regs *regs;
> +	struct iovec iov;
> +	int ret, i;
> +
> +	regs = (struct fpr_regs *) malloc(sizeof(struct fpr_regs));
> +	iov.iov_base = regs;
> +	iov.iov_len = sizeof(struct fpr_regs);
> +
> +	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_CFPR, &iov);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +
> +	if (fpr) {
> +		for (i = 0; i < 32; i++)
> +			fpr[i] = regs->fpr[i];
> +	}
> +
> +	return TEST_PASS;
> +}
> +
> +int write_ckpt_fpr(pid_t child, unsigned long val)
> +{
> +	struct fpr_regs *regs;
> +	struct iovec iov;
> +	int ret, i;
> +
> +	regs = (struct fpr_regs *) malloc(sizeof(struct fpr_regs));
> +	iov.iov_base = regs;
> +	iov.iov_len = sizeof(struct fpr_regs);
> +
> +	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_CFPR, &iov);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +
> +	for (i = 0; i < 32; i++)
> +		regs->fpr[i] = val;
> +
> +	ret = ptrace(PTRACE_SETREGSET, child, NT_PPC_TM_CFPR, &iov);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +	return TEST_PASS;
> +}
> +
> +/* GPR */
> +int show_gpr(pid_t child, unsigned long *gpr)
> +{
> +	struct pt_regs *regs;
> +	int ret, i;
> +
> +	regs = (struct pt_regs *) malloc(sizeof(struct pt_regs));
> +	if (!regs) {
> +		perror("malloc() failed");
> +		return TEST_FAIL;
> +	}
> +
> +	ret = ptrace(PTRACE_GETREGS, child, NULL, regs);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +
> +	if (gpr) {
> +		for (i = 14; i < 32; i++)
> +			gpr[i-14] = regs->gpr[i];
> +	}
> +
> +	return TEST_PASS;
> +}
> +
> +int write_gpr(pid_t child, unsigned long val)
> +{
> +	struct pt_regs *regs;
> +	int i, ret;
> +
> +	regs = (struct pt_regs *) malloc(sizeof(struct pt_regs));
> +	if (!regs) {
> +		perror("malloc() failed");
> +		return TEST_FAIL;
> +	}
> +
> +	ret = ptrace(PTRACE_GETREGS, child, NULL, regs);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +
> +	for (i = 14; i < 32; i++)
> +		regs->gpr[i] = val;
> +
> +	ret = ptrace(PTRACE_SETREGS, child, NULL, regs);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +	return TEST_PASS;
> +}
> +
> +int show_ckpt_gpr(pid_t child, unsigned long *gpr)
> +{
> +	struct pt_regs *regs;
> +	struct iovec iov;
> +	int ret, i;
> +
> +	regs = (struct pt_regs *) malloc(sizeof(struct pt_regs));
> +	if (!regs) {
> +		perror("malloc() failed");
> +		return TEST_FAIL;
> +	}
> +
> +	iov.iov_base = (u64 *) regs;
> +	iov.iov_len = sizeof(struct pt_regs);
> +
> +	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_CGPR, &iov);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +
> +	if (gpr) {
> +		for (i = 14; i < 32; i++)
> +			gpr[i-14] = regs->gpr[i];
> +	}
> +
> +	return TEST_PASS;
> +}
> +
> +int write_ckpt_gpr(pid_t child, unsigned long val)
> +{
> +	struct pt_regs *regs;
> +	struct iovec iov;
> +	int ret, i;
> +
> +	regs = (struct pt_regs *) malloc(sizeof(struct pt_regs));
> +	if (!regs) {
> +		perror("malloc() failed\n");
> +		return TEST_FAIL;
> +	}
> +	iov.iov_base = (u64 *) regs;
> +	iov.iov_len = sizeof(struct pt_regs);
> +
> +	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_CGPR, &iov);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +
> +	for (i = 14; i < 32; i++)
> +		regs->gpr[i] = val;
> +
> +	ret = ptrace(PTRACE_SETREGSET, child, NT_PPC_TM_CGPR, &iov);
> +	if (ret) {
> +		perror("ptrace(PTRACE_GETREGSET) failed");
> +		return TEST_FAIL;
> +	}
> +	return TEST_PASS;
> +}
> +
>  /* Analyse TEXASR after TM failure */
>  inline unsigned long get_tfiar(void)
>  {
