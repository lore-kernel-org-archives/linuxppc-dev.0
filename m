Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7B856685D3
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 01:19:50 +1000 (EST)
In-Reply-To: <20051022223658.3C202352B25@atlas.denx.de>
References: <20051022223658.3C202352B25@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <398F469F-357E-445D-B48E-59899230E001@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 24 Oct 2005 10:20:24 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Add PCI support for TQM834x Boards
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Two comments:
* The comment in mpc83xx_setup_hose() may not be 100% correct (see  
inline)
* Updating of pci_ids.h should be done via http:// 
pciids.sourceforge.net/.  I can handle doing this for 834x if you  
want me to.

- kumar

On Oct 22, 2005, at 5:36 PM, Wolfgang Denk wrote:

> The following patch (against latest 2.6 tree) adds  PCI  support  for
> the TQ Systems TQM834x Boards. Verified on TQM8349L.
>
> Note: for TQM834x board support actually to compile and  work,  three
> previously submitted patches are required. See postings:
>
> Sat, 22 Oct 2005   [PATCH 2.6] Add generic support for DS1377 RTC
> Sat, 22 Oct 2005   [PATCH] Cleanup mpc83xx_restart() code
> Sat, 22 Oct 2005   [Patch] Add support for TQM834x Boards
>
>
> ---
> PCI support for the TQM834x boards.
>
> Signed-off-by: Rafal Jaworowski <raj@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
>
>
> ---
> commit 5108607a56824e025fda5efe9f68ff310545adb9
> tree 4e3b67d3e9f4188f69de9715da68781fb7eebc84
> parent 0af38510e829b6d397128269fe194898924ab534
> author Rafal Jaworowski <raj@pollux.denx.de> Wed, 19 Oct 2005  
> 12:32:42 +0200
> committer Rafal Jaworowski <raj@pollux.denx.de> Wed, 19 Oct 2005  
> 12:32:42 +0200
>
>  arch/ppc/platforms/83xx/mpc834x_sys.c |    7 +++
>  arch/ppc/platforms/83xx/tqm834x.c     |   37 ++++++++++-----
>  arch/ppc/platforms/83xx/tqm834x.h     |   10 ++--
>  arch/ppc/syslib/ppc83xx_pci.h         |   41 +++++++++++++++++
>  arch/ppc/syslib/ppc83xx_setup.c       |   79 ++++++++++++++++++++++ 
> ++++++-----
>  arch/ppc/syslib/ppc83xx_setup.h       |    1
>  include/linux/pci_ids.h               |   10 ++++
>  7 files changed, 157 insertions(+), 28 deletions(-)
>
> diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/ 
> platforms/83xx/mpc834x_sys.c
> --- a/arch/ppc/platforms/83xx/mpc834x_sys.c
> +++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
> @@ -364,6 +364,13 @@ platform_init(unsigned long r3, unsigned
>      ppc_md.progress = gen550_progress;
>  #endif    /* CONFIG_SERIAL_8250 && CONFIG_SERIAL_TEXT_DEBUG */
>
> +#ifdef CONFIG_PCI
> +    ppc_md.pci_swizzle = common_swizzle;
> +    ppc_md.pci_map_irq = mpc83xx_map_irq;
> +    ppc_md.pci_exclude_device = mpc83xx_exclude_device;
> +    ppc_md.pcibios_fixup = mpc834x_pcibios_fixup;
> +#endif /* CONFIG_PCI */
> +
>      if (ppc_md.progress)
>          ppc_md.progress("mpc834x_sys_init(): exit", 0);
>
> diff --git a/arch/ppc/platforms/83xx/tqm834x.c b/arch/ppc/platforms/ 
> 83xx/tqm834x.c
> --- a/arch/ppc/platforms/83xx/tqm834x.c
> +++ b/arch/ppc/platforms/83xx/tqm834x.c
> @@ -61,28 +61,33 @@ unsigned char __res[sizeof (bd_t)];
>
>  #ifdef CONFIG_PCI
>  int
> -mpc83xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned  
> char pin)
> +tqm834x_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned  
> char pin)
>  {
> +    int irq;
>      static char pci_irq_table[][4] =
>          /*
>           *      PCI IDSEL/INTPIN->INTLINE
>           *       A      B      C      D
>           */
>      {
> -        {PIRQA, PIRQB,  PIRQC,  PIRQD}, /* idsel 0x11 */
> -        {PIRQC, PIRQD,  PIRQA,  PIRQB}, /* idsel 0x12 */
> -        {PIRQD, PIRQA,  PIRQB,  PIRQC}  /* idsel 0x13 */
> +        {PIRQA, PIRQB,  PIRQC,  PIRQD}, /* idsel 0x1c */
> +        {PIRQB, PIRQC,  PIRQD,  PIRQA}, /* idsel 0x1d */
> +        {PIRQC, PIRQD,  0,  0}      /* idsel 0x1e */
>      };
>
> -    const long min_idsel = 0x11, max_idsel = 0x13, irqs_per_slot = 4;
> -    return PCI_IRQ_TABLE_LOOKUP;
> +    const long min_idsel = 0x1c, max_idsel = 0x1e, irqs_per_slot = 4;
> +    irq = PCI_IRQ_TABLE_LOOKUP;
> +    if (!irq)
> +        irq = 0;
> +    return (irq);
>  }
>
>  int
> -mpc83xx_exclude_device(u_char bus, u_char devfn)
> +tqm834x_exclude_device(u_char bus, u_char devfn)
>  {
>      return PCIBIOS_SUCCESSFUL;
>  }
> +
>  #endif /* CONFIG_PCI */
>
>  /*  
> ********************************************************************** 
> **
> @@ -190,19 +195,20 @@ tqm834x_init_IRQ(void)
>      u8 senses[8] = {
>          0,            /* EXT 0 */
>          0,            /* EXT 1 */
> -        0,            /* EXT 2 */
> -        0,            /* EXT 3 */
>  #ifdef CONFIG_PCI
> -        IRQ_SENSE_LEVEL,    /* EXT 4 */
> +        IRQ_SENSE_LEVEL,    /* EXT 2 */
> +        IRQ_SENSE_LEVEL,    /* EXT 3 */
> +        0,            /* EXT 4 */
>          IRQ_SENSE_LEVEL,    /* EXT 5 */
>          IRQ_SENSE_LEVEL,    /* EXT 6 */
> -        IRQ_SENSE_LEVEL,    /* EXT 7 */
>  #else
> +        0,            /* EXT 2 */
> +        0,            /* EXT 3 */
>          0,            /* EXT 4 */
>          0,            /* EXT 5 */
>          0,            /* EXT 6 */
> -        0,            /* EXT 7 */
>  #endif
> +        IRQ_SENSE_LEVEL,    /* EXT 7 */
>      };
>
>      ipic_init(binfo->bi_immr_base + 0x00700, 0,  
> MPC83xx_IPIC_IRQ_OFFSET, senses, 8);
> @@ -329,6 +335,13 @@ platform_init(unsigned long r3, unsigned
>      ppc_md.progress = gen550_progress;
>  #endif    /* CONFIG_SERIAL_8250 && CONFIG_SERIAL_TEXT_DEBUG */
>
> +#ifdef CONFIG_PCI
> +    ppc_md.pci_swizzle = common_swizzle;
> +    ppc_md.pci_map_irq = tqm834x_map_irq;
> +    ppc_md.pci_exclude_device = tqm834x_exclude_device;
> +    ppc_md.pcibios_fixup = mpc834x_pcibios_fixup;
> +#endif /* CONFIG_PCI */
> +
>      if (ppc_md.progress)
>          ppc_md.progress("tqm834x_init(): exit", 0);
>
> diff --git a/arch/ppc/platforms/83xx/tqm834x.h b/arch/ppc/platforms/ 
> 83xx/tqm834x.h
> --- a/arch/ppc/platforms/83xx/tqm834x.h
> +++ b/arch/ppc/platforms/83xx/tqm834x.h
> @@ -24,15 +24,15 @@
>
>  #define VIRT_IMMRBAR        ((uint)0xfe000000)
>
> -#define PIRQA    MPC83xx_IRQ_EXT4
> -#define PIRQB    MPC83xx_IRQ_EXT5
> +#define PIRQA    MPC83xx_IRQ_EXT2
> +#define PIRQB    MPC83xx_IRQ_EXT3
>  #define PIRQC    MPC83xx_IRQ_EXT6
> -#define PIRQD    MPC83xx_IRQ_EXT7
> +#define PIRQD    MPC83xx_IRQ_EXT5
>
>  #define MPC83xx_PCI1_LOWER_IO    0x00000000
>  #define MPC83xx_PCI1_UPPER_IO    0x00ffffff
> -#define MPC83xx_PCI1_LOWER_MEM    0x80000000
> -#define MPC83xx_PCI1_UPPER_MEM    0x9fffffff
> +#define MPC83xx_PCI1_LOWER_MEM    0xc0000000
> +#define MPC83xx_PCI1_UPPER_MEM    0xdfffffff
>  #define MPC83xx_PCI1_IO_BASE    0xe2000000
>  #define MPC83xx_PCI1_MEM_OFFSET    0x00000000
>  #define MPC83xx_PCI1_IO_SIZE    0x01000000
> diff --git a/arch/ppc/syslib/ppc83xx_pci.h b/arch/ppc/syslib/ 
> ppc83xx_pci.h
> --- a/arch/ppc/syslib/ppc83xx_pci.h
> +++ b/arch/ppc/syslib/ppc83xx_pci.h
> @@ -25,6 +25,47 @@ typedef struct immr_clk {
>      u32 sccr; /* system clock control Register  */
>      u8 res0[0xF4];
>  } immr_clk_t;
> +#define SPMR_LBIUCM  0x80000000 /* LBIUCM  */
> +#define SPMR_DDRCM   0x40000000 /* DDRCM  */
> +#define SPMR_SVCOD   0x30000000 /* SVCOD  */
> +#define SPMR_SPMF    0x0F000000 /* SPMF  */
> +#define SPMR_CKID    0x00800000 /* CKID  */
> +#define SPMR_CKID_SHIFT 23
> +#define SPMR_COREPLL 0x007F0000 /* COREPLL  */
> +#define SPMR_CEVCOD  0x000000C0 /* CEVCOD  */
> +#define SPMR_CEPDF   0x00000020 /* CEPDF  */
> +#define SPMR_CEPMF   0x0000001F /* CEPMF  */
> +
> +#define OCCR_PCICOE0 0x80000000 /* PCICOE0  */
> +#define OCCR_PCICOE1 0x40000000 /* PCICOE1  */
> +#define OCCR_PCICOE2 0x20000000 /* PCICOE2  */
> +#define OCCR_PCICOE3 0x10000000 /* PCICOE3  */
> +#define OCCR_PCICOE4 0x08000000 /* PCICOE4  */
> +#define OCCR_PCICOE5 0x04000000 /* PCICOE5  */
> +#define OCCR_PCICOE6 0x02000000 /* PCICOE6  */
> +#define OCCR_PCICOE7 0x01000000 /* PCICOE7  */
> +#define OCCR_PCICD0  0x00800000 /* PCICD0  */
> +#define OCCR_PCICD1  0x00400000 /* PCICD1  */
> +#define OCCR_PCICD2  0x00200000 /* PCICD2  */
> +#define OCCR_PCICD3  0x00100000 /* PCICD3  */
> +#define OCCR_PCICD4  0x00080000 /* PCICD4  */
> +#define OCCR_PCICD5  0x00040000 /* PCICD5  */
> +#define OCCR_PCICD6  0x00020000 /* PCICD6  */
> +#define OCCR_PCICD7  0x00010000 /* PCICD7  */
> +#define OCCR_PCI1CR  0x00000002 /* PCI1CR  */
> +#define OCCR_PCI2CR  0x00000001 /* PCI2CR  */
> +
> +#define SCCR_TSEC1CM  0xc0000000 /* TSEC1CM  */
> +#define SCCR_TSEC1CM_SHIFT 30
> +#define SCCR_TSEC2CM  0x30000000 /* TSEC2CM  */
> +#define SCCR_TSEC2CM_SHIFT 28
> +#define SCCR_ENCCM    0x03000000 /* ENCCM  */
> +#define SCCR_ENCCM_SHIFT 24
> +#define SCCR_USBMPHCM 0x00c00000 /* USBMPHCM  */
> +#define SCCR_USBMPHCM_SHIFT 22
> +#define SCCR_USBDRCM  0x00300000 /* USBDRCM  */
> +#define SCCR_USBDRCM_SHIFT 20
> +#define SCCR_PCICM    0x00010000 /* PCICM  */
>
>  /*
>   * Sequencer
> diff --git a/arch/ppc/syslib/ppc83xx_setup.c b/arch/ppc/syslib/ 
> ppc83xx_setup.c
> --- a/arch/ppc/syslib/ppc83xx_setup.c
> +++ b/arch/ppc/syslib/ppc83xx_setup.c
> @@ -221,6 +221,7 @@ mpc83xx_setup_pci1(struct pci_controller
>      iounmap(ios);
>  }
>
> +#ifdef CONFIG_MPC83xx_PCI2
>  void __init
>  mpc83xx_setup_pci2(struct pci_controller *hose)
>  {
> @@ -278,8 +279,11 @@ mpc83xx_setup_pci2(struct pci_controller
>      iounmap(pci_ctrl);
>      iounmap(ios);
>  }
> +#endif
>
>  /*
> + * NOTICE for the MPC83xx SYS Freescale evaluation board:
> + *
>   * PCI buses can be enabled only if SYS board combinates with PIB
>   * (Platform IO Board) board which provide 3 PCI slots. There is 2  
> PCI buses
>   * and 3 PCI slots, so people must configure the routes between  
> them before
> @@ -287,10 +291,6 @@ mpc83xx_setup_pci2(struct pci_controller
>   * can be accessed via I2C bus 2 and are configured by firmware.  
> Refer to
>   * Freescale to get more information about firmware configuration.
>   */
> -
> -extern int mpc83xx_exclude_device(u_char bus, u_char devfn);
> -extern int mpc83xx_map_irq(struct pci_dev *dev, unsigned char idsel,
> -        unsigned char pin);
>  void __init
>  mpc83xx_setup_hose(void)
>  {
> @@ -306,22 +306,46 @@ mpc83xx_setup_hose(void)
>              sizeof(immr_clk_t));
>
>      /*
> -     * Configure PCI controller and PCI_CLK_OUTPUT both in 66M mode
> +     * Configure PCI_CLK_OUTPUT
>       */
>      val32 = clk->occr;
>      udelay(2000);
> -    clk->occr = 0xff000000;
> +
> +#ifdef CONFIG_TQM834x

Is the following comment 100% correct?  I'm not sure I follow the  
STK85xx reference.

> +    /*
> +     * WARNING! only PCI_CLK_OUTPUT1 is enabled for the TQM834x as  
> this is
> +     * the one line actually used for clocking all external PCI  
> devices in
> +     * current setup of the STK85xx.  Enabling other  
> PCI_CLK_OUTPUT lines
> +     * may lead to board's hang for unknown reasons - particularly
> +     * PCI_CLK_OUTPUT6 and PCI_CLK_OUTPUT7 are known to hang the  
> board;
> +     * this issue is under investigation (18 oct 05)
> +     */
> +    val32 = OCCR_PCICOE1;
> +#else
> +    /* enable all PCI_CLK_OUTs */
> +    val32 = (OCCR_PCICOE0 | OCCR_PCICOE1 | OCCR_PCICOE2 |  
> OCCR_PCICOE3 \
> +         | OCCR_PCICOE4 | OCCR_PCICOE5 | OCCR_PCICOE6 |  
> OCCR_PCICOE7);
> +#endif
> +    /* set frequency of the PCI and clock outputs for external  
> devicesc
> +     * according to system clocking settings */
> +    if (clk->spmr & SPMR_CKID) {
> +        /* PCI Clock is 1/2 of CONFIG_83XX_CLKIN so need to set up  
> OCCR
> +         * fields accordingly */
> +        val32 |= (OCCR_PCI1CR | OCCR_PCI2CR);
> +
> +        val32 |= (OCCR_PCICD0 | OCCR_PCICD1 | OCCR_PCICD2 \
> +              | OCCR_PCICD3 | OCCR_PCICD4 | OCCR_PCICD5 \
> +              | OCCR_PCICD6 | OCCR_PCICD7);
> +    }
> +
> +    clk->occr = val32;
>      udelay(2000);
> -
>      iounmap(clk);
>
>      hose1 = pcibios_alloc_controller();
>      if(!hose1)
>          return;
>
> -    ppc_md.pci_swizzle = common_swizzle;
> -    ppc_md.pci_map_irq = mpc83xx_map_irq;
> -
>      hose1->bus_offset = 0;
>      hose1->first_busno = 0;
>      hose1->last_busno = 0xff;
> @@ -357,7 +381,6 @@ mpc83xx_setup_hose(void)
>              MPC83xx_PCI1_UPPER_MEM,
>              IORESOURCE_MEM, "PCI host bridge 1");
>
> -    ppc_md.pci_exclude_device = mpc83xx_exclude_device;
>      hose1->last_busno = pciauto_bus_scan(hose1, hose1->first_busno);
>
>  #ifdef CONFIG_MPC83xx_PCI2
> @@ -395,4 +418,38 @@ mpc83xx_setup_hose(void)
>      hose2->last_busno = pciauto_bus_scan(hose2, hose2->first_busno);
>  #endif /* CONFIG_MPC83xx_PCI2 */
>  }
> +
> +
> +void __init
> +mpc834x_pcibios_fixup(void)
> +{
> +    struct pci_dev *dev = NULL;
> +    unsigned int class;
> +    int i;
> +
> +    if ((dev = pci_find_device(PCI_VENDOR_ID_FREESCALE,
> +                   PCI_DEVICE_ID_FREESCALE_MPC8349E, NULL))) {
> +        class = dev->class >> 8;
> +        if (class == PCI_CLASS_BRIDGE_OTHER) {
> +            /*
> +             * at least rev 1.1 of the MPC8349E chip has the class
> +             * wrongly set in the host/PCI bridge config space
> +             * register; this leads to the host/PCI bridge being
> +             * treated as a regular client device, trying to assign
> +             * PCI resources to it etc.
> +             *
> +             */
> +            dev->class = (PCI_CLASS_BRIDGE_HOST << 8) & ~0xf;
> +
> +            /* for some odd reasons the host/PCI bridge behaves
> +             * like an agent device and would claim PCI mem/io/irq
> +             * resources, so we make these resources inactive (i.e.
> +             * the bridge will not claim resources from itself)
> +             */
> +            for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
> +                dev->resource[i].flags = IORESOURCE_UNSET;
> +        }
> +    }
> +
> +}
>  #endif /*CONFIG_PCI*/
> diff --git a/arch/ppc/syslib/ppc83xx_setup.h b/arch/ppc/syslib/ 
> ppc83xx_setup.h
> --- a/arch/ppc/syslib/ppc83xx_setup.h
> +++ b/arch/ppc/syslib/ppc83xx_setup.h
> @@ -36,6 +36,7 @@ extern void mpc83xx_restart(char *cmd);
>  extern void mpc83xx_power_off(void);
>  extern void mpc83xx_halt(void);
>  extern void mpc83xx_setup_hose(void) __init;
> +extern void mpc834x_pcibios_fixup(void);
>
>  /* PCI config */
>  #define PCI1_CFG_ADDR_OFFSET (0x8300)
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2278,6 +2278,16 @@
>  #define PCI_VENDOR_ID_TDI               0x192E
>  #define PCI_DEVICE_ID_TDI_EHCI          0x0101
>
> +#define PCI_VENDOR_ID_FREESCALE            0x1957
> +#define PCI_DEVICE_ID_FREESCALE_MPC8349E    0x0080
> +#define PCI_DEVICE_ID_FREESCALE_MPC8349        0x0081
> +#define PCI_DEVICE_ID_FREESCALE_MPC8347E_1    0x0082
> +#define PCI_DEVICE_ID_FREESCALE_MPC8347_1    0x0083
> +#define PCI_DEVICE_ID_FREESCALE_MPC8347E_2    0x0084
> +#define PCI_DEVICE_ID_FREESCALE_MPC8347_2    0x0085
> +#define PCI_DEVICE_ID_FREESCALE_MPC8343E    0x0086
> +#define PCI_DEVICE_ID_FREESCALE_MPC8343        0x0087
> +
>  #define PCI_VENDOR_ID_SYMPHONY        0x1c1c
>  #define PCI_DEVICE_ID_SYMPHONY_101    0x0001
>
>
>
> !-------------------------------------------------------------flip-
>
>
>
> Best regards,
>
> Wolfgang Denk
>
> -- 
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> The first 90% of a project takes 90% of the time, the last 10%  takes
> the other 90% of the time.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
