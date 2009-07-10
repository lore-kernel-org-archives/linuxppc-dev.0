Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E3094B7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 01:04:24 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 34398DDDF4
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 01:04:23 +1000 (EST)
Date: Fri, 10 Jul 2009 08:04:21 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH v2] edac: mpc85xx: add support for mpc83xx memory
	controller
Message-ID: <20090710150420.GA11719@ovro.caltech.edu>
References: <2576.44687.qm@web50111.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2576.44687.qm@web50111.mail.re2.yahoo.com>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	Dave Jiang <djiang@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 09, 2009 at 04:24:38PM -0700, Doug Thompson wrote:
> 
> Ok, is this the one you want me to push upstream?
> 

Yep, this is the finished version.

Thanks,
Ira

> doug t
> 
> 
> --- On Thu, 7/9/09, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> 
> From: Ira W. Snyder <iws@ovro.caltech.edu>
> Subject: [PATCH v2] edac: mpc85xx: add support for mpc83xx memory controller
> To: bluesmoke-devel@lists.sourceforge.net, "Dave Jiang" <djiang@mvista.com>, "Kumar Gala" <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org
> Date: Thursday, July 9, 2009, 1:40 PM
> 
> Add support for the Freescale MPC83xx memory controller to the existing
> driver for the Freescale MPC85xx memory controller. The only difference
> between the two processors are in the CS_BNDS register parsing code, which
> has been changed so it will work on both processors.
> 
> The L2 cache controller does not exist on the MPC83xx, but the OF subsystem
> will not use the driver if the device is not present in the OF device tree.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> Kumar, I had to change the nr_pages calculation to make the math work
> out. I checked it on my board and did the math by hand for a 64GB 85xx
> using 64K pages. In both cases, nr_pages * PAGE_SIZE comes out to the
> correct value. Thanks for the help.
> 
> v1 -> v2:
>   * Use PAGE_SHIFT to parse cs_bnds regardless of board type
>   * Remove special-casing for the 83xx processor
> 
>  drivers/edac/Kconfig        |    6 +++---
>  drivers/edac/mpc85xx_edac.c |   28 +++++++++++++++++++---------
>  2 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 4339b1a..78303f9 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -176,11 +176,11 @@ config EDAC_I5100
>        San Clemente MCH.
>  
>  config EDAC_MPC85XX
> -    tristate "Freescale MPC85xx"
> -    depends on EDAC_MM_EDAC && FSL_SOC && MPC85xx
> +    tristate "Freescale MPC83xx / MPC85xx"
> +    depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || MPC85xx)
>      help
>        Support for error detection and correction on the Freescale
> -      MPC8560, MPC8540, MPC8548
> +      MPC8349, MPC8560, MPC8540, MPC8548
>  
>  config EDAC_MV64X60
>      tristate "Marvell MV64x60"
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index b4f5c63..ba2a264 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -43,7 +43,9 @@ static u32 orig_pci_err_en;
>  #endif
>  
>  static u32 orig_l2_err_disable;
> +#ifdef CONFIG_MPC85xx
>  static u32 orig_hid1[2];
> +#endif
>  
>  /************************ MC SYSFS parts ***********************************/
>  
> @@ -790,19 +792,20 @@ static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci)
>          csrow = &mci->csrows[index];
>          cs_bnds = in_be32(pdata->mc_vbase + MPC85XX_MC_CS_BNDS_0 +
>                    (index * MPC85XX_MC_CS_BNDS_OFS));
> -        start = (cs_bnds & 0xfff0000) << 4;
> -        end = ((cs_bnds & 0xfff) << 20);
> -        if (start)
> -            start |= 0xfffff;
> -        if (end)
> -            end |= 0xfffff;
> +
> +        start = (cs_bnds & 0xffff0000) >> 16;
> +        end   = (cs_bnds & 0x0000ffff);
>  
>          if (start == end)
>              continue;    /* not populated */
>  
> +        start <<= (24 - PAGE_SHIFT);
> +        end   <<= (24 - PAGE_SHIFT);
> +        end    |= (1 << (24 - PAGE_SHIFT)) - 1;
> +
>          csrow->first_page = start >> PAGE_SHIFT;
>          csrow->last_page = end >> PAGE_SHIFT;
> -        csrow->nr_pages = csrow->last_page + 1 - csrow->first_page;
> +        csrow->nr_pages = end + 1 - start;
>          csrow->grain = 8;
>          csrow->mtype = mtype;
>          csrow->dtype = DEV_UNKNOWN;
> @@ -986,6 +989,7 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
>      { .compatible = "fsl,mpc8560-memory-controller", },
>      { .compatible = "fsl,mpc8568-memory-controller", },
>      { .compatible = "fsl,mpc8572-memory-controller", },
> +    { .compatible = "fsl,mpc8349-memory-controller", },
>      {},
>  };
>  
> @@ -1001,13 +1005,13 @@ static struct of_platform_driver mpc85xx_mc_err_driver = {
>             },
>  };
>  
> -
> +#ifdef CONFIG_MPC85xx
>  static void __init mpc85xx_mc_clear_rfxe(void *data)
>  {
>      orig_hid1[smp_processor_id()] = mfspr(SPRN_HID1);
>      mtspr(SPRN_HID1, (orig_hid1[smp_processor_id()] & ~0x20000));
>  }
> -
> +#endif
>  
>  static int __init mpc85xx_mc_init(void)
>  {
> @@ -1040,26 +1044,32 @@ static int __init mpc85xx_mc_init(void)
>          printk(KERN_WARNING EDAC_MOD_STR "PCI fails to register\n");
>  #endif
>  
> +#ifdef CONFIG_MPC85xx
>      /*
>       * need to clear HID1[RFXE] to disable machine check int
>       * so we can catch it
>       */
>      if (edac_op_state == EDAC_OPSTATE_INT)
>          on_each_cpu(mpc85xx_mc_clear_rfxe, NULL, 0);
> +#endif
>  
>      return 0;
>  }
>  
>  module_init(mpc85xx_mc_init);
>  
> +#ifdef CONFIG_MPC85xx
>  static void __exit mpc85xx_mc_restore_hid1(void *data)
>  {
>      mtspr(SPRN_HID1, orig_hid1[smp_processor_id()]);
>  }
> +#endif
>  
>  static void __exit mpc85xx_mc_exit(void)
>  {
> +#ifdef CONFIG_MPC85xx
>      on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);
> +#endif
>  #ifdef CONFIG_PCI
>      of_unregister_platform_driver(&mpc85xx_pci_err_driver);
>  #endif
> -- 
> 1.5.4.3
> 
> 
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge  
> This is your chance to win up to $100,000 in prizes! For a limited time, 
> vendors submitting new applications to BlackBerry App World(TM) will have
> the opportunity to enter the BlackBerry Developer Challenge. See full prize  
> details at: http://p.sf.net/sfu/Challenge
> _______________________________________________
> bluesmoke-devel mailing list
> bluesmoke-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluesmoke-devel
> 
> 
