Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A6751A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 16:25:45 +1100 (AEDT)
Message-ID: <1448515544.9839.11.camel@ellerman.id.au>
Subject: Re: [PATCH 7/7] powerpc: fix a problematic usage of WARN()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geliang Tang <geliangtang@163.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Scott Wood
 <scottwood@freescale.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Nov 2015 16:25:44 +1100
In-Reply-To: <84a366614b84091cd4bd354e8b65dd51c1762a52.1448456395.git.geliangtang@163.com>
References: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com>
 <84a366614b84091cd4bd354e8b65dd51c1762a52.1448456395.git.geliangtang@163.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-11-25 at 21:12 +0800, Geliang Tang wrote:
> WARN() takes a condition and a format string. The condition was
> omitted. So I added it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  arch/powerpc/kernel/setup_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 5c03a6a..726a9fb 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -127,7 +127,7 @@ static void setup_tlb_core_data(void)
>  		    !mmu_has_feature(MMU_FTR_USE_TLBRSRV) &&
>  		    book3e_htw_mode != PPC_HTW_E6500) {
>  			/* Should we panic instead? */
> -			WARN_ONCE("%s: unsupported MMU configuration -- expect problems\n",
> +			WARN_ONCE(1, "%s: unsupported MMU configuration -- expect problems\n",
>  				  __func__);
>  		}
>  	}

Oh yuck.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
