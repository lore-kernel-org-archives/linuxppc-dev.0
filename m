Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x232.google.com (mail-yk0-x232.google.com
 [IPv6:2607:f8b0:4002:c07::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85ED91A0286
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2015 00:16:18 +1100 (AEDT)
Received: by ykdr82 with SMTP id r82so45396268ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Dec 2015 05:16:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1449034846-10033-1-git-send-email-rashmicy@gmail.com>
References: <1449034846-10033-1-git-send-email-rashmicy@gmail.com>
Date: Wed, 2 Dec 2015 16:16:15 +0300
Message-ID: <CAOJe8K2z8bGFniwLVPdL7_SqDsTaNOrugtpdkF0O6-tEn8vTxQ@mail.gmail.com>
Subject: Re: [v3] selftests/powerpc: Add test to check if TAR is corrupted
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Rashmica Gupta <rashmicy@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/2/15, Rashmica Gupta <rashmicy@gmail.com> wrote:
> If the transaction is aborted, the TAR should be rolled back to the
> checkpointed value before the transaction began. The value written to the
> TAR when the transaction is suspended should only remain there if the
> transaction completes successfully.
>
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
Please see the comments to the previous patch.

> ---
> Added more explanation and fixed up styling issue. No functional
> changes.
>
>  tools/testing/selftests/powerpc/tm/.gitignore |  1 +
>  tools/testing/selftests/powerpc/tm/Makefile   |  2 +-
>  tools/testing/selftests/powerpc/tm/tm-tar.c   | 92
> +++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/tm/tm-tar.c
>
> diff --git a/tools/testing/selftests/powerpc/tm/.gitignore
> b/tools/testing/selftests/powerpc/tm/.gitignore
> index 76eae258feeb..9bf6749550e3 100644
> --- a/tools/testing/selftests/powerpc/tm/.gitignore
> +++ b/tools/testing/selftests/powerpc/tm/.gitignore
> @@ -4,3 +4,4 @@ tm-signal-msr-resv
>  tm-signal-stack
>  tm-fork
>  tm-dscr
> +tm-tar
> diff --git a/tools/testing/selftests/powerpc/tm/Makefile
> b/tools/testing/selftests/powerpc/tm/Makefile
> index 59eec240339d..ab2992f69b4c 100644
> --- a/tools/testing/selftests/powerpc/tm/Makefile
> +++ b/tools/testing/selftests/powerpc/tm/Makefile
> @@ -1,4 +1,4 @@
> -TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack
> tm-fork tm-dscr
> +TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack
> tm-fork tm-dscr tm-tar
>
>  all: $(TEST_PROGS)
>
> diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c
> b/tools/testing/selftests/powerpc/tm/tm-tar.c
> new file mode 100644
> index 000000000000..732f518c95cf
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
> @@ -0,0 +1,92 @@
> +/*
> + * Copyright 2015, Michael Neuling, IBM Corp.
> + * Licensed under GPLv2.
> + * Original: Michael Neuling 19/7/2013
> + * Edited: Rashmica Gupta 01/12/2015
> + *
> + * Do some transactions, see if the tar is corrupted.
> + * If the transaction is aborted, the TAR should be rolled back to the
> + * checkpointed value before the transaction began. The value written to
> + * TAR in suspended mode should only remain in TAR if the transaction
> + * completes.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +#include "tm.h"
> +#include "utils.h"
> +
> +#define SPRN_TAR	0x32f
> +
> +int	num_loops	= 10000;
> +
> +int test_tar(void)
> +{
> +	int i;
> +
> +	SKIP_IF(!have_htm());
> +
> +	for (i = 0; i < num_loops; i++)
> +	{
> +		uint64_t result = 0;
> +		asm __volatile__(
> +			"li	7, 1;"
> +			"mtspr	%[tar], 7;"	/* tar = 1 */
> +			"tbegin.;"
> +			"beq	3f;"
> +			"li	4, 0x7000;"	/* Loop lots, to use time */
> +			"2:;"			/* Start loop */
> +			"li	7, 2;"
> +			"mtspr	%[tar], 7;"	/* tar = 2 */
> +			"tsuspend.;"
> +			"li	7, 3;"
> +			"mtspr	%[tar], 7;"	/* tar = 3 */
> +			"tresume.;"
> +			"subi	4, 4, 1;"
> +			"cmpdi	4, 0;"
> +			"bne	2b;"
> +			"tend.;"
> +
> +			/* Transaction sucess! TAR should be 3 */
> +			"mfspr  7, %[tar];"
> +			"ori	%[res], 7, 4;"  // res = 3|4 = 7
> +			"b	4f;"
> +
> +			/* Abort handler. TAR should be rolled back to 1 */
> +			"3:;"
> +			"mfspr  7, %[tar];"
> +			"ori	%[res], 7, 8;"	// res = 1|8 = 9
> +			"4:;"
> +
> +			: [res]"=r"(result)
> +			: [tar]"i"(SPRN_TAR)
> +			   : "memory", "r0", "r4", "r7");
> +
> +		/* If result is anything else other than 7 or 9, the tar
> +		 * value must have been corrupted. */
> +		if ((result != 7) && (result != 9))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	/* A low number of iterations (eg 100) can cause a false pass */
> +	if (argc > 1) {
> +		if (strcmp(argv[1], "-h") == 0) {
> +			printf("Syntax:\n\t%s [<num loops>]\n",
> +			       argv[0]);
> +			return 0;
> +		} else {
> +			num_loops = atoi(argv[1]);
> +		}
> +	}
> +
> +	printf("Starting, %d loops\n", num_loops);
> +
> +	test_harness(test_tar, "tm_tar");
> +}
> --
> 2.5.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
