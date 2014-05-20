Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DC11A086E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 20:33:08 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 20 May 2014 20:33:07 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0836B2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 20:33:07 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4KAWpfc10617206
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 20:32:51 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4KAX6aL013886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 20:33:06 +1000
Message-ID: <537B2F16.6030504@linux.vnet.ibm.com>
Date: Tue, 20 May 2014 16:01:50 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Fix build error when CONFIG_SMP=n
References: <1400579726-26206-1-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1400579726-26206-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/20/2014 03:25 PM, Shreyas B. Prabhu wrote:
> Fix the following build error when compiled with CONFIG_SMP=n
> arch/powerpc/platforms/powernv/setup.c: In function ‘pnv_kexec_wait_secondaries_down’:
> arch/powerpc/platforms/powernv/setup.c:179:4: error: implicit declaration of function ‘get_hard_smp_processor_id’ [-Werror=implicit-function-declaration]
>     rc = opal_query_cpu_status(get_hard_smp_processor_id(i),
> 
> The usage of get_hard_smp_processor_id() needs the declaration from <asm/smp.h>.
> The file setup.c includes <linux/sched.h>, which in-turn includes <linux/smp.h>.
> However, <linux/smp.h> includes <asm/smp.h> only on SMP configs and hence UP
> builds fail. Fix this by directly including <asm/smp.h> in setup.c
> unconditionally.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> ---
>  arch/powerpc/platforms/powernv/setup.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 8723d32..e6bde98 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -34,6 +34,7 @@
>  #include <asm/rtas.h>
>  #include <asm/opal.h>
>  #include <asm/kexec.h>
> +#include <asm/smp.h>
> 
>  #include "powernv.h"
> 
