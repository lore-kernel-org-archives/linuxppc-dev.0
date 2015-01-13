Return-Path: <shuahkh@osg.samsung.com>
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by lists.ozlabs.org (Postfix) with ESMTP id 2775A1A0EB9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 02:24:49 +1100 (AEDT)
Message-ID: <54B538BF.5040803@osg.samsung.com>
Date: Tue, 13 Jan 2015 08:24:47 -0700
From: Shuah Khan <shuahkh@osg.samsung.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 12/12] selftests, powerpc: Add thread based stress
 test for DSCR sysfs interfaces
References: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1421144560-15901-13-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1421144560-15901-13-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2015 03:22 AM, Anshuman Khandual wrote:
> This patch adds a test to update the system wide DSCR value repeatedly
> and then verifies that any thread on any given CPU on the system must
> be able to see the same DSCR value whether its is being read through
> the problem state based SPR or the privilege state based SPR.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/powerpc/dscr/Makefile      |   2 +-
>  .../powerpc/dscr/dscr_sysfs_thread_test.c          | 114 +++++++++++++++++++++
>  2 files changed, 115 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
> 
> diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
> index fada526..834ef88 100644
> --- a/tools/testing/selftests/powerpc/dscr/Makefile
> +++ b/tools/testing/selftests/powerpc/dscr/Makefile
> @@ -1,6 +1,6 @@
>  PROGS := dscr_default_test dscr_explicit_test dscr_user_test	\
>  	 dscr_inherit_test dscr_inherit_exec_test		\
> -	 dscr_sysfs_test
> +	 dscr_sysfs_test dscr_sysfs_thread_test
>  
>  CFLAGS := $(CFLAGS) -lpthread
>  
> diff --git a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
> new file mode 100644
> index 0000000..95a4304
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
> @@ -0,0 +1,114 @@
> +/*
> + * POWER Data Stream Control Register (DSCR) sysfs thread test
> + *
> + * This test updates the system wide DSCR default value through
> + * sysfs interface which should then update all the CPU specific
> + * DSCR default values which must also be then visible to threads
> + * executing on individual CPUs on the system.
> + *
> + * Copyright (C) 2015 Anshuman Khandual <khandual@linux.vnet.ibm.com>, IBM
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#define _GNU_SOURCE
> +#include "dscr.h"
> +
> +static pthread_mutex_t lock;	/* Pthread lock */
> +static cpu_set_t cpuset;	/* Thread cpu set */
> +static int target;		/* Thread target cpu */
> +static unsigned long *result;	/* Thread exit status array */
> +
> +static void *test_thread_dscr(void *in)
> +{
> +	unsigned long cur_dscr, cur_dscr_usr;
> +	unsigned long val = (unsigned long)in;
> +
> +	pthread_mutex_lock(&lock);
> +	target++;
> +	if (target == sysconf(_SC_NPROCESSORS_ONLN))
> +		target =  0;
> +	CPU_ZERO(&cpuset);
> +	CPU_SET(target, &cpuset);
> +
> +	if (sched_setaffinity(0, sizeof(cpuset), &cpuset)) {
> +		perror("sched_settarget_cpu() failed\n");
> +		pthread_mutex_unlock(&lock);
> +		result[target] = 1;
> +		pthread_exit(&result[target]);
> +	}
> +	pthread_mutex_unlock(&lock);
> +
> +	cur_dscr = get_dscr();
> +	cur_dscr_usr = get_dscr_usr();
> +
> +	if (val != cur_dscr) {
> +		printf("[cpu %d] Kernel DSCR should be %ld but is %ld\n",
> +					sched_getcpu(), val, cur_dscr);
> +		result[target] = 1;
> +		pthread_exit(&result[target]);
> +	}
> +
> +	if (val != cur_dscr_usr) {
> +		printf("[cpu %d] User DSCR should be %ld but is %ld\n",
> +					sched_getcpu(), val, cur_dscr_usr);
> +		result[target] = 1;
> +		pthread_exit(&result[target]);
> +	}
> +	result[target] = 0;
> +	pthread_exit(&result[target]);
> +}
> +
> +static int check_cpu_dscr_thread(unsigned long val)
> +{
> +	pthread_t threads[sysconf(_SC_NPROCESSORS_ONLN)];
> +	unsigned long *status[sysconf(_SC_NPROCESSORS_ONLN)];
> +	unsigned long i;
> +
> +	for (i = 0; i < sysconf(_SC_NPROCESSORS_ONLN); i++) {
> +		if (pthread_create(&threads[i], NULL,
> +				test_thread_dscr, (void *)val)) {
> +			perror("pthread_create() failed\n");
> +			return 1;
> +		}
> +	}
> +
> +	for (i = 0; i < sysconf(_SC_NPROCESSORS_ONLN); i++) {
> +		if (pthread_join(threads[i], (void **)&(status[i]))) {
> +			perror("pthread_join() failed\n");
> +			return 1;
> +		}
> +
> +		if (*status[i]) {
> +			printf(" %ldth thread join failed with %ld\n",
> +							i, *status[i]);
> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +int test_body(void)
> +{
> +	int i, j;
> +
> +	result = malloc(sizeof(unsigned long) * sysconf(_SC_NPROCESSORS_ONLN));
> +	pthread_mutex_init(&lock, NULL);
> +	target = 0;
> +	for (i = 0; i < COUNT; i++) {
> +		for (j = 0; j < DSCR_MAX; j++) {
> +			set_default_dscr(j);
> +			if (check_cpu_dscr_thread(j))
> +				return 1;
> +		}
> +	}
> +	free(result);
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(test_body, "dscr_sysfs_thread_test");
> +}
> 

Could you please add a .gitignore for powerpc targets as we
discussed earlier. It can be separate patch.

Also, I would like to see the test results reports using
kselftest.h - it can be separate patch in the interest of
getting tests in.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

Please take this through powerpc maintainer git.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
