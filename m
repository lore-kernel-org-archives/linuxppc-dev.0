Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVQpF4gdgzDqvf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 21:33:25 +1100 (AEDT)
Date: Mon, 29 Jan 2018 11:33:20 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
 namhyung@kernel.org, linux-kernel@vger.kernel.org,
 brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 3/3] perf trace powerpc: Use generated syscall table
Message-ID: <20180129103320.GA9986@kernel.org>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180129083417.31240-4-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180129083417.31240-4-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Jan 29, 2018 at 02:04:17PM +0530, Ravi Bangoria escreveu:
> +++ b/tools/perf/util/syscalltbl.c
> @@ -30,6 +30,10 @@
>  #include <asm/syscalls_64.c>
>  const int syscalltbl_native_max_id = SYSCALLTBL_S390_64_MAX_ID;
>  static const char **syscalltbl_native = syscalltbl_s390_64;
> +#elif defined(__powerpc64__)
> +#include <asm/syscalls_64.c>
> +const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_64_MAX_ID;
> +static const char **syscalltbl_native = syscalltbl_powerpc_64;
>  #endif

This is so cool! Thanks!

At some point we'll remove these #elif, have all of then linked, so that
we can do cross-platform interpreting of perf.data files generated with
'perf trace record', i.e. 'perf trace -i perf.data.recorded.on.s390' on
a powerpc64 or x86 machine.

We're paving the way to that with patches like yours and those for
s/390, thanks again!

- Arnaldo
