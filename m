Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 4C2DCDDE1B
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 17:17:18 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so546124anc
	for <linuxppc-dev@ozlabs.org>; Sat, 01 Dec 2007 22:17:17 -0800 (PST)
Message-ID: <fa686aa40712012217n2e9698eay71b9bef7e97c63fe@mail.gmail.com>
Date: Sat, 1 Dec 2007 23:17:17 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, vitb@kernel.crashing.org,
	galak@kernel.crashing.org, olof@lixom.net, jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH v2 2/2] [POWERPC] Use new machine_xxx_initcall hooks in
	platform code
In-Reply-To: <20071202061033.21193.64818.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071202061028.21193.39309.stgit@trillian.secretlab.ca>
	<20071202061033.21193.64818.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/1/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> This patch makes the platform code use the new machine-specific initcall
> hooks.  This has the advantage of not needing to explicitly test
> machine_is() at the top of every initcall function.

Warning: I have *not* exhaustively tested this; just spot checked in a
few places.  I'll be more thorough once I know everyone is okay with
it in principle.

Cheers,
g.

>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  arch/powerpc/platforms/40x/kilauea.c         |    5 +----
>  arch/powerpc/platforms/40x/virtex.c          |    5 +----
>  arch/powerpc/platforms/40x/walnut.c          |    5 +----
>  arch/powerpc/platforms/44x/bamboo.c          |    5 +----
>  arch/powerpc/platforms/44x/ebony.c           |    5 +----
>  arch/powerpc/platforms/44x/sequoia.c         |    5 +----
>  arch/powerpc/platforms/82xx/mpc8272_ads.c    |    5 +----
>  arch/powerpc/platforms/82xx/pq2fads.c        |    5 +----
>  arch/powerpc/platforms/83xx/mpc832x_mds.c    |    5 +----
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11 ++---------
>  arch/powerpc/platforms/83xx/mpc836x_mds.c    |    5 +----
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c    |    5 +----
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c    |    6 +-----
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    5 +----
>  arch/powerpc/platforms/8xx/ep88xc.c          |    5 ++---
>  arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 ++---
>  arch/powerpc/platforms/cell/io-workarounds.c |    5 +----
>  arch/powerpc/platforms/cell/iommu.c          |    5 +----
>  arch/powerpc/platforms/cell/pmu.c            |    5 +----
>  arch/powerpc/platforms/cell/setup.c          |    5 +----
>  arch/powerpc/platforms/celleb/iommu.c        |    6 +-----
>  arch/powerpc/platforms/celleb/setup.c        |    5 +----
>  arch/powerpc/platforms/embedded6xx/ls_uart.c |    5 +----
>  arch/powerpc/platforms/pasemi/idle.c         |    5 +----
>  arch/powerpc/platforms/pasemi/setup.c        |   10 ++--------
>  arch/powerpc/platforms/powermac/low_i2c.c    |    7 ++-----
>  arch/powerpc/platforms/powermac/pfunc_base.c |    3 +--
>  arch/powerpc/platforms/powermac/pic.c        |    3 +--
>  arch/powerpc/platforms/powermac/setup.c      |   12 ++----------
>  29 files changed, 35 insertions(+), 128 deletions(-)
>
> diff --git a/arch/powerpc/platforms/40x/kilauea.c b/arch/powerpc/platforms/40x/kilauea.c
> index 1bffdbd..0853db7 100644
> --- a/arch/powerpc/platforms/40x/kilauea.c
> +++ b/arch/powerpc/platforms/40x/kilauea.c
> @@ -29,14 +29,11 @@ static struct of_device_id kilauea_of_bus[] = {
>
>  static int __init kilauea_device_probe(void)
>  {
> -       if (!machine_is(kilauea))
> -               return 0;
> -
>         of_platform_bus_probe(NULL, kilauea_of_bus, NULL);
>
>         return 0;
>  }
> -device_initcall(kilauea_device_probe);
> +machine_device_initcall(kilauea, kilauea_device_probe);
>
>  static int __init kilauea_probe(void)
>  {
> diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
> index 14bbc32..43fcc8e 100644
> --- a/arch/powerpc/platforms/40x/virtex.c
> +++ b/arch/powerpc/platforms/40x/virtex.c
> @@ -17,14 +17,11 @@
>
>  static int __init virtex_device_probe(void)
>  {
> -       if (!machine_is(virtex))
> -               return 0;
> -
>         of_platform_bus_probe(NULL, NULL, NULL);
>
>         return 0;
>  }
> -device_initcall(virtex_device_probe);
> +machine_device_initcall(virtex, virtex_device_probe);
>
>  static int __init virtex_probe(void)
>  {
> diff --git a/arch/powerpc/platforms/40x/walnut.c b/arch/powerpc/platforms/40x/walnut.c
> index ff6db24..91a5247 100644
> --- a/arch/powerpc/platforms/40x/walnut.c
> +++ b/arch/powerpc/platforms/40x/walnut.c
> @@ -34,15 +34,12 @@ static struct of_device_id walnut_of_bus[] = {
>
>  static int __init walnut_device_probe(void)
>  {
> -       if (!machine_is(walnut))
> -               return 0;
> -
>         /* FIXME: do bus probe here */
>         of_platform_bus_probe(NULL, walnut_of_bus, NULL);
>
>         return 0;
>  }
> -device_initcall(walnut_device_probe);
> +machine_device_initcall(walnut, walnut_device_probe);
>
>  static int __init walnut_probe(void)
>  {
> diff --git a/arch/powerpc/platforms/44x/bamboo.c b/arch/powerpc/platforms/44x/bamboo.c
> index be23f11..5253996 100644
> --- a/arch/powerpc/platforms/44x/bamboo.c
> +++ b/arch/powerpc/platforms/44x/bamboo.c
> @@ -32,14 +32,11 @@ static struct of_device_id bamboo_of_bus[] = {
>
>  static int __init bamboo_device_probe(void)
>  {
> -       if (!machine_is(bamboo))
> -               return 0;
> -
>         of_platform_bus_probe(NULL, bamboo_of_bus, NULL);
>
>         return 0;
>  }
> -device_initcall(bamboo_device_probe);
> +machine_device_initcall(bamboo, bamboo_device_probe);
>
>  static int __init bamboo_probe(void)
>  {
> diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
> index 6cd3476..b783c6e 100644
> --- a/arch/powerpc/platforms/44x/ebony.c
> +++ b/arch/powerpc/platforms/44x/ebony.c
> @@ -36,14 +36,11 @@ static struct of_device_id ebony_of_bus[] = {
>
>  static int __init ebony_device_probe(void)
>  {
> -       if (!machine_is(ebony))
> -               return 0;
> -
>         of_platform_bus_probe(NULL, ebony_of_bus, NULL);
>
>         return 0;
>  }
> -device_initcall(ebony_device_probe);
> +machine_device_initcall(ebony, ebony_device_probe);
>
>  /*
>   * Called very early, MMU is off, device-tree isn't unflattened
> diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
> index 21a9dd1..e5be0c7 100644
> --- a/arch/powerpc/platforms/44x/sequoia.c
> +++ b/arch/powerpc/platforms/44x/sequoia.c
> @@ -32,14 +32,11 @@ static struct of_device_id sequoia_of_bus[] = {
>
>  static int __init sequoia_device_probe(void)
>  {
> -       if (!machine_is(sequoia))
> -               return 0;
> -
>         of_platform_bus_probe(NULL, sequoia_of_bus, NULL);
>
>         return 0;
>  }
> -device_initcall(sequoia_device_probe);
> +machine_device_initcall(sequoia, sequoia_device_probe);
>
>  static int __init sequoia_probe(void)
>  {
> diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
> index fd83440..3fce6b3 100644
> --- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
> +++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
> @@ -165,14 +165,11 @@ static struct of_device_id __initdata of_bus_ids[] = {
>
>  static int __init declare_of_platform_devices(void)
>  {
> -       if (!machine_is(mpc8272_ads))
> -               return 0;
> -
>         /* Publish the QE devices */
>         of_platform_bus_probe(NULL, of_bus_ids, NULL);
>         return 0;
>  }
> -device_initcall(declare_of_platform_devices);
> +machine_device_initcall(mpc8272_ads, declare_of_platform_devices);
>
>  /*
>   * Called very early, device-tree isn't unflattened
> diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
> index 4f457a9..c5430b3 100644
> --- a/arch/powerpc/platforms/82xx/pq2fads.c
> +++ b/arch/powerpc/platforms/82xx/pq2fads.c
> @@ -176,14 +176,11 @@ static struct of_device_id __initdata of_bus_ids[] = {
>
>  static int __init declare_of_platform_devices(void)
>  {
> -       if (!machine_is(pq2fads))
> -               return 0;
> -
>         /* Publish the QE devices */
>         of_platform_bus_probe(NULL, of_bus_ids, NULL);
>         return 0;
>  }
> -device_initcall(declare_of_platform_devices);
> +machine_device_initcall(pq2fads, declare_of_platform_devices);
>
>  define_machine(pq2fads)
>  {
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> index 39ee7a1..6b9d72a 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> @@ -110,15 +110,12 @@ static struct of_device_id mpc832x_ids[] = {
>
>  static int __init mpc832x_declare_of_platform_devices(void)
>  {
> -       if (!machine_is(mpc832x_mds))
> -               return 0;
> -
>         /* Publish the QE devices */
>         of_platform_bus_probe(NULL, mpc832x_ids, NULL);
>
>         return 0;
>  }
> -device_initcall(mpc832x_declare_of_platform_devices);
> +machine_device_initcall(mpc832x_mds, mpc832x_declare_of_platform_devices);
>
>  static void __init mpc832x_sys_init_IRQ(void)
>  {
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> index d4bd040..67a282f 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
> @@ -63,9 +63,6 @@ static struct spi_board_info mpc832x_spi_boardinfo = {
>
>  static int __init mpc832x_spi_init(void)
>  {
> -       if (!machine_is(mpc832x_rdb))
> -               return 0;
> -
>         par_io_config_pin(3,  0, 3, 0, 1, 0); /* SPI1 MOSI, I/O */
>         par_io_config_pin(3,  1, 3, 0, 1, 0); /* SPI1 MISO, I/O */
>         par_io_config_pin(3,  2, 3, 0, 1, 0); /* SPI1 CLK,  I/O */
> @@ -79,8 +76,7 @@ static int __init mpc832x_spi_init(void)
>                             mpc83xx_spi_activate_cs,
>                             mpc83xx_spi_deactivate_cs);
>  }
> -
> -device_initcall(mpc832x_spi_init);
> +machine_device_initcall(mpc832x_rdb, mpc832x_spi_init);
>
>  /* ************************************************************************
>   *
> @@ -123,15 +119,12 @@ static struct of_device_id mpc832x_ids[] = {
>
>  static int __init mpc832x_declare_of_platform_devices(void)
>  {
> -       if (!machine_is(mpc832x_rdb))
> -               return 0;
> -
>         /* Publish the QE devices */
>         of_platform_bus_probe(NULL, mpc832x_ids, NULL);
>
>         return 0;
>  }
> -device_initcall(mpc832x_declare_of_platform_devices);
> +machine_device_initcall(mpc832x_rdb, mpc832x_declare_of_platform_devices);
>
>  void __init mpc832x_rdb_init_IRQ(void)
>  {
> diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
> index e40012f..9f37718 100644
> --- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
> @@ -141,15 +141,12 @@ static struct of_device_id mpc836x_ids[] = {
>
>  static int __init mpc836x_declare_of_platform_devices(void)
>  {
> -       if (!machine_is(mpc836x_mds))
> -               return 0;
> -
>         /* Publish the QE devices */
>         of_platform_bus_probe(NULL, mpc836x_ids, NULL);
>
>         return 0;
>  }
> -device_initcall(mpc836x_declare_of_platform_devices);
> +machine_device_initcall(mpc836x_mds, mpc836x_declare_of_platform_devices);
>
>  static void __init mpc836x_mds_init_IRQ(void)
>  {
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> index bccdc25..a3fa1b0 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> @@ -233,13 +233,10 @@ static struct of_device_id __initdata of_bus_ids[] = {
>
>  static int __init declare_of_platform_devices(void)
>  {
> -       if (!machine_is(mpc85xx_ads))
> -               return 0;
> -
>         of_platform_bus_probe(NULL, of_bus_ids, NULL);
>         return 0;
>  }
> -device_initcall(declare_of_platform_devices);
> +machine_device_initcall(mpc85xx_ads, declare_of_platform_devices);
>
>  /*
>   * Called very early, device-tree isn't unflattened
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> index 4d063ee..8b1de78 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -222,9 +222,6 @@ static int mpc85xx_cds_8259_attach(void)
>         struct device_node *cascade_node = NULL;
>         int cascade_irq;
>
> -       if (!machine_is(mpc85xx_cds))
> -               return 0;
> -
>         /* Initialize the i8259 controller */
>         for_each_node_by_type(np, "interrupt-controller")
>                 if (of_device_is_compatible(np, "chrp,iic")) {
> @@ -262,8 +259,7 @@ static int mpc85xx_cds_8259_attach(void)
>
>         return 0;
>  }
> -
> -device_initcall(mpc85xx_cds_8259_attach);
> +machine_device_initcall(mpc85xx_cds, mpc85xx_cds_8259_attach);
>
>  #endif /* CONFIG_PPC_I8259 */
>
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> index 61b3eed..5f68c99 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> @@ -144,15 +144,12 @@ static struct of_device_id mpc85xx_ids[] = {
>
>  static int __init mpc85xx_publish_devices(void)
>  {
> -       if (!machine_is(mpc85xx_mds))
> -               return 0;
> -
>         /* Publish the QE devices */
>         of_platform_bus_probe(NULL,mpc85xx_ids,NULL);
>
>         return 0;
>  }
> -device_initcall(mpc85xx_publish_devices);
> +machine_device_initcall(mpc85xx_mds, mpc85xx_publish_devices);
>
>  static void __init mpc85xx_mds_pic_init(void)
>  {
> diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
> index c518b6c..88afa35 100644
> --- a/arch/powerpc/platforms/8xx/ep88xc.c
> +++ b/arch/powerpc/platforms/8xx/ep88xc.c
> @@ -155,12 +155,11 @@ static struct of_device_id __initdata of_bus_ids[] = {
>  static int __init declare_of_platform_devices(void)
>  {
>         /* Publish the QE devices */
> -       if (machine_is(ep88xc))
> -               of_platform_bus_probe(NULL, of_bus_ids, NULL);
> +       of_platform_bus_probe(NULL, of_bus_ids, NULL);
>
>         return 0;
>  }
> -device_initcall(declare_of_platform_devices);
> +machine_device_initcall(ep88xc, declare_of_platform_devices);
>
>  define_machine(ep88xc) {
>         .name = "Embedded Planet EP88xC",
> diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
> index 2cf1b6a..6ef8e9e 100644
> --- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
> +++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
> @@ -264,12 +264,11 @@ static struct of_device_id __initdata of_bus_ids[] = {
>  static int __init declare_of_platform_devices(void)
>  {
>         /* Publish the QE devices */
> -       if (machine_is(mpc885_ads))
> -               of_platform_bus_probe(NULL, of_bus_ids, NULL);
> +       of_platform_bus_probe(NULL, of_bus_ids, NULL);
>
>         return 0;
>  }
> -device_initcall(declare_of_platform_devices);
> +machine_device_initcall(mpc885_ads, declare_of_platform_devices);
>
>  define_machine(mpc885_ads) {
>         .name                   = "Freescale MPC885 ADS",
> diff --git a/arch/powerpc/platforms/cell/io-workarounds.c b/arch/powerpc/platforms/cell/io-workarounds.c
> index 9d7c2ef..e3ae39c 100644
> --- a/arch/powerpc/platforms/cell/io-workarounds.c
> +++ b/arch/powerpc/platforms/cell/io-workarounds.c
> @@ -309,9 +309,6 @@ static int __init spider_pci_workaround_init(void)
>  {
>         struct pci_controller *phb;
>
> -       if (!machine_is(cell))
> -               return 0;
> -
>         /* Find spider bridges. We assume they have been all probed
>          * in setup_arch(). If that was to change, we would need to
>          * update this code to cope with dynamically added busses
> @@ -343,4 +340,4 @@ static int __init spider_pci_workaround_init(void)
>
>         return 0;
>  }
> -arch_initcall(spider_pci_workaround_init);
> +machine_arch_initcall(cell, spider_pci_workaround_init);
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index faabc3f..648077f 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -699,9 +699,6 @@ static int __init cell_iommu_init(void)
>  {
>         struct device_node *np;
>
> -       if (!machine_is(cell))
> -               return -ENODEV;
> -
>         /* If IOMMU is disabled or we have little enough RAM to not need
>          * to enable it, we setup a direct mapping.
>          *
> @@ -744,5 +741,5 @@ static int __init cell_iommu_init(void)
>
>         return 0;
>  }
> -arch_initcall(cell_iommu_init);
> +machine_arch_initcall(cell, cell_iommu_init);
>
> diff --git a/arch/powerpc/platforms/cell/pmu.c b/arch/powerpc/platforms/cell/pmu.c
> index 1ed3036..cb0cdab 100644
> --- a/arch/powerpc/platforms/cell/pmu.c
> +++ b/arch/powerpc/platforms/cell/pmu.c
> @@ -381,9 +381,6 @@ static int __init cbe_init_pm_irq(void)
>         unsigned int irq;
>         int rc, node;
>
> -       if (!machine_is(cell))
> -               return 0;
> -
>         for_each_node(node) {
>                 irq = irq_create_mapping(NULL, IIC_IRQ_IOEX_PMI |
>                                                (node << IIC_IRQ_NODE_SHIFT));
> @@ -404,7 +401,7 @@ static int __init cbe_init_pm_irq(void)
>
>         return 0;
>  }
> -arch_initcall(cbe_init_pm_irq);
> +machine_arch_initcall(cell, cbe_init_pm_irq);
>
>  void cbe_sync_irq(int node)
>  {
> diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
> index 98e7ef8..8390d2d 100644
> --- a/arch/powerpc/platforms/cell/setup.c
> +++ b/arch/powerpc/platforms/cell/setup.c
> @@ -85,9 +85,6 @@ static int __init cell_publish_devices(void)
>  {
>         int node;
>
> -       if (!machine_is(cell))
> -               return 0;
> -
>         /* Publish OF platform devices for southbridge IOs */
>         of_platform_bus_probe(NULL, NULL, NULL);
>
> @@ -101,7 +98,7 @@ static int __init cell_publish_devices(void)
>         }
>         return 0;
>  }
> -device_initcall(cell_publish_devices);
> +machine_device_initcall(cell, cell_publish_devices);
>
>  static void cell_mpic_cascade(unsigned int irq, struct irq_desc *desc)
>  {
> diff --git a/arch/powerpc/platforms/celleb/iommu.c b/arch/powerpc/platforms/celleb/iommu.c
> index 755d869..c9884f4 100644
> --- a/arch/powerpc/platforms/celleb/iommu.c
> +++ b/arch/powerpc/platforms/celleb/iommu.c
> @@ -91,14 +91,10 @@ static struct notifier_block celleb_of_bus_notifier = {
>
>  static int __init celleb_init_iommu(void)
>  {
> -       if (!machine_is(celleb))
> -               return -ENODEV;
> -
>         celleb_init_direct_mapping();
>         set_pci_dma_ops(&dma_direct_ops);
>         bus_register_notifier(&of_platform_bus_type, &celleb_of_bus_notifier);
>
>         return 0;
>  }
> -
> -arch_initcall(celleb_init_iommu);
> +machine_arch_initcall(celleb, celleb_init_iommu);
> diff --git a/arch/powerpc/platforms/celleb/setup.c b/arch/powerpc/platforms/celleb/setup.c
> index ddfb35a..aa18f95 100644
> --- a/arch/powerpc/platforms/celleb/setup.c
> +++ b/arch/powerpc/platforms/celleb/setup.c
> @@ -127,9 +127,6 @@ static struct of_device_id celleb_bus_ids[] __initdata = {
>
>  static int __init celleb_publish_devices(void)
>  {
> -       if (!machine_is(celleb))
> -               return 0;
> -
>         /* Publish OF platform devices for southbridge IOs */
>         of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
>
> @@ -137,7 +134,7 @@ static int __init celleb_publish_devices(void)
>
>         return 0;
>  }
> -device_initcall(celleb_publish_devices);
> +machine_device_initcall(celleb, celleb_publish_devices);
>
>  define_machine(celleb) {
>         .name                   = "Cell Reference Set",
> diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
> index c99264c..9d891bd 100644
> --- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
> +++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
> @@ -117,9 +117,6 @@ static int __init ls_uarts_init(void)
>         phys_addr_t phys_addr;
>         int len;
>
> -       if (!machine_is(linkstation))
> -               return 0;
> -
>         avr = of_find_node_by_path("/soc10x/serial@80004500");
>         if (!avr)
>                 return -EINVAL;
> @@ -142,4 +139,4 @@ static int __init ls_uarts_init(void)
>         return 0;
>  }
>
> -late_initcall(ls_uarts_init);
> +machine_late_initcall(linkstation, ls_uarts_init);
> diff --git a/arch/powerpc/platforms/pasemi/idle.c b/arch/powerpc/platforms/pasemi/idle.c
> index d8e1fcc..43911d8 100644
> --- a/arch/powerpc/platforms/pasemi/idle.c
> +++ b/arch/powerpc/platforms/pasemi/idle.c
> @@ -74,9 +74,6 @@ static int pasemi_system_reset_exception(struct pt_regs *regs)
>
>  static int __init pasemi_idle_init(void)
>  {
> -       if (!machine_is(pasemi))
> -               return -ENODEV;
> -
>  #ifndef CONFIG_PPC_PASEMI_CPUFREQ
>         printk(KERN_WARNING "No cpufreq driver, powersavings modes disabled\n");
>         current_mode = 0;
> @@ -88,7 +85,7 @@ static int __init pasemi_idle_init(void)
>
>         return 0;
>  }
> -late_initcall(pasemi_idle_init);
> +machine_late_initcall(pasemi, pasemi_idle_init);
>
>  static int __init idle_param(char *p)
>  {
> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
> index 3d62060..59c8371 100644
> --- a/arch/powerpc/platforms/pasemi/setup.c
> +++ b/arch/powerpc/platforms/pasemi/setup.c
> @@ -126,9 +126,6 @@ static int __init pas_setup_mce_regs(void)
>         struct pci_dev *dev;
>         int reg;
>
> -       if (!machine_is(pasemi))
> -               return -ENODEV;
> -
>         /* Remap various SoC status registers for use by the MCE handler */
>
>         reg = 0;
> @@ -172,7 +169,7 @@ static int __init pas_setup_mce_regs(void)
>
>         return 0;
>  }
> -device_initcall(pas_setup_mce_regs);
> +machine_device_initcall(pasemi, pas_setup_mce_regs);
>
>  static __init void pas_init_IRQ(void)
>  {
> @@ -369,9 +366,6 @@ static struct of_device_id pasemi_bus_ids[] = {
>
>  static int __init pasemi_publish_devices(void)
>  {
> -       if (!machine_is(pasemi))
> -               return 0;
> -
>         pasemi_pcmcia_init();
>
>         /* Publish OF platform devices for SDC and other non-PCI devices */
> @@ -379,7 +373,7 @@ static int __init pasemi_publish_devices(void)
>
>         return 0;
>  }
> -device_initcall(pasemi_publish_devices);
> +machine_device_initcall(pasemi, pasemi_publish_devices);
>
>
>  /*
> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
> index da2007e..9c9299c 100644
> --- a/arch/powerpc/platforms/powermac/low_i2c.c
> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
> @@ -1462,9 +1462,6 @@ int __init pmac_i2c_init(void)
>                 return 0;
>         i2c_inited = 1;
>
> -       if (!machine_is(powermac))
> -               return 0;
> -
>         /* Probe keywest-i2c busses */
>         kw_i2c_probe();
>
> @@ -1483,7 +1480,7 @@ int __init pmac_i2c_init(void)
>
>         return 0;
>  }
> -arch_initcall(pmac_i2c_init);
> +machine_arch_initcall(powermac, pmac_i2c_init);
>
>  /* Since pmac_i2c_init can be called too early for the platform device
>   * registration, we need to do it at a later time. In our case, subsys
> @@ -1515,4 +1512,4 @@ static int __init pmac_i2c_create_platform_devices(void)
>
>         return 0;
>  }
> -subsys_initcall(pmac_i2c_create_platform_devices);
> +machine_subsys_initcall(powermac, pmac_i2c_create_platform_devices);
> diff --git a/arch/powerpc/platforms/powermac/pfunc_base.c b/arch/powerpc/platforms/powermac/pfunc_base.c
> index 45d54b9..db20de5 100644
> --- a/arch/powerpc/platforms/powermac/pfunc_base.c
> +++ b/arch/powerpc/platforms/powermac/pfunc_base.c
> @@ -363,8 +363,7 @@ int __init pmac_pfunc_base_install(void)
>
>         return 0;
>  }
> -
> -arch_initcall(pmac_pfunc_base_install);
> +machine_arch_initcall(powermac, pmac_pfunc_base_install);
>
>  #ifdef CONFIG_PM
>
> diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
> index 999f5e1..cd72164 100644
> --- a/arch/powerpc/platforms/powermac/pic.c
> +++ b/arch/powerpc/platforms/powermac/pic.c
> @@ -690,6 +690,5 @@ static int __init init_pmacpic_sysfs(void)
>         sysdev_driver_register(&pmacpic_sysclass, &driver_pmacpic);
>         return 0;
>  }
> -
> -subsys_initcall(init_pmacpic_sysfs);
> +machine_subsys_initcall(powermac, init_pmacpic_sysfs);
>
> diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
> index 02c5330..0421189 100644
> --- a/arch/powerpc/platforms/powermac/setup.c
> +++ b/arch/powerpc/platforms/powermac/setup.c
> @@ -398,17 +398,13 @@ static int initializing = 1;
>
>  static int pmac_late_init(void)
>  {
> -       if (!machine_is(powermac))
> -               return -ENODEV;
> -
>         initializing = 0;
>         /* this is udbg (which is __init) and we can later use it during
>          * cpu hotplug (in smp_core99_kick_cpu) */
>         ppc_md.progress = NULL;
>         return 0;
>  }
> -
> -late_initcall(pmac_late_init);
> +machine_late_initcall(powermac, pmac_late_init);
>
>  /*
>   * This is __init_refok because we check for "initializing" before
> @@ -535,9 +531,6 @@ static int __init pmac_declare_of_platform_devices(void)
>         if (machine_is(chrp))
>                 return -1;
>
> -       if (!machine_is(powermac))
> -               return 0;
> -
>         np = of_find_node_by_name(NULL, "valkyrie");
>         if (np)
>                 of_platform_device_create(np, "valkyrie", NULL);
> @@ -552,8 +545,7 @@ static int __init pmac_declare_of_platform_devices(void)
>
>         return 0;
>  }
> -
> -device_initcall(pmac_declare_of_platform_devices);
> +machine_device_initcall(powermac, pmac_declare_of_platform_devices);
>
>  /*
>   * Called very early, MMU is off, device-tree isn't unflattened
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
