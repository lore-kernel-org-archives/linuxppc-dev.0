Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hcFh2fthzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 16:14:32 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w736EFui038850
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Aug 2018 02:14:29 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kmgc7akuv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Aug 2018 02:14:29 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Fri, 3 Aug 2018 07:14:27 +0100
Date: Fri, 3 Aug 2018 11:44:21 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv/cpuidle: Fix idle states all being marked invalid
References: <20180802153951.3576-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180802153951.3576-1-npiggin@gmail.com>
Message-Id: <20180803061421.6bo6dvmj34oea3pb@aksadiga.ibm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2018 at 01:39:51AM +1000, Nicholas Piggin wrote:
> Commit 9c7b185ab2 ("powernv/cpuidle: Parse dt idle properties into
> global structure") parses dt idle states into structs, but never
> marks them valid. This results in all idle states being lost.
>
My bad. Thanks nick for fixing this. We definatetely need this.


> Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/powernv/idle.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 3116bab10aa3..ecb002c5db83 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -651,11 +651,12 @@ static int __init pnv_power9_idle_init(void)
>  					      &state->psscr_mask,
>  					      state->flags);
>  		if (err) {
> -			state->valid = false;
>  			report_invalid_psscr_val(state->psscr_val, err);
>  			continue;
>  		}
> 
> +		state->valid = true;
> +
>  		if (max_residency_ns < state->residency_ns) {
>  			max_residency_ns = state->residency_ns;
>  			pnv_deepest_stop_psscr_val = state->psscr_val;
> -- 
> 2.17.0
> 
