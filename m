Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 51A852C007B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 11:11:05 +1100 (EST)
Message-ID: <1387152653.15730.175.camel@pasglop>
Subject: Re: [PATCH] powerpc/sysdev: Fix a mpic section mismatch for MPC85xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Engelmayer <cengelma@gmx.at>
Date: Mon, 16 Dec 2013 11:10:53 +1100
In-Reply-To: <20131215193856.1637accd@spike>
References: <20131215193856.1637accd@spike>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-12-15 at 19:38 +0100, Christian Engelmayer wrote:
> Moved arch/powerpc/sysdev/mpic.c : smp_mpic_probe() out of the __init section.
> It is referenced by arch/powerpc/platforms/85xx/smp.c : smp_85xx_setup_cpu().

I don't like this. The reference is not actually going to call into the
code at all and as such is not an error, it's just a pointer comparison.

If there is no way to silence the warning, then I'd suggest to use a
global flag, something like mpc85xx_pic_type and test that instead
of comparing the pointers.

> Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
> ---
>  arch/powerpc/sysdev/mpic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 0e166ed..72c1e65 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1924,7 +1924,7 @@ void smp_mpic_message_pass(int cpu, int msg)
>  		       msg * MPIC_INFO(CPU_IPI_DISPATCH_STRIDE), physmask);
>  }
>  
> -int __init smp_mpic_probe(void)
> +int smp_mpic_probe(void)
>  {
>  	int nr_cpus;
>  
