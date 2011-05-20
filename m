Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58F53B71A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 10:35:23 +1000 (EST)
Subject: Re: [PATCH 2/7] [RFC] add bluegene entry to cputable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
In-Reply-To: <1305753895-24845-2-git-send-email-ericvh@gmail.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-2-git-send-email-ericvh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 10:35:09 +1000
Message-ID: <1305851709.7481.89.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-18 at 16:24 -0500, Eric Van Hensbergen wrote:
> Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
> ---
>  arch/powerpc/kernel/cputable.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index b9602ee..0eb245e 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -1732,6 +1732,20 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.machine_check		= machine_check_440A,
>  		.platform		= "ppc440",
>  	},
> +	{ /* Blue Gene/P */
> +		.pvr_mask		= 0xfffffff0,
> +		.pvr_value		= 0x52131880,
> +		.cpu_name		= "450 Blue Gene/P",
> +		.cpu_features		= CPU_FTRS_440x6,
> +		.cpu_user_features	= COMMON_USER_BOOKE |
> +						PPC_FEATURE_HAS_FPU,
> +		.mmu_features		= MMU_FTR_TYPE_44x,
> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 32,
> +		.cpu_setup		= __setup_cpu_460gt,
                                            ^^^^^^^^^^^^^^^^^^
Are you sure ?

Cheers,
Ben.

> +		.machine_check		= machine_check_440A,
> +		.platform		= "ppc440",
> +	},
>  	{ /* 460EX */
>  		.pvr_mask		= 0xffff0006,
>  		.pvr_value		= 0x13020002,
