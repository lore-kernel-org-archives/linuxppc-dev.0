Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXvgc5mWXzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 22:19:08 +1100 (AEDT)
Date: Sun, 27 Mar 2016 13:19:03 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] perf tools: Fix build break on powerpc
Message-ID: <20160327111903.GC4015@krava.sund.root.ku.dk>
References: <20160326180146.GA32441@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160326180146.GA32441@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 26, 2016 at 11:01:47AM -0700, Sukadev Bhattiprolu wrote:
> From 502e8236082412db1d33abfad95aaf14b539502e Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Sat, 26 Mar 2016 17:31:39 -0400
> Subject: [PATCH 1/1] perf tools: Fix build break on powerpc
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> 'Commit 531d2410635c ("perf tools: Do not include stringify.h from the
> kernel sources")' seems to have accidentially removed the inclusion of
> "util/header.h" from "arch/powerpc/util/header.c".
> 
> "util/header.h" provides the prototype for get_cpuid() and is needed to
> build perf on Powerpc.
> 
> 	arch/powerpc/util/header.c:17:1: error: no previous prototype for
> 	‘get_cpuid’ [-Werror=missing-prototypes]
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/header.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
> index 6138bde..5111e34 100644
> --- a/tools/perf/arch/powerpc/util/header.c
> +++ b/tools/perf/arch/powerpc/util/header.c
> @@ -4,6 +4,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <linux/stringify.h>
> +#include "../../util/header.h"

you could use just "header.h" right?

jirka
