Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B4542C008F
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2012 21:43:52 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 20 Nov 2012 20:38:31 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAKAXDs356950792
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2012 21:33:14 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAKAhgdH011805
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2012 21:43:43 +1100
Message-ID: <50AB5EDC.20009@in.ibm.com>
Date: Tue, 20 Nov 2012 16:13:40 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] perf/powerpc: Use uapi/unistd.h to fix build error
References: <20121107191818.GA16211@us.ibm.com>
In-Reply-To: <20121107191818.GA16211@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, robert.richter@amd.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2012 12:48 AM, Sukadev Bhattiprolu wrote:
>
>  From b8beef080260c1625c8f801105504a82005295e5 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Wed, 31 Oct 2012 11:21:28 -0700
> Subject: [PATCH 1/4] perf/powerpc: Use uapi/unistd.h to fix build error
>
> Use the 'unistd.h' from arch/powerpc/include/uapi to build the perf tool.
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Without this patch, I couldn't build perf on powerpc, with 3.7.0-rc2

Tested-by: Suzuki K. Poulose <suzuki@in.ibm.com>

Thanks
Suzuki
> ---
>   tools/perf/perf.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 054182e..f4952da 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -26,7 +26,7 @@ void get_term_dimensions(struct winsize *ws);
>   #endif
>
>   #ifdef __powerpc__
> -#include "../../arch/powerpc/include/asm/unistd.h"
> +#include "../../arch/powerpc/include/uapi/asm/unistd.h"
>   #define rmb()		asm volatile ("sync" ::: "memory")
>   #define cpu_relax()	asm volatile ("" ::: "memory");
>   #define CPUINFO_PROC	"cpu"
>
