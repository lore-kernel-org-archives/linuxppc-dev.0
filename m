Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0101.outbound.protection.outlook.com [157.56.111.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADB471A03D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 21:14:20 +1100 (AEDT)
From: "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [1/4] powerpc/cache: add cache flush operation for various e500
Date: Thu, 2 Apr 2015 10:14:11 +0000
Message-ID: <1427969652830.68303@freescale.com>
References: <1427365095-26396-1-git-send-email-chenhui.zhao@freescale.com>,
 <20150331011028.GA5667@home.buserror.net>
In-Reply-To: <20150331011028.GA5667@home.buserror.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


________________________________________
From: Wood Scott-B07421
Sent: Tuesday, March 31, 2015 9:10
To: Zhao Chenhui-B35336
Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; linux-kernel=
@vger.kernel.org; Jin Zhengxiong-R64188
Subject: Re: [1/4] powerpc/cache: add cache flush operation for various e50=
0

On Thu, Mar 26, 2015 at 06:18:12PM +0800, chenhui zhao wrote:
> Various e500 core have different cache architecture, so they
> need different cache flush operations. Therefore, add a callback
> function cpu_flush_caches to the struct cpu_spec. The cache flush
> operation for the specific kind of e500 is selected at init time.
> The callback function will flush all caches inside the current cpu.
>
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/include/asm/cacheflush.h     |   2 -
>  arch/powerpc/include/asm/cputable.h       |  11 +++
>  arch/powerpc/kernel/asm-offsets.c         |   3 +
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S | 114 ++++++++++++++++++++++++=
+++++-
>  arch/powerpc/kernel/cputable.c            |   4 ++
>  arch/powerpc/kernel/head_fsl_booke.S      |  74 -------------------
>  arch/powerpc/platforms/85xx/smp.c         |   3 +-
>  7 files changed, 133 insertions(+), 78 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include=
/asm/cacheflush.h
> index 30b35ff..729fde4 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -30,8 +30,6 @@ extern void flush_dcache_page(struct page *page);
>  #define flush_dcache_mmap_lock(mapping)              do { } while (0)
>  #define flush_dcache_mmap_unlock(mapping)    do { } while (0)
>
> -extern void __flush_disable_L1(void);
> -
>  extern void flush_icache_range(unsigned long, unsigned long);
>  extern void flush_icache_user_range(struct vm_area_struct *vma,
>                                   struct page *page, unsigned long addr,
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/a=
sm/cputable.h
> index 5cf5a6d..c776efe4 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -43,6 +43,13 @@ extern int machine_check_e500(struct pt_regs *regs);
>  extern int machine_check_e200(struct pt_regs *regs);
>  extern int machine_check_47x(struct pt_regs *regs);
>
> +#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)
> +extern void __flush_caches_e500v2(void);
> +extern void __flush_caches_e500mc(void);
> +extern void __flush_caches_e5500(void);
> +extern void __flush_caches_e6500(void);
> +#endif

Why the leading underscores?

[chenhui] Will get rid of them.

>  /* NOTE WELL: Update identify_cpu() if fields are added or removed! */
>  struct cpu_spec {
>       /* CPU is matched via (PVR & pvr_mask) =3D=3D pvr_value */
> @@ -59,6 +66,10 @@ struct cpu_spec {
>       unsigned int    icache_bsize;
>       unsigned int    dcache_bsize;
>
> +#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC)

CONFIG_PPC_E500MC implies CONFIG_E500.  Why do we need this ifdef?

[chenhui] Change to "#ifdef CONFIG_E500".

> +     /* flush caches inside the current cpu */
> +     void (*cpu_flush_caches)(void);
> +#endif

It seems you literally mean "in the cpu" -- If it's a threaded core, then
by "cpu" do you mean "thread" (like we usually do) and thus no caches get
flushed (ignore the fact that it's moot on e6500 -- this is an interface
and needs to be clear).

Also, no-oping L1 flush on e6500 is not compliant with the claim that
you're flushing the cache.  You're relying on an unstated assumption that
you'll invalidate that cache later instead.

If you want to make this "flush whatever needs to be flushed for
suspend/hotplug", call it that.

-Scott

[chenhui] OK. Then, call "cpu_down_flush".
