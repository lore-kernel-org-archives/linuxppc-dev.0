Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 453B0DDF72
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 16:20:40 +1100 (EST)
Subject: Re: [PATCH] powermac: use set_hard_smp_processor_id() instead of
	smp_hw_index
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <1228955322-16995-2-git-send-email-ntl@pobox.com>
References: <1228955322-16995-2-git-send-email-ntl@pobox.com>
Content-Type: text/plain
Date: Thu, 11 Dec 2008 16:20:29 +1100
Message-Id: <1228972829.22413.159.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-12-10 at 18:28 -0600, Nathan Lynch wrote:
> The hard_smp_processor_id functions are the appropriate interfaces for
> managing physical CPU ids.
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

> ---
>  arch/powerpc/platforms/powermac/smp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
> index 40f72c2..6b0711c 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -739,7 +739,7 @@ static void __init smp_core99_setup(int ncpus)
>  
>  		/* XXX should get this from reg properties */
>  		for (i = 1; i < ncpus; ++i)
> -			smp_hw_index[i] = i;
> +			set_hard_smp_processor_id(i, i);
>  	}
>  #endif
>  
