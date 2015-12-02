Return-Path: <michael.neuling@au.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6822F1A0C26
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 16:27:55 +1100 (AEDT)
Message-ID: <1449034075.30090.95.camel@au.ibm.com>
Subject: Re: [PATCH 2/3] selftests/powerpc: Add test for forking inside
 transaction
From: Michael Neuling <michael.neuling@au.ibm.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 02 Dec 2015 16:27:55 +1100
In-Reply-To: <1448946504-11653-3-git-send-email-rashmicy@gmail.com>
References: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
 <1448946504-11653-3-git-send-email-rashmicy@gmail.com>
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

On Tue, 2015-12-01 at 16:08 +1100, Rashmica Gupta wrote:
> This test does a fork syscall inside a transaction. Basic sniff test
> to see
> if we can enter the kernel during a transaction.

Can you add this description to the top of the test case as well?

Mikey

>=20
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> ---
>  tools/testing/selftests/powerpc/tm/.gitignore |  1 +
>  tools/testing/selftests/powerpc/tm/Makefile   |  2 +-
>  tools/testing/selftests/powerpc/tm/tm-fork.c  | 41
> +++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/tm/tm-fork.c
>=20
> diff --git a/tools/testing/selftests/powerpc/tm/.gitignore
> b/tools/testing/selftests/powerpc/tm/.gitignore
> index e6668217ccd0..d0c7c97e9b13 100644
> --- a/tools/testing/selftests/powerpc/tm/.gitignore
> +++ b/tools/testing/selftests/powerpc/tm/.gitignore
> @@ -2,3 +2,4 @@ tm-resched-dscr
>  tm-syscall
>  tm-signal-msr-resv
>  tm-signal-stack
> +tm-fork
> diff --git a/tools/testing/selftests/powerpc/tm/Makefile
> b/tools/testing/selftests/powerpc/tm/Makefile
> index 578572a3700a..f7d4727662aa 100644
> --- a/tools/testing/selftests/powerpc/tm/Makefile
> +++ b/tools/testing/selftests/powerpc/tm/Makefile
> @@ -1,4 +1,4 @@
> -TEST_PROGS :=3D tm-resched-dscr tm-syscall tm-signal-msr-resv tm
> -signal-stack
> +TEST_PROGS :=3D tm-resched-dscr tm-syscall tm-signal-msr-resv tm
> -signal-stack tm-fork
> =20
>  all: $(TEST_PROGS)
> =20
> diff --git a/tools/testing/selftests/powerpc/tm/tm-fork.c
> b/tools/testing/selftests/powerpc/tm/tm-fork.c
> new file mode 100644
> index 000000000000..f571a48a59a0
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/tm/tm-fork.c
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright 2015, Michael Neuling, IBM Corp.
> + * Licensed under GPLv2.
> + *
> + * Edited: Rashmica Gupta, Nov 2015
> + *
> + * Fork inside a transaction
> + */
> +
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <pthread.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include "utils.h"
> +#include "tm.h"
> +
> +int test_fork(void)
> +{
> +	SKIP_IF(!have_htm());
> +
> +	asm __volatile__(
> +		"tbegin.;"
> +		"blt    1f; "
> +		"li     0, 2;"  /* fork syscall */
> +		"sc  ;"
> +		"tend.;"
> +		"1: ;"
> +		: : : "memory", "r0");
> +	/* If we reach here, we've passed.  Otherwise we've probably
> crashed
> +	 * the kernel */
> +
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(test_fork, "tm_fork");
> +}
