Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVYdg452RzDqmr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 16:39:35 +1000 (AEST)
Date: Thu, 16 Jun 2016 08:39:29 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: He Kuang <hekuang@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 alexander.shishkin@linux.intel.com, wangnan0@huawei.com,
 adrian.hunter@intel.com, ak@linux.intel.com, maddy@linux.vnet.ibm.com,
 bp@suse.de, dsahern@gmail.com, linux@horizon.com, namhyung@kernel.org,
 linux@rasmusvillemoes.dk, yury.norov@gmail.com, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] tools include: Sync byteorder/generic.h
Message-ID: <20160616063929.GC9533@krava>
References: <20160615212958.GC4882@kernel.org>
 <1466040729-100926-1-git-send-email-hekuang@huawei.com>
 <1466040729-100926-2-git-send-email-hekuang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466040729-100926-2-git-send-email-hekuang@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2016 at 01:32:08AM +0000, He Kuang wrote:
> From: Wang Nan <wangnan0@huawei.com>
> 
> This patch copies "include/linux/byteorder/generic.h" to
> "tools/include/linux/byteorder/generic.h" to enable other libraries to
> use macros in it.

it's not the file copied, as the changelog suggest,
just several macros, please fix the changelog

thanks,
jirka

> 
> tools/perf/MANIFEST is also updated for 'make perf-*-src-pkg'.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Signed-off-by: He Kuang <hekuang@huawei.com>
> ---
>  tools/include/linux/byteorder/generic.h | 48 +++++++++++++++++++++++++++++++++
>  tools/perf/MANIFEST                     |  1 +
>  2 files changed, 49 insertions(+)
>  create mode 100644 tools/include/linux/byteorder/generic.h
> 
> diff --git a/tools/include/linux/byteorder/generic.h b/tools/include/linux/byteorder/generic.h
> new file mode 100644
> index 0000000..41b4507
> --- /dev/null
> +++ b/tools/include/linux/byteorder/generic.h
> @@ -0,0 +1,48 @@
> +#ifndef _TOOLS_LINUX_BYTEORDER_GENERIC_H
> +#define _TOOLS_LINUX_BYTEORDER_GENERIC_H
> +
> +#include <endian.h>
> +#include <byteswap.h>
> +
> +#define cpu_to_le64 __cpu_to_le64
> +#define le64_to_cpu __le64_to_cpu
> +#define cpu_to_le32 __cpu_to_le32
> +#define le32_to_cpu __le32_to_cpu
> +#define cpu_to_le16 __cpu_to_le16
> +#define le16_to_cpu __le16_to_cpu
> +#define cpu_to_be64 __cpu_to_be64
> +#define be64_to_cpu __be64_to_cpu
> +#define cpu_to_be32 __cpu_to_be32
> +#define be32_to_cpu __be32_to_cpu
> +#define cpu_to_be16 __cpu_to_be16
> +#define be16_to_cpu __be16_to_cpu
> +
> +#if __BYTE_ORDER == __BIG_ENDIAN
> +#define __cpu_to_le16 bswap_16
> +#define __cpu_to_le32 bswap_32
> +#define __cpu_to_le64 bswap_64
> +#define __le16_to_cpu bswap_16
> +#define __le32_to_cpu bswap_32
> +#define __le64_to_cpu bswap_64
> +#define __cpu_to_be16
> +#define __cpu_to_be32
> +#define __cpu_to_be64
> +#define __be16_to_cpu
> +#define __be32_to_cpu
> +#define __be64_to_cpu
> +#else
> +#define __cpu_to_le16
> +#define __cpu_to_le32
> +#define __cpu_to_le64
> +#define __le16_to_cpu
> +#define __le32_to_cpu
> +#define __le64_to_cpu
> +#define __cpu_to_be16 bswap_16
> +#define __cpu_to_be32 bswap_32
> +#define __cpu_to_be64 bswap_64
> +#define __be16_to_cpu bswap_16
> +#define __be32_to_cpu bswap_32
> +#define __be64_to_cpu bswap_64
> +#endif
> +
> +#endif /* _TOOLS_LINUX_BYTEORDER_GENERIC_H */
> diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
> index 8c8c6b9..80ac3d4 100644
> --- a/tools/perf/MANIFEST
> +++ b/tools/perf/MANIFEST
> @@ -46,6 +46,7 @@ tools/include/asm-generic/bitops/hweight.h
>  tools/include/asm-generic/bitops.h
>  tools/include/linux/atomic.h
>  tools/include/linux/bitops.h
> +tools/include/linux/byteorder/generic.h
>  tools/include/linux/compiler.h
>  tools/include/linux/filter.h
>  tools/include/linux/hash.h
> -- 
> 1.8.5.2
> 
