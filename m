Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf040502hzDqnK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 18:54:40 +1000 (AEST)
Date: Tue, 28 Jun 2016 10:54:34 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yury Norov <ynorov@caviumnetworks.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Wang Nan <wangnan0@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5] tools/perf: Fix the mask in regs_dump__printf and
 print_sample_iregs
Message-ID: <20160628085434.GA28550@krava>
References: <1466660967-2016-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466660967-2016-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 23, 2016 at 11:19:27AM +0530, Madhavan Srinivasan wrote:

SNIP

> 
> Changelog v1:
> 1)updated commit message and patch subject
> 2)Add the fix to print_sample_iregs() in builtin-script.c
> 
>  tools/include/linux/bitmap.h |  2 ++
>  tools/lib/bitmap.c           | 18 ++++++++++++++++++
>  tools/perf/builtin-script.c  |  4 +++-
>  tools/perf/util/session.c    |  4 +++-
>  4 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index 28f5493da491..5e98525387dc 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -2,6 +2,7 @@
>  #define _PERF_BITOPS_H
>  
>  #include <string.h>
> +#include <limits.h>

this could go in the bitmap.c file, but anyway:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>  #include <linux/bitops.h>
>  
>  #define DECLARE_BITMAP(name,bits) \
> @@ -10,6 +11,7 @@
>  int __bitmap_weight(const unsigned long *bitmap, int bits);
>  void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
>  		 const unsigned long *bitmap2, int bits);
> +void bitmap_from_u64(unsigned long *dst, u64 mask);
>  
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
>  

SNIP
