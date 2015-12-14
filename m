Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9E0D1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 02:44:16 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 14 Dec 2015 21:14:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8DC47125805D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 21:14:35 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBEFi7B957147604
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 21:14:07 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBEFi6Xc018715
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 21:14:07 +0530
Date: Mon, 14 Dec 2015 21:13:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Wang Nan <wangnan0@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2] tools lib bpf: Support libbpf on PowerPC
Message-ID: <20151214154326.GE23726@naverao1-tp.in.ibm.com>
References: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1450094259-123844-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450094259-123844-1-git-send-email-wangnan0@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/12/14 11:57AM, Wang Nan wrote:
> Support basic PowerPC compiling.
> 
> Checks BPF syscall number, turn off libbpf building on platform doesn't
> support sys_bpf instead of blocking compiling.
> 
> Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> 
> v1 -> v2: __powerpc64__ -> __powerpc__. Code is from
>           ./tools/perf/perf-sys.h, but not tested yet.
> 
> Naveen, please help me try this patch on PPC.

Thanks, this works. However...

> 	  
> Thank you.
> 
> ---
>  tools/build/feature/test-bpf.c | 23 ++++++++++++++++++++++-
>  tools/lib/bpf/bpf.c            |  6 ++++--
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-bpf.c
> index 062bac8..19497f7 100644
> --- a/tools/build/feature/test-bpf.c
> +++ b/tools/build/feature/test-bpf.c
> @@ -1,9 +1,26 @@
> +#include <asm/unistd.h>
>  #include <linux/bpf.h>
> +#include <unistd.h>
> +
> +#ifndef __NR_bpf
> +# if defined(__i386__)
> +#  define __NR_bpf 357
> +# elif defined(__x86_64__)
> +#  define __NR_bpf 321
> +# elif defined(__aarch64__)
> +#  define __NR_bpf 280
> +# elif defined(__powerpc__)
> +#  define __NR_bpf 361

I think we should drop __aarch64__ and __powerpc__ here since this 
builds fine on ppc without these hunks.

> +# else
> +#  error __NR_bpf not defined. libbpf does not support your arch.
> +# endif
> +#endif
>  
>  int main(void)
>  {
>  	union bpf_attr attr;
>  
> +	/* Check fields in attr */
>  	attr.prog_type = BPF_PROG_TYPE_KPROBE;
>  	attr.insn_cnt = 0;
>  	attr.insns = 0;
> @@ -14,5 +31,9 @@ int main(void)
>  	attr.kern_version = 0;
>  
>  	attr = attr;
> -	return 0;
> +	/*
> +	 * Test existance of __NR_bpf and BPF_PROG_LOAD.

Nit... 'for existence'.

> +	 * This call should fail if we run the testcase.
> +	 */
> +	return syscall(__NR_bpf, BPF_PROG_LOAD, attr, sizeof(attr));
>  }
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 5bdc6ea..fd25c58 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -14,8 +14,8 @@
>  #include "bpf.h"
>  
>  /*
> - * When building perf, unistd.h is override. Define __NR_bpf is
> - * required to be defined.
> + * When building perf, unistd.h is overrided. __NR_bpf is
> + * required to be defined explicitly.
>   */
>  #ifndef __NR_bpf
>  # if defined(__i386__)
> @@ -24,6 +24,8 @@
>  #  define __NR_bpf 321
>  # elif defined(__aarch64__)
>  #  define __NR_bpf 280
> +# elif defined(__powerpc__)
> +#  define __NR_bpf 361

And, I think we should drop this hunk, but include the patch I sent.  
That ensures that the proper headers from the kernel source tree are 
included, so there won't be a need to explicitly define __NR_bpf for 
each architecture.


Regards,
Naveen
