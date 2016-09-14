Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYq1v6kqDzDsWc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 14:53:39 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id vz6so183971pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 21:53:39 -0700 (PDT)
Message-ID: <1473828811.2554.12.camel@gmail.com>
Subject: Re: [PATCH v14 07/15] selftests/powerpc: Add ptrace tests for TAR,
 PPR, DSCR registers
From: Cyril Bur <cyrilbur@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc: Shuah Khan <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Chris Smart <chris@distroguy.com>, Suraj Jitindar Singh
 <sjitindarsingh@gmail.com>, Michael Neuling <mikey@neuling.org>, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>, Jack Miller <jack@codezen.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Wed, 14 Sep 2016 14:53:31 +1000
In-Reply-To: <1473665605-11890-8-git-send-email-wei.guo.simon@gmail.com>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
 <1473665605-11890-8-git-send-email-wei.guo.simon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-09-12 at 15:33 +0800, wei.guo.simon@gmail.com wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> This patch adds ptrace interface test for TAR, PPR, DSCR
> registers. This also adds ptrace interface based helper
> functions related to TAR, PPR, DSCR register access.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
>  .../testing/selftests/powerpc/ptrace/ptrace-tar.c  | 159
> ++++++++++++++++++
>  .../testing/selftests/powerpc/ptrace/ptrace-tar.h  |  50 ++++++
>  tools/testing/selftests/powerpc/ptrace/ptrace.h    | 181
> +++++++++++++++++++++
>  4 files changed, 392 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-
> tar.c
>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-
> tar.h
> 

[snip]

> +
> +void tar(void)
> +{
> +	unsigned long reg[3];
> +	int ret;
> +
> +	cptr = (int *)shmat(shm_id, NULL, 0);
> +	printf("%-30s TAR: %u PPR: %lx DSCR: %u\n",
> +			user_write, TAR_1, PPR_1, DSCR_1);
> +
> +	mtspr(SPRN_TAR, TAR_1);
> +	mtspr(SPRN_PPR, PPR_1);
> +	mtspr(SPRN_DSCR, DSCR_1);
> +
> +	cptr[2] = 1;
> +
> +	/* Wait on parent */
> +	while (!cptr[0]);
		asm volatile("" ::: "memory");

> +
> +	reg[0] = mfspr(SPRN_TAR);
> +	reg[1] = mfspr(SPRN_PPR);
> +	reg[2] = mfspr(SPRN_DSCR);
> +
> +	printf("%-30s TAR: %lu PPR: %lx DSCR: %lu\n",
> +			user_read, reg[0], reg[1], reg[2]);
> +
> +	/* Unblock the parent now */
> +	cptr[1] = 1;
> +	shmdt((int *)cptr);
> +
> +	ret = validate_tar_registers(reg, TAR_2, PPR_2, DSCR_2);
> +	if (ret)
> +		exit(1);
> +	exit(0);
> +}
> +
> +int trace_tar(pid_t child)
> +{
> +	unsigned long reg[3];
> +	int ret;
> +
> +	ret = start_trace(child);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = show_tar_registers(child, reg);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	printf("%-30s TAR: %lu PPR: %lx DSCR: %lu\n",
> +			ptrace_read_running, reg[0], reg[1],
> reg[2]);
> +
> +	ret = validate_tar_registers(reg, TAR_1, PPR_1, DSCR_1);
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
> +int trace_tar_write(pid_t child)
> +{
> +	int ret;
> +
> +	ret = start_trace(child);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	ret = write_tar_registers(child, TAR_2, PPR_2, DSCR_2);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	printf("%-30s TAR: %u PPR: %lx DSCR: %u\n",
> +			ptrace_write_running, TAR_2, PPR_2, DSCR_2);
> +
> +	ret = stop_trace(child);
> +	if (ret)
> +		return TEST_FAIL;
> +
> +	return TEST_PASS;
> +}

More comments about calling TEST_FAIL(x)

> +
> +int ptrace_tar(void)
> +{
> +	pid_t pid;
> +	int ret, status;
> +
> +	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 3,
> 0777|IPC_CREAT);
> +	pid = fork();
> +	if (pid < 0) {
> +		perror("fork() failed");
> +		return TEST_FAIL;
> +	}
> +
> +	if (pid == 0)
> +		tar();
> +
> +	if (pid) {
> 

[snip]
