Return-Path: <plasmaroo@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.225])
	by ozlabs.org (Postfix) with ESMTP id 43F3CDE10A
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 19:38:20 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so298430rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jul 2008 02:38:18 -0700 (PDT)
Message-ID: <792f5f410807020238x3efca5fagd568ea49473e768f@mail.gmail.com>
Date: Wed, 2 Jul 2008 10:38:18 +0100
From: "Tim Yamin" <plasm@roo.me.uk>
Sender: plasmaroo@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/mpc5200: Fix lite5200b suspend/resume
In-Reply-To: <20080701211033.13852.31692.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701211033.13852.31692.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

This patch works fine for me.

Cheers,

Tim

On Tue, Jul 1, 2008 at 10:12 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Tim Yamin <plasm@roo.me.uk>
>
> Suspend/resume ("echo mem > /sys/power/state") does not work with
> vanilla kernels -- the system does not suspend correctly and just
> hangs. This patch fixes this so suspend/resume works:
>
> 1) of_iomap does not map the whole 0xC000 of the MPC5200 immr so
> saving registers does not work.
> 2) PCI registers need to be saved and restored.
>
> Signed-off-by: Tim Yamin <plasm@roo.me.uk>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> Tim, please test this version.  I fixed a couple of bugs and want to make
> sure I haven't broken anything.  Once you ack it I'll ask Paul to pull it
> into 2.6.26.
>
> g.
>
>  arch/powerpc/platforms/52xx/lite5200_pm.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/lite5200_pm.c b/arch/powerpc/platforms/52xx/lite5200_pm.c
> index 41c7fd9..fe92e65 100644
> --- a/arch/powerpc/platforms/52xx/lite5200_pm.c
> +++ b/arch/powerpc/platforms/52xx/lite5200_pm.c
> @@ -14,6 +14,7 @@ static struct mpc52xx_sdma __iomem *bes;
>  static struct mpc52xx_xlb __iomem *xlb;
>  static struct mpc52xx_gpio __iomem *gps;
>  static struct mpc52xx_gpio_wkup __iomem *gpw;
> +static void __iomem *pci;
>  static void __iomem *sram;
>  static const int sram_size = 0x4000;   /* 16 kBytes */
>  static void __iomem *mbar;
> @@ -50,6 +51,8 @@ static int lite5200_pm_prepare(void)
>                { .type = "builtin", .compatible = "mpc5200", }, /* efika */
>                {}
>        };
> +       u64 regaddr64 = 0;
> +       const u32 *regaddr_p;
>
>        /* deep sleep? let mpc52xx code handle that */
>        if (lite5200_pm_target_state == PM_SUSPEND_STANDBY)
> @@ -60,8 +63,12 @@ static int lite5200_pm_prepare(void)
>
>        /* map registers */
>        np = of_find_matching_node(NULL, immr_ids);
> -       mbar = of_iomap(np, 0);
> +       regaddr_p = of_get_address(np, 0, NULL, NULL);
> +       if (regaddr_p)
> +               regaddr64 = of_translate_address(np, regaddr_p);
>        of_node_put(np);
> +
> +       mbar = ioremap((u32) regaddr64, 0xC000);
>        if (!mbar) {
>                printk(KERN_ERR "%s:%i Error mapping registers\n", __func__, __LINE__);
>                return -ENOSYS;
> @@ -71,6 +78,7 @@ static int lite5200_pm_prepare(void)
>        pic = mbar + 0x500;
>        gps = mbar + 0xb00;
>        gpw = mbar + 0xc00;
> +       pci = mbar + 0xd00;
>        bes = mbar + 0x1200;
>        xlb = mbar + 0x1f00;
>        sram = mbar + 0x8000;
> @@ -85,6 +93,7 @@ static struct mpc52xx_sdma sbes;
>  static struct mpc52xx_xlb sxlb;
>  static struct mpc52xx_gpio sgps;
>  static struct mpc52xx_gpio_wkup sgpw;
> +static char spci[0x200];
>
>  static void lite5200_save_regs(void)
>  {
> @@ -94,6 +103,7 @@ static void lite5200_save_regs(void)
>        _memcpy_fromio(&sxlb, xlb, sizeof(*xlb));
>        _memcpy_fromio(&sgps, gps, sizeof(*gps));
>        _memcpy_fromio(&sgpw, gpw, sizeof(*gpw));
> +       _memcpy_fromio(spci, pci, 0x200);
>
>        _memcpy_fromio(saved_sram, sram, sram_size);
>  }
> @@ -103,6 +113,8 @@ static void lite5200_restore_regs(void)
>        int i;
>        _memcpy_toio(sram, saved_sram, sram_size);
>
> +       /* PCI Configuration */
> +       _memcpy_toio(pci, spci, 0x200);
>
>        /*
>         * GPIOs. Interrupt Master Enable has higher address then other
