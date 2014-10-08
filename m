Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7AD61A033F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 21:14:56 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Oct 2014 15:44:48 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7FAEB3940048
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 15:44:43 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s98AGxNi59048136
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Oct 2014 15:47:00 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s98AEfLA002375
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Oct 2014 15:44:42 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linux-kernel@vger.kernel.or
Subject: Re: [PATCH] tools/perf/powerpc: Fix build break
In-Reply-To: <1408004299-18986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1408004299-18986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 08 Oct 2014 15:44:41 +0530
Message-ID: <87oatm3m26.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

>   CC       arch/powerpc/util/skip-callchain-idx.o
> arch/powerpc/util/skip-callchain-idx.c: In function =E2=80=98check_return=
_reg=E2=80=99:
> arch/powerpc/util/skip-callchain-idx.c:55:3: error: implicit declaration =
of function =E2=80=98pr_debug=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
>    pr_debug("dwarf_frame_register() %s\n", dwarf_errmsg(-1));
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/pe=
rf/arch/powerpc/util/skip-callchain-idx.c
> index a7c23a4b3778..d73ef8bb08c7 100644
> --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> @@ -15,6 +15,7 @@
>
>  #include "util/thread.h"
>  #include "util/callchain.h"
> +#include "util/debug.h"
>
>  /*
>   * When saving the callchain on Power, the kernel conservatively saves

We still have this broken upstream.

-aneesh
