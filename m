Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjfC54rlszDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:43:29 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/6] powerpc/xics: Fully qualify cast to silence sparse
Date: Mon, 04 Jul 2016 09:46:21 +0200
Message-ID: <6138424.54EmzRVKbE@wuerfel>
In-Reply-To: <1467616182-30886-3-git-send-email-dja@axtens.net>
References: <1467616182-30886-1-git-send-email-dja@axtens.net>
 <1467616182-30886-3-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, July 4, 2016 5:09:39 PM CEST Daniel Axtens wrote:
> Make the cast fully line up with what out_rm8 expects.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/sysdev/xics/icp-native.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
> index afdf62f2a695..e9cffb06cc01 100644
> --- a/arch/powerpc/sysdev/xics/icp-native.c
> +++ b/arch/powerpc/sysdev/xics/icp-native.c
> @@ -176,7 +176,7 @@ void icp_native_cause_ipi_rm(int cpu)
>          * causing the IPI.
>          */
>         xics_phys = paca[cpu].kvm_hstate.xics_phys;
> -       out_rm8((u8 *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
> +       out_rm8((volatile u8 __iomem *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
>  }

We don't normally mark pointers as 'volatile' when passing them
to the MMIO accessors. The reason that they take a volatile argument
is mainly to avoid a warning for drivers that for historic reasons
use volatile pointers intead of __iomem pointers.

	Arnd
