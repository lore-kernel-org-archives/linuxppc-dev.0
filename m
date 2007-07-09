Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 572BFDDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jul 2007 01:58:05 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1372357wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 09 Jul 2007 08:58:04 -0700 (PDT)
Message-ID: <fa686aa40707090858x6f6a5318i113e3e02e5f4af35@mail.gmail.com>
Date: Mon, 9 Jul 2007 09:58:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH] mpc52xx: sparse fixes
In-Reply-To: <20070709075203.GF4186@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070621074507.GL23294@moe.telargo.com>
	<20070709075203.GF4186@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/9/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> sparse caught these static functions / __iomem annotations
> under arch/powerpc/platform/52xx/
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

>
> ---
> Reposting, adding tnt to Cc, and requesting inclusion.
> The patch is pretty much harmless :-)
>
>
>  arch/powerpc/platforms/52xx/efika.c      |    4 ++--
>  arch/powerpc/platforms/52xx/lite5200.c   |    2 +-
>  arch/powerpc/platforms/52xx/mpc52xx_pm.c |    8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> Index: work-powerpc.git/arch/powerpc/platforms/52xx/efika.c
> ===================================================================
> --- work-powerpc.git.orig/arch/powerpc/platforms/52xx/efika.c
> +++ work-powerpc.git/arch/powerpc/platforms/52xx/efika.c
> @@ -83,7 +83,7 @@ static struct pci_ops rtas_pci_ops = {
>  };
>
>
> -void __init efika_pcisetup(void)
> +static void __init efika_pcisetup(void)
>  {
>         const int *bus_range;
>         int len;
> @@ -145,7 +145,7 @@ void __init efika_pcisetup(void)
>  }
>
>  #else
> -void __init efika_pcisetup(void)
> +static void __init efika_pcisetup(void)
>  {}
>  #endif
>
> Index: work-powerpc.git/arch/powerpc/platforms/52xx/lite5200.c
> ===================================================================
> --- work-powerpc.git.orig/arch/powerpc/platforms/52xx/lite5200.c
> +++ work-powerpc.git/arch/powerpc/platforms/52xx/lite5200.c
> @@ -156,7 +156,7 @@ static void __init lite5200_setup_arch(v
>
>  }
>
> -void lite5200_show_cpuinfo(struct seq_file *m)
> +static void lite5200_show_cpuinfo(struct seq_file *m)
>  {
>         struct device_node* np = of_find_all_nodes(NULL);
>         const char *model = NULL;
> Index: work-powerpc.git/arch/powerpc/platforms/52xx/mpc52xx_pm.c
> ===================================================================
> --- work-powerpc.git.orig/arch/powerpc/platforms/52xx/mpc52xx_pm.c
> +++ work-powerpc.git/arch/powerpc/platforms/52xx/mpc52xx_pm.c
> @@ -9,8 +9,8 @@
>
>
>  /* these are defined in mpc52xx_sleep.S, and only used here */
> -extern void mpc52xx_deep_sleep(void *sram, void *sdram_regs,
> -               struct mpc52xx_cdm *, struct mpc52xx_intr *);
> +extern void mpc52xx_deep_sleep(void __iomem *sram, void __iomem *sdram_regs,
> +               struct mpc52xx_cdm __iomem *, struct mpc52xx_intr __iomem*);
>  extern void mpc52xx_ds_sram(void);
>  extern const long mpc52xx_ds_sram_size;
>  extern void mpc52xx_ds_cached(void);
> @@ -21,7 +21,7 @@ static void __iomem *sdram;
>  static struct mpc52xx_cdm __iomem *cdm;
>  static struct mpc52xx_intr __iomem *intr;
>  static struct mpc52xx_gpio_wkup __iomem *gpiow;
> -static void *sram;
> +static void __iomem *sram;
>  static int sram_size;
>
>  struct mpc52xx_suspend mpc52xx_suspend;
> @@ -100,7 +100,7 @@ int mpc52xx_pm_enter(suspend_state_t sta
>         u32 clk_enables;
>         u32 msr, hid0;
>         u32 intr_main_mask;
> -       void __iomem * irq_0x500 = (void *)CONFIG_KERNEL_START + 0x500;
> +       void __iomem * irq_0x500 = (void __iomem *)CONFIG_KERNEL_START + 0x500;
>         unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
>         char saved_0x500[mpc52xx_ds_cached_size];
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
