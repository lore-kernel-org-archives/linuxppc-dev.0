Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 3120F2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 15:38:12 +1100 (EST)
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by muin.pair.com (Postfix) with ESMTPSA id CDAC08FC2C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 23:31:53 -0500 (EST)
Received: by mail-la0-f49.google.com with SMTP id fs13so3346787lab.36
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2013 20:31:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1359725305-23916-1-git-send-email-agust@denx.de>
References: <1359725305-23916-1-git-send-email-agust@denx.de>
Date: Fri, 1 Feb 2013 22:31:51 -0600
Message-ID: <CAOZdJXUfe5KWBtabUUPrGHhcFb6dbnPNJCsU23yoxb-4GeKQsg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/512x: add function for CS parameter configuration
From: Timur Tabi <timur@tabi.org>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 1, 2013 at 7:28 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Add ability to configure CS parameters for devices that need
> different CS parameters setup after their configuration. I.e.
> an FPGA device on LP bus can require different CS parameters
> for its bus interface after loading firmware into it. A driver
> can easily reconfigure the LPC CS parameters using this function.

Could you define "CS" somewhere?

> +struct mpc512x_lpc {
> +       u32     cs_cfg[8];      /* CS config */
> +       u32     cs_ctrl;        /* CS Control Register */
> +       u32     cs_status;      /* CS Status Register */
> +       u32     burst_ctrl;     /* CS Burst Control Register */
> +       u32     deadcycle_ctrl; /* CS Deadcycle Control Register */
> +       u32     holdcycle_ctrl; /* CS Holdcycle Control Register */
> +       u32     alt;            /* Address Latch Timing Register */
> +};

These should be __be32.

> +
> +int mpc512x_cs_config(int cs, u32 val);
> +
>  #endif /* __ASM_POWERPC_MPC5121_H__ */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
> index c344438..112b4f6 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -436,3 +436,33 @@ void __init mpc512x_init(void)
>         mpc512x_restart_init();
>         mpc512x_psc_fifo_init();
>  }
> +
> +/**
> + * mpc512x_cs_config - Setup chip select configuration
> + * @cs: chip select number
> + * @val: chip select configuration value
> + *
> + * Perform chip select configuration for devices on LocalPlus Bus.
> + * Intended to dynamically reconfigure the chip select parameters
> + * for configurable devices on the bus.
> + */
> +int mpc512x_cs_config(int cs, u32 val)
> +{
> +       static struct mpc512x_lpc __iomem *lpc;
> +       struct device_node *np;
> +
> +       if (cs < 0 || cs > 7)
> +               return -EINVAL;

If you make cs an unsigned int, you won't need to test for < 0.

> +
> +       if (!lpc) {
> +               np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-lpc");
> +               lpc = of_iomap(np, 0);
> +               of_node_put(np);
> +               if (!lpc)
> +                       return -ENOMEM;
> +       }
> +
> +       out_be32(&lpc->cs_cfg[cs], val);

You forgot the iounmap() if lpc == NULL.

> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mpc512x_cs_config);

EXPORT_SYMBOL, please, to match the rest of the Freescale platforms.



-- 
Timur Tabi
Linux kernel developer at Freescale
