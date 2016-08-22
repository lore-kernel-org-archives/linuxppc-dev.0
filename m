Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJ8YD55znzDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 09:14:56 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h186so7077641pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 16:14:56 -0700 (PDT)
Message-ID: <1471907688.758.1.camel@gmail.com>
Subject: Re: [PATCH] selftest/powerpc: Add test for sigreturn in transaction
From: Cyril Bur <cyrilbur@gmail.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: wei.guo.simon@gmail.com
Date: Tue, 23 Aug 2016 09:14:48 +1000
In-Reply-To: <1471884782-20403-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1471884782-20403-1-git-send-email-ldufour@linux.vnet.ibm.com>
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

On Mon, 2016-08-22 at 18:53 +0200, Laurent Dufour wrote:
> Ensure that kernel is throwing away the suspended transaction when
> sigreturn() is called otherwise it if fails to restore the signal
> frame's TM SPRS.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> ---
>  tools/testing/selftests/powerpc/tm/Makefile       |  2 +-
>  tools/testing/selftests/powerpc/tm/tm-sigreturn.c | 89
> +++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/tm/tm-sigreturn.c
> 
> diff --git a/tools/testing/selftests/powerpc/tm/Makefile
> b/tools/testing/selftests/powerpc/tm/Makefile
> index 9d301d785d9e..5e0396d79c8a 100644
> --- a/tools/testing/selftests/powerpc/tm/Makefile
> +++ b/tools/testing/selftests/powerpc/tm/Makefile
> @@ -1,5 +1,5 @@
>  TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-
> signal-stack \
> -	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-exec tm-execed
> +	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-exec tm-execed tm-
> sigreturn
>  
>  all: $(TEST_PROGS)
>  
> diff --git a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
> b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
> new file mode 100644
> index 000000000000..43fa83de23a5
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
> @@ -0,0 +1,89 @@
> +/*
> + * Copyright 2015, Laurent Dufour, IBM Corp.
> + * Licensed under GPLv2.
> + *
> + * Test the kernel's signal returning code to check reclaim is done
> if
> + * the sigreturn() is called while in a transaction (suspended since
> active
> + * is already dropped trough the system call path).
> + *
> + * The kernel must discard the transaction when entering sigreturn,
> + * since restoring the potential TM SPRS from the signal frame is
> requiring to
> + * not be in a transaction.
> + */
> +
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <signal.h>
> +#include <string.h>
> +
> +#include "utils.h"
> +#include "tm.h"
> +
> +
> +void handler(int sig)
> +{
> +	uint64_t ret;
> +
> +	asm __volatile__(
> +		"li             3,1             ;"
> +		"tbegin.                        ;"
> +		"beq            1f              ;"
> +		"li             3,0             ;"
> +		"tsuspend.                      ;"
> +		"1:                             ;"
> +		"std%X[ret]     3, %[ret]       ;"
> +		: [ret]"=m"(ret)
> +		:
> +		: "memory", "3", "cr0");
> +
> +	if (ret)
> +		exit(1);
> +
> +	/*
> +	 * We return from the signal handle while in a suspended
> transaction
> +	 */
> +}
> +
> +
> +int tm_sigreturn(void)
> +{
> +	struct sigaction sa;
> +	uint64_t ret = 0;
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_handler = handler;
> +	sigemptyset(&sa.sa_mask);
> +
> +	if (sigaction(SIGSEGV, &sa, NULL))
> +		exit(1);
> +
> +	asm __volatile__(
> +		"tbegin.                        ;"
> +		"beq            1f              ;"
> +		"li             3,0             ;"
> +		"std            3,0(3)          ;" /* trigger SEGV
> */
> +		"li             3,1             ;"
> +		"std%X[ret]     3,%[ret]        ;"
> +		"tend.                          ;"
> +		"b              2f              ;"
> +		"1:                             ;"
> +		"li             3,2             ;"
> +		"std%X[ret]     3,%[ret]        ;"
> +		"2:                             ;"
> +		: [ret]"=m"(ret)
> +		:
> +		: "memory", "3", "cr0");
> +
> +	if (ret != 2)
> +		exit(1);
> +
> +	exit(0);
> +}
> +
> +int main(void)
> +{
> +	return test_harness(tm_sigreturn, "tm_sigreturn");
> +}
