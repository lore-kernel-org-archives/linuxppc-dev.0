Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 880521A0286
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 16:12:43 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Dec 2015 10:42:40 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8D0393940019
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 10:42:39 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB25CcLU7668046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 10:42:39 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB25CciY018440
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2015 10:42:38 +0530
Message-ID: <565E7DC6.4080306@linux.vnet.ibm.com>
Date: Wed, 02 Dec 2015 10:42:38 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
CC: mikey@neuling.org
Subject: Re: [PATCH] selftests/powerpc: Add test to check if TAR is corrupted
References: <1449026569-30094-1-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1449026569-30094-1-git-send-email-rashmicy@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/02/2015 08:52 AM, Rashmica Gupta wrote:
> If the transaction is aborted, the TAR should be rolled back to the
> checkpointed value before the transaction began.

And if it does not abort, it should continue to hold the changed
(inside the transaction) TAR value after the transaction finishes.
The test here does check for both these cases and hence the commit
message should reflect that as well. This test can also accommodate
checks for PPR and DSCR register in one go.

In the TM ptrace patch series (https://lkml.org/lkml/2015/10/8/522)
which is still under review, there are couple of tests related
to (TAR, PPR, DSCR) registers with (TM running & TM suspended) and
without TM. There, the values are being checked using ptrace interface
instead. Can you please check them and just make sure that we are not
duplicating anything here.

> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> ---
> To check this yourself, undo the changes from the patch "powerpc/tm: Fix
> context switching TAR, PPR and DSCR SPRs".
> 
>  tools/testing/selftests/powerpc/tm/.gitignore |  1 +
>  tools/testing/selftests/powerpc/tm/Makefile   |  2 +-
>  tools/testing/selftests/powerpc/tm/tm-tar.c   | 90 +++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/tm/tm-tar.c
> 
> diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
> index 76eae258feeb..9bf6749550e3 100644
> --- a/tools/testing/selftests/powerpc/tm/.gitignore
> +++ b/tools/testing/selftests/powerpc/tm/.gitignore
> @@ -4,3 +4,4 @@ tm-signal-msr-resv
>  tm-signal-stack
>  tm-fork
>  tm-dscr
> +tm-tar
> diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
> index 59eec240339d..ab2992f69b4c 100644
> --- a/tools/testing/selftests/powerpc/tm/Makefile
> +++ b/tools/testing/selftests/powerpc/tm/Makefile
> @@ -1,4 +1,4 @@
> -TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-fork tm-dscr
> +TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-fork tm-dscr tm-tar
>  
>  all: $(TEST_PROGS)
>  
> diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c b/tools/testing/selftests/powerpc/tm/tm-tar.c
> new file mode 100644
> index 000000000000..22a0c3485412
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
> @@ -0,0 +1,90 @@
> +/* 
> + * Copyright 2015, Michael Neuling, IBM Corp. 
> + * Licensed under GPLv2.
> + * Original: Michael Neuling 19/7/2013
> + * Edited: Rashmica Gupta 01/12/2015
> + *
> + * Do some transactions, see if the tar is corrupted.

It can use a better explanation here.

> + *
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
> +			"mtspr	%[tar], 7;"	// tar = 1

Please use /* */ kind of comment sections not //.

> +			"tbegin.;"	
> +			"beq	3f;"
> +			"li	4, 0x7000;"	// Loop lots, to use time
> +			"2:;"			// Start loop

Here as well.

> +			"li	7, 2;"
> +			"mtspr	%[tar], 7;"	// tar = 2
> +			"tsuspend.;"
> +			"li	7, 3;"
> +			"mtspr	%[tar], 7;"	// tar = 3
> +			"tresume.;"
> +			"subi	4, 4, 1;"
> +			"cmpdi	4, 0;"
> +			"bne	2b;"
> +			"tend.;"
> +
> +			// Transaction sucess! TAR should be 3.
> +			"mfspr  7, %[tar];"
> +			"ori	%[res], 7, 4;"  // res = 3|4 = 7
> +			"b	4f;"
> +
> +			// Abort handler. TAR should be rolled back to 1.
> +			"3:;"
> +			"mfspr  7, %[tar];"
> +			"ori	%[res], 7, 8;"	// res = 1|8 = 9
> +			"4:;"
> +
> +			: [res]"=r"(result)
> +			: [tar]"i"(SPRN_TAR)
> +			   : "memory", "r0", "r4", "r7");
> +
> +		// If result is anything else other than 7 or 9, the tar
> +		// value must have been corrupted.

Here as well.

> +		if ((result != 7) && (result != 9)) 
> +			return 1;
> +		
> +	}
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +
> +	// A low number of iterations (eg 100) can cause a false pass.

Here as well.

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
> 
