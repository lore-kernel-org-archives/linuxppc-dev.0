Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVYdL4q7RzDqlK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 16:39:18 +1000 (AEST)
Date: Thu, 16 Jun 2016 08:39:12 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: He Kuang <hekuang@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 alexander.shishkin@linux.intel.com, wangnan0@huawei.com,
 adrian.hunter@intel.com, ak@linux.intel.com, maddy@linux.vnet.ibm.com,
 bp@suse.de, dsahern@gmail.com, linux@horizon.com, namhyung@kernel.org,
 linux@rasmusvillemoes.dk, yury.norov@gmail.com, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] tools include: Fix wrong macro definitions for
 cpu_to_le* for big endian
Message-ID: <20160616063912.GB9533@krava>
References: <20160615212958.GC4882@kernel.org>
 <1466040729-100926-1-git-send-email-hekuang@huawei.com>
 <1466040729-100926-3-git-send-email-hekuang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466040729-100926-3-git-send-email-hekuang@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2016 at 01:32:09AM +0000, He Kuang wrote:
> From: Wang Nan <wangnan0@huawei.com>
> 
> The cpu_to_le* macros in kernel.h are defined without considering
> endianese. This patch includes "byteoder/generic.h" instead to fix the
> bug, and removes redundant le64_to_cpu definition in intel-bts.c.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Signed-off-by: He Kuang <hekuang@huawei.com>
> ---
>  tools/include/linux/kernel.h | 5 ++---
>  tools/perf/util/intel-bts.c  | 5 -----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
> index 76df535..6145e41 100644
> --- a/tools/include/linux/kernel.h
> +++ b/tools/include/linux/kernel.h
> @@ -64,11 +64,10 @@
>  #endif
>  
>  /*
> - * Both need more care to handle endianness
> + * Need more care to handle endianness
>   * (Don't use bitmap_copy_le() for now)

what's the purpose of this comment now?

>   */
> -#define cpu_to_le64(x)	(x)
> -#define cpu_to_le32(x)	(x)
> +#include <linux/byteorder/generic.h>
>  
>  static inline int
>  vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 9df9960..0e632c4 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -40,11 +40,6 @@
>  #define INTEL_BTS_ERR_NOINSN  5
>  #define INTEL_BTS_ERR_LOST    9
>  
> -#if __BYTE_ORDER == __BIG_ENDIAN
> -#define le64_to_cpu bswap_64
> -#else
> -#define le64_to_cpu
> -#endif

the purpose of this patchset is to unify these macros right?

there're more conversion defines in:
  util/intel-pt-decoder/intel-pt-pkt-decoder.c,

please remove them as well

thanks,
jirka
