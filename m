Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409dTj2lSmzF24J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 04:36:08 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2RHZcZ6129222
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 13:36:05 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gyt4y9etu-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 13:36:05 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 27 Mar 2018 11:36:04 -0600
References: <20180223183344.21038-1-bauerman@linux.vnet.ibm.com>
 <20180223185020.GI5559@ram.oc3035372033.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/powerpc: Add ptrace tests for Protection
 Key registers
In-reply-to: <20180223185020.GI5559@ram.oc3035372033.ibm.com>
Date: Tue, 27 Mar 2018 14:35:55 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87sh8ll8uc.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:

> On Fri, Feb 23, 2018 at 03:33:43PM -0300, Thiago Jung Bauermann wrote:
>> This test exercises read and write access to the AMR, IAMR and UAMOR.
>> 
>
> Tested-by: Ram Pai <linuxram@us.ibm.com>
> Acked-by: Ram Pai <linuxram@us.ibm.com>

Ping? Can this and patch 2/2 go in v4.17?

>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>> ---
>>  tools/testing/selftests/powerpc/include/reg.h      |   1 +
>>  tools/testing/selftests/powerpc/ptrace/Makefile    |   5 +-
>>  tools/testing/selftests/powerpc/ptrace/child.h     | 130 ++++++++
>>  .../testing/selftests/powerpc/ptrace/ptrace-pkey.c | 326 +++++++++++++++++++++
>>  tools/testing/selftests/powerpc/ptrace/ptrace.h    |  37 +++
>>  5 files changed, 498 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/powerpc/ptrace/child.h
>>  create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
>> 
>> diff --git a/tools/testing/selftests/powerpc/include/reg.h b/tools/testing/selftests/powerpc/include/reg.h
>> index 4afdebcce4cd..7f348c059bc2 100644
>> --- a/tools/testing/selftests/powerpc/include/reg.h
>> +++ b/tools/testing/selftests/powerpc/include/reg.h
>> @@ -54,6 +54,7 @@
>>  #define SPRN_DSCR_PRIV 0x11	/* Privilege State DSCR */
>>  #define SPRN_DSCR      0x03	/* Data Stream Control Register */
>>  #define SPRN_PPR       896	/* Program Priority Register */
>> +#define SPRN_AMR       13	/* Authority Mask Register - problem state */
>> 
>>  /* TEXASR register bits */
>>  #define TEXASR_FC	0xFE00000000000000
>> diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
>> index 480305266504..707ba734faf2 100644
>> --- a/tools/testing/selftests/powerpc/ptrace/Makefile
>> +++ b/tools/testing/selftests/powerpc/ptrace/Makefile
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  TEST_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
>>                ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx \
>> -              ptrace-tm-spd-vsx ptrace-tm-spr
>> +              ptrace-tm-spd-vsx ptrace-tm-spr ptrace-pkey
>> 
>>  include ../../lib.mk
>> 
>> @@ -9,6 +9,9 @@ all: $(TEST_PROGS)
>> 
>>  CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm -fno-pie
>> 
>> +ptrace-pkey: ../harness.c ../utils.c ../lib/reg.S ptrace.h child.h ptrace-pkey.c
>> +	$(LINK.c) $^ $(LDLIBS) -pthread -o $@
>> +
>>  $(TEST_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
>> 
>>  clean:
>> diff --git a/tools/testing/selftests/powerpc/ptrace/child.h b/tools/testing/selftests/powerpc/ptrace/child.h
>> new file mode 100644
>> index 000000000000..40c1a6d92111
>> --- /dev/null
>> +++ b/tools/testing/selftests/powerpc/ptrace/child.h
>> @@ -0,0 +1,130 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Helper functions to sync execution between parent and child processes.
>> + *
>> + * Copyright 2018, Thiago Jung Bauermann, IBM Corporation.
>> + */
>> +#include <stdio.h>
>> +#include <stdbool.h>
>> +#include <semaphore.h>
>> +
>> +/*
>> + * Information in a shared memory location for synchronization between child and
>> + * parent.
>> + */
>> +struct child_sync {
>> +	/* The parent waits on this semaphore. */
>> +	sem_t sem_parent;
>> +
>> +	/* If true, the child should give up as well. */
>> +	bool parent_gave_up;
>> +
>> +	/* The child waits on this semaphore. */
>> +	sem_t sem_child;
>> +
>> +	/* If true, the parent should give up as well. */
>> +	bool child_gave_up;
>> +};
>> +
>> +#define CHILD_FAIL_IF(x, sync)						\
>> +	do {								\
>> +		if (x) {						\
>> +			fprintf(stderr,					\
>> +				"[FAIL] Test FAILED on line %d\n", __LINE__); \
>> +			(sync)->child_gave_up = true;			\
>> +			prod_parent(sync);				\
>> +			return 1;					\
>> +		}							\
>> +	} while (0)
>> +
>> +#define PARENT_FAIL_IF(x, sync)						\
>> +	do {								\
>> +		if (x) {						\
>> +			fprintf(stderr,					\
>> +				"[FAIL] Test FAILED on line %d\n", __LINE__); \
>> +			(sync)->parent_gave_up = true;			\
>> +			prod_child(sync);				\
>> +			return 1;					\
>> +		}							\
>> +	} while (0)
>> +
>> +int init_child_sync(struct child_sync *sync)
>> +{
>> +	int ret;
>> +
>> +	ret = sem_init(&sync->sem_parent, 1, 0);
>> +	if (ret) {
>> +		perror("Semaphore initialization failed");
>> +		return 1;
>> +	}
>> +
>> +	ret = sem_init(&sync->sem_child, 1, 0);
>> +	if (ret) {
>> +		perror("Semaphore initialization failed");
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void destroy_child_sync(struct child_sync *sync)
>> +{
>> +	sem_destroy(&sync->sem_parent);
>> +	sem_destroy(&sync->sem_child);
>> +}
>> +
>> +int wait_child(struct child_sync *sync)
>> +{
>> +	int ret;
>> +
>> +	/* Wait until the child prods us. */
>> +	ret = sem_wait(&sync->sem_parent);
>> +	if (ret) {
>> +		perror("Error waiting for child");
>> +		return 1;
>> +	}
>> +
>> +	return sync->child_gave_up;
>> +}
>> +
>> +int prod_child(struct child_sync *sync)
>> +{
>> +	int ret;
>> +
>> +	/* Unblock the child now. */
>> +	ret = sem_post(&sync->sem_child);
>> +	if (ret) {
>> +		perror("Error prodding child");
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int wait_parent(struct child_sync *sync)
>> +{
>> +	int ret;
>> +
>> +	/* Wait until the parent prods us. */
>> +	ret = sem_wait(&sync->sem_child);
>> +	if (ret) {
>> +		perror("Error waiting for parent");
>> +		return 1;
>> +	}
>> +
>> +	return sync->parent_gave_up;
>> +}
>> +
>> +int prod_parent(struct child_sync *sync)
>> +{
>> +	int ret;
>> +
>> +	/* Unblock the parent now. */
>> +	ret = sem_post(&sync->sem_parent);
>> +	if (ret) {
>> +		perror("Error prodding parent");
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
>> new file mode 100644
>> index 000000000000..8332b9338d39
>> --- /dev/null
>> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
>> @@ -0,0 +1,326 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Ptrace test for Memory Protection Key registers
>> + *
>> + * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
>> + * Copyright (C) 2018 IBM Corporation.
>> + */
>> +#include "ptrace.h"
>> +#include "child.h"
>> +
>> +#ifndef __NR_pkey_alloc
>> +#define __NR_pkey_alloc		384
>> +#endif
>> +
>> +#ifndef __NR_pkey_free
>> +#define __NR_pkey_free		385
>> +#endif
>> +
>> +#ifndef NT_PPC_PKEY
>> +#define NT_PPC_PKEY		0x110
>> +#endif
>> +
>> +#ifndef PKEY_DISABLE_EXECUTE
>> +#define PKEY_DISABLE_EXECUTE	0x4
>> +#endif
>> +
>> +#define AMR_BITS_PER_PKEY 2
>> +#define PKEY_REG_BITS (sizeof(u64) * 8)
>> +#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey + 1) * AMR_BITS_PER_PKEY))
>> +
>> +static const char user_read[] = "[User Read (Running)]";
>> +static const char user_write[] = "[User Write (Running)]";
>> +static const char ptrace_read_running[] = "[Ptrace Read (Running)]";
>> +static const char ptrace_write_running[] = "[Ptrace Write (Running)]";
>> +
>> +/* Information shared between the parent and the child. */
>> +struct shared_info {
>> +	struct child_sync child_sync;
>> +
>> +	/* AMR value the parent expects to read from the child. */
>> +	unsigned long amr1;
>> +
>> +	/* AMR value the parent is expected to write to the child. */
>> +	unsigned long amr2;
>> +
>> +	/* AMR value that ptrace should refuse to write to the child. */
>> +	unsigned long amr3;
>> +
>> +	/* IAMR value the parent expects to read from the child. */
>> +	unsigned long expected_iamr;
>> +
>> +	/* UAMOR value the parent expects to read from the child. */
>> +	unsigned long expected_uamor;
>> +
>> +	/*
>> +	 * IAMR and UAMOR values that ptrace should refuse to write to the child
>> +	 * (even though they're valid ones) because userspace doesn't have
>> +	 * access to those registers.
>> +	 */
>> +	unsigned long new_iamr;
>> +	unsigned long new_uamor;
>> +};
>> +
>> +static int sys_pkey_alloc(unsigned long flags, unsigned long init_access_rights)
>> +{
>> +	return syscall(__NR_pkey_alloc, flags, init_access_rights);
>> +}
>> +
>> +static int sys_pkey_free(int pkey)
>> +{
>> +	return syscall(__NR_pkey_free, pkey);
>> +}
>> +
>> +static int child(struct shared_info *info)
>> +{
>> +	unsigned long reg;
>> +	bool disable_execute = true;
>> +	int pkey1, pkey2, pkey3;
>> +	int ret;
>> +
>> +	/* Wait until parent fills out the initial register values. */
>> +	ret = wait_parent(&info->child_sync);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Get some pkeys so that we can change their bits in the AMR. */
>> +	pkey1 = sys_pkey_alloc(0, PKEY_DISABLE_EXECUTE);
>> +	if (pkey1 < 0) {
>> +		pkey1 = sys_pkey_alloc(0, 0);
>> +		CHILD_FAIL_IF(pkey1 < 0, &info->child_sync);
>> +
>> +		disable_execute = false;
>> +	}
>> +
>> +	pkey2 = sys_pkey_alloc(0, 0);
>> +	CHILD_FAIL_IF(pkey2 < 0, &info->child_sync);
>> +
>> +	pkey3 = sys_pkey_alloc(0, 0);
>> +	CHILD_FAIL_IF(pkey3 < 0, &info->child_sync);
>> +
>> +	info->amr1 |= 3ul << pkeyshift(pkey1);
>> +	info->amr2 |= 3ul << pkeyshift(pkey2);
>> +	info->amr3 |= info->amr2 | 3ul << pkeyshift(pkey3);
>> +
>> +	if (disable_execute)
>> +		info->expected_iamr |= 1ul << pkeyshift(pkey1);
>> +
>> +	info->expected_uamor |= 3ul << pkeyshift(pkey1) |
>> +				3ul << pkeyshift(pkey2);
>> +	info->new_iamr |= 1ul << pkeyshift(pkey1) | 1ul << pkeyshift(pkey2);
>> +	info->new_uamor |= 3ul << pkeyshift(pkey1);
>> +
>> +	/*
>> +	 * We won't use pkey3. We just want a plausible but invalid key to test
>> +	 * whether ptrace will let us write to AMR bits we are not supposed to.
>> +	 *
>> +	 * This also tests whether the kernel restores the UAMOR permissions
>> +	 * after a key is freed.
>> +	 */
>> +	sys_pkey_free(pkey3);
>> +
>> +	printf("%-30s AMR: %016lx pkey1: %d pkey2: %d pkey3: %d\n",
>> +	       user_write, info->amr1, pkey1, pkey2, pkey3);
>> +
>> +	mtspr(SPRN_AMR, info->amr1);
>> +
>> +	/* Wait for parent to read our AMR value and write a new one. */
>> +	ret = prod_parent(&info->child_sync);
>> +	CHILD_FAIL_IF(ret, &info->child_sync);
>> +
>> +	ret = wait_parent(&info->child_sync);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reg = mfspr(SPRN_AMR);
>> +
>> +	printf("%-30s AMR: %016lx\n", user_read, reg);
>> +
>> +	CHILD_FAIL_IF(reg != info->amr2, &info->child_sync);
>> +
>> +	/*
>> +	 * Wait for parent to try to write an invalid AMR value.
>> +	 */
>> +	ret = prod_parent(&info->child_sync);
>> +	CHILD_FAIL_IF(ret, &info->child_sync);
>> +
>> +	ret = wait_parent(&info->child_sync);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reg = mfspr(SPRN_AMR);
>> +
>> +	printf("%-30s AMR: %016lx\n", user_read, reg);
>> +
>> +	CHILD_FAIL_IF(reg != info->amr2, &info->child_sync);
>> +
>> +	/*
>> +	 * Wait for parent to try to write an IAMR and a UAMOR value. We can't
>> +	 * verify them, but we can verify that the AMR didn't change.
>> +	 */
>> +	ret = prod_parent(&info->child_sync);
>> +	CHILD_FAIL_IF(ret, &info->child_sync);
>> +
>> +	ret = wait_parent(&info->child_sync);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reg = mfspr(SPRN_AMR);
>> +
>> +	printf("%-30s AMR: %016lx\n", user_read, reg);
>> +
>> +	CHILD_FAIL_IF(reg != info->amr2, &info->child_sync);
>> +
>> +	/* Now let parent now that we are finished. */
>> +
>> +	ret = prod_parent(&info->child_sync);
>> +	CHILD_FAIL_IF(ret, &info->child_sync);
>> +
>> +	return TEST_PASS;
>> +}
>> +
>> +static int parent(struct shared_info *info, pid_t pid)
>> +{
>> +	unsigned long regs[3];
>> +	int ret, status;
>> +
>> +	/*
>> +	 * Get the initial values for AMR, IAMR and UAMOR and communicate them
>> +	 * to the child.
>> +	 */
>> +	ret = ptrace_read_regs(pid, NT_PPC_PKEY, regs, 3);
>> +	PARENT_FAIL_IF(ret, &info->child_sync);
>> +
>> +	info->amr1 = info->amr2 = info->amr3 = regs[0];
>> +	info->expected_iamr = info->new_iamr = regs[1];
>> +	info->expected_uamor = info->new_uamor = regs[2];
>> +
>> +	/* Wake up child so that it can set itself up. */
>> +	ret = prod_child(&info->child_sync);
>> +	PARENT_FAIL_IF(ret, &info->child_sync);
>> +
>> +	ret = wait_child(&info->child_sync);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Verify that we can read the pkey registers from the child. */
>> +	ret = ptrace_read_regs(pid, NT_PPC_PKEY, regs, 3);
>> +	PARENT_FAIL_IF(ret, &info->child_sync);
>> +
>> +	printf("%-30s AMR: %016lx IAMR: %016lx UAMOR: %016lx\n",
>> +	       ptrace_read_running, regs[0], regs[1], regs[2]);
>> +
>> +	PARENT_FAIL_IF(regs[0] != info->amr1, &info->child_sync);
>> +	PARENT_FAIL_IF(regs[1] != info->expected_iamr, &info->child_sync);
>> +	PARENT_FAIL_IF(regs[2] != info->expected_uamor, &info->child_sync);
>> +
>> +	/* Write valid AMR value in child. */
>> +	ret = ptrace_write_regs(pid, NT_PPC_PKEY, &info->amr2, 1);
>> +	PARENT_FAIL_IF(ret, &info->child_sync);
>> +
>> +	printf("%-30s AMR: %016lx\n", ptrace_write_running, info->amr2);
>> +
>> +	/* Wake up child so that it can verify it changed. */
>> +	ret = prod_child(&info->child_sync);
>> +	PARENT_FAIL_IF(ret, &info->child_sync);
>> +
>> +	ret = wait_child(&info->child_sync);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Write invalid AMR value in child. */
>> +	ret = ptrace_write_regs(pid, NT_PPC_PKEY, &info->amr3, 1);
>> +	PARENT_FAIL_IF(ret, &info->child_sync);
>> +
>> +	printf("%-30s AMR: %016lx\n", ptrace_write_running, info->amr3);
>> +
>> +	/* Wake up child so that it can verify it didn't change. */
>> +	ret = prod_child(&info->child_sync);
>> +	PARENT_FAIL_IF(ret, &info->child_sync);
>> +
>> +	ret = wait_child(&info->child_sync);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Try to write to IAMR. */
>> +	regs[0] = info->amr1;
>> +	regs[1] = info->new_iamr;
>> +	ret = ptrace_write_regs(pid, NT_PPC_PKEY, regs, 2);
>> +	PARENT_FAIL_IF(!ret, &info->child_sync);
>> +
>> +	printf("%-30s AMR: %016lx IAMR: %016lx\n",
>> +	       ptrace_write_running, regs[0], regs[1]);
>> +
>> +	/* Try to write to IAMR and UAMOR. */
>> +	regs[2] = info->new_uamor;
>> +	ret = ptrace_write_regs(pid, NT_PPC_PKEY, regs, 3);
>> +	PARENT_FAIL_IF(!ret, &info->child_sync);
>> +
>> +	printf("%-30s AMR: %016lx IAMR: %016lx UAMOR: %016lx\n",
>> +	       ptrace_write_running, regs[0], regs[1], regs[2]);
>> +
>> +	/* Verify that all registers still have their expected values. */
>> +	ret = ptrace_read_regs(pid, NT_PPC_PKEY, regs, 3);
>> +	PARENT_FAIL_IF(ret, &info->child_sync);
>> +
>> +	printf("%-30s AMR: %016lx IAMR: %016lx UAMOR: %016lx\n",
>> +	       ptrace_read_running, regs[0], regs[1], regs[2]);
>> +
>> +	PARENT_FAIL_IF(regs[0] != info->amr2, &info->child_sync);
>> +	PARENT_FAIL_IF(regs[1] != info->expected_iamr, &info->child_sync);
>> +	PARENT_FAIL_IF(regs[2] != info->expected_uamor, &info->child_sync);
>> +
>> +	/* Wake up child so that it can verify AMR didn't change and wrap up. */
>> +	ret = prod_child(&info->child_sync);
>> +	PARENT_FAIL_IF(ret, &info->child_sync);
>> +
>> +	ret = wait(&status);
>> +	if (ret != pid) {
>> +		printf("Child's exit status not captured\n");
>> +		ret = TEST_PASS;
>> +	} else if (!WIFEXITED(status)) {
>> +		printf("Child exited abnormally\n");
>> +		ret = TEST_FAIL;
>> +	} else
>> +		ret = WEXITSTATUS(status) ? TEST_FAIL : TEST_PASS;
>> +
>> +	return ret;
>> +}
>> +
>> +static int ptrace_pkey(void)
>> +{
>> +	struct shared_info *info;
>> +	int shm_id;
>> +	int ret;
>> +	pid_t pid;
>> +
>> +	shm_id = shmget(IPC_PRIVATE, sizeof(*info), 0777 | IPC_CREAT);
>> +	info = shmat(shm_id, NULL, 0);
>> +
>> +	ret = init_child_sync(&info->child_sync);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pid = fork();
>> +	if (pid < 0) {
>> +		perror("fork() failed");
>> +		ret = TEST_FAIL;
>> +	} else if (pid == 0)
>> +		ret = child(info);
>> +	else
>> +		ret = parent(info, pid);
>> +
>> +	shmdt(info);
>> +
>> +	if (pid) {
>> +		destroy_child_sync(&info->child_sync);
>> +		shmctl(shm_id, IPC_RMID, NULL);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	return test_harness(ptrace_pkey, "ptrace_pkey");
>> +}
>> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.h b/tools/testing/selftests/powerpc/ptrace/ptrace.h
>> index 19fb825270a1..d2c9c4c2b5ee 100644
>> --- a/tools/testing/selftests/powerpc/ptrace/ptrace.h
>> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
>> @@ -102,6 +102,43 @@ int cont_trace(pid_t child)
>>  	return TEST_PASS;
>>  }
>> 
>> +int ptrace_read_regs(pid_t child, unsigned long type, unsigned long regs[],
>> +		     int n)
>> +{
>> +	struct iovec iov;
>> +	long ret;
>> +
>> +	FAIL_IF(start_trace(child));
>> +
>> +	iov.iov_base = regs;
>> +	iov.iov_len = n * sizeof(unsigned long);
>> +
>> +	ret = ptrace(PTRACE_GETREGSET, child, type, &iov);
>> +	FAIL_IF(ret != 0);
>> +
>> +	FAIL_IF(stop_trace(child));
>> +
>> +	return TEST_PASS;
>> +}
>> +
>> +long ptrace_write_regs(pid_t child, unsigned long type, unsigned long regs[],
>> +		       int n)
>> +{
>> +	struct iovec iov;
>> +	long ret;
>> +
>> +	FAIL_IF(start_trace(child));
>> +
>> +	iov.iov_base = regs;
>> +	iov.iov_len = n * sizeof(unsigned long);
>> +
>> +	ret = ptrace(PTRACE_SETREGSET, child, type, &iov);
>> +
>> +	FAIL_IF(stop_trace(child));
>> +
>> +	return ret;
>> +}
>> +
>>  /* TAR, PPR, DSCR */
>>  int show_tar_registers(pid_t child, unsigned long *out)
>>  {


-- 
Thiago Jung Bauermann
IBM Linux Technology Center
