Return-Path: <slightlyunconventional@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.189])
	by ozlabs.org (Postfix) with ESMTP id 05C1EDDDEA
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 10:03:37 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so2202857rnf.16
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Dec 2008 15:03:35 -0800 (PST)
Message-ID: <fb412d760812011503h7453d4dbt8e748c065ba364b6@mail.gmail.com>
Date: Mon, 1 Dec 2008 17:03:34 -0600
From: "Hollis Blanchard" <hollis@penguinppc.org>
Sender: slightlyunconventional@gmail.com
To: "Paul Mackerras" <paulus@samba.org>,
	"Ben Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH] [v4] ppc: force memory size to be a multiple of PAGE_SIZE
In-Reply-To: <654d47bb9cbd63f515bf.1227716366@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <654d47bb9cbd63f515bf.1227716366@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Milton Miller <miltonm@bga.com>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 26, 2008 at 10:19 AM, Hollis Blanchard <hollisb@us.ibm.com> wrote:
> Ensure that total memory size is page-aligned, because otherwise
> mark_bootmem() gets upset.
>
> This error case was triggered by using 64 KiB pages in the kernel while
> arch/powerpc/boot/4xx.c arbitrarily reduced the amount of memory by 4096 (to
> work around a chip bug that affects the last 256 bytes of physical memory).
>
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
> ---
> Changes from v3:
> - No need to call lmb_enforce_memory_limit() with limit=lmb_phys_mem_size().
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -1160,6 +1160,8 @@ static inline void __init phyp_dump_rese
>
>  void __init early_init_devtree(void *params)
>  {
> +       unsigned long limit;
> +
>        DBG(" -> early_init_devtree(%p)\n", params);
>
>        /* Setup flat device-tree pointer */
> @@ -1200,7 +1202,19 @@ void __init early_init_devtree(void *par
>        early_reserve_mem();
>        phyp_dump_reserve_mem();
>
> -       lmb_enforce_memory_limit(memory_limit);
> +       limit = memory_limit;
> +       if (! limit) {
> +               unsigned long memsize;
> +
> +               /* Ensure that total memory size is page-aligned, because
> +                * otherwise mark_bootmem() gets upset. */
> +               lmb_analyze();
> +               memsize = lmb_phys_mem_size();
> +               if ((memsize & PAGE_MASK) != memsize)
> +                       limit = memsize & PAGE_MASK;
> +       }
> +       lmb_enforce_memory_limit(limit);
> +
>        lmb_analyze();
>
>        DBG("Phys. mem: %lx\n", lmb_phys_mem_size());

Paul or Ben: since there have been no further comments on this, would
you queue it up for 2.6.29? Thanks.

-Hollis
