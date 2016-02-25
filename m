Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6264D1A0063
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 17:22:43 +1100 (AEDT)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 861741402C9
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 17:22:42 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id c10so2293616pfc.0
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 22:22:42 -0800 (PST)
Date: Thu, 25 Feb 2016 17:22:33 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v5 1/9] selftests/powerpc: Test the preservation of FPU
 and VMX regs across syscall
Message-ID: <20160225172233.194807c5@camb691>
In-Reply-To: <1456198702-29657-2-git-send-email-cyrilbur@gmail.com>
References: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
 <1456198702-29657-2-git-send-email-cyrilbur@gmail.com>
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

On Tue, 23 Feb 2016 14:38:14 +1100
Cyril Bur <cyrilbur@gmail.com> wrote:

> Test that the non volatile floating point and Altivec registers get
> correctly preserved across the fork() syscall.
> 
> fork() works nicely for this purpose, the registers should be the same for
> both parent and child
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  tools/testing/selftests/powerpc/Makefile           |   3 +-
>  tools/testing/selftests/powerpc/basic_asm.h        |  62 +++++++
>  tools/testing/selftests/powerpc/math/.gitignore    |   2 +
>  tools/testing/selftests/powerpc/math/Makefile      |  16 ++
>  tools/testing/selftests/powerpc/math/fpu_asm.S     | 161 +++++++++++++++++
>  tools/testing/selftests/powerpc/math/fpu_syscall.c |  90 ++++++++++
>  tools/testing/selftests/powerpc/math/vmx_asm.S     | 195 +++++++++++++++++++++
>  tools/testing/selftests/powerpc/math/vmx_syscall.c |  91 ++++++++++
>  8 files changed, 619 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/basic_asm.h
>  create mode 100644 tools/testing/selftests/powerpc/math/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/math/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/math/fpu_asm.S
>  create mode 100644 tools/testing/selftests/powerpc/math/fpu_syscall.c
>  create mode 100644 tools/testing/selftests/powerpc/math/vmx_asm.S
>  create mode 100644 tools/testing/selftests/powerpc/math/vmx_syscall.c
> 

[snip]

> diff --git a/tools/testing/selftests/powerpc/math/.gitignore b/tools/testing/selftests/powerpc/math/.gitignore
> new file mode 100644
> index 0000000..b19b269
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/.gitignore
> @@ -0,0 +1,2 @@
> +fpu_syscall
> +vmx_syscall
> diff --git a/tools/testing/selftests/powerpc/math/Makefile b/tools/testing/selftests/powerpc/math/Makefile
> new file mode 100644
> index 0000000..598e5df
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/Makefile
> @@ -0,0 +1,16 @@
> +TEST_PROGS := fpu_syscall vmx_syscall
> +
> +all: $(TEST_PROGS)
> +
> +#The general powerpc makefile adds -flto. This isn't interacting well with the custom ASM.
> +#filter-out -flto to avoid false failures.
> +$(TEST_PROGS): ../harness.c
> +$(TEST_PROGS): CFLAGS = $(filter-out -flto,$(CFLAGS) -O2 -g -pthread -m64 -maltivec)

Hi Michael, sorry, there should be a ':' before the '=' to avoid recursive variable problems

-$(TEST_PROGS): CFLAGS = $(filter-out -flto,$(CFLAGS) -O2 -g -pthread -m64 -maltivec)
+$(TEST_PROGS): CFLAGS := $(filter-out -flto,$(CFLAGS) -O2 -g -pthread -m64 -maltivec)

Are you ok to fix it up here?

Thanks

> +
> +fpu_syscall: fpu_asm.S
> +vmx_syscall: vmx_asm.S
> +
> +include ../../lib.mk
> +
> +clean:
> +	rm -f $(TEST_PROGS) *.o
> diff --git a/tools/testing/selftests/powerpc/math/fpu_asm.S b/tools/testing/selftests/powerpc/math/fpu_asm.S
> new file mode 100644
> index 0000000..b12c051
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/math/fpu_asm.S
> @@ -0,0 +1,161 @@
> +/*
> + * Copyright 2015, Cyril Bur, IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include "../basic_asm.h"

[snip]
