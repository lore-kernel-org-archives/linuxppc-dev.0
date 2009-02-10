Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 88264DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 09:02:19 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so55239qwe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 14:02:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090210161350.GA2596@iram.es>
References: <20090210161350.GA2596@iram.es>
Date: Tue, 10 Feb 2009 16:02:17 -0600
Message-ID: <b5e2fc790902101402i65dae8few43f18bdcb6b61fa2@mail.gmail.com>
Subject: Re: [PATCH] Disable mv643xx Ethernet port 0 on Pegasos
From: Matt Sealey <matt@genesi-usa.com>
To: Gabriel Paubert <paubert@iram.es>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Gabriel.

On Tue, Feb 10, 2009 at 10:13 AM, Gabriel Paubert <paubert@iram.es> wrote:
> After the last changes, the mv643xx_eth driver now detects
> a spurious interface on port 0. Since only port 1 is actually
> connected to a PHY, remove its description.
>
> Signed-off-by: Gabriel Paubert <paubert@iram.es>
>
> ---
>
> Tested on the last batch of Pegasos produced. Caveat: do not enable
> the Marvell PHY driver in your config, however the generic one works.
>
>
> diff --git a/arch/powerpc/platforms/chrp/pegasos_eth.c b/arch/powerpc/platforms/chrp/pegasos_eth.c
> index 130ff72..039fc8e 100644
> --- a/arch/powerpc/platforms/chrp/pegasos_eth.c
> +++ b/arch/powerpc/platforms/chrp/pegasos_eth.c
> @@ -21,8 +21,8 @@
>  #define PEGASOS2_SRAM_BASE                     (0xf2000000)
>  #define PEGASOS2_SRAM_SIZE                     (256*1024)
>
> -#define PEGASOS2_SRAM_BASE_ETH0                        (PEGASOS2_SRAM_BASE)
> -#define PEGASOS2_SRAM_BASE_ETH1                        (PEGASOS2_SRAM_BASE_ETH0 + (PEGASOS2_SRAM_SIZE / 2) )
> +#define PEGASOS2_SRAM_BASE_ETH_PORT0                   (PEGASOS2_SRAM_BASE)
> +#define PEGASOS2_SRAM_BASE_ETH_PORT1                   (PEGASOS2_SRAM_BASE_ETH_PORT0 + (PEGASOS2_SRAM_SIZE / 2) )
>
>
>  #define PEGASOS2_SRAM_RXRING_SIZE              (PEGASOS2_SRAM_SIZE/4)
> @@ -47,75 +47,42 @@ static struct platform_device mv643xx_eth_shared_device = {
>        .resource       = mv643xx_eth_shared_resources,
>  };
>
> -static struct resource mv643xx_eth0_resources[] = {
> +static struct resource mv643xx_eth_port1_resources[] = {
>        [0] = {
> -               .name   = "eth0 irq",
> +               .name   = "eth port1 irq",
>                .start  = 9,
>                .end    = 9,
>                .flags  = IORESOURCE_IRQ,
>        },
>  };
>
> -
> -static struct mv643xx_eth_platform_data eth0_pd = {
> -       .shared         = &mv643xx_eth_shared_device,
> -       .port_number    = 0,
> -
> -       .tx_sram_addr = PEGASOS2_SRAM_BASE_ETH0,
> -       .tx_sram_size = PEGASOS2_SRAM_TXRING_SIZE,
> -       .tx_queue_size = PEGASOS2_SRAM_TXRING_SIZE/16,
> -
> -       .rx_sram_addr = PEGASOS2_SRAM_BASE_ETH0 + PEGASOS2_SRAM_TXRING_SIZE,
> -       .rx_sram_size = PEGASOS2_SRAM_RXRING_SIZE,
> -       .rx_queue_size = PEGASOS2_SRAM_RXRING_SIZE/16,
> -};
> -
> -static struct platform_device eth0_device = {
> -       .name           = MV643XX_ETH_NAME,
> -       .id             = 0,
> -       .num_resources  = ARRAY_SIZE(mv643xx_eth0_resources),
> -       .resource       = mv643xx_eth0_resources,
> -       .dev = {
> -               .platform_data = &eth0_pd,
> -       },
> -};
> -
> -static struct resource mv643xx_eth1_resources[] = {
> -       [0] = {
> -               .name   = "eth1 irq",
> -               .start  = 9,
> -               .end    = 9,
> -               .flags  = IORESOURCE_IRQ,
> -       },
> -};
> -
> -static struct mv643xx_eth_platform_data eth1_pd = {
> +static struct mv643xx_eth_platform_data eth_port1_pd = {
>        .shared         = &mv643xx_eth_shared_device,
>        .port_number    = 1,
> +       .phy_addr       = MV643XX_ETH_PHY_ADDR(7),
>
> -       .tx_sram_addr = PEGASOS2_SRAM_BASE_ETH1,
> +       .tx_sram_addr = PEGASOS2_SRAM_BASE_ETH_PORT1,
>        .tx_sram_size = PEGASOS2_SRAM_TXRING_SIZE,
>        .tx_queue_size = PEGASOS2_SRAM_TXRING_SIZE/16,
>
> -       .rx_sram_addr = PEGASOS2_SRAM_BASE_ETH1 + PEGASOS2_SRAM_TXRING_SIZE,
> +       .rx_sram_addr = PEGASOS2_SRAM_BASE_ETH_PORT1 + PEGASOS2_SRAM_TXRING_SIZE,
>        .rx_sram_size = PEGASOS2_SRAM_RXRING_SIZE,
>        .rx_queue_size = PEGASOS2_SRAM_RXRING_SIZE/16,
>  };
>
> -static struct platform_device eth1_device = {
> +static struct platform_device eth_port1_device = {
>        .name           = MV643XX_ETH_NAME,
>        .id             = 1,
> -       .num_resources  = ARRAY_SIZE(mv643xx_eth1_resources),
> -       .resource       = mv643xx_eth1_resources,
> +       .num_resources  = ARRAY_SIZE(mv643xx_eth_port1_resources),
> +       .resource       = mv643xx_eth_port1_resources,
>        .dev = {
> -               .platform_data = &eth1_pd,
> +               .platform_data = &eth_port1_pd,
>        },
>  };
>
>  static struct platform_device *mv643xx_eth_pd_devs[] __initdata = {
>        &mv643xx_eth_shared_device,
> -       &eth0_device,
> -       &eth1_device,
> +       &eth_port1_device,
>  };
>
>  /***********/
> @@ -191,15 +158,10 @@ static int __init mv643xx_eth_add_pds(void)
>
>                if ( Enable_SRAM() < 0)
>                {
> -                       eth0_pd.tx_sram_addr = 0;
> -                       eth0_pd.tx_sram_size = 0;
> -                       eth0_pd.rx_sram_addr = 0;
> -                       eth0_pd.rx_sram_size = 0;
> -
> -                       eth1_pd.tx_sram_addr = 0;
> -                       eth1_pd.tx_sram_size = 0;
> -                       eth1_pd.rx_sram_addr = 0;
> -                       eth1_pd.rx_sram_size = 0;
> +                       eth_port1_pd.tx_sram_addr = 0;
> +                       eth_port1_pd.tx_sram_size = 0;
> +                       eth_port1_pd.rx_sram_addr = 0;
> +                       eth_port1_pd.rx_sram_size = 0;
>
>  #ifdef BE_VERBOSE
>                        printk("Pegasos II/Marvell MV64361: Can't enable the "
>



-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
