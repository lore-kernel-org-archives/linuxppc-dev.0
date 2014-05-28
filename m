Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE2AA1A0678
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 19:27:31 +1000 (EST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7BC3F1400D4
 for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2014 19:27:30 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 28 May 2014 14:57:27 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D54B81258054
 for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2014 14:56:36 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4S9RYJ852297950
 for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2014 14:57:34 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4S9RNQx019490
 for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2014 14:57:23 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] selftests/powerpc: Test the THP bug we fixed in the
 previous commit
In-Reply-To: <1401265278-29307-2-git-send-email-mpe@ellerman.id.au>
References: <1401265278-29307-1-git-send-email-mpe@ellerman.id.au>
 <1401265278-29307-2-git-send-email-mpe@ellerman.id.au>
Date: Wed, 28 May 2014 14:57:23 +0530
Message-ID: <8738fumex0.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: aneesh.kumar@in.ibm.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  tools/testing/selftests/powerpc/Makefile           |  2 +-
>  tools/testing/selftests/powerpc/mm/Makefile        | 18 ++++++
>  .../selftests/powerpc/mm/hugetlb_vs_thp_test.c     | 72 ++++++++++++++++++++++
>  3 files changed, 91 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/mm/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/mm/hugetlb_vs_thp_test.c
>
> diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
> index 316194f..b3dbe9e 100644
> --- a/tools/testing/selftests/powerpc/Makefile
> +++ b/tools/testing/selftests/powerpc/Makefile
> @@ -13,7 +13,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
>  
>  export CC CFLAGS
>  
> -TARGETS = pmu copyloops
> +TARGETS = pmu copyloops mm
>  
>  endif
>  
> diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
> new file mode 100644
> index 0000000..357ccbd
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/mm/Makefile
> @@ -0,0 +1,18 @@
> +noarg:
> +	$(MAKE) -C ../
> +
> +PROGS := hugetlb_vs_thp_test
> +
> +all: $(PROGS)
> +
> +$(PROGS): ../harness.c
> +
> +run_tests: all
> +	@-for PROG in $(PROGS); do \
> +		./$$PROG; \
> +	done;
> +
> +clean:
> +	rm -f $(PROGS)
> +
> +.PHONY: all run_tests clean
> diff --git a/tools/testing/selftests/powerpc/mm/hugetlb_vs_thp_test.c b/tools/testing/selftests/powerpc/mm/hugetlb_vs_thp_test.c
> new file mode 100644
> index 0000000..3d8e5b0
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/mm/hugetlb_vs_thp_test.c
> @@ -0,0 +1,72 @@
> +#include <stdio.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +#include "utils.h"
> +
> +/* This must match the huge page & THP size */
> +#define SIZE	(16 * 1024 * 1024)
> +
> +static int test_body(void)
> +{
> +	void *addr;
> +	char *p;
> +
> +	addr = (void *)0xa0000000;
> +
> +	p = mmap(addr, SIZE, PROT_READ | PROT_WRITE,
> +		 MAP_HUGETLB | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	if (p != MAP_FAILED) {
> +		/*
> +		 * Typically the mmap will fail because no huge pages are
> +		 * allocated on the system. But if there are huge pages
> +		 * allocated the mmap will succeed. That's fine too, we just
> +		 * munmap here before continuing.
> +		 */
> +		munmap(addr, SIZE);
> +	}
> +
> +	p = mmap(addr, SIZE, PROT_READ | PROT_WRITE,
> +		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	if (p == MAP_FAILED) {
> +		printf("Mapping failed @ %p\n", addr);
> +		perror("mmap");
> +		return 1;
> +	}
> +
> +	/*
> +	 * Either a user or kernel access is sufficient to trigger the bug.
> +	 * A kernel access is easier to spot & debug, as it will trigger the
> +	 * softlockup or RCU stall detectors, and when the system is kicked
> +	 * into xmon we get a backtrace in the kernel.
> +	 *
> +	 * A good option is:
> +	 *  getcwd(p, SIZE);
> +	 *
> +	 * For the purposes of this testcase it's preferable to spin in
> +	 * userspace, so the harness can kill us if we get stuck. That way we
> +	 * see a test failure rather than a dead system.
> +	 */
> +	*p = 0xf;
> +
> +	munmap(addr, SIZE);
> +
> +	return 0;
> +}
> +
> +static int test_main(void)
> +{
> +	int i;
> +
> +	/* 10,000 because it's a "bunch", and completes reasonably quickly */
> +	for (i = 0; i < 10000; i++)
> +		if (test_body())
> +			return 1;
> +
> +	return 0;
> +}
> +
> +int main(void)
> +{
> +	return test_harness(test_main, "hugetlb_vs_thp");
> +}
> -- 
> 1.9.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
