Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0142.outbound.protection.outlook.com [157.56.111.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04F4B1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 06:36:29 +1000 (AEST)
Message-ID: <1433795774.2477.64.camel@freescale.com>
Subject: Re: [PATCH v2] powerpc/cache: add cache flush operation for various
 e500
From: Scott Wood <scottwood@freescale.com>
To: <Yuantian.Tang@freescale.com>
CC: <b07421@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, Chenhui Zhao <chenhui.zhao@freescale.com>,
 Tang Yuantian <Yuantian.Tang@feescale.com>
Date: Mon, 8 Jun 2015 15:36:14 -0500
In-Reply-To: <1433757985-11653-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1433757985-11653-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-06-08 at 18:06 +0800, Yuantian.Tang@freescale.com wrote:
> +
> +_GLOBAL(flush_caches_e500v2)
> +     mflr r0
> +     bl      flush_dcache_L1
> +     mtlr r0
> +     blr
> +
> +_GLOBAL(flush_caches_e500mc)
> +_GLOBAL(flush_caches_e5500)
> +     mflr r0
> +     bl      flush_dcache_L1
> +     bl      flush_backside_L2_cache
> +     mtlr r0
> +     blr

s/flush_caches/cpu_down_flush/g


> +
> +/* L1 Data Cache of e6500 contains no modified data, no flush is 
> required */
> +_GLOBAL(flush_caches_e6500)
> +     blr
> diff --git a/arch/powerpc/kernel/cputable.c 
> b/arch/powerpc/kernel/cputable.c
> index 60262fd..ed388c7 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -2021,6 +2021,7 @@ static struct cpu_spec __initdata cpu_specs[] =
> {
>               .cpu_setup              = __setup_cpu_e500v2,
>               .machine_check          = machine_check_e500,
>               .platform               = "ppc8548",
> +             .cpu_down_flush = flush_caches_e500v2,
>       },
>  #else
>       {       /* e500mc */
> @@ -2040,6 +2041,7 @@ static struct cpu_spec __initdata cpu_specs[] =
> {
>               .cpu_setup              = __setup_cpu_e500mc,
>               .machine_check          = machine_check_e500mc,
>               .platform               = "ppce500mc",
> +             .cpu_down_flush = flush_caches_e500mc,
>       },

Please keep whitespace consistent with the rest of the structure.

-Scott
