Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRFgt6RzqzDqMh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 19:31:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, cyrilbur@gmail.com,
 Breno Leitao <brenohl@br.ibm.com>, Gustavo Bueno Romero <gromero@br.ibm.com>
Subject: Re: [PATCH 2/2] selftests/powerpc: Test TM and VMX register state
In-Reply-To: <20170508071627.21851-2-mikey@neuling.org>
References: <20170508071627.21851-1-mikey@neuling.org>
 <20170508071627.21851-2-mikey@neuling.org>
Date: Mon, 15 May 2017 19:31:06 +1000
Message-ID: <87y3tya2lh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> diff --git a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c b/tools/=
testing/selftests/powerpc/tm/tm-vmx-unavail.c
> new file mode 100644
> index 0000000000..137185ba49
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
> @@ -0,0 +1,118 @@
> +/*
> + * Copyright 2017, Michael Neuling, IBM Corp.
> + * Licensed under GPLv2.
> + * Original: Breno Leitao <brenohl@br.ibm.com> &
> + *           Gustavo Bueno Romero <gromero@br.ibm.com>
> + * Edited: Michael Neuling
> + *
> + * Force VMX unavailable during a transaction and see if it corrupts
> + * the checkpointed VMX register state after the abort.
> + */
> +
> +#include <inttypes.h>
> +#include <htmintrin.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <pthread.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +#include <pthread.h>
> +
> +#include "tm.h"
> +#include "utils.h"
> +
> +int passed;
> +
> +void *worker(void *unused)
> +{
> +	__int128 vmx0;
> +	uint64_t texasr;

On BE:

  ppc64-gcc -std=3Dgnu99 -O2 -Wall -Werror -DGIT_VERSION=3D'"v4.12-rc1-3-ge=
36b67a25585"' -I/home/michael/work/topics/powerpc-maint/src/maint/tools/tes=
ting/selftests/powerpc/include  -mhtm -pthread    tm-vmx-unavail.c ../harne=
ss.c ../utils.c  -o /home/michael/work/topics/powerpc-maint/src/maint/tools=
/testing/selftests/powerpc/tm/tm-vmx-unavail
  tm-vmx-unavail.c: In function =E2=80=98worker=E2=80=99:
  tm-vmx-unavail.c:29:2: error: expected expression before =E2=80=98__int12=
8=E2=80=99
    __int128 vmx0;
    ^
  tm-vmx-unavail.c:62:21: error: =E2=80=98vmx0=E2=80=99 undeclared (first u=
se in this function)
     : [vmx0_ptr] "r"(&vmx0)
                       ^
  tm-vmx-unavail.c:62:21: note: each undeclared identifier is reported only=
 once for each function it appears in
  tm-vmx-unavail.c:72:9: error: format =E2=80=98%lx=E2=80=99 expects argume=
nt of type =E2=80=98long unsigned int=E2=80=99, but argument 2 has type =E2=
=80=98uint64_t {aka long long unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
    printf("Failure with error: %lx\n",   _TEXASR_FAILURE_CODE(texasr));
           ^
  tm-vmx-unavail.c:73:9: error: format =E2=80=98%lx=E2=80=99 expects argume=
nt of type =E2=80=98long unsigned int=E2=80=99, but argument 2 has type =E2=
=80=98uint64_t {aka long long unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
    printf("Summary error     : %lx\n",   _TEXASR_FAILURE_SUMMARY(texasr));
           ^
  tm-vmx-unavail.c:74:9: error: format =E2=80=98%lx=E2=80=99 expects argume=
nt of type =E2=80=98long unsigned int=E2=80=99, but argument 2 has type =E2=
=80=98uint64_t {aka long long unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
    printf("TFIAR exact       : %lx\n\n", _TEXASR_TFIAR_EXACT(texasr));
           ^
  cc1: all warnings being treated as errors


I tried -maltivec/vsx but that didn't fix it.

cheers
