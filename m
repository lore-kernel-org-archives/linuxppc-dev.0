Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id A9B52DDEB8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jul 2007 14:29:57 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so74481wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 21:29:56 -0700 (PDT)
Message-ID: <fa686aa40707242129p1b5f5299i44818ead5ed4d2f3@mail.gmail.com>
Date: Tue, 24 Jul 2007 22:29:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [PATCH] Xilinx TEMAC driver
In-Reply-To: <46A5C305.5000903@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <46A5C305.5000903@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/24/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>     Hopefully this is not too much of a mess.
>
>     This is a very preliminary patch to add support for the Xilinx TEMAC.
>     This is closer approximation to a normal linux driver.
>     There are no external dependencies aside from a properly setup
> xparameters.h and
>     platform data structure for the TEMAC - i.e. no need for xilinx_edk,
> xilinx_common, ...
>     The whole driver is in a single source file.
>     It autonegotiates, and it actually works in some Pico Firmware where
> the MV/Xilinx driver does not.

Hooray!  Thanks for posting your work.  I'm keen to try this on my
platform.  Comments below.

General comments:
- Remove the c++ (//) style comments
- indentation should be by tabs, not spaces.  Run the whole file
through the scripts/Lindent utility.
- Your patch has been damaged by your mailer (by wrapping lines).  I
cannot apply this patch as-is.  Maybe take a look at git-send-email
for sending patches.
- Keep lines < 80 characters long.
- CamelCaseVariablesStructuresAndFunctions don't match the Linux coding style.
- rather than commenting out DEBUG_PRINTK's, instead add "#define
DEBUG" before the #include statements, and use the dev_dbg() macro.

>
>     Somewhere long ago this started out based on the Xilinx code from
> the Trek Webserver sample.
>     As such it is also losely based on the xilinx_edk code.
>     Hopefully, I remembered to provide proper attribution. This is
> preliminary so things like that will get fixed.
>     It includes support for the LocalLink TEMAC, though the LL_TEMAC
> performance is poor, and I could not figure
>     out anyway to make it interrupt driven so it had a fairly high rate
> of dropped packets.
>     It ONLY supports the FIFO based PLB TEMAC. If you want SGDMA add it
> or use the Xilinx/MV driver.
>
>     There is alot of cruft in the driver that needs yanked, bits and
> peices of #ifdefed out code from the xilinx EDK or ldd3
>     or whatever I thought I needed, and have not yet been willing to delete.
>
>     I am also using dman near the same identical source for a TEMAC
> driver for GreenHills, and there are likely some
>     #ifdef's that only make sense in that context.
>
>     At somepoint I will try to clean all of the above crap out.
>
>     I also need to clean up my git tree so that I can produce a proper
> patch.
>
>     Enough caveats - patch follows.
>
>
>
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 7d57f4a..fe5aa83 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2332,6 +2337,59 @@ config ATL1
>
>  endif # NETDEV_1000
>
> +config PICO_TEMAC
> +    tristate "Pico Xilinx 10/100/1000 Mbit Local Link/PLB TEMAC support"

Drop the PICO name, this should work with any TEMAC implementation.

> +    depends on XILINX_VIRTEX && !XILINX_OLD_TEMAC && !XILINX_TEMAC
> +    select MII
> +    select NET_POLL_CONTROLLER
> +#    select PHYLIB

Drop the commented out bits, they can always be added back in when
phylib support is added.

> +    help
> +      This driver supports Tri-Mode, 10/100/1000 Mbit EMAC IP
> +      from Xilinx EDK.
> +
> +config PICO_DEBUG_TEMAC
> +    bool 'Pico TEMAC Debugging'
> +    default y
> +    depends on PICO_TEMAC && PICO_DEBUG
> +
> +
>  #
>  #    10 Gigabit Ethernet
>  #
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index a77affa..2248dd4 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -227,3 +227,8 @@ obj-$(CONFIG_NETCONSOLE) += netconsole.o
>  obj-$(CONFIG_FS_ENET) += fs_enet/
>
>  obj-$(CONFIG_NETXEN_NIC) += netxen/
> +obj-$(CONFIG_PICO_TEMAC) += temac.o
> diff --git a/drivers/net/temac.c b/drivers/net/temac.c
> new file mode 100644
> index 0000000..01d30c4
> --- /dev/null
> +++ b/drivers/net/temac.c
> @@ -0,0 +1,3742 @@
> +/*
> +
> + linux/drivers/net/temac.c
> +
> + Driver for Xilinx hard temac ethernet NIC's
> +
> + Author: David H. Lynch Jr. <dhlii@dlasys.net>
> + Copyright (C) 2005 DLA Systems
> + The author may be reached as dhlii@sdlasys.net, or C/O
> +       DLA Systems
> +       354 Rudy Dam rd.
> +       Lititz PA 17543

Drop the contact info, you can add stuff to MAINTAINERS if you prefer
in a separate patch.

> +
> +This program is free software; you can redistribute it and/or modify
> +it under the terms of the GNU General Public License as published by
> +the Free Software Foundation; either version 2 of the License, or
> +(at your option) any later version.
> +
> +This program is distributed in the hope that it will be useful,
> +but WITHOUT ANY WARRANTY; without even the implied warranty of
> +MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +GNU General Public License for more details.
> +
> +You should have received a copy of the GNU General Public License
> +along with this program; if not, write to the Free Software
> +Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + things that need looked at:
> +    process_transmits
> +    temac_EtherRead
> +    temac_hard_start_xmit
> +    ehter_reset
> +    temac_get_link_status
> +
> +$Id: temac.c,v 0.10 2005/12/14 10:03:27 dhlii Exp $

Drop the CVS-fu.  It's irrelevant for mainline.

> +
> +*/
> +#define DRV_NAME        "temac"
> +#define DRV_DESCRIPTION "Xilinx hard Tri-Mode Eth MAC driver"
> +#define DRV_VERSION     "0.10a"
> +#define DRV_RELDATE     "07/10/2006"

For mainline submission, VERSION and RELDATE are irrelevant.

> +
> +#if defined(__KERNEL__)
> +#define LINUX 1
> +#endif
> +static const char version[] = DRV_NAME ".c:v" DRV_VERSION " "
> DRV_RELDATE "  David H. Lynch Jr. (dhlii@dlasys.net)\n";
> +
> +#if defined(LINUX)

Heh; I'm pretty sure we're running on Linux here.

> +#include <linux/module.h>
> +#include <linux/ioport.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/init.h>
> +#include <linux/skbuff.h>
> +#include <linux/spinlock.h>
> +#include <linux/crc32.h>
> +
> +#include <linux/mii.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/xilinx_devices.h>
> +#include <linux/ethtool.h>
> +#include <asm/delay.h>
> +#include <asm/irq.h>
> +#include <asm/io.h>
> +
> +#define FRAME_ALIGNMENT                 8                       /* Byte
> alignment of ethernet frames */
> +typedef char EthFrame[9000] __attribute__ ((aligned(FRAME_ALIGNMENT)));
> +
> +#define TRUE                                    1
> +#define FALSE                                   0
> +
> +#define TEMAC_RX_TIMEOUT            (jiffies + ((1 * HZ)/5))
> +#define TEMAC_TX_TIMEOUT            (jiffies + (2 * HZ))
> +#define TEMAC_MII_TIMEOUT           (jiffies + (2 * HZ))    /* timer
> wakeup time : 2 second */
> +
> +/*
> +Transmit timeout, default 5 seconds.
> + */
> +static int
> +watchdog = 5000;
> +module_param(watchdog, int, 0400);
> +MODULE_PARM_DESC(watchdog, "transmit timeout in milliseconds");

Is this best done as a module parm?  I would think this is something
you'd want to change of the fily... then again, it's just a watchdog
timer.  How often is in necessary to fiddle with the timeout?

> +
> +static struct platform_device *temac_device;
> +
> +/* for exclusion of all program flows (processes, ISRs and BHs) */
> +DEFINE_SPINLOCK(XTE_spinlock);

Avoid uppercase in variable defines.

> +#define res_size(_r) (((_r)->end - (_r)->start) + 1)
> +#define EnetDbPrint(dev,msg)

Avoid CamelCaseFunctionsAndDefines.

> +#define Success 0
> +#define Failure -1

0 as success is a pretty well defined convention.  Don't add new
defines for it here.

> +#define Error int

Remove this, just use 'int'

<snip>

> +
> +#define db_printf       DEBUG_PRINTK
> +/* use 0 for production, 1 for verification, >1 for debug */
> +#if defined(CONFIG_PICO_DEBUG_TEMAC)
> +#define DEBUG_FUNC              if (lp->dbg)
> {dbg_printk("\n%s:%s()",DRV_NAME, __FUNCTION__);}
> +#define DEBUG_FUNC_EXIT         if (lp->dbg) {dbg_printk("\n%s:%s()
> exit",DRV_NAME,__FUNCTION__);}
> +#define DEBUG_FUNC_EX(ret)      if (lp->dbg)
> {dbg_printk("\n%s:%s(%d)exit",DRV_NAME,__FUNCTION__,ret);}
> +#define DEBUG_PRINTL(args...)   if (lp->dbg) dbg_printk("\n" __FILE__
> ": " args)
> +#define DEBUG_PRINTK(args...)   if (lp->dbg) dbg_printk(args)
> +#define DEBUG_PUTS(fmt...)      if (lp->dbg) dbg_puts(fmt)
> +void dbg_printk(unsigned char *fmt, ...);
> +static unsigned int debug = 1;
> +#else
> +#define DEBUG_FUNC              do { } while(0)
> +#define DEBUG_FUNC_EXIT         do { } while(0)
> +#define DEBUG_PRINTL(args...)   do { } while(0)
> +#define DEBUG_PRINTK(args...)   do { } while(0)
> +#define DEBUG_PUTS(args...)     do { } while(0)
> +#define dump_skb(lp, skb) 0
> +#define dump_skb_data(lp, skb, str) 0
> +static unsigned int debug = 1;
> +#endif

Not a good idea to add your own debug print functions.  Drivers should
use dev_dbg(), dev_info(), etc.  Or in the odd case where the dev
structure is not available, user the pr_debug() macro.

<snip>

> +/* This type encapsulates a packet FIFO channel and support attributes to
> + * allow unaligned data transfers.
> + */
> +struct temac_pktFifo {
> +    u32             Hold[2];                /* Holding register */
> +    unsigned        ByteIndex;              /* Holding register index */
> +    unsigned        Width;                  /* Width of packet FIFO's
> keyhole data port in bytes */
> +    u32             RegBaseAddress;         /**< Base address of
> registers */
> +    u32             DataBaseAddress;        /**< Base address of data
> for FIFOs */
> +} ;
> +
> +struct temac_local {
> +#if defined(LINUX)
> +    struct sk_buff              *deferred_skb;     /* buffer for one
> skb in case no room is available for transmission */
> +
> +//  void                        *RxFramePtr;       /* Address of first
> RxFrame */
> +    unsigned                    MaxFrameSz;        /* Size in bytes of
> largest frame for Tx or Rx */
> +//  u32                         RxPktFifoDepth;    /**< Depth of
> receive packet FIFO in bits */
> +//  u32                         TxPktFifoDepth;    /**< Depth of
> transmit packet FIFO in bits */
> +//  u16                         MacFifoDepth;      /**< Depth of the
> status/length FIFOs in entries */
> +
> +    struct resource             *nic_addr_res;     /* resources found */
> +    struct resource             *phy_addr_res;
> +    struct resource             *nic_addr_req;     /* resources
> requested */
> +    struct resource             *phy_addr_req;
> +    void __iomem                *nic_vaddr;        /* Register I/O base
> address */
> +
> +    struct mii_if_info          mii_if;
> +#else
> +    EnetDevice                  enetDevice;
> +    InterruptHandler            handler;
> +    struct sk_buff              __skb[(NUM_TX_BDS+NUM_RX_BDS) +
> (MAX_CACHE_LINE_SIZE/sizeof(struct sk_buff))];
> +    char                        name[20];
> +    u32                         base_addr;
> +    u8                          dev_addr[6];
> +
> +    u32                         disablecount;
> +    u32                         enablecount;
> +    u32                         tx_reset_pending;
> +    u32                         rx_reset_pending;
> +    u32                         reads_denied_during_reset;
> +    u32                         writes_denied_during_reset;
> +
> +    int                         devno;
> +    Error                       (*GetLinkStatus)(struct temac_local *
> lp, LinkSpeed *linkSpeed, LinkStatus *linkStatus, LinkDuplex  *linkDuplex);
> +
> +    PHY                         mii_if;
> +    u32                         trans_start;
> +    u32                         last_rx;
> +#endif
> +    unsigned int                mii:1;              /* mii port
> available */
> +    u8                          regshift;
> +    u32                         msg_enable;         /* debug message
> level */
> +    struct net_device_stats     stats;              /* Statistics for
> this device */
> +    unsigned int                phy_mode;          /* dcr */
> +    u16                         phy_addr;
> +    u32                         phy_status;
> +    unsigned int                poll:1;
> +    unsigned int                dbg:1;              /* debug ? */
> +    unsigned int                nic_type;           /* plb/ll */
> +    int                         LinkSpeed;          /* Speed of link
> 10/100/1000 */
> +    u32                         options;            /* Current options
> word */
> +//  u32                         TxPktFifoErrors;    /**< Number of Tx
> packet FIFO errors detected */
> +//  u32                         TxStatusErrors;
> +//  u32                         RxPktFifoErrors;    /**< Number of Rx
> packet FIFO errors detected */
> +//  u32                         RxRejectErrors;
> +//  u32                         FifoErrors;         /**< Number of
> length/status FIFO errors detected */
> +//  u32                         IpifErrors;         /**< Number of IPIF
> transaction and data phase errors detected */
> +//  u32                         Interrupts;         /**< Number of

Remove the commented out members; they can be added in when needed.

<snip>

> +static u32
> +_ior(u32 offset) {
> +    u32 value;
> +    value = (*(volatile u32 *) (offset));
> +    __asm__ __volatile__("eieio");
> +    return value;
> +}
> +
> +static void
> +_iow(u32 offset, u32 value) {
> +    (*(volatile u32 *) (offset) = value);
> +    __asm__ __volatile__("eieio");
> +}
> +
> +static u32
> +ior(struct net_device *ndev, int offset) {
> +    return _ior(ndev->base_addr + offset);
> +}
> +
> +static u32
> +ios(struct net_device *ndev) {
> +    return ior(ndev, XTE_IPIER_OFFSET) & ior(ndev, XTE_IPISR_OFFSET);
> +}
> +
> +static void
> +iow(struct net_device *ndev, int offset, u32 value) {
> +    _iow(ndev->base_addr + offset, value);
> +}

Don't define new IO functions.  Use the ones in <asm/io.h>

> +
> +/***************************************************************************
> + * Reads an MII register from the MII PHY attached to the Xilinx Temac.
> + *
> + * Parameters:
> + *   dev      - the temac device.
> + *   phy_addr - the address of the PHY [0..31]
> + *   reg_num  - the number of the register to read. 0-6 are defined by
> + *              the MII spec, but most PHYs have more.
> + *   reg_value - this is set to the specified register's value
> + *
> + * Returns:
> + *   Success or Failure
> + */
> +static Error
> +g_mdio_read(struct net_device *ndev, int phy_id, int reg_num, u16 *
> reg_val) {

what does the 'g_' prefix signify?

<snip>

> +        switch (ii) {
> +            case MII_ANI:
> +                disp_mii(ndev, "ANI", ii);
> +                break;
> +            case MII_SSR:
> +                disp_mii(ndev, "SSR", ii);
> +                break;
> +            case MII_ISR:
> +                disp_mii(ndev, "ISR", ii);
> +                break;
> +            case MII_BMCR:
> +                disp_mii(ndev, "MCR", ii);
> +                break;
> +            case MII_BMSR:
> +                disp_mii(ndev, "MSR", ii);
> +                break;
> +            case MII_PHYSID1:
> +                disp_mii(ndev,"PHYSID1",ii);
> +                break;
> +            case MII_PHYSID2:
> +                disp_mii(ndev,"PHYSID2",ii);
> +                break;
> +            case MII_ADVERTISE:
> +                disp_mii(ndev,"ADV", ii);
> +                break;
> +            case MII_LPA:
> +                disp_mii(ndev,"LPA", ii);
> +                break;
> +            case MII_EXPANSION:
> +                disp_mii(ndev,"EXPANSION", ii);
> +                break;
> +            case MII_CTRL1000:
> +                disp_mii(ndev,"CTRL1000", ii);
> +                break;
> +            case MII_STAT1000:
> +                disp_mii(ndev,"STAT1000", ii);
> +                break;
> +            case MII_ESTATUS:
> +                disp_mii(ndev,"ESTATUS", ii);
> +                break;
> +            case MII_DCOUNTER:
> +                disp_mii(ndev,"DCOUNTER", ii);
> +                break;
> +            case MII_NWAYTEST:
> +                disp_mii(ndev,"NWAYTEST", ii);
> +                break;
> +            case MII_RERRCOUNTER:
> +                disp_mii(ndev,"RERRCOUNT", ii);
> +                break;
> +            case MII_SREVISION:
> +                disp_mii(ndev,"SREVISION",ii);
> +                break;
> +            case MII_RESV1:
> +                disp_mii(ndev,"RESV1",ii);
> +                break;
> +            case MII_LBRERROR:
> +                disp_mii(ndev,"LBERROR",ii);
> +                break;
> +            case MII_PHYADDR:
> +                disp_mii(ndev,"PHYADDR",ii);
> +                break;
> +            case MII_RESV2:
> +                disp_mii(ndev,"RESV2",ii);
> +                break;
> +            case MII_TPISTATUS:
> +                disp_mii(ndev,"TPISTATUS",ii);
> +                break;
> +            case MII_NCONFIG:
> +                disp_mii(ndev,"NCONFIG",ii);
> +                break;
> +#if 0
> +            case MII_FCSCOUNTER:
> +                disp_mii(ndev,"FCSCOUNTER",ii);
> +                break;
> +#endif

This case statement is a *really* good candidate to be replaced with a
lookup table.

> +            default:
> +                disp_mii(ndev,0, ii);
> +                break;
> +        }
> +    }
> +    /*
> +    Print TEMAC Receiver and Transmitter configuration
> +    */
> +    DEBUG_PRINTK("\nReading Hard TEMAC Regs:\n");
> +
> +    for (ii = 0x200,jj = 0; ii <= 0x3a4; ii += 4) {
> +        switch (ii) {
> +            case XTE_RXC0_OFFSET:
> +                disp_emac_cfg(ndev, "RxCW0", ii, jj++);
> +                break;
> +            case XTE_RXC1_OFFSET:
> +                disp_emac_cfg(ndev, "RxCW1", ii, jj++);
> +                break;
> +            case XTE_TXC_OFFSET:
> +                disp_emac_cfg(ndev, "TxCW", ii, jj++);
> +                break;
> +            case XTE_FCC_OFFSET:
> +                disp_emac_cfg(ndev, "Flow", ii, jj++);
> +                break;
> +            case XTE_EMCFG_OFFSET:
> +                disp_emac_cfg(ndev, "ModeCfg", ii, jj++);
> +                break;
> +            case XTE_MC_OFFSET:
> +                disp_emac_cfg(ndev, "MgmtCfg", ii, jj++);
> +                break;
> +            case XTE_UAW0_OFFSET:
> +                disp_emac_cfg(ndev, "MacAddr0", ii, jj++);
> +                break;
> +            case XTE_UAW1_OFFSET:
> +                disp_emac_cfg(ndev, "MacAddr1", ii, jj++);
> +                break;
> +            case XTE_MAW0_OFFSET:
> +                disp_emac_cfg(ndev, "AtAddr0", ii, jj++);
> +                break;
> +            case XTE_MAW1_OFFSET:
> +                disp_emac_cfg(ndev, "AtAddr1", ii, jj++);
> +                break;
> +            case XTE_AFM_OFFSET:
> +                disp_emac_cfg(ndev, "AtCAF", ii, jj++);
> +                break;
> +            case XGP_IRSTATUS:
> +                disp_emac_cfg(ndev, "ISR", ii, jj++);
> +                break;
> +            case XGP_IRENABLE:
> +                disp_emac_cfg(ndev, "IER", ii, jj++);
> +                break;

Same with this one.

> +            default:
> +                break;
> +        }
> +    }
> +    DEBUG_PRINTK("\n");
> +
> +    if (lp->nic_type == TEMAC_PLB) {
> +        DEBUG_PRINTK("\nReading PLB TEMAC Regs:\n");
> +
> +        for (ii = 0x0,jj = 4;ii <= 0x1020; ii += 4) {
> +            switch (ii) {
> +                case XTE_DISR_OFFSET:
> +                    disp_temac_cfg(ndev, "DISR", ii, jj++);
> +                    break;
> +                case XTE_DIPR_OFFSET:
> +                    disp_temac_cfg(ndev, "DIPR", ii, jj++);
> +                    break;
> +                case XTE_DIER_OFFSET:
> +                    disp_temac_cfg(ndev, "DIER", ii, jj++);
> +                    break;
> +                case XTE_DGIE_OFFSET:
> +                    disp_temac_cfg(ndev, "DGIE", ii, jj++);
> +                    break;
> +                case XTE_IPISR_OFFSET:
> +                    disp_temac_cfg(ndev, "IPISR", ii, jj++);
> +                    break;
> +                case XTE_IPIER_OFFSET:
> +                    disp_temac_cfg(ndev, "IPIER", ii, jj++);
> +                    break;
> +                case XTE_DSR_OFFSET:
> +                    disp_temac_cfg(ndev, "MIR", ii, jj++);
> +                    break;
> +                case XTE_TPLR_OFFSET:
> +                    // disp_temac_cfg(ndev, "TPLR", ii, jj++);  // do
> not try to display this register - BAD things will happen
> +                    break;
> +                case XTE_CR_OFFSET:
> +                    disp_temac_cfg(ndev, "CR", ii, jj++);
> +                    break;
> +                case XTE_TSR_OFFSET:
> +                    // disp_temac_cfg(ndev, "TSR", ii, jj++);
> +                    break;
> +                case XTE_RPLR_OFFSET:
> +                    // disp_temac_cfg(ndev, "RPLR", ii, jj++);
> +                    break;
> +                case XTE_RSR_OFFSET:
> +                    disp_temac_cfg(ndev, "RSR", ii, jj++);
> +                    break;
> +                case XTE_TPPR_OFFSET:
> +                    disp_temac_cfg(ndev, "TPPR", ii, jj++);
> +                    break;

Ditto

> +                default:
> +                    break;
> +            }
> +        }
> +    }
> +    DEBUG_PRINTK("\nDisplaying Options:\n");
> +
> +    for (ii = 0, jj = 0;ii < 32; ii++) {
> +        if ( lp->options & ( 1 << ii)) {
> +            jj++;
> +            if ((jj % 4) == 0) DEBUG_PRINTK("\n\t");
> +            switch ( 1 << ii) {
> +                case XTE_PROMISC_OPTION:
> +                    DEBUG_PRINTK("PROMISC ");
> +                    break;
> +                case XTE_JUMBO_OPTION:
> +                    DEBUG_PRINTK("JUMBO ");
> +                    break;
> +                case XTE_VLAN_OPTION:
> +                    DEBUG_PRINTK("VLAN ");
> +                    break;
> +                case XTE_FLOW_CONTROL_OPTION:
> +                    DEBUG_PRINTK("FLOW_CONTROL ");
> +                    break;
> +                case XTE_FCS_STRIP_OPTION:
> +                    DEBUG_PRINTK("FCS_STRIP ");
> +                    break;
> +                case XTE_FCS_INSERT_OPTION:
> +                    DEBUG_PRINTK("FCS_INSERT ");
> +                    break;
> +                case XTE_LENTYPE_ERR_OPTION:
> +                    DEBUG_PRINTK("LENTYPE ERR ");
> +                    break;
> +                case XTE_POLLED_OPTION:
> +                    DEBUG_PRINTK("POLLED ");
> +                    break;
> +                case XTE_REPORT_RXERR_OPTION:
> +                    DEBUG_PRINTK("REPORT_RXERR ");
> +                    break;
> +                case XTE_TRANSMITTER_ENABLE_OPTION:
> +                    DEBUG_PRINTK("TRANSMITTER_ENABLE ");
> +                    break;
> +                case XTE_RECEIVER_ENABLE_OPTION:
> +                    DEBUG_PRINTK("RECEIVER_ENABLE ");
> +                    break;
> +                case XTE_BROADCAST_OPTION:
> +                    DEBUG_PRINTK("BROADCAST ");
> +                    break;
> +                case XTE_MULTICAST_CAM_OPTION:
> +                    DEBUG_PRINTK("MULTICAST_CAM ");
> +                    break;
> +                case XTE_REPORT_TXSTATUS_OVERRUN_OPTION:
> +                    DEBUG_PRINTK("REPORT_TXSTATUS_OVERRUN ");
> +                    break;
> +                case XTE_ANEG_OPTION:
> +                    DEBUG_PRINTK("ANEG ");
> +                    break;

Ditto

<snip>

> +
> +static u8
> +recvBd[] = {
> +    0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00
> +};

Global variables are automatically zeroed.  No need to zero it explicitly.

<snip>

> +#else
> +    plb_temac_interrupt(ndev);
> +#...
>
> [Message clipped]

Heh; too big for my email client.... anyway; clean up the basic
comments, eliminate the non-Linux stuff and repost.  It will be much
easier to review when the coding style issues are sorted out.  Also,
take a look at your mailer and make sure you can email inline patches
without word wrapping.

Cheers and thanks,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
