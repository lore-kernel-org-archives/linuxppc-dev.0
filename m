Return-Path: <srs0=pisz=d5=google.com=jsperbeck@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zB4Fg3wcJzDqy2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 06:41:59 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zB4Ff3Stgz8tlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 06:41:58 +1100 (AEDT)
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zB4Fb4qZwz9s7G
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2018 06:41:53 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id i11so62480359wmf.4
 for <linuxppc-dev@ozlabs.org>; Tue, 02 Jan 2018 11:41:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180102110324.31978-1-mpe@ellerman.id.au>
References: <20180102110324.31978-1-mpe@ellerman.id.au>
From: John Sperbeck <jsperbeck@google.com>
Date: Tue, 2 Jan 2018 11:41:47 -0800
Message-ID: <CAFNjLiWrz_=epy8BE6-EVDsr6hbUO5=ykOL1gV1asc=WMOoFFQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Add a test of SEGV error behaviour
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 2, 2018 at 3:03 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Add a test case of the error code reported when we take a SEGV on a
> mapped but inaccessible area. We broke this recently.
>
> Based on a test case from John Sperbeck <jsperbeck@google.com>.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/powerpc/mm/.gitignore    |  3 +-
>  tools/testing/selftests/powerpc/mm/Makefile      |  2 +-
>  tools/testing/selftests/powerpc/mm/segv_errors.c | 78 ++++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/powerpc/mm/segv_errors.c
>
> diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
> index e715a3f2fbf4..7d7c42ed6de9 100644
> --- a/tools/testing/selftests/powerpc/mm/.gitignore
> +++ b/tools/testing/selftests/powerpc/mm/.gitignore
> @@ -1,4 +1,5 @@
>  hugetlb_vs_thp_test
>  subpage_prot
>  tempfile
> -prot_sao
> \ No newline at end of file
> +prot_sao
> +segv_errors
> \ No newline at end of file
> diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
> index bf315bcbe663..8ebbe96d80a8 100644
> --- a/tools/testing/selftests/powerpc/mm/Makefile
> +++ b/tools/testing/selftests/powerpc/mm/Makefile
> @@ -2,7 +2,7 @@
>  noarg:
>         $(MAKE) -C ../
>
> -TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao
> +TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors
>  TEST_GEN_FILES := tempfile
>
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/powerpc/mm/segv_errors.c b/tools/testing/selftests/powerpc/mm/segv_errors.c
> new file mode 100644
> index 000000000000..06ae76ee3ea1
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/mm/segv_errors.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright 2017 John Sperbeck
> + *
> + * Test that an access to a mapped but inaccessible area causes a SEGV and
> + * reports si_code == SEGV_ACCERR.
> + */
> +
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <sys/mman.h>
> +#include <assert.h>
> +#include <ucontext.h>
> +
> +#include "utils.h"
> +
> +static bool faulted;
> +static int si_code;
> +
> +static void segv_handler(int n, siginfo_t *info, void *ctxt_v)
> +{
> +       ucontext_t *ctxt = (ucontext_t *)ctxt_v;
> +       struct pt_regs *regs = ctxt->uc_mcontext.regs;
> +
> +       faulted = true;
> +       si_code = info->si_code;
> +       regs->nip += 4;
> +}
> +
> +int test_segv_errors(void)
> +{
> +       struct sigaction act = {
> +               .sa_sigaction = segv_handler,
> +               .sa_flags = SA_SIGINFO,
> +       };
> +       char c, *p = NULL;
> +
> +       p = mmap(NULL, getpagesize(), 0, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> +       FAIL_IF(p == MAP_FAILED);
> +
> +       FAIL_IF(sigaction(SIGSEGV, &act, NULL) != 0);
> +
> +       faulted = false;
> +       si_code = 0;
> +
> +       /*
> +        * We just need a compiler barrier, but mb() works and has the nice
> +        * property of being easy to spot in the disassembly.
> +        */
> +       mb();
> +       c = *p;
> +       mb();
> +
> +       FAIL_IF(!faulted);
> +       FAIL_IF(si_code != SEGV_ACCERR);
> +
> +       faulted = false;
> +       si_code = 0;
> +
> +       mb();
> +       *p = c;
> +       mb();
> +
> +       FAIL_IF(!faulted);
> +       FAIL_IF(si_code != SEGV_ACCERR);
> +
> +       return 0;
> +}
> +
> +int main(void)
> +{
> +       return test_harness(test_segv_errors, "segv_errors");
> +}
> --
> 2.14.3
>

Looks good to me.

Acked-by: John Sperbeck <jsperbeck@google.com>
