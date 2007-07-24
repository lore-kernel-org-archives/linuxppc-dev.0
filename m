Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B539DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 19:18:17 +1000 (EST)
Received: from [206.223.20.140]
	by mx.dlasys.net with esmtp (Exim 4.63 #1 (Debian))
	id 1IDGQj-0007Uz-UF
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Jul 2007 05:11:46 -0400
Message-ID: <46A5C305.5000903@dlasys.net>
Date: Tue, 24 Jul 2007 05:14:45 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] Xilinx TEMAC driver
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Hopefully this is not too much of a mess.

    This is a very preliminary patch to add support for the Xilinx TEMAC.
    This is closer approximation to a normal linux driver.
    There are no external dependencies aside from a properly setup
xparameters.h and
    platform data structure for the TEMAC - i.e. no need for xilinx_edk,
xilinx_common, ...
    The whole driver is in a single source file.
    It autonegotiates, and it actually works in some Pico Firmware where
the MV/Xilinx driver does not.
   
    Somewhere long ago this started out based on the Xilinx code from
the Trek Webserver sample.
    As such it is also losely based on the xilinx_edk code.
    Hopefully, I remembered to provide proper attribution. This is
preliminary so things like that will get fixed.
    It includes support for the LocalLink TEMAC, though the LL_TEMAC
performance is poor, and I could not figure
    out anyway to make it interrupt driven so it had a fairly high rate
of dropped packets.
    It ONLY supports the FIFO based PLB TEMAC. If you want SGDMA add it
or use the Xilinx/MV driver.

    There is alot of cruft in the driver that needs yanked, bits and
peices of #ifdefed out code from the xilinx EDK or ldd3
    or whatever I thought I needed, and have not yet been willing to delete.

    I am also using dman near the same identical source for a TEMAC
driver for GreenHills, and there are likely some
    #ifdef's that only make sense in that context.

    At somepoint I will try to clean all of the above crap out.

    I also need to clean up my git tree so that I can produce a proper
patch.

    Enough caveats - patch follows.


   

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 7d57f4a..fe5aa83 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2332,6 +2337,59 @@ config ATL1
 
 endif # NETDEV_1000
 
+config PICO_TEMAC
+    tristate "Pico Xilinx 10/100/1000 Mbit Local Link/PLB TEMAC support"
+    depends on XILINX_VIRTEX && !XILINX_OLD_TEMAC && !XILINX_TEMAC
+    select MII
+    select NET_POLL_CONTROLLER
+#    select PHYLIB
+    help
+      This driver supports Tri-Mode, 10/100/1000 Mbit EMAC IP
+      from Xilinx EDK.
+
+config PICO_DEBUG_TEMAC
+    bool 'Pico TEMAC Debugging'
+    default y
+    depends on PICO_TEMAC && PICO_DEBUG
+
+
 #
 #    10 Gigabit Ethernet
 #
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index a77affa..2248dd4 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -227,3 +227,8 @@ obj-$(CONFIG_NETCONSOLE) += netconsole.o
 obj-$(CONFIG_FS_ENET) += fs_enet/
 
 obj-$(CONFIG_NETXEN_NIC) += netxen/
+obj-$(CONFIG_PICO_TEMAC) += temac.o
diff --git a/drivers/net/temac.c b/drivers/net/temac.c
new file mode 100644
index 0000000..01d30c4
--- /dev/null
+++ b/drivers/net/temac.c
@@ -0,0 +1,3742 @@
+/*
+
+ linux/drivers/net/temac.c
+
+ Driver for Xilinx hard temac ethernet NIC's
+
+ Author: David H. Lynch Jr. <dhlii@dlasys.net>
+ Copyright (C) 2005 DLA Systems
+ The author may be reached as dhlii@sdlasys.net, or C/O
+       DLA Systems
+       354 Rudy Dam rd.
+       Lititz PA 17543
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ things that need looked at:
+    process_transmits
+    temac_EtherRead
+    temac_hard_start_xmit
+    ehter_reset
+    temac_get_link_status
+
+$Id: temac.c,v 0.10 2005/12/14 10:03:27 dhlii Exp $
+
+*/
+#define DRV_NAME        "temac"
+#define DRV_DESCRIPTION "Xilinx hard Tri-Mode Eth MAC driver"
+#define DRV_VERSION     "0.10a"
+#define DRV_RELDATE     "07/10/2006"
+
+#if defined(__KERNEL__)
+#define LINUX 1
+#endif
+static const char version[] = DRV_NAME ".c:v" DRV_VERSION " "
DRV_RELDATE "  David H. Lynch Jr. (dhlii@dlasys.net)\n";
+
+#if defined(LINUX)
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/init.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/crc32.h>
+
+#include <linux/mii.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/xilinx_devices.h>
+#include <linux/ethtool.h>
+#include <asm/delay.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+
+#define FRAME_ALIGNMENT                 8                       /* Byte
alignment of ethernet frames */
+typedef char EthFrame[9000] __attribute__ ((aligned(FRAME_ALIGNMENT)));
+
+#define TRUE                                    1
+#define FALSE                                   0
+
+#define TEMAC_RX_TIMEOUT            (jiffies + ((1 * HZ)/5))
+#define TEMAC_TX_TIMEOUT            (jiffies + (2 * HZ))
+#define TEMAC_MII_TIMEOUT           (jiffies + (2 * HZ))    /* timer
wakeup time : 2 second */
+
+/*
+Transmit timeout, default 5 seconds.
+ */
+static int
+watchdog = 5000;
+module_param(watchdog, int, 0400);
+MODULE_PARM_DESC(watchdog, "transmit timeout in milliseconds");
+
+static struct platform_device *temac_device;
+
+/* for exclusion of all program flows (processes, ISRs and BHs) */
+DEFINE_SPINLOCK(XTE_spinlock);
+#define res_size(_r) (((_r)->end - (_r)->start) + 1)
+#define EnetDbPrint(dev,msg)
+#define Success 0
+#define Failure -1
+#define Error int
+
+
+#else
+
+#define EIO             500
+
+// additional MII defines
+#define MII_BMCR            0x00        /* Basic mode control register */
+#define BMCR_ANRESTART          0x0200  /* Auto negotiation restart    */
+#define BMCR_ANENABLE           0x1000  /* Enable auto negotiation     */
+#define BMCR_RESET              0x8000  /* Reset the DP83840           */
+#define MII_BMSR            0x01        /* Basic mode status register  */
+#define BMSR_LSTATUS            0x0004  /* Link status                 */
+#define MII_PHYSID1         0x02        /* PHYS ID 1                   */
+#define MII_PHYSID2         0x03        /* PHYS ID 2                   */
+#define MII_ADVERTISE       0x04        /* Advertisement control reg   */
+#define ADVERTISE_CSMA          0x0001  /* Only selector supported     */
+#define ADVERTISE_10FULL        0x0040  /* Try for 10mbps full-duplex  */
+#define ADVERTISE_100FULL       0x0100  /* Try for 100mbps full-duplex */
+#define MII_LPA             0x05        /* Link partner ability reg    */
+#define MII_EXPANSION       0x06        /* Expansion register          */
+
+#define MII_CTRL1000        0x09        /* 1000BASE-T control          */
+#define ADVERTISE_1000FULL      0x0200  /* Advertise 1000BASE-T full
duplex */
+#define MII_STAT1000        0x0a        /* 1000BASE-T status           */
+#define MII_ESTATUS     0x0f    /* Extended Status */
+#define MII_DCOUNTER        0x12        /* Disconnect counter          */
+#define MII_FCSCOUNTER      0x13        /* False carrier counter       */
+#define MII_NWAYTEST        0x14        /* N-way auto-neg test reg     */
+#define MII_RERRCOUNTER     0x15        /* Receive error counter       */
+#define MII_SREVISION       0x16        /* Silicon revision            */
+#define MII_RESV1           0x17        /* Reserved...                 */
+#define MII_LBRERROR        0x18        /* Lpback, rx, bypass error    */
+#define MII_PHYADDR         0x19        /* PHY address                 */
+#define MII_RESV2           0x1a        /* Reserved...                 */
+#define MII_TPISTATUS       0x1b        /* TPI status for 10mbps       */
+#define MII_NCONFIG         0x1c        /* Network interface config    */
+
+#define MAX_TEMAC_DEVS  2
+
+#ifndef NUM_TX_BDS
+# define NUM_TX_BDS 32
+#endif
+#ifndef NUM_RX_BDS
+# define NUM_RX_BDS 32
+#endif
+
+
+#include "miiphy.h"
+#include "enet_iodevice.h"
+#include "interrupt.h"
+#include "interruptcontroller.h"
+#include "cksum.h"
+#include <string.h>
+
+#define spin_lock(lock)
+#define spin_unlock(lock)
+#define spin_lock_irqsave(lock, flags)
+#define spin_unlock_irqrestore(lock, flags)
+int is_valid_ether_addr(const UINT1 *addr);
+// #define is_valid_ether_addr(addr) 0          // this is in Pico BSP now
+#define mfdcr(addr)             -1
+#define mtdcr(addr,val)
+#define netif_wake_queue(lp)    0
+#define netif_stop_queue(lp)    0
+#define netif_rx(lp)            0
+#define printk_ratelimit()      0
+#define eth_type_trans(skb, lp) 0
+typedef unsigned long   spinlock_t;
+typedef unsigned long   irqreturn_t;
+#define IRQ_HANDLED EVENT_HANDLED
+
+
+
+#define MAX_CACHE_LINE_SIZE     64
+
+#define NUM_RX_EVENTS   (NUM_RX_BDS)
+#define NUM_TX_EVENTS   (NUM_TX_BDS * 2)
+
+#ifndef NUM_CLOSE_ACTIONS
+# define NUM_CLOSE_ACTIONS 32
+#endif
+
+#ifndef MAXMOVELEN
+# define MAXMOVELEN 12800
+#endif
+
+#define MINIMUM_PACKET_LENGTH 64
+
+typedef unsigned long   u32;
+typedef unsigned int    u16;
+typedef unsigned char   u8;
+
+/*
+ *  Network device statistics. Akin to the 2.0 ether stats but
+ *  with byte counters.
+ */
+
+struct net_device_stats
+{
+    unsigned long   rx_packets;     /* total packets received   */
+    unsigned long   tx_packets;     /* total packets transmitted    */
+    unsigned long   rx_bytes;       /* total bytes received     */
+    unsigned long   tx_bytes;       /* total bytes transmitted  */
+    unsigned long   rx_errors;      /* bad packets received     */
+    unsigned long   tx_errors;      /* packet transmit problems */
+    unsigned long   rx_dropped;     /* no space in linux buffers    */
+    unsigned long   tx_dropped;     /* no space available in linux  */
+    unsigned long   multicast;      /* multicast packets received   */
+    unsigned long   collisions;
+
+    /* detailed rx_errors: */
+    unsigned long   rx_length_errors;
+    unsigned long   rx_over_errors;     /* receiver ring buff overflow  */
+    unsigned long   rx_crc_errors;      /* recved pkt with crc error    */
+    unsigned long   rx_frame_errors;    /* recv'd frame alignment error */
+    unsigned long   rx_fifo_errors;     /* recv'r fifo overrun      */
+    unsigned long   rx_missed_errors;   /* receiver missed packet   */
+
+    /* detailed tx_errors */
+    unsigned long   tx_aborted_errors;
+    unsigned long   tx_carrier_errors;
+    unsigned long   tx_fifo_errors;
+    unsigned long   tx_heartbeat_errors;
+    unsigned long   tx_window_errors;
+   
+    /* for cslip etc */
+    unsigned long   rx_compressed;
+    unsigned long   tx_compressed;
+};
+
+struct timer_list
+{
+    unsigned long   rx_packets;     /* total packets received   */
+};
+
+#define SKB_RX      (1 << 0)
+#define SKB_TX      (1 << 1)
+#define SKB_INUSE   (1 << 2)
+#define SKB_ALLOC   (1 << 3)
+#define SKB_FULL    (1 << 4)
+#define SKB_PAD     (1 << 5)
+
+struct sk_buff {
+        UINT4           flags;          // asorted flag bits
+        UINT4           fifo_data;      // fifo address
+        UINT4           fifo_reg;       // fifo address
+        UINT4           size;
+        UINT4           len;                    // Owner, Status,
Buffer Length      
+        UINT4           user;                   // values from ghs     
+        UINT4           user_data;              // value from ghs
+        UINT4           protocol;  
+        struct temac_local *    dev;
+            unsigned char       *data;
+            unsigned char       *tail;
+} ;
+
+#define net_device temac_local
+#define jiffies 0
+#endif
+
+// board types
+#define TEMAC_LL                                0
+#define TEMAC_PLB                               1
+
+#define PHY_DCR                                 1
+
+#define ALIGNMENT_SEND                          8
+#define ALIGNMENT_RECV                          8
+
+#define MII_ANI                                 0x10
+#define PHY_NUM                                 0
+
+#define MII_SSR                                 0x11
+#define MII_SSR_LINK                                    (1 << 10)
+#define MII_SSR_SPDMASK                         0xC000
+#define MII_SSR_SPD1000                                 (1 << 15)
+#define MII_SSR_SPD100                                  (1 << 14)
+#define MII_SSR_SPD10                                   0
+#define MII_SSR_FD                                      (1 << 13)
+
+#define MII_ISR                     0x13
+
+// packet size info
+#define XTE_MTU                         1500                    /* max
MTU size of Ethernet frame */
+#define XTE_HDR_SIZE                    14                      /* size
of Ethernet header */
+#define XTE_TRL_SIZE                    4                       /* size
of Ethernet trailer (FCS) */
+#define XTE_MAX_FRAME_SIZE              (XTE_MTU + XTE_HDR_SIZE +
XTE_TRL_SIZE)
+
+#define TIMEOUT_ERROR                   -1
+#define SRC_RDY_TIMEOUT_ERROR           -2
+#define SOF_TIMEOUT_ERROR               -3
+#define UNKNOWN_ERROR                   -4
+
+#define XST_FAILURE                     1L
+#define XST_DEVICE_NOT_FOUND            2L
+#define XST_DEVICE_IS_STARTED           5L
+#define XST_DEVICE_IS_STOPPED           6L
+#define XST_FIFO_ERROR                  7L                      /* an
error occurred during an operation with a FIFO such as an underrun or
overrun, this error requires the device to be reset */
+#define XST_NOT_POLLED                  10L                     /* the
device is not configured for polled mode operation */
+#define XST_FIFO_NO_ROOM                11L                     /* a
FIFO did not have room to put the specified data into */
+#define XST_NO_DATA                     13L                     /*
there was no data available */
+#define XST_NO_FEATURE                  19L                     /*
device is not configured with the requested feature */
+#define XST_DATA_LOST                   26L                     /*
driver defined error */
+#define XST_RECV_ERROR                  27L                     /*
generic receive error */
+#define XST_SEND_ERROR                  28L                     /*
generic transmit error */
+#define XST_PFIFO_ERROR                 504L                    /*
generic packet FIFO error */
+#define XST_PFIFO_DEADLOCK              505L                    /*
packet FIFO is reporting * empty and full simultaneously */
+#define XST_IPIF_ERROR                  541L                    /*
generic ipif error */
+
+
+
+/**  Configuration options
+ *
+ * Device configuration options. See the temac_setoptions(),
+ * XTemac_ClearOptions() and XTemac_GetOptions() for information on how
to use
+ * options.
+ *
+ * The default state of the options are noted and are what the device
and driver
+ * will be set to after calling XTemac_Reset() or XTemac_Initialize().
+ *
+ */
+
+#define XTE_PROMISC_OPTION                      (1 << 0)        /**<
Accept all incoming packets. This option defaults to disabled (cleared) */
+#define XTE_JUMBO_OPTION                        (1 << 1)        /**<
Jumbo frame support for Tx & Rx. This option defaults to disabled
(cleared) */
+#define XTE_VLAN_OPTION                         (1 << 2)        /**<
VLAN Rx & Tx frame support.  This option defaults to disabled (cleared) */
+#define XTE_FLOW_CONTROL_OPTION                 (1 << 4)        /**<
Enable recognition of flow control frames on Rx This option defaults to
enabled (set) */
+#define XTE_FCS_STRIP_OPTION                    (1 << 5)        /**<
Strip FCS and PAD from incoming frames. Note: PAD from VLAN frames is
not stripped.  This option defaults to disabled (set) */
+#define XTE_FCS_INSERT_OPTION                   (1 << 6)        /**<
Generate FCS field and add PAD automatically for outgoing frames.  This
option defaults to enabled (set) */
+#define XTE_LENTYPE_ERR_OPTION                  (1 << 7)        /**<
Enable Length/Type error checking for incoming frames. When this option is
+                                                                    
set, the MAC will filter frames that have a mismatched type/length field
+                                                                    
and if XTE_REPORT_RXERR_OPTION is set, the user is notified when these
+                                                                    
types of frames are encountered. When this option is cleared, the MAC will
+                                                                    
allow these types of frames to be received.
+                                                                    
This option defaults to enabled (set) */
+#define XTE_POLLED_OPTION                       (1 << 9)        /**<
Polled mode communications.
+                                                                    
Users may enter/exit polled mode
+                                                                    
from any interrupt driven mode.
+                                                                    
This option defaults to disabled (cleared) */
+
+#define XTE_REPORT_RXERR_OPTION                 (1 << 10)       /**<
Enable reporting of dropped receive packets due to errors This option
defaults to enabled (set) */
+#define XTE_TRANSMITTER_ENABLE_OPTION           (1 << 11)       /**<
Enable the transmitter.  This option defaults to enabled (set) */
+#define XTE_RECEIVER_ENABLE_OPTION              (1 << 12)       /**<
Enable the receiver This option defaults to enabled (set) */
+#define XTE_BROADCAST_OPTION                    (1 << 13)       /**<
Allow reception of the broadcast address This option defaults to enabled
(set) */
+#define XTE_MULTICAST_CAM_OPTION                (1 << 14)       /**<
Allows reception of multicast addresses programmed into CAM This option
defaults to disabled (clear) */
+#define XTE_REPORT_TXSTATUS_OVERRUN_OPTION      (1 << 15)       /**<
Enable reporting the overrun of the Transmit status FIFO. This type of
+                                                                    
error is latched by HW and can be cleared only by a reset. SGDMA systems,
+                                                                    
this option should be enabled since the DMA engine is responsible for
+                                                                    
keeping this from occurring. For FIFO direct systems, this error may be
+                                                                     a
nuisance because a SW system may be able to transmit frames faster
+                                                                    
than the interrupt handler can handle retrieving statuses.
+                                                                    
This option defaults to enabled (set) */
+#define XTE_ANEG_OPTION                         (1 << 16)       /**<
Enable autonegotiation interrupt This option defaults to disabled (clear) */
+
+#define XTE_DEFAULT_OPTIONS                     \
+    (XTE_FLOW_CONTROL_OPTION |                  \
+     XTE_BROADCAST_OPTION |                     \
+     XTE_FCS_INSERT_OPTION |                    \
+     XTE_FCS_STRIP_OPTION |                     \
+     XTE_LENTYPE_ERR_OPTION |                   \
+     XTE_TRANSMITTER_ENABLE_OPTION |            \
+     XTE_REPORT_RXERR_OPTION |                  \
+     XTE_REPORT_TXSTATUS_OVERRUN_OPTION |       \
+     XTE_RECEIVER_ENABLE_OPTION)                                /**<
Default options set when device is initialized or reset */
+
+
+#define XTE_END_OF_PACKET                   1                   /**<
The data written is the last for the *  current packet */
+#define XTE_PARTIAL_PACKET                  0                   /**<
There is more data to come for the *  current packet */
+
+//------------------------------------------------
+
+#define PHY_TIMEOUT                         10000
+
+/**  Register offsets
+ *
+ * These constants define the offsets to each of the registers from the
+ * register base address, each of the constants are a number of bytes
+ */
+#define XPF_V200A_RESET_REG_OFFSET          0UL                    
/**< Reset register */
+#define XPF_V200A_COUNT_STATUS_REG_OFFSET   4UL                    
/**< Count/Status register */
+
+#define XPF_V200A_RESET_FIFO_MASK           0x0000000A              /**
* This constant is used with the Reset Register */
+
+/**  Occupancy/Vacancy Count Register constants
+ */
+/** Constant used with the Occupancy/Vacancy Count Register. This
+ *  register also contains FIFO status
+ */
+#define XPF_V200A_COUNT_MASK            0x00FFFFFF
+
+
+/************************** Constant Definitions
*****************************/
+
+#define XTE_RESET_IPIF_DELAY_US         1                       /**<
Number of Us to delay after IPIF reset */
+
+/* Register offset definitions. Unless otherwise noted, register access
is 32 bit.  */
+/**  IPIF interrupt and reset registers */
+#define XTE_DISR_OFFSET                 0x00000000              /**<
Device interrupt status */
+#define XTE_DIPR_OFFSET                 0x00000004              /**<
Device interrupt pending */
+/**  Interrupt status bits for top level interrupts
+ *  These bits are associated with the XTE_DISR_OFFSET, XTE_DIPR_OFFSET,
+ *  and XTE_DIER_OFFSET registers.
+ */
+#define XTE_DXR_SEND_FIFO_MASK                  (1 << 6)        /**<
Send FIFO channel */
+#define XTE_DXR_RECV_FIFO_MASK                  (1 << 5)        /**<
Receive FIFO channel */
+#define XTE_DXR_CORE_MASK                       (1 << 2)        /**<
Core */
+#define XTE_DXR_DPTO_MASK                       (1 << 1)        /**<
Data phase timeout */
+#define XTE_DXR_TERR_MASK                       (1 << 0)        /**<
Transaction error */
+#define XTE_DIER_OFFSET                 0x00000008              /**<
Device interrupt enable */
+#define XTE_DGIE_OFFSET                 0x0000001C              /**<
Device global interrupt enable */
+#define XTE_DGIE_ENABLE_MASK                    (1 << 31)       /**<
Write this value to DGIE to enable interrupts from this device */
+#define XTE_IPISR_OFFSET                0x00000020              /**< IP
interrupt status */
+#define XTE_IPIER_OFFSET                0x00000028              /**< IP
interrupt enable */
+#define XTE_DSR_OFFSET                  0x00000040              /**<
Device software reset (write) */
+#define XTE_DSR_RESET_MASK              0x0000000A              /**<
Write this value to DSR to reset entire core */
+// #define XTE_MIR_OFFSET               0x00000040              /**<
Identification (read) */
+
+/**  Interrupt status bits for MAC interrupts
+ *  These bits are associated with XTE_IPISR_OFFSET and XTE_IPIER_OFFSET
+ *  registers.
+ *
+ */
+#define XTE_IPXR_XMIT_DONE_MASK                 (1 << 0)        /**< Tx
complete  MUST read TSR to clear */
+#define XTE_IPXR_RECV_DONE_MASK                 (1 << 1)        /**< Rx
complete  MUST read RSR to clear */
+#define XTE_IPXR_AUTO_NEG_MASK                  (1 << 2)        /**<
Auto negotiation complete */
+#define XTE_IPXR_RECV_REJECT_MASK               (1 << 3)        /**< Rx
packet rejected */
+//#define XTE_IPXR_XMIT_SFIFO_EMPTY_MASK        (1 << 4)        /**< Tx
status fifo empty */
+//#define XTE_IPXR_RECV_LFIFO_EMPTY_MASK        (1 << 5)        /**< Rx
length fifo empty */
+#define XTE_IPXR_XMIT_LFIFO_FULL_MASK           (1 << 6)        /**< Tx
length fifo full */
+#define XTE_IPXR_RECV_LFIFO_OVER_MASK           (1 << 7)        /**< Rx
length fifo overrun Note that this signal is no longer asserted by HW */
+#define XTE_IPXR_RECV_LFIFO_UNDER_MASK          (1 << 8)        /**< Rx
length fifo underrun requires RESET to clear */
+#define XTE_IPXR_XMIT_SFIFO_OVER_MASK           (1 << 9)        /**< Tx
status fifo overrun  requires RESET to clear */
+#define XTE_IPXR_XMIT_SFIFO_UNDER_MASK          (1 << 10)       /**< Tx
status fifo underrun requires RESET to clear */
+#define XTE_IPXR_XMIT_LFIFO_OVER_MASK           (1 << 11)       /**< Tx
length fifo overrun  requires RESET to clear */
+#define XTE_IPXR_XMIT_LFIFO_UNDER_MASK          (1 << 12)       /**< Tx
length fifo underrun requires RESET to clear */
+#define XTE_IPXR_RECV_PFIFO_ABORT_MASK          (1 << 13)       /**< Rx
packet rejected due to full packet FIFO */
+#define XTE_IPXR_RECV_LFIFO_ABORT_MASK          (1 << 14)       /**< Rx
packet rejected due to full length FIFO */
+#define XTE_IPXR_MII_PEND_MASK                  (1 << 15)       /**<
Mii operation now pending */
+#define XTE_IPXR_MII_DONE_MASK                  (1 << 16)       /**<
Mii operation has completed */
+#define XTE_IPXR_XMIT_PFIFO_UNDER_MASK          (1 << 17)       /**< Tx
packet FIFO underrun requires RESET to clear */
+//#define XTE_IPXR_XMIT_DMA_MASK                (1 << 19)       /**< Rx
dma channel */
+//#define XTE_IPXR_RECV_DMA_MASK                (1 << 20)       /**< Tx
dma channel */
+#define XTE_IPXR_RECV_FIFO_LOCK_MASK            (1 << 21)       /**< Rx
FIFO deadlock         requires RESET to clear */
+#define XTE_IPXR_XMIT_FIFO_LOCK_MASK            (1 << 22)       /**< Tx
FIFO deadlock         requires RESET to clear */
+
+
+#define XTE_IPXR_RECV_DROPPED_MASK                                      \
+    (XTE_IPXR_RECV_REJECT_MASK |                                        \
+     XTE_IPXR_RECV_PFIFO_ABORT_MASK |                                   \
+     XTE_IPXR_RECV_LFIFO_ABORT_MASK)                            /**<
IPXR bits that indicate a dropped receive frame */
+
+#define XTE_IPXR_RECV_ERROR_MASK                                        \
+    (XTE_IPXR_RECV_DROPPED_MASK |                                       \
+     XTE_IPXR_RECV_LFIFO_UNDER_MASK)                            /**<
IPXR bits that indicate receive errors */
+
+#define XTE_IPXR_FIFO_FATAL_ERROR_MASK                                  \
+    (XTE_IPXR_RECV_FIFO_LOCK_MASK |                                     \
+     XTE_IPXR_XMIT_FIFO_LOCK_MASK |                                     \
+     XTE_IPXR_XMIT_PFIFO_UNDER_MASK |                                   \
+     XTE_IPXR_XMIT_LFIFO_UNDER_MASK |                                   \
+     XTE_IPXR_XMIT_LFIFO_OVER_MASK |                                    \
+     XTE_IPXR_XMIT_SFIFO_UNDER_MASK |                                   \
+     XTE_IPXR_XMIT_SFIFO_OVER_MASK |                                    \
+     XTE_IPXR_RECV_LFIFO_UNDER_MASK)                            /**<
IPXR bits that indicate fatal FIFO errors. These bits can only be
cleared by a device reset */
+
+
+/**  IPIF transmit and receive packet fifo base offsets
+ *        Individual registers and bit definitions are defined in
+ *        xpacket_fifo_l_v2_00_a.h. This register group is not
accessible if
+ *        the device instance is configured for SGDMA.
+ */
+#define XTE_PFIFO_TXREG_OFFSET          0x00002000              /**<
Packet FIFO Tx channel */
+#define XTE_PFIFO_TXDATA_OFFSET         0x00002100              /**<
IPIF Tx packet fifo port */
+
+#define XTE_PFIFO_RXREG_OFFSET          0x00002010              /**<
Packet FIFO Rx channel */
+#define XTE_PFIFO_RXDATA_OFFSET         0x00002200              /**<
IPIF Rx packet fifo port */
+// #define XTE_IPIF_ISC_TXISR_OFFSET    0x00002318             
+// #define XTE_IPIF_ISC_TXIER_OFFSET    0x0000231c             
+// #define XTE_IPIF_ISC_RXISR_OFFSET    0x00002358             
+// #define XTE_IPIF_ISC_RXIER_OFFSET    0x0000235c             
+
+/**  PLB_TEMAC registers. The TPLR, TSR, RPLR, and RSR are not accessible
+ *        when a device instance is configured for SGDMA. LLPS is not
accessible
+ *        when a device instance is configured for FIFO direct.
+ */
+#define XTE_CR_OFFSET                   0x00001000              /**<  
Control Register (CR) */
+#define XTE_CR_BCREJ_MASK                   (1 << 2)            /**<
Disable broadcast address filtering */
+#define XTE_CR_MCREJ_MASK                   (1 << 1)            /**<
Disable multicast address filtering */
+#define XTE_CR_HRST_MASK                    (1 << 0)            /**<
Reset the hard TEMAC core */
+
+#define XTE_TPLR_OFFSET                 0x00001004              /**< Tx
packet length (FIFO) */
+#define XTE_TSR_OFFSET                  0x00001008              /**< Tx
status (FIFO) */
+#define XTE_TSR_TXED_MASK               0x80000000              /**<
Excess deferral error */
+#define XTE_TSR_PFIFOU_MASK             0x40000000              /**<
Packet FIFO underrun */
+#define XTE_TSR_TXLC_MASK               0x01000000              /**<
Late collision error */
+#define XTE_TSR_ERROR_MASK  (XTE_TSR_TXED_MASK | XTE_TSR_PFIFOU_MASK |
XTE_TSR_TXLC_MASK)    /**< TSR bits that indicate an error */
+#define XTE_RPLR_OFFSET                 0x0000100C              /**< Rx
packet length (FIFO) */
+#define XTE_RSR_OFFSET                  0x00001010              /**<
Receive status */
+#define XTE_TPPR_OFFSET                 0x00001014              /**< Tx
pause packet */
+// #define XTE_LLPS_OFFSET              0x00001018              /**<
LLINK PFIFO status */
+
+
+/**  HARD_TEMAC Core Registers
+ * These are registers defined within the device's hard core located in the
+ * processor block. They are accessed with the host interface. These
registers
+ * are addressed offset by XTE_HOST_IPIF_OFFSET or by the DCR base address
+ * if so configured.
+ *
+ * Access to these registers should go through macros
XIo_In32(XTE_HOST_IPIF_OFFSET+)
+ * and XIo_Out32(XTE_HOST_IPIF_OFFSET+) to guarantee proper access.
+ */
+#define XTE_HOST_IPIF_OFFSET            0x00003000              /**<
Offset of host registers when memory mapped into IPIF */
+#define XTE_RXC0_OFFSET                 0x00000200              /**< Rx
configuration word 0 */
+#define XTE_RXC1_OFFSET                 0x00000240              /**< Rx
configuration word 1 */
+//#define XTE_RXC1_RXRST_MASK               (1 << 31)           /**<
Receiver reset */
+#define XTE_RXC1_RXJMBO_MASK                (1 << 30)           /**<
Jumbo frame enable */
+#define XTE_RXC1_RXFCS_MASK                 (1 << 29)           /**<
FCS not stripped */
+#define XTE_RXC1_RXEN_MASK                  (1 << 28)           /**<
Receiver enable */
+#define XTE_RXC1_RXVLAN_MASK                (1 << 27)           /**<
VLAN enable */
+#define XTE_RXC1_RXHD_MASK                  (1 << 26)           /**<
Half duplex */
+#define XTE_RXC1_RXLT_MASK                  (1 << 25)           /**<
Length/type check disable */
+//#define XTE_RXC1_ERXC1_MASK           0x0000FFFF              /**<
Pause frame source address bits [47:32]. Bits [31:0] are stored in
register ERXC0 */
+
+#define XTE_TXC_OFFSET                  0x00000280              /**< Tx
configuration */
+#define XTE_TXC_TXRST_MASK                  (1 << 31)           /**<
Transmitter reset */
+#define XTE_TXC_TXJMBO_MASK                 (1 << 30)           /**<
Jumbo frame enable */
+#define XTE_TXC_TXFCS_MASK                  (1 << 29)           /**<
Generate FCS */
+#define XTE_TXC_TXEN_MASK                   (1 << 28)           /**<
Transmitter enable */
+#define XTE_TXC_TXVLAN_MASK                 (1 << 27)           /**<
VLAN enable */
+#define XTE_TXC_TXHD_MASK                   (1 << 26)           /**<
Half duplex */
+#define XTE_TXC_TXIFG_MASK                  (1 << 25)           /**<
IFG adjust enable */
+
+#define XTE_FCC_OFFSET                  0x000002C0              /**<
Flow control configuration */
+#define XTE_FCC_RXFLO_MASK                  (1 << 29)           /**< Rx
flow control enable */
+//#define XTE_FCC_TXFLO_MASK                (1 << 30)           /**< Tx
flow control enable */
+
+#define XTE_EMCFG_OFFSET                0x00000300              /**<
EMAC configuration */
+#define XTE_EMCFG_LINKSPD_MASK          0xC0000000              /**<
Link speed */
+//#define XTE_EMCFG_RGMII_MASK              (1 << 29)           /**<
RGMII mode enable */
+//#define XTE_EMCFG_SGMII_MASK              (1 << 28)           /**<
SGMII mode enable */
+//#define XTE_EMCFG_1000BASEX_MASK          (1 << 27)           /**<
1000BaseX mode enable */
+//#define XTE_EMCFG_HOSTEN_MASK             (1 << 26)           /**<
Host interface enable */
+//#define XTE_EMCFG_TX16BIT                 (1 << 25)           /**< 16
bit Tx client enable */
+//#define XTE_EMCFG_RX16BIT                 (1 << 24)           /**< 16
bit Rx client enable */
+#define XTE_EMCFG_LINKSPD_10            0x00000000              /**<
XTE_EMCFG_LINKSPD_MASK for 10 Mbit */
+#define XTE_EMCFG_LINKSPD_100               (1 << 30)           /**<
XTE_EMCFG_LINKSPD_MASK for 100 Mbit */
+#define XTE_EMCFG_LINKSPD_1000              (1 << 31)           /**<
XTE_EMCFG_LINKSPD_MASK for 1000 Mbit */
+
+// #define XTE_GMIC_OFFSET              0x00000320              /**<
RGMII/SGMII configuration */
+#define XTE_MC_OFFSET                   0x00000340              /**<
Management configuration */
+#define XTE_MC_MDIO_MASK                    (1 << 6)            /**<
MII management enable */
+#define XTE_MDIO_CLOCK_DIV_100MHz       0x28                    /* 100
MHz host clock */
+#define XTE_MDIO_DIV_DFT                29                      /*
Default MDIO clock divisor */
+// #define XTE_MC_CLK_DVD_MAX           0x3F                    /**<
Maximum MDIO divisor */
+
+#define XTE_UAW0_OFFSET                 0x00000380              /**<
Unicast address word 0 */
+#define XTE_UAW1_OFFSET                 0x00000384              /**<
Unicast address word 1 */
+#define XTE_UAW1_MASK                   0x0000FFFF              /**<
Station address bits [47:32] Station address bits [31:0] are stored in
register UAW0 */
+
+#define XTE_MAW0_OFFSET                 0x00000388              /**<
Multicast address word 0 */
+#define XTE_MAW1_OFFSET                 0x0000038C              /**<
Multicast address word 1 */
+#define XTE_AFM_OFFSET                  0x00000390              /**<
Promisciuous mode */
+#define XTE_AFM_EPPRM_MASK                  (1 << 31)           /**<
Promiscuous mode enable */
+
+#define XGP_IRSTATUS                0x3A0                       /*
Interrupt Request status */
+#define XGP_IRENABLE                0x3A4                       /*
Interrupt Request enable */
+
+    /**  MII Mamagement Control register (MGTCR) */
+#define XTE_MGTDR_OFFSET                0x000003B0              /**<
MII data */
+#define XGP_E0_MIIM_ADDR                0x000003B4              /**<
MII control */
+#define XTE_MGTCR_RWN_MASK                  (1 << 10)           /**<
Read-not-write,0=read 1=write */
+#define XTE_MGTCR_PHYAD_MASK            0x000003E0              /**<
PHY address */
+#define XTE_MGTCR_REGAD_MASK            0x0000001F              /**<
PHY register address */
+#define XTE_MGTCR_PHYAD_SHIFT_MASK      5                       /**<
Shift bits for PHYAD */
+#define MGTCR_PHYAD(x)              ((x & 0x1f) << 5)       /**< PHY
address */
+#define MGTCR_REGAD(x)              (x & 0x1f)              /**< PHY
register address */
+
+
+#define PFIFO_64BIT_WIDTH_BYTES 8
+
+#define XGP_HIF_BASEADDR                    0x10c
+#define XGP_HIF_DATA_REG_MSW_OFFSET         0x000
+#define XGP_HIF_DATA_REG_LSW_OFFSET         0x001
+#define XGP_HIF_CNTL_REG_OFFSET             0x002
+#define XGP_CON_REG_PERIPH_RESET                (1 << 31)
+#define XGP_CON_REG_TEMAC_RESET                 (1 << 30)
+#define XGP_CON_REG_PHY_RESET                   (1 << 29)
+#define XGP_HIF_RDY_STATUS_OFFSET           0x003  
+
+/** DCR Ready Status Register masks for EMAC0 */
+#define XGP_HIF_RDYSTAT_CONFIG0_READ_MASK           (1 << 5)
+#define XGP_HIF_RDYSTAT_CONFIG0_WRITE_MASK          (1 << 6)
+#define XGP_HIF_RDYSTAT_AF0_WRITE_MASK              (1 << 4)
+#define XGP_HIF_RDYSTAT_AF0_READ_MASK               (1 << 3)
+#define XGP_HIF_RDYSTAT_MIIM0_WRITE_MASK            (1 << 2)
+#define XGP_HIF_RDYSTAT_MIIM0_READ_MASK             (1 << 1)
+
+/** DCR control register CntlReg masks * */
+#define XGP_HIF_CNTL_REG_OFFSET_DCR_WRITE           (1 << 15)       /*
Write enable */
+
+
+
+#define db_printf       DEBUG_PRINTK
+/* use 0 for production, 1 for verification, >1 for debug */
+#if defined(CONFIG_PICO_DEBUG_TEMAC)
+#define DEBUG_FUNC              if (lp->dbg)
{dbg_printk("\n%s:%s()",DRV_NAME, __FUNCTION__);}
+#define DEBUG_FUNC_EXIT         if (lp->dbg) {dbg_printk("\n%s:%s()
exit",DRV_NAME,__FUNCTION__);}
+#define DEBUG_FUNC_EX(ret)      if (lp->dbg)
{dbg_printk("\n%s:%s(%d)exit",DRV_NAME,__FUNCTION__,ret);}
+#define DEBUG_PRINTL(args...)   if (lp->dbg) dbg_printk("\n" __FILE__
": " args)
+#define DEBUG_PRINTK(args...)   if (lp->dbg) dbg_printk(args)
+#define DEBUG_PUTS(fmt...)      if (lp->dbg) dbg_puts(fmt)
+void dbg_printk(unsigned char *fmt, ...);
+static unsigned int debug = 1;
+#else
+#define DEBUG_FUNC              do { } while(0)
+#define DEBUG_FUNC_EXIT         do { } while(0)
+#define DEBUG_PRINTL(args...)   do { } while(0)
+#define DEBUG_PRINTK(args...)   do { } while(0)
+#define DEBUG_PUTS(args...)     do { } while(0)
+#define dump_skb(lp, skb) 0
+#define dump_skb_data(lp, skb, str) 0
+static unsigned int debug = 1;
+#endif
+
+#define mHoldS_SetEmpty(F)  ((F)->ByteIndex = 0)
+#define mHoldR_SetEmpty(F)  ((F)->ByteIndex = (F)->Width)
+/*******************************************************************************
+ * Primitive read from 64 bit FIFO. Use two 32-bit wide I/O accesses.
+ *
+ * @param F - Address to a temac_pktFifo structure
+ * @param DestPtr - Destination data address aligned on 4 byte boundary
+ *
+
******************************************************************************/
+#define mReadFifo64(F, DestPtr)                                \
+    (DestPtr)[0] = _ior(F->DataBaseAddress);          \
+    (DestPtr)[1] = _ior(F->DataBaseAddress + 4);
+
+#define mPush64(F) mWriteFifo64(F, &F->Hold[0])
+#define mHold_GetIndex(F)      ((F)->ByteIndex)
+#define mHoldS_IsEmpty(F)   ((F)->ByteIndex == 0)
+#define mHoldR_IsEmpty(F)   ((F)->ByteIndex >= (F)->Width)
+#define mHold_CopyOut(F, I, D) ((D) = (*(u8*)(((u8*)(&(F)->Hold[0])) +
(I))))
+#define mHold_SetIndex(F, D)   ((F)->ByteIndex = (D))
+#define mHold_CopyIn(F, I, D)  (*(u8*)(((u8*)(&(F)->Hold[0])) + (I)) = (D))
+#define mPop64(F) mReadFifo64(F, &F->Hold[0])
+#define mHold_SetIndex(F, D)   ((F)->ByteIndex = (D))
+#define mHoldS_IsFull(F)    ((F)->ByteIndex >= (F)->Width)
+#define mHold_Advance(F, D)    ((F)->ByteIndex += (D))
+/*******************************************************************************
+ * Primitive write to 64 bit FIFO. Use two 32-bit wide I/O accesses.
+ *
+ * @param F - Address to a temac_pktFifo structure
+ * @param SrcPtr - Source data address aligned on 4 byte boundary
+ *
+
******************************************************************************/
+#define mWriteFifo64(F, SrcPtr)                                \
+    {                                                          \
+        register u32 Faddr = F->DataBaseAddress;      \
+        _iow(Faddr, (SrcPtr)[0]);                         \
+        _iow(Faddr + 4, (SrcPtr)[1]);                     \
+    }
+
+
+
+/* Structure/enum declaration ------------------------------- */
+
+/* This type encapsulates a packet FIFO channel and support attributes to
+ * allow unaligned data transfers.
+ */
+struct temac_pktFifo {
+    u32             Hold[2];                /* Holding register */
+    unsigned        ByteIndex;              /* Holding register index */
+    unsigned        Width;                  /* Width of packet FIFO's
keyhole data port in bytes */
+    u32             RegBaseAddress;         /**< Base address of
registers */
+    u32             DataBaseAddress;        /**< Base address of data
for FIFOs */
+} ;
+
+struct temac_local {
+#if defined(LINUX)
+    struct sk_buff              *deferred_skb;     /* buffer for one
skb in case no room is available for transmission */
+
+//  void                        *RxFramePtr;       /* Address of first
RxFrame */
+    unsigned                    MaxFrameSz;        /* Size in bytes of
largest frame for Tx or Rx */
+//  u32                         RxPktFifoDepth;    /**< Depth of
receive packet FIFO in bits */
+//  u32                         TxPktFifoDepth;    /**< Depth of
transmit packet FIFO in bits */
+//  u16                         MacFifoDepth;      /**< Depth of the
status/length FIFOs in entries */
+
+    struct resource             *nic_addr_res;     /* resources found */
+    struct resource             *phy_addr_res;
+    struct resource             *nic_addr_req;     /* resources
requested */
+    struct resource             *phy_addr_req;
+    void __iomem                *nic_vaddr;        /* Register I/O base
address */
+
+    struct mii_if_info          mii_if;
+#else
+    EnetDevice                  enetDevice;
+    InterruptHandler            handler;
+    struct sk_buff              __skb[(NUM_TX_BDS+NUM_RX_BDS) +
(MAX_CACHE_LINE_SIZE/sizeof(struct sk_buff))];
+    char                        name[20];
+    u32                         base_addr;
+    u8                          dev_addr[6];
+
+    u32                         disablecount;
+    u32                         enablecount;
+    u32                         tx_reset_pending;
+    u32                         rx_reset_pending;
+    u32                         reads_denied_during_reset;
+    u32                         writes_denied_during_reset;
+
+    int                         devno;
+    Error                       (*GetLinkStatus)(struct temac_local *
lp, LinkSpeed *linkSpeed, LinkStatus *linkStatus, LinkDuplex  *linkDuplex);
+
+    PHY                         mii_if;
+    u32                         trans_start;
+    u32                         last_rx;
+#endif
+    unsigned int                mii:1;              /* mii port
available */
+    u8                          regshift;
+    u32                         msg_enable;         /* debug message
level */
+    struct net_device_stats     stats;              /* Statistics for
this device */
+    unsigned int                phy_mode;          /* dcr */
+    u16                         phy_addr;
+    u32                         phy_status;
+    unsigned int                poll:1;
+    unsigned int                dbg:1;              /* debug ? */
+    unsigned int                nic_type;           /* plb/ll */
+    int                         LinkSpeed;          /* Speed of link
10/100/1000 */
+    u32                         options;            /* Current options
word */
+//  u32                         TxPktFifoErrors;    /**< Number of Tx
packet FIFO errors detected */
+//  u32                         TxStatusErrors;
+//  u32                         RxPktFifoErrors;    /**< Number of Rx
packet FIFO errors detected */
+//  u32                         RxRejectErrors;
+//  u32                         FifoErrors;         /**< Number of
length/status FIFO errors detected */
+//  u32                         IpifErrors;         /**< Number of IPIF
transaction and data phase errors detected */
+//  u32                         Interrupts;         /**< Number of
interrupts serviced */
+    spinlock_t                  lock;
+    u16                         dcr_host;
+    struct timer_list           rx_timer;
+    struct timer_list           mii_timer;
+
+    /* Packet FIFO channels */
+    struct temac_pktFifo        RecvFifo;           /* Receive channel */
+    struct temac_pktFifo        SendFifo;           /* Transmit channel */
+
+} ;
+
+#if !defined(LINUX)
+static void EmacPhyInit(struct temac_local* lp);
+
+#define DEBUG_LOG
+
+extern void usDelay(u32 usec);
+
+static void
+mdelay(u32 delay) {
+    while(delay--) {
+        usDelay(1000);
+    }
+}
+
+/****************************************************************************/
+static struct sk_buff*
+get_free_skb(struct temac_local* lp, int num_skb) {
+    int ii;
+    // DEBUG_FUNC;
+    for(ii=0;ii < (NUM_TX_BDS+NUM_RX_BDS);ii++){
+        struct sk_buff *skb = &lp->__skb[ii];
+        // DEBUG_PRINTK("\n__skb[%d]
flags=%0x,%0x",ii,lp->__skb[ii].flags, skb->flags );
+        // if (lp->dbg) dump_skb(lp, skb);
+        if ((skb->flags & SKB_INUSE) == 0) {
+                skb->flags |= SKB_INUSE ;
+            // DEBUG_PRINTK(" found %d %0x %0x",ii, skb, &lp->__skb[ii]);
+            // this cast appears critical
+            return  (struct sk_buff *) &lp->__skb[ii];
+        }
+    }
+    // DEBUG_PRINTK(" ~found\n");
+    return NULL;
+}
+
+static u32
+get_free_skb_count(struct temac_local* lp) {
+    int ii;
+    struct sk_buff *skb ;
+    u32 ret = 0;
+    // DEBUG_PRINTK("\nget_free_skb_count()=");
+    for(ii=0;ii < (NUM_TX_BDS+NUM_RX_BDS);ii++){
+        skb = &lp->__skb[ii];
+        if ((skb->flags & SKB_INUSE) == 0) ret++;
+       
+    }
+    // DEBUG_PRINTK("%d",ret);
+    return ret;
+}
+
+static void
+skb_put(struct sk_buff *skb, u32 len) {
+    skb->len = len;
+    skb->tail = skb->data+len;
+}
+
+#define dev_kfree_skb_irq dev_kfree_skb
+static void
+dev_kfree_skb(struct sk_buff *skb) {
+    memset((void*)skb, 0, sizeof(struct sk_buff));
+}
+
+static struct sk_buff *
+dev_alloc_skb(u32 len) {
+    static struct sk_buff *skb;
+    struct temac_local* lp = &temac_dev_array[0];
+    int ii;
+    // DEBUG_PRINTK("\ndev_alloc_skb(len=%d)",len);
+    for(ii=0;ii < (NUM_TX_BDS+NUM_RX_BDS);ii++){
+        skb = &lp->__skb[ii];
+
+        // DEBUG_PRINTK("\nskb[%d] flags=%0x, len=%d", ii, skb->flags,
skb->size );
+        if (((skb->flags & (SKB_INUSE | SKB_RX | SKB_ALLOC)) ==
(SKB_INUSE | SKB_RX)) && (skb->size >= len) && (skb->len == 0)) {
+            skb->flags |= SKB_ALLOC;
+             // DEBUG_PRINTK(" found %d %0x %0x",ii, skb, &lp->__skb[ii]);
+            return skb;
+        }
+    }
+    return NULL;
+}
+static struct temac_local   temac_dev_array[MAX_TEMAC_DEVS];
+static u8           num_devs = 0;
+
+static struct temac_local*
+temac_allocate(void) {
+    struct temac_local* lp;
+
+    if (num_devs >= MAX_TEMAC_DEVS) {
+        return NULL;
+    }
+
+    lp = &temac_dev_array[num_devs];
+    num_devs++;
+
+    return lp;
+}
+#endif
+
+static u32
+_ior(u32 offset) {
+    u32 value;
+    value = (*(volatile u32 *) (offset));
+    __asm__ __volatile__("eieio");
+    return value;
+}
+
+static void
+_iow(u32 offset, u32 value) {
+    (*(volatile u32 *) (offset) = value);
+    __asm__ __volatile__("eieio");
+}
+
+static u32
+ior(struct net_device *ndev, int offset) {
+    return _ior(ndev->base_addr + offset);
+}
+
+static u32
+ios(struct net_device *ndev) {
+    return ior(ndev, XTE_IPIER_OFFSET) & ior(ndev, XTE_IPISR_OFFSET);
+}
+
+static void
+iow(struct net_device *ndev, int offset, u32 value) {
+    _iow(ndev->base_addr + offset, value);
+}
+
+/***************************************************************************
+ * Reads an MII register from the MII PHY attached to the Xilinx Temac.
+ *
+ * Parameters:
+ *   dev      - the temac device.
+ *   phy_addr - the address of the PHY [0..31]
+ *   reg_num  - the number of the register to read. 0-6 are defined by
+ *              the MII spec, but most PHYs have more.
+ *   reg_value - this is set to the specified register's value
+ *
+ * Returns:
+ *   Success or Failure
+ */
+static Error
+g_mdio_read(struct net_device *ndev, int phy_id, int reg_num, u16 *
reg_val) {
+    struct temac_local *lp = ndev->priv;
+    u32 timeout, status;
+    unsigned long flags;
+    *reg_val = 0;
+    // unsigned long flags;
+
+    // DEBUG_PRINTK("\nmdio_read(%x,%x)= ", phy_id, reg_num);
+    timeout = PHY_TIMEOUT;
+    /* Start a read */
+
+    /* Make sure no other PHY operation is currently in progress */
+    if (ior(ndev, XTE_IPISR_OFFSET) & XTE_IPXR_MII_PEND_MASK)
+        return Failure;
+
+    if (lp->mii) {
+        spin_lock_irqsave(&lp->lock, flags);
+
+        switch (lp->phy_mode) {
+            case PHY_DCR:
+                mtdcr(lp->phy_addr + XGP_HIF_DATA_REG_LSW_OFFSET,
((phy_id << 5) | (reg_num)));
+                mtdcr(lp->phy_addr + XGP_HIF_CNTL_REG_OFFSET,
XGP_E0_MIIM_ADDR);
+                while (!(mfdcr(lp->phy_addr +
XGP_HIF_RDY_STATUS_OFFSET) & XGP_HIF_RDYSTAT_MIIM0_READ_MASK));
+                *reg_val = (u16) mfdcr(lp->phy_addr +
XGP_HIF_DATA_REG_LSW_OFFSET);
+                break;
+
+            default:
+                /* Construct Mgtcr mask for the operation */
+                /* Write and wait for completion */
+                iow(ndev, XTE_HOST_IPIF_OFFSET + XGP_E0_MIIM_ADDR,
(reg_num & XTE_MGTCR_REGAD_MASK) | ((phy_id <<
XTE_MGTCR_PHYAD_SHIFT_MASK) & XTE_MGTCR_PHYAD_MASK) | XTE_MGTCR_RWN_MASK);
+
+                while (!(status = ior(ndev, XTE_IPISR_OFFSET) &
XTE_IPXR_MII_DONE_MASK) && timeout--) ;
+                if (!(status & (XTE_IPXR_MII_DONE_MASK)))
+                    return Failure;
+
+                *reg_val = ior(ndev, XTE_HOST_IPIF_OFFSET +
XTE_MGTDR_OFFSET);      /* Read data */
+
+                /* Clear MII status bits */
+                iow(ndev, XTE_IPISR_OFFSET, ior(ndev, XTE_IPISR_OFFSET)
& (XTE_IPXR_MII_DONE_MASK | XTE_IPXR_MII_PEND_MASK));
+                break;
+        }
+        spin_unlock_irqrestore(&lp->lock, flags);
+    }
+//  DEBUG_PRINTK("%x", *reg_val);
+    return Success;
+}
+
+static int
+mdio_read(struct net_device *ndev, int phy_id, int reg_num) {
+    u16 ret = 0;
+    g_mdio_read(ndev, phy_id, reg_num, &ret);
+    return ret;
+}
+
+/***************************************************************************
+ * Writes an MII register from the MII PHY attached to the Xilinx Temac.
+ *
+ * Parameters:
+ *   dev      - the temac device.
+ *   phy_id - the address of the PHY [0..31]
+ *   reg_num  - the number of the register to read. 0-6 are defined by
+ *              the MII spec, but most PHYs have more.
+ *   reg_value - the value to set
+ *
+ * Returns:
+ *   Success or Failure
+ */
+static void
+mdio_write(struct net_device *ndev, int phy_id, int reg_num, int reg_val) {
+    struct temac_local *lp = ndev->priv;
+    u32 timeout, status;
+    unsigned long flags;
+    int EmacNum = 0;
+    // DEBUG_FUNC;
+    // DEBUG_PRINTK("\nmdio_write(%x,%x, %x)= ", phy_id,
reg_num,reg_value);
+    timeout = PHY_TIMEOUT;
+
+    if (lp->mii) {
+        spin_lock_irqsave(&lp->lock, flags);
+        switch (lp->phy_mode) {
+            case PHY_DCR:
+                mtdcr(lp->phy_addr + XGP_HIF_DATA_REG_LSW_OFFSET,
(reg_val));
+                mtdcr(lp->phy_addr + XGP_HIF_CNTL_REG_OFFSET,
XGP_HIF_CNTL_REG_OFFSET_DCR_WRITE | XTE_MGTDR_OFFSET);
+                mtdcr(lp->phy_addr + XGP_HIF_DATA_REG_LSW_OFFSET,
((phy_id << 5) | (reg_num)));
+                mtdcr(lp->phy_addr + XGP_HIF_CNTL_REG_OFFSET,
XGP_HIF_CNTL_REG_OFFSET_DCR_WRITE | ((EmacNum) << 10) | XGP_E0_MIIM_ADDR);
+                while (!(mfdcr(lp->phy_addr +
XGP_HIF_RDY_STATUS_OFFSET) & XGP_HIF_RDYSTAT_MIIM0_WRITE_MASK));
+                break;
+
+            default:
+                /* Make sure no other PHY operation is currently in
progress */
+                if (ior(ndev, XTE_IPISR_OFFSET) & XTE_IPXR_MII_PEND_MASK)
+                    return ;
+                /* Construct Mgtcr mask for the operation */
+                /* Write and wait for completion */
+                iow(ndev, XTE_HOST_IPIF_OFFSET + XTE_MGTDR_OFFSET,
reg_val & 0xffff);
+                iow(ndev, XTE_HOST_IPIF_OFFSET + XGP_E0_MIIM_ADDR,
(reg_num & XTE_MGTCR_REGAD_MASK) | ((phy_id <<
XTE_MGTCR_PHYAD_SHIFT_MASK) & XTE_MGTCR_PHYAD_MASK));
+
+                while (!(status = ior(ndev, XTE_IPISR_OFFSET) &
XTE_IPXR_MII_DONE_MASK) && timeout--) ;
+                if (!(status & (XTE_IPXR_MII_DONE_MASK)))
+                    return ;
+
+                /* Clear MII status bits */
+                iow(ndev, XTE_IPISR_OFFSET, ior(ndev, XTE_IPISR_OFFSET)
& (XTE_IPXR_MII_DONE_MASK | XTE_IPXR_MII_PEND_MASK));
+                break;
+        }
+        spin_unlock_irqrestore(&lp->lock, flags);
+    }
+    // return Success;
+}
+
+static u32
+emac_cfg_read(struct net_device *ndev, u16 phy_id, u16 reg_num) {
+    struct temac_local *lp = ndev->priv;
+    int EmacNum = 0;
+    u32 ret = 0;
+
+    if (lp->mii) {
+        switch (lp->phy_mode) {
+            case PHY_DCR:
+                mtdcr(lp->phy_addr + XGP_HIF_CNTL_REG_OFFSET, (EmacNum
<< 10) | (reg_num));
+                while (!(mfdcr(lp->phy_addr +
XGP_HIF_RDY_STATUS_OFFSET) & (XGP_HIF_RDYSTAT_CONFIG0_READ_MASK << (8 *
(EmacNum)))));
+                return (u32) mfdcr(lp->phy_addr +
XGP_HIF_DATA_REG_LSW_OFFSET);
+            default:
+                return ior(ndev, XTE_HOST_IPIF_OFFSET + reg_num);
+        }
+    }
+
+    return ret;
+}
+
+static void
+emac_cfg_write(struct net_device *ndev, u16 phy_id, u32 reg_num, u32 val) {
+    struct temac_local *lp = ndev->priv;
+    int EmacNum = 0;
+
+    if (lp->mii) {
+        switch (lp->phy_mode) {
+            case PHY_DCR:
+                mtdcr(lp->phy_addr + XGP_HIF_DATA_REG_LSW_OFFSET, (val));
+                mtdcr(lp->phy_addr + XGP_HIF_CNTL_REG_OFFSET,
XGP_HIF_CNTL_REG_OFFSET_DCR_WRITE | (EmacNum << 10) | (reg_num));
+                while (!(mfdcr(lp->phy_addr +
XGP_HIF_RDY_STATUS_OFFSET) & XGP_HIF_RDYSTAT_CONFIG0_WRITE_MASK));
+                break;
+            default:
+                iow(ndev, XTE_HOST_IPIF_OFFSET + reg_num, val);
+                break;
+        }
+    }
+}
+
+static u32
+emac_AF_read(struct net_device *ndev, int reg_num) {
+    struct temac_local *lp = ndev->priv;
+    int EmacNum = 0;
+        switch (lp->phy_mode) {
+            case PHY_DCR:
+                mtdcr((lp->phy_addr) + XGP_HIF_CNTL_REG_OFFSET,
(EmacNum << 10) | (reg_num));
+                while ( !(mfdcr(lp->phy_addr +
XGP_HIF_RDY_STATUS_OFFSET )  & (XGP_HIF_RDYSTAT_AF0_READ_MASK <<
(8*(EmacNum)))));
+                return (u32) mfdcr((lp->phy_addr) +
XGP_HIF_DATA_REG_LSW_OFFSET) ;
+            default:
+                return ior(ndev, XTE_HOST_IPIF_OFFSET + reg_num);
+        }
+        return 0;
+}
+
+static void
+emac_AF_write(struct net_device *ndev, int reg_num, u32 val) {
+    struct temac_local *lp = ndev->priv;
+    int EmacNum = 0;
+
+    if (lp->mii) {
+        switch (lp->phy_mode) {
+            case PHY_DCR:
+                mtdcr(lp->phy_addr + XGP_HIF_DATA_REG_LSW_OFFSET, (val));
+                mtdcr(lp->phy_addr + XGP_HIF_CNTL_REG_OFFSET,
XGP_HIF_CNTL_REG_OFFSET_DCR_WRITE | ((EmacNum) << 10) | (reg_num));
+                while (!(mfdcr(lp->phy_addr +
XGP_HIF_RDY_STATUS_OFFSET) & XGP_HIF_RDYSTAT_AF0_WRITE_MASK));
+                break;
+            default:
+                iow(ndev, XTE_HOST_IPIF_OFFSET + reg_num, val);
+                break;
+        }
+    }
+}
+#if defined(CONFIG_PICO_DEBUG_TEMAC)
+
+static void
+dump_skb(struct temac_local* lp, struct sk_buff *skb) {
+#if !defined(LINUX)
+    DEBUG_PRINTK("\nskb->flags\t%0x",  skb->flags);
+    DEBUG_PRINTK("\nskb->fifo_data\t%0x",  skb->fifo_data);
+    DEBUG_PRINTK("\nskb->fifo_reg\t%0x",  skb->fifo_reg);
+    DEBUG_PRINTK("\nskb->size\t%d",  skb->size);
+#endif
+    DEBUG_PRINTK("\nskb->len\t%0d",  skb->len);
+#if !defined(LINUX)
+    DEBUG_PRINTK("\nskb->user\t%0x",  skb->user);
+    DEBUG_PRINTK("\nskb->user_data\t%0x",  skb->user_data);
+#endif
+    DEBUG_PRINTK("\nskb->dev\t%0x",  skb->dev);
+    DEBUG_PRINTK("\nskb->data\t%0x",  skb->data);
+    DEBUG_PRINTK("\nskb->tail\t%0x",  skb->tail);
+}
+
+static void
+dump_skb_data(struct temac_local *lp, struct sk_buff *skb, char *str) {
+    int ii;
+    u8 *cp = skb->data ;
+
+    DEBUG_PRINTK("\n%s %d bytes", str, skb->len);
+    for (ii = 0; ii < skb->len; ii++) {
+        if (( ii % 16) == 0) DEBUG_PRINTK("\n");
+        if (( ii % 8) == 0) DEBUG_PRINTK(" ");
+        DEBUG_PRINTK("%02x ", cp[ii]);
+    }
+    DEBUG_PRINTK("\n");
+}
+
+static void
+disp_emac_cfg(struct net_device *ndev, char *rname, int  regnum, int idx) {
+    struct temac_local *lp = ndev->priv;
+    u32 ret;
+    int ii;
+
+    if ((idx % 4) == 0) DEBUG_PRINTK("\n\t");
+    ret = emac_cfg_read(ndev, PHY_NUM, regnum);
+    if (rname) {
+        DEBUG_PRINTK("%s:", rname);
+        for(ii=strlen(rname);ii<10;ii++) DEBUG_PRINTK(" ");
+        DEBUG_PRINTK("0x%08x  ", ret);
+    } else
+        DEBUG_PRINTK("R%03d:      0x%08x  ",  regnum, ret);
+}
+
+static void
+disp_temac_cfg(struct net_device *ndev, char *rname, int  addr, int idx) {
+    struct temac_local *lp = ndev->priv;
+    u32 ret = 0;
+    int ii;
+
+    if ((idx % 4) == 0) DEBUG_PRINTK("\n\t");
+    switch (lp->phy_mode) {
+        case PHY_DCR:
+            break;
+        default:
+            ret = _ior(ndev->base_addr + addr);
+            break;
+    }
+    if (rname) {
+        DEBUG_PRINTK("%s:", rname);
+        for(ii=strlen(rname);ii<10;ii++) DEBUG_PRINTK(" ");
+        DEBUG_PRINTK("0x%08x  ", ret);
+    } else
+        DEBUG_PRINTK("R%03d:      0x%08x  ",  addr, ret);
+}
+
+static void
+disp_mii(struct net_device *ndev, char *rname, int  regnum) {
+    struct temac_local *lp = ndev->priv;
+    u32 ret;
+    int ii;
+    if ((regnum % 4) == 0) DEBUG_PRINTK("\n\t");
+    ret =  mdio_read(ndev, PHY_NUM, regnum);
+    if (rname) {
+        DEBUG_PRINTK("%s:", rname);
+        for(ii=strlen(rname);ii<10;ii++) DEBUG_PRINTK(" ");
+        DEBUG_PRINTK("0x%08x  ", ret);
+    } else
+        DEBUG_PRINTK("R%02d:       0x%08x  ",  regnum, ret);
+}
+
+static void
+temac_dump(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    u32 ret;
+    int ii, jj;
+
+#if defined(LINUX)
+    DEBUG_PRINTK("\nresources:\n\tirq=%d ", ndev->irq);
+    DEBUG_PRINTK("\n\tnic  physical address =%x ",
lp->nic_addr_res->start);
+    DEBUG_PRINTK("size %x ", res_size(lp->nic_addr_res));
+    DEBUG_PRINTK("virtual address %lx", ndev->base_addr);
+    DEBUG_PRINTK("\n\t irq=%d mem=%lx phy=%x", ndev->irq,
ndev->base_addr, lp->phy_addr);
+#else
+    DEBUG_PRINTK("\nresources:\n\tirq=%d ", ndev->handler.vect);
+    DEBUG_PRINTK("virtual address %x ", ndev->base_addr);
+    DEBUG_PRINTK("\n\t irq=%d mem=%x phy=%x", ndev->handler.vect,
ndev->base_addr, ndev->phy_addr);
+#endif
+
+    DEBUG_PRINTK("\n\t");
+    ret = mdio_read(ndev, PHY_NUM, MII_SSR) ;
+    switch (ret & MII_SSR_SPDMASK) {
+        case MII_SSR_SPD1000:
+            DEBUG_PRINTK("1000");
+            break;
+        case MII_SSR_SPD100:
+            DEBUG_PRINTK("100");
+            break;
+        case MII_SSR_SPD10:
+            DEBUG_PRINTK("10");
+            break;
+        default:
+            DEBUG_PRINTK("Error : invalid PHY mode/speed");
+    };
+    DEBUG_PRINTK("BASE-T, ");
+    if ((ret & MII_SSR_FD) == MII_SSR_FD) {
+        DEBUG_PRINTK("FD");
+    } else {
+        DEBUG_PRINTK("HD");
+    }
+    if ((ret & MII_SSR_LINK)  == 0) {
+        DEBUG_PRINTK(" Ethernet Link Down");
+    }
+    /* read mii phy registers */
+    DEBUG_PRINTK("\nReading PHY Regs through DCR:\n\t");
+    for (ii = 0; ii < 32; ii++) {
+        switch (ii) {
+            case MII_ANI:
+                disp_mii(ndev, "ANI", ii);
+                break;
+            case MII_SSR:
+                disp_mii(ndev, "SSR", ii);
+                break;
+            case MII_ISR:
+                disp_mii(ndev, "ISR", ii);
+                break;
+            case MII_BMCR:
+                disp_mii(ndev, "MCR", ii);
+                break;
+            case MII_BMSR:
+                disp_mii(ndev, "MSR", ii);
+                break;
+            case MII_PHYSID1:
+                disp_mii(ndev,"PHYSID1",ii);
+                break;
+            case MII_PHYSID2:
+                disp_mii(ndev,"PHYSID2",ii);
+                break;
+            case MII_ADVERTISE:
+                disp_mii(ndev,"ADV", ii);
+                break;
+            case MII_LPA:
+                disp_mii(ndev,"LPA", ii);
+                break;
+            case MII_EXPANSION:
+                disp_mii(ndev,"EXPANSION", ii);
+                break;
+            case MII_CTRL1000:
+                disp_mii(ndev,"CTRL1000", ii);
+                break;
+            case MII_STAT1000:
+                disp_mii(ndev,"STAT1000", ii);
+                break;
+            case MII_ESTATUS:
+                disp_mii(ndev,"ESTATUS", ii);
+                break;
+            case MII_DCOUNTER:
+                disp_mii(ndev,"DCOUNTER", ii);
+                break;
+            case MII_NWAYTEST:
+                disp_mii(ndev,"NWAYTEST", ii);
+                break;
+            case MII_RERRCOUNTER:
+                disp_mii(ndev,"RERRCOUNT", ii);
+                break;
+            case MII_SREVISION:
+                disp_mii(ndev,"SREVISION",ii);
+                break;
+            case MII_RESV1:
+                disp_mii(ndev,"RESV1",ii);
+                break;
+            case MII_LBRERROR:
+                disp_mii(ndev,"LBERROR",ii);
+                break;
+            case MII_PHYADDR:
+                disp_mii(ndev,"PHYADDR",ii);
+                break;
+            case MII_RESV2:
+                disp_mii(ndev,"RESV2",ii);
+                break;
+            case MII_TPISTATUS:
+                disp_mii(ndev,"TPISTATUS",ii);
+                break;
+            case MII_NCONFIG:
+                disp_mii(ndev,"NCONFIG",ii);
+                break;
+#if 0
+            case MII_FCSCOUNTER:
+                disp_mii(ndev,"FCSCOUNTER",ii);
+                break;
+#endif
+            default:
+                disp_mii(ndev,0, ii);
+                break;
+        }
+    }
+    /*
+    Print TEMAC Receiver and Transmitter configuration
+    */
+    DEBUG_PRINTK("\nReading Hard TEMAC Regs:\n");
+
+    for (ii = 0x200,jj = 0; ii <= 0x3a4; ii += 4) {
+        switch (ii) {
+            case XTE_RXC0_OFFSET:
+                disp_emac_cfg(ndev, "RxCW0", ii, jj++);
+                break;
+            case XTE_RXC1_OFFSET:
+                disp_emac_cfg(ndev, "RxCW1", ii, jj++);
+                break;
+            case XTE_TXC_OFFSET:
+                disp_emac_cfg(ndev, "TxCW", ii, jj++);
+                break;
+            case XTE_FCC_OFFSET:
+                disp_emac_cfg(ndev, "Flow", ii, jj++);
+                break;
+            case XTE_EMCFG_OFFSET:
+                disp_emac_cfg(ndev, "ModeCfg", ii, jj++);
+                break;
+            case XTE_MC_OFFSET:
+                disp_emac_cfg(ndev, "MgmtCfg", ii, jj++);
+                break;
+            case XTE_UAW0_OFFSET:
+                disp_emac_cfg(ndev, "MacAddr0", ii, jj++);
+                break;
+            case XTE_UAW1_OFFSET:
+                disp_emac_cfg(ndev, "MacAddr1", ii, jj++);
+                break;
+            case XTE_MAW0_OFFSET:
+                disp_emac_cfg(ndev, "AtAddr0", ii, jj++);
+                break;
+            case XTE_MAW1_OFFSET:
+                disp_emac_cfg(ndev, "AtAddr1", ii, jj++);
+                break;
+            case XTE_AFM_OFFSET:
+                disp_emac_cfg(ndev, "AtCAF", ii, jj++);
+                break;
+            case XGP_IRSTATUS:
+                disp_emac_cfg(ndev, "ISR", ii, jj++);
+                break;
+            case XGP_IRENABLE:
+                disp_emac_cfg(ndev, "IER", ii, jj++);
+                break;
+            default:
+                break;
+        }
+    }
+    DEBUG_PRINTK("\n");
+
+    if (lp->nic_type == TEMAC_PLB) {
+        DEBUG_PRINTK("\nReading PLB TEMAC Regs:\n");
+
+        for (ii = 0x0,jj = 4;ii <= 0x1020; ii += 4) {
+            switch (ii) {
+                case XTE_DISR_OFFSET:
+                    disp_temac_cfg(ndev, "DISR", ii, jj++);
+                    break;
+                case XTE_DIPR_OFFSET:
+                    disp_temac_cfg(ndev, "DIPR", ii, jj++);
+                    break;
+                case XTE_DIER_OFFSET:
+                    disp_temac_cfg(ndev, "DIER", ii, jj++);
+                    break;
+                case XTE_DGIE_OFFSET:
+                    disp_temac_cfg(ndev, "DGIE", ii, jj++);
+                    break;
+                case XTE_IPISR_OFFSET:
+                    disp_temac_cfg(ndev, "IPISR", ii, jj++);
+                    break;
+                case XTE_IPIER_OFFSET:
+                    disp_temac_cfg(ndev, "IPIER", ii, jj++);
+                    break;
+                case XTE_DSR_OFFSET:
+                    disp_temac_cfg(ndev, "MIR", ii, jj++);
+                    break;
+                case XTE_TPLR_OFFSET:
+                    // disp_temac_cfg(ndev, "TPLR", ii, jj++);  // do
not try to display this register - BAD things will happen
+                    break;
+                case XTE_CR_OFFSET:
+                    disp_temac_cfg(ndev, "CR", ii, jj++);
+                    break;
+                case XTE_TSR_OFFSET:
+                    // disp_temac_cfg(ndev, "TSR", ii, jj++);
+                    break;
+                case XTE_RPLR_OFFSET:
+                    // disp_temac_cfg(ndev, "RPLR", ii, jj++);
+                    break;
+                case XTE_RSR_OFFSET:
+                    disp_temac_cfg(ndev, "RSR", ii, jj++);
+                    break;
+                case XTE_TPPR_OFFSET:
+                    disp_temac_cfg(ndev, "TPPR", ii, jj++);
+                    break;
+                default:
+                    break;
+            }
+        }
+    }
+    DEBUG_PRINTK("\nDisplaying Options:\n");
+
+    for (ii = 0, jj = 0;ii < 32; ii++) {
+        if ( lp->options & ( 1 << ii)) {
+            jj++;
+            if ((jj % 4) == 0) DEBUG_PRINTK("\n\t");
+            switch ( 1 << ii) {
+                case XTE_PROMISC_OPTION:
+                    DEBUG_PRINTK("PROMISC ");
+                    break;
+                case XTE_JUMBO_OPTION:
+                    DEBUG_PRINTK("JUMBO ");
+                    break;
+                case XTE_VLAN_OPTION:
+                    DEBUG_PRINTK("VLAN ");
+                    break;
+                case XTE_FLOW_CONTROL_OPTION:
+                    DEBUG_PRINTK("FLOW_CONTROL ");
+                    break;
+                case XTE_FCS_STRIP_OPTION:
+                    DEBUG_PRINTK("FCS_STRIP ");
+                    break;
+                case XTE_FCS_INSERT_OPTION:
+                    DEBUG_PRINTK("FCS_INSERT ");
+                    break;
+                case XTE_LENTYPE_ERR_OPTION:
+                    DEBUG_PRINTK("LENTYPE ERR ");
+                    break;
+                case XTE_POLLED_OPTION:
+                    DEBUG_PRINTK("POLLED ");
+                    break;
+                case XTE_REPORT_RXERR_OPTION:
+                    DEBUG_PRINTK("REPORT_RXERR ");
+                    break;
+                case XTE_TRANSMITTER_ENABLE_OPTION:
+                    DEBUG_PRINTK("TRANSMITTER_ENABLE ");
+                    break;
+                case XTE_RECEIVER_ENABLE_OPTION:
+                    DEBUG_PRINTK("RECEIVER_ENABLE ");
+                    break;
+                case XTE_BROADCAST_OPTION:
+                    DEBUG_PRINTK("BROADCAST ");
+                    break;
+                case XTE_MULTICAST_CAM_OPTION:
+                    DEBUG_PRINTK("MULTICAST_CAM ");
+                    break;
+                case XTE_REPORT_TXSTATUS_OVERRUN_OPTION:
+                    DEBUG_PRINTK("REPORT_TXSTATUS_OVERRUN ");
+                    break;
+                case XTE_ANEG_OPTION:
+                    DEBUG_PRINTK("ANEG ");
+                    break;
+                default:
+                    DEBUG_PRINTK("UNK ");
+                    break;
+            }
+        }
+    }
+    DEBUG_PRINTK("\n");
+}
+#endif
+
+/*
+Changes the mac address if the controller is not running.
+
+static int (*set_mac_address)(struct net_device *dev, void *addr);
+Function that can be implemented if the interface supports the ability
to change its
+hardware address. Many interfaces don't support this ability at all.
Others use the
+default eth_mac_addr implementation (from drivers/net/net_init.c).
eth_mac_addr
+only copies the new address into dev->dev_addr, and it does so only if
the interface
+is not running. Drivers that use eth_mac_addr should set the hardware MAC
+address from dev->dev_addr in their open method.
+
+*/
+static u32
+temac_set_mac_address(struct net_device *ndev, void *address) {
+    struct temac_local *lp = ndev->priv;
+#if defined(LINUX)
+    u8 addr[] = { 0x0, 0x50, 0xc2, 0x44, 0x2f, 0xff };
+    int ii;
+
+    // DEBUG_FUNC;
+    if (address)
+        memcpy(ndev->dev_addr, address, ETH_ALEN);
+
+    if (!is_valid_ether_addr(ndev->dev_addr)) {
+        printk(KERN_ERR "%s: Invalid ethernet MAC address.  Please set
using ifconfig\n", ndev->name);
+        for (ii=0; ii<6; ii++)
+            ndev->dev_addr[ii] = addr[ii];
+    }
+#endif
+    /* set up unicast MAC address filter set its mac address */
+    emac_AF_write(ndev,  XTE_UAW0_OFFSET, ((ndev->dev_addr[3] << 24) |
(ndev->dev_addr[2] << 16) | (ndev->dev_addr[1] << 8) |
(ndev->dev_addr[0])));
+    /* There are reserved bits in EUAW1 so don't affect them Set MAC
bits [47:32] in EUAW1 */
+    emac_AF_write(ndev, XTE_UAW1_OFFSET, (ndev->dev_addr[4] &
0x000000FF) | (ndev->dev_addr[5] << 8) | (emac_AF_read(ndev,
XTE_UAW1_OFFSET) & ~XTE_UAW1_MASK));
+
+    /* enable address filter */
+    emac_AF_write(ndev, XTE_AFM_OFFSET, 0);
+    return Success;
+}
+
+/*
+OPTIONAL
+static void (*set_multicast_list)(struct net_device *dev);
+Method called when the multicast list for the device changes and when the
+flags change. See the section Multicast for further details and a sample
+implementation.
+*/
+static void
+temac_set_multicast_list(struct net_device *ndev) {
+}
+
+static u32 temac_setoptions(struct net_device *ndev, u32 Options) ;
+/*
+Initilize temac board
+ */
+static void
+temac_device_reset(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    u32 ret;
+    u32 Reg;
+    int ii;
+
+    // DEBUG_FUNC;
+    /* Perform a software reset */
+    /* Reset the device */
+    switch (lp->nic_type) {
+        case TEMAC_PLB:
+            iow(ndev, XTE_DSR_OFFSET,
XTE_DSR_RESET_MASK);                 // reset everything
+#if 0
+            iow(ndev, XTE_CR_OFFSET,   XTE_CR_HRST_MASK);             
// Reset HARD TEMAC
+            emac_cfg_write(lp, PHY_NUM, XTE_RXC1_OFFSET,
XTE_RXC1_RXRST_MASK);
+            while (emac_cfg_read(lp, PHY_NUM, XTE_RXC1_OFFSET) & 
XTE_RXC1_RXRST_MASK);     // Wait for the receiver to finish reset
+            emac_cfg_write(lp, PHY_NUM, XTE_TXC_OFFSET,
XTE_TXC_TXRST_MASK);
+            while (emac_cfg_read(lp, PHY_NUM, XTE_TXC_OFFSET) & 
XTE_TXC_TXRST_MASK);   // Wait for the receiver to finish reset
+#endif
+
+            /* Initialize the packet FIFOs */
+            lp->RecvFifo.RegBaseAddress = (u32) (ndev->base_addr +
XTE_PFIFO_RXREG_OFFSET);
+            lp->RecvFifo.DataBaseAddress =  (u32) (ndev->base_addr +
XTE_PFIFO_RXDATA_OFFSET);
+            _iow(lp->RecvFifo.RegBaseAddress +
XPF_V200A_RESET_REG_OFFSET, XPF_V200A_RESET_FIFO_MASK);
+            lp->SendFifo.RegBaseAddress = (u32) (ndev->base_addr +
XTE_PFIFO_TXREG_OFFSET);
+            lp->SendFifo.DataBaseAddress =  (u32) (ndev->base_addr +
XTE_PFIFO_TXDATA_OFFSET);
+            _iow(lp->SendFifo.RegBaseAddress +
XPF_V200A_RESET_REG_OFFSET, XPF_V200A_RESET_FIFO_MASK);
+
+            /* Choose an access algorithm.
+             * Note: 64-bit wide FIFO is the only width supported at
this time
+             */
+            lp->RecvFifo.Width = PFIFO_64BIT_WIDTH_BYTES;
+            lp->SendFifo.Width = PFIFO_64BIT_WIDTH_BYTES;
+
+            /* Initialize the holds */
+            mHoldS_SetEmpty(&lp->SendFifo);
+            mHoldR_SetEmpty(&lp->RecvFifo);
+
+            /* Reset the hardware and set default options */
+
+            /* Stop the device and reset HW */
+            iow(ndev, XTE_DGIE_OFFSET, 0); /* Disable interrupts */
+
+            /* Disable the receiver */
+            emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET)& ~XTE_RXC1_RXEN_MASK);
+
+            /* Stopping the receiver in mid-packet causes a dropped
packet indication
+             * from HW. Clear it.
+             */
+            if (ior(ndev, XTE_IPISR_OFFSET) & XTE_IPXR_RECV_REJECT_MASK)
+                iow(ndev, XTE_IPISR_OFFSET, XTE_IPXR_RECV_REJECT_MASK);
+           
+            /* Reset IPIF */
+            iow(ndev, XTE_DSR_OFFSET, XTE_DSR_RESET_MASK);
+            udelay(XTE_RESET_IPIF_DELAY_US);
+
+            /* Default IPIF interrupt block enable mask */
+            iow(ndev, XTE_DIER_OFFSET, XTE_DXR_CORE_MASK |
XTE_DXR_DPTO_MASK | XTE_DXR_TERR_MASK | XTE_DXR_RECV_FIFO_MASK |
XTE_DXR_SEND_FIFO_MASK);
+#if 0
+            // Interframe gap: The HW has an enable bit to change the
IFG through the
+            // XTE_TPPR_OFFSET register. Rather than make the user set
this bit then
+            // change the register, simplifiy the process by always
setting the
+            // enable bit. All the user needs to do is use
XTemac_SetIfg() thereafter.
+            // The default IFG is 96 bit times. Whatever is in the
register adds to that.
+            // By default leave this register at 0 so we have 96 bit times.
+            // Now set IFG adjust enable
+            iow(ndev, XTE_TPPR_OFFSET, 0);
+            emac_cfg_write(lp, PHY_NUM, XTE_TXC_OFFSET,
emac_cfg_read(lp, PHY_NUM, XTE_TXC_OFFSET) | XTE_TXC_TXIFG_MASK);
+            emac_cfg_write(lp, PHY_NUM, XTE_MC_OFFSET,
XTE_XTE_MDIO_DIV_DFT | XTE_MC_MDIO_MASK); // Set default MDIO divisor
+
+            // Reset the FIFOs  - check this out for TEMAC
+            iow(ndev,
(XTE_PFIFO_TXREG_OFFSET+XPF_V200A_RESET_REG_OFFSET),
XPF_V200A_RESET_FIFO_MASK);
+            iow(ndev,
(XTE_PFIFO_RXREG_OFFSET+XPF_V200A_RESET_REG_OFFSET),
XPF_V200A_RESET_FIFO_MASK);
+#endif
+            break;
+#if defined(CONFIG_PICO_LL_TEMAC)
+        case TEMAC_LL:
+            /* Hold the PHY in reset */
+            mtdcr(lp->dcr_host, XGP_CON_REG_PHY_RESET);
+            mdelay(40);
+            /* reset the peripheral and the emac hold the temac in
reset since this bit is not self-clearing */
+            mtdcr(lp->dcr_host, XGP_CON_REG_TEMAC_RESET);
+            mdelay(40);
+
+            /*
+               reset the peripheral. This is self-clearing. This will
also kick
+               the temac and PHY out of reset. 
+               Note that this may enable the Tx/Rx of the
+               temac if tied-off that way in hardware, but that should
be OK.
+             */
+            mtdcr(lp->dcr_host, XGP_CON_REG_PERIPH_RESET);
+            mdelay(40);
+
+            mtdcr(lp->dcr_host, 0);
+            mdelay(40);
+            break;
+#endif
+    }
+    /* Sync default options with HW but leave receiver and transmitter
disabled.  */
+    temac_setoptions(ndev, lp->options &
~(XTE_TRANSMITTER_ENABLE_OPTION | XTE_RECEIVER_ENABLE_OPTION));
+
+    /* Set default MDIO divisor */
+    /* Set up MII management registers to write to PHY  */
+    emac_cfg_write(ndev, PHY_NUM, XTE_MC_OFFSET, XTE_MC_MDIO_MASK |
XTE_MDIO_DIV_DFT);
+
+    /*
+    Set A-N Advertisement Regs for Full Duplex modes ONLY
+    address 4 = Autonegotiate Advertise Register
+    Disable 1000 Mbps for negotiation if not built for GEth
+    */
+    mdio_write(ndev, PHY_NUM, MII_ADVERTISE,  mdio_read(ndev, PHY_NUM,
MII_ADVERTISE) | ADVERTISE_10FULL | ADVERTISE_100FULL | ADVERTISE_CSMA);
+    mdio_write(ndev, PHY_NUM, MII_CTRL1000, ADVERTISE_1000FULL);
+
+    /*
+    Soft reset the PHY
+    address 0 = Basic Mode Control Register
+    */
+    mdio_write(ndev, PHY_NUM, MII_BMCR, mdio_read(ndev, PHY_NUM,
MII_BMCR) | BMCR_RESET | BMCR_ANENABLE | BMCR_ANRESTART);
+
+    /* Wait for a PHY Link (auto-negotiation to complete)...  */
+    // if (lp->dbg) printk("\nWaiting for ethernet link..");
+    ret = mdio_read(ndev, PHY_NUM, MII_BMSR);
+    ii = 64;
+    while (((ret & BMSR_LSTATUS) != BMSR_LSTATUS) && ii--) {
+        DEBUG_PRINTK(".");
+        mdelay(500);
+        ret = mdio_read(ndev, PHY_NUM, MII_BMSR);
+    }
+    ret = mdio_read(ndev, PHY_NUM, MII_SSR) ;
+
+    Reg = emac_cfg_read(ndev, PHY_NUM, XTE_EMCFG_OFFSET) &
~XTE_EMCFG_LINKSPD_MASK;
+    if (ret & MII_SSR_LINK) {
+        switch (ret & MII_SSR_SPDMASK) {
+            case MII_SSR_SPD1000:                           /*
1000Base-T */
+                lp->LinkSpeed = 1000;
+                emac_cfg_write(ndev, PHY_NUM, XTE_EMCFG_OFFSET, Reg |
(u32)XTE_EMCFG_LINKSPD_1000);
+                break;
+            case MII_SSR_SPD100:                            /* 100Base-T */
+                lp->LinkSpeed = 100;
+                emac_cfg_write(ndev, PHY_NUM, XTE_EMCFG_OFFSET, Reg |
XTE_EMCFG_LINKSPD_100);
+                break;
+            case MII_SSR_SPD10:                             /* 10Base-T */
+                lp->LinkSpeed = 10;
+                // emac_cfg_write(ndev, 0, XTE_EMCFG_OFFSET,
XTE_EMCFG_LINKSPD_10);
+                break;
+        };
+        if ((ret & MII_SSR_FD) == 0x0){
+            /* set up Tx/Rx config reg for half duplex */
+            ret = emac_cfg_read(ndev, 0, XTE_TXC_OFFSET);
+            emac_cfg_write(ndev, 0, XTE_TXC_OFFSET, ret |
XTE_TXC_TXHD_MASK);
+            ret = emac_cfg_read(ndev, 0, XTE_RXC1_OFFSET);
+            emac_cfg_write(ndev, 0, XTE_RXC1_OFFSET, ret |
XTE_RXC1_RXHD_MASK);
+        }
+        // DEBUG_PRINTK("\nEthernet connected at %dMbps Full-Duplex",
lp->LinkSpeed);
+    } else {
+        if ((ret & MII_SSR_LINK) == 0x0)
+            DEBUG_PRINTK("\nEthernet Link Down");
+    }
+    temac_set_mac_address(ndev,0);
+    /* Set address filter table */
+    temac_set_multicast_list(ndev);
+    if (lp->nic_type == TEMAC_PLB) {
+        lp->options &=  ~XTE_FCS_INSERT_OPTION  ;
+            // XTE_JUMBO_OPTION | XTE_TRANSMITTER_ENABLE_OPTION |
XTE_RECEIVER_ENABLE_OPTION | XTE_FLOW_CONTROL_OPTION |
XTE_BROADCAST_OPTION | XTE_FCS_STRIP_OPTION  | XTE_LENTYPE_ERR_OPTION |
XTE_REPORT_RXERR_OPTION | XTE_REPORT_TXSTATUS_OVERRUN_OPTION;
+    }
+    if (lp->poll) lp->options |= XTE_POLLED_OPTION ;
+    if (temac_setoptions(ndev, lp->options))
+         DEBUG_PRINTK("Error setting TEMAC options, code %d\r\n", ret);
+    if (lp->nic_type == TEMAC_PLB) {
+        /* Allow interrupts (if not in polled mode) and exit */
+        // DEBUG_PRINTK("temac->options %0x\n", lp->options);
+        if ((lp->options & XTE_POLLED_OPTION) == 0) {
+            iow(ndev, XTE_DGIE_OFFSET, (u32) XTE_DGIE_ENABLE_MASK);
+            // DEBUG_PRINTK("enable interrupts\n");
+        }
+    }
+#if !defined(LINUX)
+    phyInit(&lp->mii_if, (void *) lp, g_mdio_read, mdio_write);
+
+    result = phySearch(&lp->mii_if);
+
+    if (result == Success) {
+        LinkSpeed   linkSpeed;
+        LinkStatus  linkStatus;
+        LinkDuplex  linkDuplex;
+
+        lp->mii_if.GetLinkStatus(&lp->mii_if, &linkSpeed, &linkStatus,
&linkDuplex);
+        if (linkDuplex == LinkFullDuplex) {
+            emac_cfg_write(lp, PHY_NUM, XTE_RXC1_OFFSET,
(emac_cfg_read(lp, PHY_NUM, XTE_RXC1_OFFSET) & ~XTE_RXC1_RXHD_MASK));
+            emac_cfg_write(lp, PHY_NUM, XTE_TXC_OFFSET, 
(emac_cfg_read(lp, PHY_NUM, XTE_TXC_OFFSET) & ~XTE_TXC_TXHD_MASK));
+            DEBUG_PRINTK("\ntemac_phy_init(FD)");
+        } else {
+            emac_cfg_write(lp, PHY_NUM, XTE_RXC1_OFFSET,
(emac_cfg_read(lp, PHY_NUM, XTE_RXC1_OFFSET) | XTE_RXC1_RXHD_MASK));
+            emac_cfg_write(lp, PHY_NUM, XTE_TXC_OFFSET, 
(emac_cfg_read(lp, PHY_NUM, XTE_TXC_OFFSET) | XTE_TXC_TXHD_MASK));
+            DEBUG_PRINTK("\ntemac_phy_init(HD)");
+        }
+        Reg = emac_cfg_read(lp, PHY_NUM, XTE_EMCFG_OFFSET) &
~XTE_EMCFG_LINKSPD_MASK;
+        switch (linkSpeed) {
+            case Link1000Mbps:
+                emac_cfg_write(lp, PHY_NUM, XTE_EMCFG_OFFSET, Reg |
(u32) XTE_EMCFG_LINKSPD_1000);
+                DEBUG_PRINTK("\ntemac_phy_init(1000)");
+                break;
+            case Link100Mbps:
+                emac_cfg_write(lp, PHY_NUM, XTE_EMCFG_OFFSET, Reg |
XTE_EMCFG_LINKSPD_100);
+                DEBUG_PRINTK("\ntemac_phy_init(100)");
+                break;
+            case Link10Mbps:
+                emac_cfg_write(lp, PHY_NUM, XTE_EMCFG_OFFSET, Reg |
XTE_EMCFG_LINKSPD_10);
+                DEBUG_PRINTK("\ntemac_phy_init(10)");
+                break;
+            case LinkSpeedAuto:
+                emac_cfg_write(lp, PHY_NUM, XTE_EMCFG_OFFSET, Reg |
XTE_EMCFG_LINKSPD_100);
+                DEBUG_PRINTK("\ntemac_phy_init(auto)");
+            default:
+                emac_cfg_write(lp, PHY_NUM, XTE_EMCFG_OFFSET, Reg |
XTE_EMCFG_LINKSPD_100);
+                DEBUG_PRINTK("\ntemac_phy_init(??)
linkSpeed=%d",linkSpeed);
+                break;
+        }
+    }
+#endif
+    /*
+    Print PHY regs so that we can see if they are configured correctly
+    */
+    // if(lp->dbg) temac_dump(ndev);
+// Turns on packet generator and stops (Test Only)
+#if(0)
+    mdio_write(ndev, 0, XGP_PCS_EXTADDR_REG, 0x12);
+    Data = mdio_read(ndev, 0, XGP_PCS_EXTADDR_REG);
+    mdio_write(ndev, 0, XGP_PCS_EXTFUNC_REG, Data | 0x38);
+    while (1);
+#endif
+
+    /* Init Driver variable */
+    ndev->trans_start = 0;
+    spin_lock_init(&lp->lock);
+}
+
+/*****************************************************************************/
+/**
+ * Set options for the driver/device. The driver should be stopped with
+ * XTemac_Stop() before changing options.
+ *
+ * @param InstancePtr is a pointer to the instance to be worked on.
+ * @param Options are the options to set. Multiple options can be set
by OR'ing
+ *        XTE_*_OPTIONS constants together. Options not specified are not
+ *        affected.
+ *
+ * @return
+ * - 0 if the options were set successfully
+ * - XST_DEVICE_IS_STARTED if the device has not yet been stopped
+ * - XST_NO_FEATURE if setting an option requires HW support not present
+ *
+ * @note
+ * See xtemac.h for a description of the available options.
+ *
+
******************************************************************************/
+static u32
+temac_setoptions(struct net_device *ndev, u32 Options) {
+    struct temac_local *lp = ndev->priv;
+
+    /* Turn on jumbo packet support for both Rx and Tx */
+    if (Options & XTE_JUMBO_OPTION) {
+        emac_cfg_write(ndev, PHY_NUM, XTE_TXC_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_TXC_OFFSET) | XTE_TXC_TXJMBO_MASK);
+        emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET) | XTE_RXC1_RXJMBO_MASK);
+    } else {
+        emac_cfg_write(ndev, PHY_NUM, XTE_TXC_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_TXC_OFFSET) & ~XTE_TXC_TXJMBO_MASK);
+        emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET) & ~XTE_RXC1_RXJMBO_MASK);
+    }
+
+    /* Turn on VLAN packet support for both Rx and Tx */
+    if (Options & XTE_VLAN_OPTION) {
+        emac_cfg_write(ndev, PHY_NUM, XTE_TXC_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_TXC_OFFSET) | XTE_TXC_TXVLAN_MASK);
+        emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET) | XTE_RXC1_RXVLAN_MASK);
+    } else {
+        emac_cfg_write(ndev, PHY_NUM, XTE_TXC_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_TXC_OFFSET) & ~XTE_TXC_TXVLAN_MASK);
+        emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET) & ~XTE_RXC1_RXVLAN_MASK);
+    }
+
+    /* Turn on FCS stripping on receive packets */
+    if (Options & XTE_FCS_STRIP_OPTION) {
+        emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET) | XTE_RXC1_RXFCS_MASK);
+    } else {
+        emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET) & ~ XTE_RXC1_RXFCS_MASK);
+    }
+
+    /* Turn on FCS insertion on transmit packets */
+    if (Options & XTE_FCS_INSERT_OPTION) {
+        emac_cfg_write(ndev, PHY_NUM, XTE_TXC_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_TXC_OFFSET) | XTE_TXC_TXFCS_MASK);
+    } else {
+        emac_cfg_write(ndev, PHY_NUM, XTE_TXC_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_TXC_OFFSET) & ~XTE_TXC_TXFCS_MASK);
+    }
+
+    /* Turn on length/type field checking on receive packets */
+    if (Options & XTE_LENTYPE_ERR_OPTION) {
+        emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET) | XTE_RXC1_RXLT_MASK);
+    } else {
+        emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET) & ~XTE_RXC1_RXLT_MASK);
+    }
+
+
+    /* Rest of options twiddle bits of other registers. Handle them one at
+     * a time
+     */
+
+    /* Turn on flow control */
+    if (Options & XTE_FLOW_CONTROL_OPTION) {
+        emac_cfg_write(ndev, PHY_NUM, XTE_FCC_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_FCC_OFFSET) | XTE_FCC_RXFLO_MASK);
+    } else {
+        emac_cfg_write(ndev, PHY_NUM, XTE_FCC_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_FCC_OFFSET) & ~XTE_FCC_RXFLO_MASK);
+    }
+
+    /* Turn on promiscuous frame filtering (all frames are received ) */
+    if (Options & XTE_PROMISC_OPTION) {
+        emac_cfg_write(ndev, PHY_NUM, XTE_AFM_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_AFM_OFFSET) | XTE_AFM_EPPRM_MASK);
+    } else {
+        emac_cfg_write(ndev, PHY_NUM, XTE_AFM_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_AFM_OFFSET) & ~XTE_AFM_EPPRM_MASK);
+    }
+
+    /* Allow broadcast address filtering */
+    if (Options & XTE_BROADCAST_OPTION) {
+        iow(ndev, XTE_CR_OFFSET, ior(ndev, XTE_CR_OFFSET) &
~XTE_CR_BCREJ_MASK);
+    } else {
+        iow(ndev, XTE_CR_OFFSET, ior(ndev, XTE_CR_OFFSET) |
XTE_CR_BCREJ_MASK);
+    }
+
+    /* Allow multicast address filtering */
+    if (Options & XTE_MULTICAST_CAM_OPTION) {
+        iow(ndev, XTE_CR_OFFSET, ior(ndev, XTE_CR_OFFSET) &
~XTE_CR_MCREJ_MASK);
+    } else {
+        iow(ndev, XTE_CR_OFFSET, ior(ndev, XTE_CR_OFFSET) |
XTE_CR_MCREJ_MASK);
+    }
+
+    /* Enable interrupts related to rejection of bad frames */
+    if (Options & XTE_REPORT_RXERR_OPTION) {
+        /* Clear out any previous error conditions that may have existed
+         * prior to enabling the reporting of these types of errors
+         */
+        iow(ndev, XTE_IPISR_OFFSET, ior(ndev, XTE_IPISR_OFFSET) &
XTE_IPXR_RECV_DROPPED_MASK );
+
+        /* Whether these are enabled here are based on the last call to
+         * XTemac_IntrFifoEnable/Disable() and
XTemac_IntrSgDmaEnable/Disable()
+         * for the receive channel.
+         *
+         * If receive interrupts are enabled, then enable these
interrupts. This
+         * way, when XTemac_Start() is called, these interrupt enables
take
+         * effect right away.
+         *
+         * If receive interrupts are disabled, then don't do anything
here. The
+         * XTemac_IntrFifoEnable() and XTemac_IntrSgDmaEnable()
functions when
+         * called will check this option and enable these interrupts if
needed.
+         */
+        // if (lp->Flags & (XTE_FLAGS_RECV_FIFO_INT_ENABLE)) {
+            iow(ndev, XTE_IPIER_OFFSET, ior(ndev, XTE_IPIER_OFFSET) |
XTE_IPXR_RECV_DROPPED_MASK );
+        // }
+    } else {
+        iow(ndev,  XTE_IPIER_OFFSET, ior(ndev,  XTE_IPIER_OFFSET) &
~XTE_IPXR_RECV_DROPPED_MASK);
+    }
+   
+
+    /* Enable interrrupt related to assertion of auto-negotiate HW
interrupt */
+    if (Options & XTE_ANEG_OPTION) {
+        /* Clear out any previous interupt condition that may have existed
+         * prior to enabling the reporting of auto negotiation
+         */
+        iow(ndev, XTE_IPISR_OFFSET, ior(ndev, XTE_IPISR_OFFSET) &
XTE_IPXR_AUTO_NEG_MASK);
+
+        /* Make this interupt source enabled when XTemac_Start() is
called */
+        iow(ndev, XTE_IPIER_OFFSET, ior(ndev, XTE_IPIER_OFFSET) &
XTE_IPXR_AUTO_NEG_MASK);
+    } else {
+        iow(ndev, XTE_IPIER_OFFSET, ior(ndev, XTE_IPIER_OFFSET) &
~XTE_IPXR_AUTO_NEG_MASK);
+    }
+   
+
+    /* Enable transmitter if not already enabled */
+    if (Options & XTE_TRANSMITTER_ENABLE_OPTION) {
+        emac_cfg_write(ndev, PHY_NUM, XTE_TXC_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_TXC_OFFSET) | XTE_TXC_TXEN_MASK); 
+        if (!(lp->options & XTE_POLLED_OPTION)) {
+            iow(ndev, XTE_IPIER_OFFSET, ior(ndev, XTE_IPIER_OFFSET) |
XTE_IPXR_XMIT_DONE_MASK);
+            if (lp->options & XTE_REPORT_TXSTATUS_OVERRUN_OPTION)
+                iow(ndev, XTE_IPIER_OFFSET, ior(ndev, XTE_IPIER_OFFSET)
| XTE_IPXR_XMIT_SFIFO_OVER_MASK);
+        }
+    } else {
+        emac_cfg_write(ndev, PHY_NUM, XTE_TXC_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_TXC_OFFSET) & ~XTE_TXC_TXEN_MASK);
+    }
+
+
+    /* Enable receiver? */
+    if (Options & XTE_RECEIVER_ENABLE_OPTION) {
+        emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET) | XTE_RXC1_RXEN_MASK);
+        if (!(lp->options & XTE_POLLED_OPTION)) {
+            iow(ndev, XTE_IPIER_OFFSET, ior(ndev, XTE_IPIER_OFFSET) |
XTE_IPXR_RECV_DONE_MASK);
+            if (lp->options & XTE_REPORT_TXSTATUS_OVERRUN_OPTION)
+                iow(ndev, XTE_IPIER_OFFSET, ior(ndev, XTE_IPIER_OFFSET)
| XTE_IPXR_RECV_DROPPED_MASK);
+        }
+    } else {
+        emac_cfg_write(ndev, PHY_NUM, XTE_RXC1_OFFSET,
emac_cfg_read(ndev, PHY_NUM, XTE_RXC1_OFFSET) & ~XTE_RXC1_RXEN_MASK);
+    }
+
+    /* The remaining options not handled here are managed elsewhere in the
+ * driver. No register modifications are needed at this time.
Reflecting the
+     * option in lp->Options is good enough for now.
+     */
+
+    /* Set options word to its new value */
+    lp->options |= Options;
+
+    return (0);
+}
+
+#if defined(CONFIG_PICO_LL_TEMAC)
+#define LL_SOF_MASK                     ((1 << 8))
+#define LL_EOF_MASK                     ((1 << 7))
+#define LL_SOP_MASK                     ((1 << 6))
+#define LL_EOP_MASK                     ((1 << 5))
+#define LL_RX_SRC_RDY_MASK              ((1 << 4))
+#define LL_REM_MASK                     (0x0000000F)
+
+#define LL_TX_DATA                      0x00
+#define LL_TX_CTRL                      0x08
+#define LL_TX_RDY                       0x10
+#define LL_RX_DATA                      0x20
+#define LL_RX_CTRL                      0x28
+#define LL_RX_RDY                       0x30
+
+static int
+ll_recvFrame(struct net_device *ndev, struct sk_buff *skb, u8 *bd) {
+    struct temac_local *lp = ndev->priv;
+    u32 cw;
+    u32 dw;
+    u32 src_rdy_counter = 0;
+    u32 sof_counter = 0;
+    enum { S_IDLE=1, S_HEADER, S_PAYLOAD, S_FOOTER } state = S_IDLE;
+    const u32 src_rdy_counter_max = 10;
+    const u32 sof_counter_max = 10;
+    u8 *b ;
+
+    // DEBUG_FUNC;
+    // skb->data SHOULD == skb-->tail;
+    b = skb->tail ;
+    skb->len = 0;
+    while (1) {
+
+        /*  read the control word to see if the source ready bit is
active (low) */
+        while (((cw = ior(ndev,LL_RX_CTRL)) & LL_RX_SRC_RDY_MASK) ==
LL_RX_SRC_RDY_MASK) {
+
+            /* only hang around for some amount of time waiting for
data to be present */
+            if (++src_rdy_counter == src_rdy_counter_max) {
+                skb->len = 0;
+                return SRC_RDY_TIMEOUT_ERROR;
+            }
+        }
+
+        /* reset watchdog counter */
+        src_rdy_counter = 0;
+        /*
+        IDLE STATE
+        */
+        if (state == S_IDLE) {
+
+            /*
+            haven't reached the SOF yet
+            only hang around for so long awaiting an SOF before returning
+            */
+            if ((cw & LL_SOF_MASK)) {
+                if (++sof_counter == sof_counter_max) {
+                    skb->len = 0;
+                    return SOF_TIMEOUT_ERROR;
+                }
+            }
+
+            else {
+
+                /*
+                reset watchdog counter
+                */
+                sof_counter = 0;
+                /*
+                ensure we record the start of a frame
+                */
+                state = S_HEADER;
+            }
+
+            /* ignore the LocalLink Header Words */
+            dw = ior(ndev,LL_RX_DATA);
+        }
+        /*
+        HEADER STATE
+        */
+        else if (state == S_HEADER) {
+            dw = ior(ndev, LL_RX_DATA);
+            if (!(cw & LL_SOP_MASK)) {
+                state = S_PAYLOAD;
+                *((u32 *) b) = dw;
+                b += 4;
+                skb->len += 4;
+                skb->tail += 4;
+            }
+        }
+        /* PAYLOAD STATE */
+        else if (state == S_PAYLOAD) {
+            *((u32 *) b) = ior(ndev,LL_RX_DATA);
+            b += 4;
+            skb->len += 4;
+            skb->tail += 4;
+            if (!(cw & LL_EOP_MASK))
+                state = S_FOOTER;
+        }
+        /* FOOTER STATE */
+        else if (state == S_FOOTER) {
+            *((u32 *) bd) = ior(ndev,LL_RX_DATA);
+            bd += 4;
+            if (!(cw & LL_EOF_MASK)) {
+
+                /* we've got the last data word */
+                cw = ~cw & LL_REM_MASK;
+                /* update the payload count according to the (masked)
rem value */
+                while (cw) {
+                    if (cw & 1)
+                        skb->len++;
+                    cw >>= 1;
+                }
+
+                /* return success */
+                return 0;
+            }
+        }
+    }
+}
+
+static u8
+recvBd[] = {
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00
+};
+
+static void
+ll_temac_interrupt(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    /*  read the control word to see if the source ready bit is active
(low) */
+    while ((ior(ndev, LL_RX_CTRL) & LL_RX_SRC_RDY_MASK) !=
LL_RX_SRC_RDY_MASK)  {
+        u32 ret ;
+        struct sk_buff *skb;
+        skb = dev_alloc_skb(XTE_MAX_FRAME_SIZE);
+        if (!skb) {
+            if (printk_ratelimit())
+                DEBUG_PRINTK("temac: low on memory - packet dropped\n");
+            lp->stats.rx_dropped++;
+            spin_unlock(&lp->lock);
+            return ;
+            // return IRQ_HANDLED;
+        }
+        if ((ret = ll_recvFrame(ndev, skb, recvBd))) {
+            DEBUG_PRINTK("\nwhoops=%x",ret);
+        } else {
+            // if (lp->dbg) dump_skb_data(skb, "Recv");
+            /* Pass to upper layer */
+            skb->dev = ndev;
+            skb->protocol = eth_type_trans(skb, ndev);
+            lp->stats.rx_bytes += skb->len;
+            lp->stats.rx_packets++;
+            netif_rx(skb);
+        }
+    }
+}
+#endif
+
+static void
+FifoRecvHandler(struct net_device *ndev);
+
+static void
+plb_temac_interrupt(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    u32 disr ;
+    u32 ipisr ;
+ 
+    // DEBUG_FUNC;
+    /* Get top level interrupt status. The status is self clearing when
the interrupt source is cleared */
+    disr = ior(ndev, XTE_DISR_OFFSET);
+#if 0
+    DEBUG_PRINTK("\nDISR %08x",disr);
+    if (disr & (XTE_DXR_DPTO_MASK | XTE_DXR_TERR_MASK)) {
+        lp->IpifErrors++;
+        DEBUG_PRINTK("\ntemac_interrupt_fifo() TERR");
+        // ErrorHandler(XST_IPIF_ERROR, disr, 0);
+    }
+    /* Receive packet FIFO is deadlocked */
+    if (disr & XTE_DXR_RECV_FIFO_MASK) {
+        lp->RxPktFifoErrors++;
+        DEBUG_PRINTK("\ntemac_interrupt_fifo() RX DEADLOCK");
+    }
+    /* Transmit packet FIFO is deadlocked */
+    if (disr & XTE_DXR_SEND_FIFO_MASK) {
+        lp->TxPktFifoErrors++;
+        DEBUG_PRINTK("\ntemac_interrupt_fifo() TX DEADLOCK");          
+    }
+#endif
+    /* Handle core interrupts */
+    if (disr & XTE_DXR_CORE_MASK) {
+        /* Calculate which enabled interrupts have been asserted */
+        ipisr = ios(ndev);
+        if (!ipisr) {
+            DEBUG_PRINTK("\ntemac_interrupt_fifo() !ipisr");           
+            return ;
+        }
+
+        // DEBUG_PRINTK("\nIPISR %0x", ior(ndev, XTE_IPISR_OFFSET));
+        // DEBUG_PRINTK("\nIPIER %0x", ior(ndev, XTE_IPIER_OFFSET));
+
+        /* Check for fatal status/length FIFO errors. These errors
can't be * cleared */
+        if (ipisr & XTE_IPXR_FIFO_FATAL_ERROR_MASK) {
+#if 0
+            lp->FifoErrors++;
+            DEBUG_PRINTK("\ntemac_interrupt_fifo() Fatal FIFO ERR");
+
+#if !defined(LINUX)
+            if (ipisr & XTE_IPXR_RECV_LFIFO_OVER_MASK) {    /* requires
reset */
+                EnetDbPrint(&lp->enetDevice, "Rx Length FIFO Overrun");
+                DEBUG_PRINTK("\nRx Length FIFO Overrun");
+            }
+
+            if (ipisr & XTE_IPXR_RECV_LFIFO_UNDER_MASK) {   /* requires
reset */
+                EnetDbPrint(&lp->enetDevice, "Rx Length FIFO Underrun");
+                DEBUG_PRINTK("\nRx Length FIFO Underrun");
+            }
+#endif
+            if (ipisr & XTE_IPXR_XMIT_SFIFO_OVER_MASK) {    /* requires
reset */
+                EnetDbPrint(&lp->enetDevice, "Tx Status FIFO Overrun");
+                DEBUG_PRINTK("\nTx Status FIFO Overrun");
+            }
+
+            if (ipisr & XTE_IPXR_XMIT_SFIFO_UNDER_MASK) {   /* requires
reset */
+                EnetDbPrint(&lp->enetDevice, "Tx Status FIFO Underrun");
+                DEBUG_PRINTK("\nTx Status FIFO Underrun");
+            }
+
+            if (ipisr & XTE_IPXR_XMIT_LFIFO_OVER_MASK) {    /* requires
reset */
+                EnetDbPrint(&lp->enetDevice, "Tx Length FIFO Overrun");
+                DEBUG_PRINTK("\nTx Length FIFO Overrun");
+            }
+
+            if (ipisr & XTE_IPXR_XMIT_LFIFO_UNDER_MASK) {   /* requires
reset */
+                EnetDbPrint(&lp->enetDevice, "Tx Length FIFO Underrun");
+                DEBUG_PRINTK("\nTx Length FIFO Underrun");
+            }
+#endif
+            // ErrorHandler(XST_FIFO_ERROR, CorePending &
XTE_IPXR_FIFO_FATAL_ERROR_MASK, 0);
+            temac_device_reset(ndev);
+        }
+        /* A receive packet has arrived. Call the receive handler.
+         *
+         * Acking this interrupt is not done here. The handler has a
choice:
+         * 1) Call XTemac_FifoRecv() which will ack this interrupt
source, or
+         * 2) Call XTemac_IntrFifoDisable() and defer XTEmac_FifoRecv()
to a
+         * later time. Failure to do one of these actions will leave this
+         * interupt still pending resulting in an exception loop.
+         */
+        if (ipisr & XTE_IPXR_RECV_DONE_MASK) {
+            // DEBUG_PRINTK("\ntemac_interrupt_fifo() FifoRecv()");
+            FifoRecvHandler(ndev);
+        }
+
+        /* A transmit has completed. Pull off all statuses that are
available.
+         * For each status that contains a non-fatal error, the error
handler
+         * is invoked. For fatal errors, the error handler is invoked
once and
+         * assumes the callback will reset the device.
+         *
+         * Unless there was a fatal error, then call the send handler since
+         * resources in the packet FIFO, transmit length FIFO, and transmit
+         * status FIFO have been freed up. This gives the handler a chance
+         * to enqueue new frame(s).
+         */
+        if (ipisr & XTE_IPXR_XMIT_DONE_MASK) {
+           
+            // DEBUG_PRINTK("\nplb_temac_interrupt()
XTE_IPXR_XMIT_DONE_MASK");
+            // DEBUG_PRINTK("\ntemac_interrupt_fifo() XMIT DONE");
+            /* While XMIT_DONE persists */
+            do {
+                u32 Reg;
+                /* Get TSR, try to clear XMIT_DONE */
+                Reg = ior(ndev, XTE_TSR_OFFSET);
+                iow(ndev, XTE_IPISR_OFFSET, XTE_IPXR_XMIT_DONE_MASK);
+
+                /* Does TSR indicate error? */
+                if (Reg & XTE_TSR_ERROR_MASK) {
+                    // lp->TxStatusErrors++;
+                    DEBUG_PRINTK("\ntemac_interrupt_fifo() Send Error");
+                    // ErrorHandler(XST_SEND_ERROR, Reg, 0);
+
+                    /* Fatal errors end processing immediately */
+                    if (Reg & XTE_TSR_PFIFOU_MASK) {
+                        return;
+                    }
+                }
+
+                /* Read IPISR and test XMIT_DONE again */
+                ipisr = ior(ndev, XTE_IPISR_OFFSET);
+            } while (ipisr & XTE_IPXR_XMIT_DONE_MASK);
+            // lp->stats.tx_packets++;
+        }
+
+        /* Check for dropped receive frame. Ack the interupt then call the
+         * error handler
+         */
+        if (ipisr & XTE_IPXR_RECV_DROPPED_MASK) {
+            iow(ndev, XTE_IPISR_OFFSET, ipisr &
XTE_IPXR_RECV_DROPPED_MASK);
+            // lp->RxRejectErrors++;
+            // DEBUG_PRINTK("\nplb_temac_interrupt_fifo() RX DROPPED");
+        }
+    }
+    // DEBUG_FUNC_EXIT;
+}
+/****************************************************************************
+ *                         Device Operational Functions                 *
+ *                                          *
+ * These functions are used to operate the device at runtime            *
+
****************************************************************************/
+
+static irqreturn_t
+temac_interrupt(int irq, void *ndev_id, struct pt_regs *regs) {
+    struct net_device *ndev = ndev_id;
+    struct temac_local *lp = ndev->priv;
+    // DEBUG_FUNC;
+    if (!ndev) {
+        if (lp->dbg) printk ("temac_interrupt() without DEVICE arg\n");
+        return IRQ_HANDLED;
+    }
+#if 0
+    switch (irq) {
+        case -1:
+            if (lp->dbg) printk ("temac_interrupt() NET_POLL\n");
+            break;
+        case -2:
+            // if (lp->dbg) printk ("temac_interrupt()
temac_rx_timeout()\n");
+            break;
+        case 0:
+            /* Call it. */
+            // if (lp->dbg) printk("temac_interrupt() INT\n");
+           //  lp->Interrupts++;                               /* Log
interrupt */
+            break;
+        default:
+            /* Call it. */
+            if (lp->dbg) printk("temac_interrupt() IRQ=%d\n",irq);
+            break;
+    }
+#endif
+
+    /* A real interrupt coming */
+    spin_lock(&lp->lock);
+#if defined(CONFIG_PICO_LL_TEMAC)
+    switch (lp->nic_type) {
+        case TEMAC_PLB:
+            plb_temac_interrupt(ndev);
+            break;
+
+        case TEMAC_LL:
+            ll_temac_interrupt(ndev);
+            break;
+    }
+#else
+    plb_temac_interrupt(ndev);
+#endif
+
+#if 0
+    /* read from PHY status register */
+    ret = mdio_read(ndev, PHY_NUM, MII_FCSCOUNTER);
+    if (lp->phy_status != ret) {
+        lp->phy_status = ret;
+        if (lp->dbg) DEBUG_PRINTK("\nPHY interrupt status register
%08x", ret);
+        if ((ret & 0x00000c00) == (0x00000c00)) {
+            if (lp->dbg) DEBUG_PRINTK("\nautoneg complete , link up");
+        } else if (ret & 0x00000400) {
+            if (lp->dbg) DEBUG_PRINTK("\nlink down");
+        }
+    }
+#endif
+
+#if defined(LINUX)
+    #warning "need to tell linux transmission complete"
+#else
+    EnetNotifyTask(&lp->enetDevice);            // must be called on
transmission or reception complete - should only be called once/interrupt
+#endif
+    spin_unlock(&lp->lock);
+    /* Ack the interrupts we saw and processed */
+    // iow(ndev, XTE_IPISR_OFFSET, ints);
+    // iow(ndev, XTE_DISR_OFFSET, dev_ints);
+    // DEBUG_FUNC_EXIT;
+    return IRQ_HANDLED;
+}
+
+#if defined(CONFIG_PICO_LL_TEMAC)
+static u32
+rem_table[] = {
+    0x0000000F, 0x00000008, 0x0000000C, 0x0000000E,
+};
+
+static int
+ll_sendFrame(struct net_device *ndev, struct sk_buff *skb, u8 *bd) {
+    int i;
+    u32 cw;
+    u32 *bp = (u32 *) skb->data;
+    u32 *bdesc = (u32 *) bd;
+
+    // DEBUG_FUNC;
+    /*
+    Send Buffer Descriptor as LocalLink Header
+    */
+
+    iow(ndev, LL_TX_DATA, bdesc[0]);
+    iow(ndev, LL_TX_CTRL, ~(0xffffffff & (LL_SOF_MASK | LL_REM_MASK)));
+    iow(ndev, LL_TX_DATA, bdesc[1]);
+    iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
+    iow(ndev, LL_TX_DATA, bdesc[2]);
+    iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
+    iow(ndev, LL_TX_DATA, bdesc[3]);
+    iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
+    iow(ndev, LL_TX_DATA, bdesc[4]);
+    iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
+    iow(ndev, LL_TX_DATA, bdesc[5]);
+    iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
+    iow(ndev, LL_TX_DATA, bdesc[6]);
+    iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
+    iow(ndev, LL_TX_DATA, bdesc[7]);
+    iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_REM_MASK));
+
+    /*
+    Send Ethernet Frame in LocalLink payload
+    */
+    for (i = 0; i < skb->len / 4; i++) {
+
+        /* Assume caches are off */
+        iow(ndev, LL_TX_DATA, bp[i]);
+        cw = 0;
+        /* Detect End of Packet */
+        if (i == (skb->len / 4 - 1)) {
+            if (skb->len % 4) {
+                cw |= LL_REM_MASK;
+            } else {
+                cw |= LL_EOP_MASK | LL_REM_MASK;
+            }
+        }
+        /* Detect Start of Packet */
+        if (i == 0)
+            cw |= LL_SOP_MASK | LL_REM_MASK;
+        if (i > 0 && i < (skb->len / 4 - 1))
+            cw |= LL_REM_MASK;
+        iow(ndev, LL_TX_CTRL, ~(0xffffffff & cw));
+    }
+
+    /*  If skb->len is not a multiple of 4, then send last 1, 2, or 3
bytes... */
+    if (skb->len % 4) {
+        iow(ndev, LL_TX_DATA, bp[i]);
+        cw = LL_EOP_MASK | rem_table[skb->len % 4];
+        iow(ndev, LL_TX_CTRL, ~(0xffffffff & cw));
+    }
+    /*
+    Send Dummy LocalLink Footer
+    */
+    iow(ndev, LL_TX_DATA, 0);
+    iow(ndev, LL_TX_CTRL, ~(0xffffffff & LL_EOF_MASK));
+    return 0;
+}
+#endif
+
+u8 bDescriptor[] = {
+    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+};
+static u32 Read_64(struct temac_local *lp, void *BufPtr, u32 ByteCount,
int Eop);
+static u32 Write_64(struct temac_local *lp, void *BufPtr, u32 ByteCount);
+
+static int
+plb_sendFrame(struct net_device *ndev, struct sk_buff *skb, u8 * bd) {
+    struct temac_local *lp = ndev->priv;
+    u32 Reg;
+
+    // DEBUG_FUNC;
+    /* Load the FIFO */
+    /* Transfer the data using the best/fastest method */
+    Write_64(lp, skb->data, skb->len);
+
+    /* Make sure the packet FIFO didn't report an error */
+    Reg = ior(ndev, XTE_DISR_OFFSET);
+    if (Reg & XTE_DXR_SEND_FIFO_MASK) {
+        // DEBUG_PRINTK("\nplb_sendFrame() Error: XTE_DXR_SEND_FIFO_MASK");
+        return -EIO;
+    }
+
+    /* Verify no IPIF errors */
+    if (Reg & (XTE_DXR_DPTO_MASK | XTE_DXR_TERR_MASK)) {
+        /* Only bump stats in polled mode. For interrupt driven mode,
this stat
+         * is bumped in temac_interrupt_fifo()
+         */
+        // DEBUG_PRINTK("\nplb_sendFrame() Error: XTE_DXR_TERR_MASK");
+        return -EIO;
+    }
+
+    /* Initiate transmit */
+    /* See if transmit length FIFO is full. If it is, try to clear the
+     * status. If it the status remains, then return an error
+     */
+    Reg = ior(ndev, XTE_IPISR_OFFSET);
+    if (Reg & XTE_IPXR_XMIT_LFIFO_FULL_MASK) {
+        iow(ndev, XTE_IPISR_OFFSET, XTE_IPXR_XMIT_LFIFO_FULL_MASK);
+
+        Reg = ior(ndev, XTE_IPISR_OFFSET);
+        if (Reg & XTE_IPXR_XMIT_LFIFO_FULL_MASK) {
+            // lp->FifoErrors++;
+            // DEBUG_PRINTK("\nplb_sendFrame() Error:
XTE_IPIXR_XMIT_LFIFO_FULL_MASK");
+            return -EIO;
+        }
+    }
+
+    // DEBUG_PRINTK("\nplb_sendFrame() XTE_TPLR_OFFSET -start xmit");
+    /* Start transmit */
+    iow(ndev, XTE_TPLR_OFFSET, skb->len);
+   
+    // DEBUG_FUNC_EXIT;
+    return 0;
+}
+
+#define XTE_RX_SINK_BUFFER_SIZE 1024
+static void
+FifoRecvHandler(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    struct sk_buff *skb;
+    u32 len;
+    u32 ret = 0;
+    static u32 rx_buffer_sink[XTE_RX_SINK_BUFFER_SIZE / sizeof(u32)];
+
+    // DEBUG_FUNC;
+    spin_lock(&XTE_spinlock);
+    // while ((ret  = XTemac_FifoQueryRecvStatus(ndev)) == XST_NO_DATA
&& NumTries--); // not in interrupt version
+
+    /* If the receive length FIFO is empty, then there's no packet
waiting */
+    if (!((ret = ior(ndev, XTE_IPISR_OFFSET)) & XTE_IPXR_RECV_DONE_MASK)) {
+        // DEBUG_PRINTK("\n%s: XTemac could not read received packet
length, error=%d.\n", ndev->name, ret);
+        lp->stats.rx_errors++;
+        // reset(ndev, __LINE__);
+        spin_unlock(&XTE_spinlock);
+        return;
+    }
+    /* Get the length */
+    len = ior(ndev, XTE_RPLR_OFFSET);
+    // DEBUG_PRINTK("\nlen=%d.\n", len);
+
+    /* The IPXR_RECV_DONE_MASK status bit is tied to the RSR register.
To clear
+     * this condition, read from the RSR (which has no information)
then write
+     * to the IPISR register to ack the status.
+     */
+    ret = ior(ndev, XTE_RSR_OFFSET);
+    iow(ndev, XTE_IPISR_OFFSET, XTE_IPXR_RECV_DONE_MASK);
+
+    if (!(skb = dev_alloc_skb(len + ALIGNMENT_RECV))) {
+        /* Couldn't get memory. */
+        lp->stats.rx_dropped++;
+        // DEBUG_PRINTK("\n%s: XTemac could not allocate receive
buffer.", ndev->name);
+
+        /* consume data in Xilinx TEMAC RX data fifo so it is sync with
RX length fifo */
+        for (; len > XTE_RX_SINK_BUFFER_SIZE; len -=
XTE_RX_SINK_BUFFER_SIZE) {
+            Read_64(lp, rx_buffer_sink, XTE_RX_SINK_BUFFER_SIZE,
XTE_PARTIAL_PACKET);
+        }
+        Read_64(lp, rx_buffer_sink, len, XTE_END_OF_PACKET);
+
+        spin_unlock(&XTE_spinlock);
+        return;
+    }
+    /* Read the packet data */
+    if ((ret = Read_64(lp, skb->data, len, XTE_END_OF_PACKET))) {
+        lp->stats.rx_errors++;
+        dev_kfree_skb_irq(skb);
+        // DEBUG_PRINTK("\n%s: XTemac could not receive buffer,
error=%d.", ndev->name, ret);
+        // reset(lp, __LINE__);
+        spin_unlock(&XTE_spinlock);
+        return;
+    }
+    spin_unlock(&XTE_spinlock);
+
+    skb_put(skb, len);  /* Tell the skb how much data we got. */
+    // if (lp->dbg) dump_skb(lp, skb);
+    // if (lp->dbg) dump_skb_data(lp, skb, "recv");
+    skb->dev = ndev;  /* Fill out required meta-data. */
+    lp->stats.rx_bytes += skb->len;
+
+#if !defined(LINUX)
+/*
+This function must be called when a packet is successfully received.
+user_data should be the value that was passed in as an argument to
EtherRead().
+pkt and len specify the packet that was received.
+ returns true/false. if false the buffer should be reused
+*/
+       
+    packetUsed = EnetPacketReceived(&lp->enetDevice, (Address)
skb->data, skb->len, skb->user_data);
+    if (packetUsed) {
+        dev_kfree_skb_irq(skb);
+    } else {
+        // mark SKB available
+        skb->flags &= ~SKB_ALLOC ;              // not allocated
+        skb->len = 0;
+        skb->tail = skb->data;
+    }
+
+#endif
+    skb->protocol = eth_type_trans(skb, ndev);
+    // DEBUG_PRINTK("\nskb->protocol=%x", skb->protocol);
+    /* skb->ip_summed = CHECKSUM_NONE; */
+    ret = netif_rx(skb);                     /* Send the packet
upstream. */
+    ndev->last_rx = jiffies;
+    lp->stats.rx_packets++;
+    // DEBUG_FUNC_EXIT;
+}
+
+/*******************************************************************************
+* Read into the 64 bit holding buffer from the receive packet FIFO.
+* Each time the holding buffer becomes full, then it is flushed to the
+* provided buffer.
+*
+* @param F is a pointer to the packet FIFO instance to be worked on.
+* @param BufPtr is the destination buffer address on any alignment
+* @param ByteCount is the number of bytes to transfer
+*
+*******************************************************************************/
+static void
+Read64_Unaligned(struct temac_local *lp, void *BufPtr, u32 ByteCount) {
+    struct temac_pktFifo * F = &lp->RecvFifo;
+    u8 *DestPtr = (u8 *) BufPtr;
+    unsigned FifoTransfersLeft;
+    unsigned PartialBytes;
+    unsigned BytesLeft;
+    int i;
+
+    // DEBUG_FUNC;
+    /* Stage 1: The hold may have some residual bytes that must be flushed
+     * to the buffer before anything is read from the FIFO
+     */
+
+    /* Calculate the number of bytes to flush to the buffer from the hold.
+     * If the number of bytes to flush is greater than the "Bytes"
requested,
+     * then adjust accordingly.
+     */
+    i = mHold_GetIndex(F);
+    PartialBytes = PFIFO_64BIT_WIDTH_BYTES - i;
+
+    if (PartialBytes > ByteCount) {
+        PartialBytes = ByteCount;
+    }
+
+    /* Calculate the number of bytes remaining after flushing to the
buffer */
+    BytesLeft = ByteCount - PartialBytes;
+
+    /* Move the hold's index forward */
+    mHold_Advance(F, PartialBytes);
+
+    /* Copy bytes */
+    while (PartialBytes--) {
+        mHold_CopyOut(F, i, *DestPtr);
+        i++;
+        DestPtr++;
+    }
+
+    /* No more data to process */
+    if (!BytesLeft) {
+        return;
+    }
+
+    /* Stage 2: The hold is empty now, if any more bytes are left to
process, then
+     * it will begin with nothing in the hold. Use the hold as a
temporary storage
+     * area to contain the data.
+     *
+     * The hold is filled with FIFO data, then that data is written to
the buffer.
+     * Do this FifoTransfersLeft times
+     */
+
+    /* Calculate the number of times a push will need to occur */
+    FifoTransfersLeft = BytesLeft / PFIFO_64BIT_WIDTH_BYTES;
+
+    /* Calculate the number of partial bytes left after this stage */
+    PartialBytes = BytesLeft - (FifoTransfersLeft *
PFIFO_64BIT_WIDTH_BYTES);
+
+    /* Write to the hold and push data to the FIFO */
+    while (FifoTransfersLeft--) {
+        /* Load the hold with the next data set from the FIFO */
+        mPop64(F);
+
+        /* Write hold to buffer */
+        for (i = 0; i < PFIFO_64BIT_WIDTH_BYTES; i++) {
+            mHold_CopyOut(F, i, *DestPtr);
+            DestPtr++;
+        }
+    }
+
+    /* No more data to process
+     * After processing full FIFO chunks of data, the hold is empty at this
+     * point
+     */
+    if (!PartialBytes) {
+        return;
+    }
+
+    /* Stage 3: All that is left is to fill the hold one more time with
FIFO
+     * data, then write the remaining requested bytes to the buffer
+     */
+
+    /* Get FIFO data */
+    mPop64(F);
+
+    /* Copy bytes from the hold to the buffer */
+    for (i = 0; i < PartialBytes; i++) {
+        mHold_CopyOut(F, i, *DestPtr);
+        DestPtr++;
+    }
+
+    /* Set the hold's index to its final correct value */
+    mHold_SetIndex(F, PartialBytes);
+    // DEBUG_FUNC_EXIT;
+}
+
+/*******************************************************************************
+* Read directly from the 64 bit wide receive FIFO into an aligned
destination
+* buffer. Leftover bytes are written to the holding buffer.
+*
+* @param F is a pointer to the packet FIFO instance to be worked on.
+* @param BufPtr is the destination buffer address on 32-bit alignment
+* @param ByteCount is the number of bytes to transfer
+*
+*******************************************************************************/
+static void
+Read64_Aligned(struct temac_local *lp, u32 * BufPtr, u32 ByteCount) {
+    struct temac_pktFifo * F = &lp->RecvFifo;
+    unsigned FifoTransfersLeft = ByteCount / PFIFO_64BIT_WIDTH_BYTES;
+    unsigned PartialBytes = ByteCount & (PFIFO_64BIT_WIDTH_BYTES - 1);
+
+    // DEBUG_FUNC;
+    /* Direct transfer */
+    while (FifoTransfersLeft--) {
+        mReadFifo64(F, BufPtr);
+        BufPtr += 2;
+    }
+
+    /* Leftover bytes are left in the holding area */
+    if (PartialBytes) {
+        Read64_Unaligned(lp, BufPtr, PartialBytes);
+    }
+    // DEBUG_FUNC_EXIT;
+}
+
+/*******************************************************************************
+* Write to the 64 bit holding buffer. Each time it becomes full, then it is
+* pushed to the transmit FIFO.
+*
+* @param F is a pointer to the packet FIFO instance to be worked on.
+* @param BufPtr is the source buffer address on any alignment
+* @param ByteCount is the number of bytes to transfer
+*
+*******************************************************************************/
+static void
+Write64_Unaligned(struct temac_local *lp, void *BufPtr, u32 ByteCount) {
+    struct temac_pktFifo * F = &lp->SendFifo;
+    u8 *SrcPtr = (u8 *) BufPtr;
+    unsigned FifoTransfersLeft;
+    unsigned PartialBytes;
+    unsigned BytesLeft;
+    int i;
+
+    // DEBUG_FUNC;
+    /* Stage 1: The hold may be partially full. Write enough bytes to it to
+     * cause a push to the FIFO
+     */
+
+    /* Calculate the number of bytes needed to trigger a push, if not
enough
+     * bytes have been specified to cause a push, then adjust accordingly
+     */
+    i = mHold_GetIndex(F);
+    PartialBytes = PFIFO_64BIT_WIDTH_BYTES - i;
+    if (PartialBytes > ByteCount) {
+        PartialBytes = ByteCount;
+    }
+
+    /* Calculate the number of bytes remaining after the first push */
+    BytesLeft = ByteCount - PartialBytes;
+
+    /* Write to the hold and advance its index */
+    mHold_Advance(F, PartialBytes);
+
+    while (PartialBytes--) {
+        mHold_CopyIn(F, i, *SrcPtr);
+        SrcPtr++;
+        i++;
+    }
+
+    /* Push to fifo if needed */
+    if (mHoldS_IsFull(F)) {
+        mPush64(F);
+        mHoldS_SetEmpty(F);
+    }
+
+    /* No more data to process */
+    if (!BytesLeft) {
+        return;
+    }
+
+    /* Stage 2: The hold is empty now, if any more bytes are left to
process, then
+     * it will begin with nothing in the hold. Use the hold as a
temporary storage
+     * area to contain the data.
+     *
+     * The hold is filled then pushed out to the FIFOs a number of
times based on
+     * how many bytes are left to process.
+     */
+
+    /* Calculate the number of times a push will need to occur */
+    FifoTransfersLeft = BytesLeft / PFIFO_64BIT_WIDTH_BYTES;
+
+    /* Calculate the number of partial bytes left after this stage */
+    PartialBytes = BytesLeft - (FifoTransfersLeft *
PFIFO_64BIT_WIDTH_BYTES);
+
+    /* Write to the hold and push data to the FIFO */
+    while (FifoTransfersLeft--) {
+        for (i = 0; i < PFIFO_64BIT_WIDTH_BYTES; i++) {
+            mHold_CopyIn(F, i, *SrcPtr);
+            SrcPtr++;
+        }
+        mPush64(F);
+    }
+
+    /* No more data to process
+     * HoldIndex was left at 0 by stage 1, at this point, that is
+     * still the correct value.
+     */
+    if (!PartialBytes) {
+        return;
+    }
+
+    /* Stage 3: All that is left is to fill the hold with the remaining
data
+     * to be processed. There will be no push to the FIFO because there
is not
+     * enough data left to cause one.
+     */
+
+    /* Write to the hold and push data to the FIFO */
+    for (i = 0; i < PartialBytes; i++) {
+        mHold_CopyIn(F, i, *SrcPtr);
+        SrcPtr++;
+    }
+
+    /* Set the hold's index to its final correct value */
+    mHold_SetIndex(F, PartialBytes);
+    // DEBUG_FUNC_EXIT;
+}
+
+/*******************************************************************************
+* Write directly to the 64 bit wide transmit FIFO from an aligned source
+* buffer. Leftover bytes are written to the holding buffer.
+*
+* @param F is a pointer to the packet FIFO instance to be worked on.
+* @param BufPtr is the source buffer address on 32-bit alignment
+* @param ByteCount is the number of bytes to transfer
+*
+*******************************************************************************/
+static void
+Write64_Aligned(struct temac_local *lp, u32 * BufPtr, u32 ByteCount) {
+    struct temac_pktFifo * F = &lp->SendFifo;
+    unsigned FifoTransfersLeft = ByteCount / PFIFO_64BIT_WIDTH_BYTES;
+    unsigned PartialBytes = ByteCount & (PFIFO_64BIT_WIDTH_BYTES - 1);
+
+    // DEBUG_FUNC;
+    /* Direct transfer */
+    while (FifoTransfersLeft--) {
+        _iow(F->DataBaseAddress + 0, (BufPtr)[0]);                        
+        _iow(F->DataBaseAddress + 4, (BufPtr)[1]);                   
+        BufPtr += 2;
+    }
+
+    /* Leftover bytes are left in the holding area */
+    if (PartialBytes) {
+        Write64_Unaligned(lp, BufPtr, PartialBytes);
+    }
+    // DEBUG_FUNC_EXIT;
+}
+
+/*******************************************************************************
+* Algorithm to read from a 64 bit wide receive packet FIFO with through
the
+* holding buffer.
+*
+* @param F is a pointer to a Temac FIFO instance to worked on.
+* @param BufPtr is the destination address on any alignment
+* @param ByteCount is the number of bytes to transfer
+*
+* @return 0 if transfer completed or XST_NO_DATA if the amount of
+*         data being buffered by the driver plus the amount of data in the
+*         packet FIFO is not enough to satisfy the number of bytes
requested
+*         by the ByteCount parameter.
+*******************************************************************************/
+static u32
+Read_64(struct temac_local *lp, void *BufPtr, u32 ByteCount, int Eop) {
+    struct temac_pktFifo * F = &lp->RecvFifo;
+    unsigned BufAlignment = (unsigned) BufPtr & 3;
+    unsigned PartialBytes;
+    unsigned MaxBytes;
+    int HoldAlignment = mHold_GetIndex(F);
+
+    // DEBUG_FUNC;
+    /* Determine how many bytes can be read from the packet FIFO */
+    MaxBytes = _ior(lp->RecvFifo.RegBaseAddress +
XPF_V200A_COUNT_STATUS_REG_OFFSET) & XPF_V200A_COUNT_MASK;
+    MaxBytes *= PFIFO_64BIT_WIDTH_BYTES;
+
+    /* Case 1: Buffer aligned on 4-byte boundary and Hold is empty
+     *  
+     *   1. Read all bytes using the fastest transfer method
+     */
+    if ((BufAlignment == 0) && (mHoldR_IsEmpty(F))) {
+        /* Enough data in fifo? */
+        if (ByteCount > MaxBytes) {
+            return (XST_NO_DATA);
+        }
+
+        Read64_Aligned(lp, (u32 *) BufPtr, ByteCount);
+    }
+
+    /* Case 2: Buffer and Hold are byte aligned with each other
+     *
+     *   1. Transfer enough bytes from the Hold to the buffer to trigger a
+     *      read from the FIFO.
+     *
+     *   2. The state of the buffer and Hold are now as described by
Case 1 so
+     *      read remaining bytes using the fastest transfer method
+     */
+    else if (BufAlignment == (HoldAlignment % PFIFO_64BIT_WIDTH_BYTES)) {
+        PartialBytes = PFIFO_64BIT_WIDTH_BYTES - HoldAlignment;
+
+        if (ByteCount < PartialBytes) {
+            PartialBytes = ByteCount;
+        }
+
+        /* Enough data in fifo? Must account for the number of bytes
the driver
+         * is currently buffering
+         */
+        if (ByteCount > (MaxBytes + PartialBytes)) {
+            return (XST_NO_DATA);
+        }
+
+        Read64_Unaligned(lp, BufPtr, PartialBytes);
+        Read64_Aligned(lp, (u32 *) ((u32) BufPtr + PartialBytes),
ByteCount - PartialBytes);
+    }
+
+    /* Case 3: No alignment to take advantage of
+     *
+     *    1. Read FIFOs using the slower method.
+     */
+    else {
+        /* Enough data in fifo? Must account for the number of bytes
the driver
+         * is currently buffering
+         */
+        PartialBytes = PFIFO_64BIT_WIDTH_BYTES - HoldAlignment;
+        if (ByteCount > (MaxBytes + PartialBytes)) {
+            return (XST_NO_DATA);
+        }
+
+        Read64_Unaligned(lp, BufPtr, ByteCount);
+    }
+
+    /* If this marks the end of packet, then dump any remaining data in the
+     * hold. The dumped data in this context is meaningless.
+     */
+    if (Eop == XTE_END_OF_PACKET) {
+        mHoldR_SetEmpty(F);
+    }
+    // DEBUG_FUNC_EXIT;
+    return (0);
+}
+/*******************************************************************************
+* Algorithm to write to a 64 bit wide transmit packet FIFO through the
holding
+* buffer.
+*
+* @param FPtr is a pointer to a Temac FIFO instance to worked on.
+* @param BufPtr is the source buffer address on any alignment
+* @param ByteCount is the number of bytes to transfer
+* @param Eop specifies whether the last byte written is the last byte
of the
+*        packet.
+*
+* @return 0
+*******************************************************************************/
+static u32
+Write_64(struct temac_local *lp, void *BufPtr, u32 ByteCount) {
+    struct temac_pktFifo * F = &lp->SendFifo;
+    unsigned BufAlignment = (unsigned) BufPtr & 3;
+    unsigned PartialBytes;
+    int HoldAlignment = mHold_GetIndex(F);
+
+    // DEBUG_FUNC;
+    /* Case 1: Buffer aligned on 4-byte boundary and Hold is empty
+     *  
+     *   1. Write all bytes using the fastest transfer method
+     */
+    if ((BufAlignment == 0) && (mHoldS_IsEmpty(F))) {
+        Write64_Aligned(lp, (u32 *) BufPtr, ByteCount);
+    }
+
+    /* Case 2: Buffer and Hold are byte aligned with each other
+     *
+     *   1. Transfer enough bytes from the buffer to the Hold to
trigger a flush
+     *      to the FIFO.
+     *
+     *   2. The state of the buffer and Hold are as described by Case 1 so
+     *      write remaining bytes using the fastest transfer method
+     */
+    else if (BufAlignment == (HoldAlignment % PFIFO_64BIT_WIDTH_BYTES)) {
+        PartialBytes = PFIFO_64BIT_WIDTH_BYTES - HoldAlignment;
+
+        if (ByteCount < PartialBytes) {
+            PartialBytes = ByteCount;
+        }
+
+        Write64_Unaligned(lp, BufPtr, PartialBytes);
+        Write64_Aligned(lp, (u32 *) ((u32) BufPtr + PartialBytes),
ByteCount - PartialBytes);
+    }
+
+    /* Case 3: No alignment to take advantage of
+     *
+     *    1. Read FIFOs using the slower method.
+     */
+    else {
+        Write64_Unaligned(lp, BufPtr, ByteCount);
+    }
+
+    /* If TxBytes is non-zero then the caller wants to transmit data
from the
+     * FIFO
+     */
+
+    /* Push the hold to the FIFO if data is present */
+    if (!mHoldS_IsEmpty(F)) {
+        mPush64(F);
+        mHoldS_SetEmpty(F);
+    }
+
+    // DEBUG_FUNC_EXIT;
+    return (0);
+}
+#if 0
+
+static u32
+Read64(struct temac_local *lp, void *BufPtr, u32 ByteCount, int Eop) {
+    u8      *rbuf = BufPtr ;   
+    u32     ret ;
+    u32     len ;
+    int     ii ;
+
+    // DEBUG_FUNC;
+    while (ior(ndev, XTE_IPISR_OFFSET) & XTE_IPXR_RECV_DONE_MASK) {
+        /* Get the length */
+        len = ior(ndev, XTE_RPLR_OFFSET);
+        DEBUG_PRINTK("\nRead64()=%0x",len);
+
+        /* The IPXR_RECV_DONE_MASK status bit is tied to the RSR
register. To clear
+        * this condition, read from the RSR (which has no information)
then write
+        * to the IPISR register to ack the status.
+        */
+        ret = ior(ndev, XTE_RSR_OFFSET);
+        iow(ndev, XTE_IPISR_OFFSET, XTE_IPXR_RECV_DONE_MASK);
+        ret = Read_64(lp, BufPtr, ByteCount, Eop) ;
+        if (lp->dbg) {
+            for(ii=0;ii<len;ii++){
+                if ((ii%16)==0) DEBUG_PRINTK("\n%08x ", ii);   
+                DEBUG_PRINTK("%02x ", rbuf[ii]);   
+            }
+            DEBUG_PRINTK("\n");
+        }
+    }
+    DEBUG_FUNC_EXIT;
+    return ret;
+}
+
+static void
+sendTest(struct temac_local *lp) {
+    unsigned char sbuf[]  = { 0xff,0xff,0xff,0xff,0xff,0xff,
+                              0x08,0x00,0x3e,0x26,0x15,0x59,
+                              0x00, 0x42,
+                              0xfe, 0xff,
+                             
0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f,
+                             
0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1a,0x1b,0x1c,0x1d,0x1e,0x1f,
+                             
0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2a,0x2b,0x2c,0x2d,0x2e,0x2f,
+                             
0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3a,0x3b,0x3c,0x3d,0x3e,0x3f
+                            };
+    unsigned char rbuf[512]  ;
+    int ii;
+    u32 Status;
+    int len = sizeof(sbuf);
+
+    DEBUG_FUNC;
+#if 0
+    iow(ndev,XTE_DSR_OFFSET,    XTE_DSR_RESET_MASK);            //
Reset PLB TEMAC
+    iow(ndev, XTE_CR_OFFSET,    XTE_CR_HRST_MASK);          // Reset
HARD TEMAC
+    emac_cfg_write(lp, PHY_NUM, XTE_RXC1_OFFSET,    XTE_RXC1_RXRST_MASK);
+    emac_cfg_write(lp, PHY_NUM, XTE_TXC_OFFSET,     XTE_TXC_TXRST_MASK);
+    emac_cfg_write(lp, PHY_NUM, XTE_MC_OFFSET,  XTE_XTE_MDIO_DIV_DFT |
XTE_MC_MDIO_MASK);   // Set default MDIO divisor
+
+    emac_cfg_write(lp, PHY_NUM, XTE_RXC1_OFFSET,   
XTE_RXC1_RXEN_MASK);            // Enable Rx, VLAN, Jumbo, Strip FCS
+    emac_cfg_write(lp, PHY_NUM, XTE_TXC_OFFSET,    
XTE_TXC_TXEN_MASK+XTE_TXC_TXIFG_MASK);      // Enable Tx, VLAN, Jumbo,
No client supplied FCS
+    emac_cfg_write(lp, PHY_NUM, XTE_EMCFG_OFFSET,  
XTE_EMCFG_LINKSPD_10+XTE_EMCFG_HOSTEN_MASK);    // Set 1G Host Interface
+    emac_cfg_write(lp, PHY_NUM, XTE_UAW0_OFFSET, ((buf[6]<<8) | (buf[7])));
+    emac_cfg_write(lp, PHY_NUM, XTE_UAW1_OFFSET, ((buf[8]<<24) |
(buf[9]<<16) | (buf[10]<<8) | (buf[11])));
+#endif
+    iow(ndev, XTE_DGIE_OFFSET,0);                   // disable interrupts
+    emac_cfg_write(lp, PHY_NUM, XTE_AFM_OFFSET, (u32)
XTE_AFM_EPPRM_MASK);          // temporarily enable Promiscuous  
+    // for(ii=0;ii<len;ii++)
+    //  sbuf[ii] = 0xff;   
+
+    Write_64(lp, sbuf, len);
+    Status = Read64(lp, rbuf, len, XTE_END_OF_PACKET);
+    DEBUG_PRINTK("\ndone\n");      
+    iow(ndev, XTE_DGIE_OFFSET, 0xffffffff);
+}
+#endif
+/************************** Variable Definitions
*****************************/
+
+/*
+ * array of masks associated with the bit position, improves performance
+ * in the ISR and acknowledge functions, this table is shared between all
+ * instances of the driver, this table is not statically initialized
because
+ * the size of the table is based upon the maximum used interrupt id
+ */
+
+
+/*
+Hardware start transmission.
+Send a packet to media from the upper layer.
+Method that initiates the transmission of a packet.
+The full packet (protocol headers and all) is contained in a socket
buffer (sk_buff) structure.
+Socket buffers are introduced later in this chapter.
+skb->data points to the packet
+skb->len is its length
+ */
+static int
+temac_hard_start_xmit(struct sk_buff *skb, struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    u32 ret = 0;
+    unsigned long  flags = 0;
+
+    // DEBUG_FUNC;
+    netif_stop_queue(ndev);
+    spin_lock_irqsave(&XTE_spinlock, flags);
+    ndev->trans_start = jiffies;
+
+#if defined(CONFIG_PICO_LL_TEMAC)
+    switch (lp->nic_type) {
+        case TEMAC_PLB:
+            ret = plb_sendFrame(ndev,skb, bDescriptor);
+            break;
+        case TEMAC_LL:
+            ret = ll_sendFrame(ndev,skb, bDescriptor);
+            break;
+    }
+#else
+    // DEBUG_PRINTK("\n>plb_sendFrame()");
+    ret = plb_sendFrame(ndev,skb, bDescriptor);
+#endif
+    // DEBUG_PRINTK("\n<plb_sendFrame()");
+    if (ret) {
+        // reset(dev, __LINE__);
+        lp->stats.tx_errors++;
+        spin_unlock_irqrestore(&XTE_spinlock, flags);
+        // DEBUG_PRINTK("\n%d=temac_hard_start_transmit() error", ret);
+        // DEBUG_FUNC_EX(ret);
+        return  -EIO;
+    }
+    lp->stats.tx_bytes += skb->len;
+    lp->stats.tx_packets++;
+
+    dev_kfree_skb(skb); /* free this SKB */      // this crashes driver
eventually
+
+    // dump_skb_data(lp,skb, "Send");
+    netif_wake_queue(ndev);
+    spin_unlock_irqrestore(&XTE_spinlock, flags);
+    // DEBUG_PRINTK("\n%d=temac_hard_start_transmit() exit",ret);
+    // DEBUG_FUNC_EX(0);
+    return 0;
+}
+
+static void
+temac_shutdown(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    
+    // DEBUG_FUNC;
+    /* RESET device */
+    mdio_write(ndev, 0, MII_BMCR, BMCR_RESET);  /* PHY RESET */
+    /* Power-Down PHY */
+    /* Disable all interrupt */
+    /* Disable RX */
+}
+
+/*
+Stop the interface.
+Stops the interface. The interface is stopped when it is brought down.
+This function should reverse operations performed at open time.
+*/
+static int
+temac_stop(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    unsigned long flags;
+
+    // DEBUG_FUNC;
+    spin_lock_irqsave(&XTE_spinlock, flags);
+
+    del_timer(&lp->rx_timer);
+    del_timer(&lp->mii_timer);
+
+    /* Stop Send queue */
+    netif_stop_queue(ndev);
+    /* Now we could stop the ndevice */
+    netif_carrier_off(ndev);
+    /*
+     * If not in polled mode, free the interrupt.  Currently, there
+     * isn't any code to set polled mode, so this check is probably
+     * superfluous.
+     */
+    free_irq(ndev->irq, ndev);
+    temac_shutdown(ndev);
+    return 0;
+}
+
+/* temac_release_board release a board, and any mapped resources */
+static void
+temac_release_board(struct platform_device *pdev, struct net_device
*ndev) {
+    struct temac_local *lp = ndev->priv;
+
+    // DEBUG_FUNC;
+    /* unmap our resources */
+    iounmap((void *) ndev->base_addr);
+
+    /* release the resources */
+
+    if (lp->phy_addr_req != NULL) {
+        release_resource(lp->phy_addr_req);
+        kfree(lp->phy_addr_req);
+    }
+
+    if (lp->nic_addr_res != NULL) {
+        release_resource(lp->nic_addr_res);
+        kfree(lp->nic_addr_req);
+    }
+}
+
+/*
+Whenever an application needs to get statistics for the interface, this
method is
+called. This happens, for example, when ifconfig or netstat -i is run.
A sample
+implementation for snull is introduced in the section Statistical
Information.
+ */
+static struct net_device_stats
+*temac_get_stats(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+
+    // DEBUG_FUNC;
+    return &lp->stats;
+}
+
+/*
+ * This function is used to handle ports that do not have an interrupt.
+ */
+static void
+temac_rx_timeout(unsigned long data) {
+    struct net_device *ndev = (struct net_device *) data;
+    struct temac_local *lp = ndev->priv;
+
+    // DEBUG_FUNC;
+    disable_irq(ndev->irq);
+    temac_interrupt(-2, ndev, NULL);
+    enable_irq(ndev->irq);
+
+    mod_timer(&lp->rx_timer, TEMAC_RX_TIMEOUT);
+}
+/*
+ A periodic timer routine
+ Dynamic media sense, allocated Rx buffer...
+ */
+static void
+temac_mii_timeout(unsigned long data) {
+    struct net_device *ndev = (struct net_device *) data;
+    struct temac_local *lp = ndev->priv;
+
+    // DEBUG_FUNC;
+    mii_check_media(&lp->mii_if, netif_msg_link(lp), 0);
+    /* Set timer again */
+    mod_timer(&lp->mii_timer, TEMAC_MII_TIMEOUT);
+}
+
+static int
+temac_open(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    unsigned long flags;
+
+    // DEBUG_FUNC;
+
+    /*
+     * Just to be safe, stop TX queue and the ndevice first. If the
ndevice is
+     * already stopped, an error will be returned. In this case, we don't
+     * really care,.
+     */
+    netif_stop_queue(ndev);
+    spin_lock_irqsave(&XTE_spinlock, flags);
+
+    if (ndev->mtu > XTE_MTU)
+        ndev->mtu = XTE_MTU;
+
+    /*
+    Enable interrupts if not in polled mode
+    */
+    if (ndev->irq < 0) {
+        lp->poll = 1;
+    } else if (request_irq(ndev->irq, &temac_interrupt, 0, ndev->name,
ndev)) {
+            printk(KERN_ERR "%s: XTemac could not allocate interrupt
%d. reverting to polled IO\n", ndev->name, ndev->irq);
+            lp->poll = 1;
+    }
+
+    /* Initialize TEMAC board */
+    temac_device_reset(ndev);
+
+    /* set and active a timer process */
+    lp->mii_timer.data     = (unsigned long) ndev;
+    lp->mii_timer.function = &temac_mii_timeout;
+    init_timer(&lp->mii_timer);
+    mod_timer(&lp->mii_timer, TEMAC_MII_TIMEOUT);
+
+    lp->rx_timer.data     = (unsigned long) ndev;
+    lp->rx_timer.function = &temac_rx_timeout;
+    init_timer(&lp->rx_timer);
+    mod_timer(&lp->rx_timer, TEMAC_RX_TIMEOUT);
+
+    mii_check_media(&lp->mii_if, netif_msg_link(lp), 1);
+    /* We're ready to go. */
+    netif_start_queue(ndev);
+    spin_unlock_irqrestore(&XTE_spinlock, flags);
+
+    return 0;
+}
+static int
+temac_do_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd) {
+    struct temac_local *lp = ndev->priv;
+    int rc;
+    unsigned long flags;
+
+    /* SIOC[GS]MIIxxx ioctls */
+    if (lp->mii) {
+        spin_lock_irqsave(&lp->lock, flags);
+        rc = generic_mii_ioctl(&lp->mii_if, if_mii(rq), cmd, NULL);
+        spin_unlock_irqrestore(&lp->lock, flags);
+    } else {
+        rc = -EOPNOTSUPP;
+    }
+
+    return rc;
+}
+
+/*
+Our watchdog timed out. Called by the networking layer
+Method called by the networking code when a packet transmission fails
to complete within a reasonable period, on the assumption that an
interrupt has been
+missed or the interface has locked up. It should handle the problem and
resume packet transmission.
+*/
+static void
+temac_tx_timeout(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    unsigned long flags;
+
+    // DEBUG_FUNC;
+    spin_lock_irqsave(&lp->lock, flags);
+
+    netif_stop_queue(ndev);
+    printk(KERN_ERR "%s: XTemac exceeded transmit timeout of %lu ms. 
Resetting emac.\n", ndev->name, TEMAC_TX_TIMEOUT * 1000UL / HZ);
+    lp->stats.tx_errors++;
+    temac_device_reset(ndev);
+    ndev->trans_start = jiffies;
+    netif_wake_queue(ndev);                         /* We can accept TX
packets again */
+
+    spin_unlock_irqrestore(&lp->lock, flags);
+}
+
+/*
+OPTIONAL
+void (*poll_controller)(struct net_device *dev);
+Function that asks the driver to check for events on the interface in
situations
+where interrupts are disabled. It is used for specific in-kernel
networking tasks,
+such as remote consoles and kernel debugging over the network.
+
+*/
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void
+temac_poll_controller(struct net_device *ndev) {
+    // DEBUG_FUNC;
+    disable_irq(ndev->irq);
+    temac_interrupt(-1, ndev, NULL);
+    enable_irq(ndev->irq);
+}
+#endif
+/*
+OPTIONAL
+
+int (*change_mtu)(struct net_device *dev, int new_mtu);
+Function that takes action if there is a change in the maximum transfer
unit (MTU)
+for the interface. If the driver needs to do anything particular when
the MTU is
+changed by the user, it should declare its own function; otherwise, the
default does
+the right thing. snull has a template for the function if you are
interested.
+*/
+int temac_change_mtu(struct net_device *dev, int new_mtu) {
+#if 0
+    int head_size = XTE_HDR_SIZE;
+    struct temac_local *lp = (struct temac_local *)dev->priv;
+    int max_frame = new_mtu + head_size + XTE_TRL_SIZE;
+    int min_frame = 1 + head_size + XTE_TRL_SIZE;
+
+    // DEBUG_FUNC;
+    if ((max_frame < min_frame) || (max_frame > lp->max_frame_size))
+        return -EINVAL;
+
+    dev->mtu = new_mtu; /* change mtu in net_device structure */
+#endif
+    return 0;
+}
+
+static int
+temac_ethtool_get_settings(struct net_device *ndev, struct ethtool_cmd
*cmd) {
+    struct temac_local *lp = ndev->priv;
+    unsigned long flags;
+    int r = -EOPNOTSUPP;
+
+    if (lp->mii) {
+        spin_lock_irqsave(&lp->lock, flags);
+        mii_ethtool_gset(&lp->mii_if, cmd);
+        spin_unlock_irqrestore(&lp->lock, flags);
+        r = 0;
+    }
+    return r;
+}
+
+static int
+temac_ethtool_set_settings(struct net_device *ndev, struct ethtool_cmd
*cmd) {
+    struct temac_local *lp = ndev->priv;
+    unsigned long flags;
+    int r = -EOPNOTSUPP;
+
+    if (lp->mii) {
+        spin_lock_irqsave(&lp->lock, flags);
+        r = mii_ethtool_sset(&lp->mii_if, cmd);
+        spin_unlock_irqrestore(&lp->lock, flags);
+    }
+    return r;
+}
+
+static void
+temac_ethtool_get_drvinfo(struct net_device *ndev, struct
ethtool_drvinfo *info) {
+
+    memset(info, 0, sizeof(struct ethtool_drvinfo));
+    strncpy(info->driver, DRV_NAME, sizeof(info->driver) - 1);
+    strncpy(info->version, DRV_VERSION, sizeof(info->version) - 1);
+    /* Also tell how much memory is neinfoinfo for dumping register
values */
+    info->regdump_len = 0;
+}
+
+static u32
+temac_ethtool_get_link(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    unsigned long flags;
+    int r;
+
+    spin_lock_irqsave(&lp->lock, flags);
+    r = mii_link_ok(&lp->mii_if);
+    spin_unlock_irqrestore(&lp->lock, flags);
+
+    return r;
+}
+
+static u32
+temac_ethtool_get_msglevel(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    return lp->msg_enable;
+}
+
+static void
+temac_ethtool_set_msglevel(struct net_device *ndev, u32 value) {
+    struct temac_local *lp = ndev->priv;
+    lp->msg_enable = value;
+}
+
+static int
+temac_ethtool_nway_reset(struct net_device *ndev) {
+    struct temac_local *lp = ndev->priv;
+    unsigned long flags;
+    int r = -EOPNOTSUPP;
+
+    if (lp->mii) {
+        spin_lock_irqsave(&lp->lock, flags);
+        r = mii_nway_restart(&lp->mii_if);
+        spin_unlock_irqrestore(&lp->lock, flags);
+    }
+    return r;
+}
+
+static struct ethtool_ops temac_ethtool_ops = {
+    .get_settings = temac_ethtool_get_settings,
+    .set_settings = temac_ethtool_set_settings,
+    .get_drvinfo = temac_ethtool_get_drvinfo,
+    .get_msglevel = temac_ethtool_get_msglevel,
+    .set_msglevel = temac_ethtool_set_msglevel,
+    .nway_reset = temac_ethtool_nway_reset,
+    .get_link = temac_ethtool_get_link,
+    .get_tx_csum = ethtool_op_get_tx_csum,
+    .get_sg = ethtool_op_get_sg,
+    .get_tso = ethtool_op_get_tso,
+    .get_perm_addr = ethtool_op_get_perm_addr,
+};
+/*
+Search TEMAC board, allocate space and register it
+ */
+static int
+temac_device_probe(struct platform_device *pdev) {
+    struct net_device *ndev;
+    struct xtemac_platform_data *pdata = pdev->dev.platform_data;
+    struct temac_local *lp; /* Point a board information structure */
+    int i;
+    u32 ret = 0;
+    int nic_size;
+    // DEBUG_FUNC;
+    printk(version);
+    /* Init network device */
+    ndev = alloc_etherdev(sizeof(struct temac_local));
+    if (!ndev) {
+        printk("%s: could not allocate device.\n", DRV_NAME);
+        return -ENOMEM;
+    }
+
+    SET_MODULE_OWNER(ndev);
+    SET_NETDEV_DEV(ndev, &pdev->dev);
+    /* setup board info structure */
+    lp = (struct temac_local *) ndev->priv;
+    // lp->einfo = einfo;
+    /* Clear memory */
+    memset(lp, 0, sizeof(*lp));
+    spin_lock_init(&lp->lock);
+/*  get device configuration from platform Device */
+    ndev->irq = platform_get_irq(pdev, 0);
+    lp->nic_type = TEMAC_PLB;
+    lp->dbg = 1;
+    lp->options = XTE_DEFAULT_OPTIONS;
+
+    if (pdev->num_resources < 2) {
+        printk("%s: insufficient resources %d.\n", DRV_NAME,
pdev->num_resources);
+        ret = -ENODEV;
+        goto out;
+    }
+    lp->nic_type            = pdata->nic_type;
+    if ((pdata->rx_pkt_fifo_depth >= 131072) &&
(pdata->tx_pkt_fifo_depth >= 131072)) {
+        lp->MaxFrameSz = sizeof(EthFrame);
+    } else {
+        lp->MaxFrameSz = 1536;  /* Sized to fit within cache lines */
+    }
+//    lp->MacFifoDepth        = pdata->mac_fifo_depth;
+    lp->dcr_host            = pdata->dcr_host;
+#if defined(CONFIG_PICO_LL_TEMAC)
+    switch (lp->nic_type) {
+        case TEMAC_PLB:
+            // ndev->base_addr      = XPAR_PLB_TEMAC_0_BASEADDR;
+            lp->phy_mode            = 0;     
+            break;
+        case TEMAC_LL:
+            // ndev->base_addr      = XPAR_PLB_LL_IF_0_BASEADDR ;
+            lp->phy_addr            =
XGP_HIF_BASEADDR;                                     /* set default
address of PHY */
+            lp->phy_mode            = PHY_DCR;     
+            break;
+    }
+#else
+    lp->phy_mode            = 0;     
+#endif
+    lp->nic_addr_res = platform_get_resource(pdev, IORESOURCE_MEM,
0);      /* address of NIC */
+    if (lp->nic_addr_res == NULL) {
+        printk(KERN_ERR DRV_NAME ":insufficient resources\n");
+        ret = -ENOENT;
+        goto out;
+    }
+    nic_size = res_size(lp->nic_addr_res);
+    lp->nic_addr_req = request_mem_region(lp->nic_addr_res->start,
nic_size, pdev->name);
+    if (lp->nic_addr_req == NULL) {
+        printk(KERN_ERR DRV_NAME ":cannot claim address reg area\n");
+        ret = -EIO;
+        goto out;
+    }
+
+    ndev->base_addr = (u32) ioremap(lp->nic_addr_res->start, nic_size);
+    if (ndev->base_addr == 0) {
+        printk(KERN_ERR "failed to ioremap address reg\n");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    /* fill in parameters for net-dev structure */
+
+/*      done getting platform_device parameters start initializine
device */
+    /* Set all handlers to stub values, let user configure this data */
+    lp->mii = 1;            /*  really important can't read/write
anyting until set */
+    lp->regshift = 3;      
+
+    lp->LinkSpeed = 1000;                                   // Tell
driver that the PHY is 10/100/1000 capable
+    lp->mii_if.full_duplex = 1;
+    lp->mii_if.phy_id_mask = 0x1f;
+    lp->mii_if.reg_num_mask = 0x1f;
+    lp->mii = 1;
+    lp->msg_enable = debug;
+    lp->mii_if.dev = ndev;
+    lp->mii_if.mdio_read = mdio_read;
+    lp->mii_if.mdio_write = mdio_write;
+    /* Set the mii phy_id so that we can query the link state */
+    //  if (lp->mii)
+    //      lp->mii_if.phy_id = ((lp->a.read_bcr (ioaddr, 33)) >> 5) &
0x1f;
+    // memcpy(ndev->dev_addr, "\0\1\2345", ETH_ALEN);
+
+    temac_set_mac_address(ndev,pdata->mac_addr);
+    /* from this point we assume that we have found a TEMAC */
+    /* driver system function */
+    ether_setup(ndev);
+    /* The TEMAC-specific entries in the device structure. */
+    ndev->open = &temac_open;
+    ndev->stop = &temac_stop;
+    ndev->get_stats = &temac_get_stats;
+    ndev->do_ioctl = &temac_do_ioctl;
+    ndev->tx_timeout = &temac_tx_timeout;
+    ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
+    ndev->hard_start_xmit = &temac_hard_start_xmit;
+    ndev->set_multicast_list = &temac_set_multicast_list;
+    ndev->ethtool_ops = &temac_ethtool_ops;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+    ndev->poll_controller = temac_poll_controller;
+#endif
+    ndev->flags &= ~IFF_MULTICAST;                  /* clear multicast */
+    ndev->change_mtu = temac_change_mtu;
+    platform_set_drvdata(pdev, ndev);
+    ret = register_netdev(ndev);
+    if (ret == 0) {
+        printk("%s: %s_temac at %lx,%x IRQ %d MAC: ", ndev->name,
(lp->nic_type == TEMAC_PLB) ? "plb" : "ll", ndev->base_addr,
lp->phy_addr, ndev->irq);
+        for (i = 0; i < 5; i++)
+            printk("%02x:", ndev->dev_addr[i]);
+        printk("%02x", ndev->dev_addr[5]);
+#ifdef CONFIG_NET_POLL_CONTROLLER
+        printk(" NET_POLL");
+#endif
+        /* print h/w id  */
+        if (lp->nic_type == TEMAC_PLB) {
+            ret = ior(ndev,XTE_DSR_OFFSET);
+            printk(KERN_INFO " id %d.%d%c, block id %d, type %d\n",
((ret >> 28) & 0xf), ((ret >> 21) & 0x7f), (((ret >> 16) & 0x1f) + 'a'),
((ret >> 16) & 0xff), ((ret >> 0) & 0xff));
+        }
+    }
+    return 0;
+//  release:
+    out:
+    printk("%s: not found (%d).\n", DRV_NAME, ret);
+    temac_release_board(pdev, ndev);
+    kfree(ndev);
+    return ret;
+}
+
+
+static int
+temac_device_suspend(struct platform_device *pdev, pm_message_t state) {
+    struct net_device *ndev = platform_get_drvdata(pdev);
+    //  DEBUG_FUNC;
+    if (ndev) {
+        if (netif_running(ndev)) {
+            netif_device_detach(ndev);
+            temac_shutdown(ndev);
+        }
+    }
+    return 0;
+}
+
+static int
+temac_device_resume(struct platform_device *pdev) {
+    struct net_device *ndev = platform_get_drvdata(pdev);
+    // DEBUG_FUNC;
+    if (ndev) {
+
+        if (netif_running(ndev)) {
+            temac_device_reset(ndev);
+            netif_device_attach(ndev);
+        }
+    }
+    return 0;
+}
+
+static int __devexit
+temac_device_remove(struct platform_device *pdev) {
+    struct net_device *ndev = platform_get_drvdata(pdev);
+    // DEBUG_FUNC;
+    platform_set_drvdata(pdev, NULL);
+    unregister_netdev(ndev);
+    temac_release_board(pdev, ndev);
+    free_netdev(ndev);  /* free device structure */
+    // DEBUG_FUNC_EXIT;
+    return 0;
+}
+
+static struct platform_driver temac_driver = {
+    .probe = temac_device_probe,
+    .remove = temac_device_remove,
+    .suspend = temac_device_suspend,
+    .resume = temac_device_resume,.driver = {
+    .name = DRV_NAME,
+    },
+};
+
+static int __init
+temac_init_module(void) {
+    int err;
+    if ((err = platform_driver_register(&temac_driver))) {  /* search
board and register */
+        printk(KERN_ERR "Driver registration failed\n");
+        return err;
+    }
+#if 0
+    temac_device = platform_device_alloc(DRV_NAME, 0);
+    if (!temac_device) {
+        goto out_unregister;
+    }
+
+    if (platform_device_add(temac_device)) {
+        platform_device_put(temac_device);
+        temac_device = NULL;
+    }
+    return 0;
+out_unregister:
+    platform_driver_unregister(&temac_driver);
+    return -ENOMEM;
+#else
+    return 0;
+
+#endif
+}
+
+static void __exit
+temac_cleanup_module(void) {
+    platform_driver_unregister(&temac_driver);
+    if (temac_device) {
+        platform_device_unregister(temac_device);
+        temac_device = NULL;
+    }
+}
+
+module_init(temac_init_module);
+module_exit(temac_cleanup_module);
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "temac debug level (1-4)");
+//module_param(speed, int, 0);
+//static unsigned int speed = CONFIG_XILINX_OLD_TEMAC_SPEED;
+//MODULE_PARM_DESC(speed, "temac speed 10,100,1000");
+MODULE_AUTHOR("David H. Lynch Jr. <dhlii@dlasys.net>");
+MODULE_LICENSE("GPL");
+
+/*
+
+OPTIONAL functions
+
+Function (called before hard_start_xmit) that builds the hardware
header from
+the source and destination hardware addresses that were previously
retrieved; its
+job is to organize the information passed to it as arguments into an
appropriate,
+device-specific hardware header. eth_header is the default function for
Ethernet-
+like interfaces, and ether_setup assigns this field accordingly.
+int (*hard_header) (struct sk_buff *skb, struct net_device *dev,
unsigned short type, void *daddr, void *saddr, unsigned len);
+
+Function used to rebuild the hardware header after ARP resolution
completes
+but before a packet is transmitted. The default function used by
Ethernet devices
+uses the ARP support code to fill the packet with missing information.
+int (*rebuild_header)(struct sk_buff *skb);
+
+Changes the interface configuration. This method is the entry point for
configuring the driver. The I/O address for the device and its interrupt
number can be
+changed at runtime using set_config. This capability can be used by the
system
+administrator if the interface cannot be probed for. Drivers for modern
hardware normally do not need to implement this method.
+int (*set_config)(struct net_device *dev, struct ifmap *map);
+
+Method provided by NAPI-compliant drivers to operate the interface in a
polled
+mode, with interrupts disabled. NAPI (and the weight field) are covered
in the
+section Receive Interrupt Mitigation.
+int (*poll)(struct net_device *dev; int *quota) L
+
+header_cache is called to fill in the hh_cache structure with the
results of an ARP
+query. Almost all Ethernet-like drivers can use the default
eth_header_cache
+implementation.
+int (*header_cache) (struct neighbour *neigh, struct hh_cache *hh);
+
+Method that updates the destination address in the hh_cache structure in
+response to a change. Ethernet devices use eth_header_cache_update.
+int (*header_cache_update) (struct hh_cache *hh, struct net_device
*dev, unsigned char *haddr);
+
+The hard_header_parse method extracts the source address from the
packet contained in skb,
+copying it into the buffer at haddr. The return value from the function
is the length of that address. Ethernet devices normally use
eth_header_parse.
+int (*hard_header_parse) (struct sk_buff *skb, unsigned char *haddr);
+
+Utility Fields
+
+The remaining struct net_device data fields are used by the interface
to hold useful
+status information. Some of the fields are used by ifconfig and netstat
to provide the
+user with information about the current configuration. Therefore, an
interface
+should assign values to these fields:
+
+unsigned long trans_start;
+unsigned long last_rx;
+
+Fields that hold a jiffies value. The driver is responsible for
updating these values when transmission begins and when a packet is
received, respectively. The
+trans_start value is used by the networking subsystem to detect
transmitter
+lockups. last_rx is currently unused, but the driver should maintain
this field
+anyway to be prepared for future use.
+
+int watchdog_timeo;
+
+The minimum time (in jiffies) that should pass before the networking layer
+decides that a transmission timeout has occurred and calls the drivers
tx_timeout function.
+
+static void *priv;
+The equivalent of filp->private_data. In modern drivers, this field is
set by
+alloc_netdev and should not be accessed directly; use netdev_priv instead.
+
+struct dev_mc_list *mc_list;
+
+int mc_count;
+Fields that handle multicast transmission. mc_count is the count of
items in mc_list.
+See the section Multicast for further details.
+
+spinlock_t xmit_lock;
+
+int xmit_lock_owner;
+The xmit_lock is used to avoid multiple simultaneous calls to the drivers
+hard_start_xmit function. xmit_lock_owner is the number of the CPU that
has
+obtained xmit_lock. The driver should make no changes to these fields.
+*/
+#if 0
+static u32
+emac_AFM_read(struct net_device *ndev, int reg_num, int MultAddrReg,
u32 *mult_addr_msw, u32 *mult_addr_lsw)  {
+    struct temac_local *lp = ndev->priv;
+    int EmacNum = 0;
+    mtdcr((lp->phy_addr) + XGP_HIF_DATA_REG_LSW_OFFSET, MultAddrReg );
+    mtdcr((lp->phy_addr) + XGP_HIF_CNTL_REG_OFFSET,
XGP_HIF_CNTL_REG_OFFSET_DCR_WRITE | (EmacNum << 10) | reg_num);
+    while ( !(mfdcr(lp->phy_addr + XGP_HIF_RDY_STATUS_OFFSET )  &
(XGP_HIF_RDYSTAT_AF0_READ_MASK << (8*EmacNum))));
+    *mult_addr_lsw = mfdcr((lp->phy_addr) + XGP_HIF_DATA_REG_LSW_OFFSET);
+    *mult_addr_msw = mfdcr((lp->phy_addr) + XGP_HIF_DATA_REG_MSW_OFFSET);
+}
+
+static void
+emac_AFM_write(struct net_device *ndev, int reg_num, u32 mult_addr_msw,
u32 mult_addr_lsw)  {
+    emac_AF_write(ndev, XTE_MAW0_OFFSET, (((mult_addr_msw << 24) &
0xff000000) | ((mult_addr_msw << 8) & 0x00ff0000) | ((mult_addr_msw >>
8) &  0x0000ff00) | ((mult_addr_msw >> 24) & 0x000000ff)));
+    emac_AF_write(ndev, XTE_MAW1_OFFSET, (reg_num << 16) |
((mult_addr_lsw<<8) & 0xff00) | ((mult_addr_lsw >>8 ) & 0x00ff)) ;
+
+}
+#endif
+/*
+ vim: tabstop=4 shiftwidth=4 softtabstop=4 nolist expandtab
+*/
diff --git a/include/linux/xilinx_devices.h b/include/linux/xilinx_devices.h
new file mode 100755
index 0000000..747453a
--- /dev/null
+++ b/include/linux/xilinx_devices.h
@@ -0,0 +1,104 @@
+/*
+ * include/linux/xilinx_devices.h
+ *
+ * Definitions for any platform device related flags or structures for
+ * Xilinx EDK IPs
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2005 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is
licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef _XILINX_DEVICE_H_
+#define _XILINX_DEVICE_H_
+
+#include <linux/types.h>
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,15)
+#include <linux/device.h>
+#else
+#include <linux/platform_device.h>
+#endif
+
+/*- 10/100 Mb Ethernet Controller IP (XEMAC) -*/
+
+struct xemac_platform_data {
+    u32 device_flags;
+    u32 dma_mode;
+    u32 has_mii;
+    u32 has_err_cnt;
+    u32 has_cam;
+    u32 has_jumbo;
+    u32 tx_dre;
+    u32 rx_dre;
+    u32 tx_hw_csum;
+    u32 rx_hw_csum;
+    u8 mac_addr[6];
+};
+
+/* Flags related to XEMAC device features */
+#define XEMAC_HAS_ERR_COUNT    0x00000001
+#define XEMAC_HAS_MII        0x00000002
+#define XEMAC_HAS_CAM        0x00000004
+#define XEMAC_HAS_JUMBO        0x00000008
+
+/* Possible DMA modes supported by XEMAC */
+#define XEMAC_DMA_NONE        1
+#define XEMAC_DMA_SIMPLE    2    /* simple 2 channel DMA */
+#define XEMAC_DMA_SGDMA        3    /* scatter gather DMA */
+
+/*- 10/100/1000 Mb Ethernet Controller IP (XTEMAC) -*/
+
+struct xtemac_platform_data {
+#ifdef XPAR_TEMAC_0_INCLUDE_RX_CSUM
+    u8 tx_dre;
+    u8 rx_dre;
+    u8 tx_csum;
+    u8 rx_csum;
+    u8 phy_type;
+#endif
+    u8 dma_mode;
+    u32 rx_pkt_fifo_depth;
+    u32 tx_pkt_fifo_depth;
+    u16 mac_fifo_depth;
+    u8 dcr_host;
+    u8 dre;
+
+    u8 mac_addr[6];
+
+#if defined(CONFIG_XILINX_OLD_TEMAC)
+    u16 speed;
+#endif
+#if defined(CONFIG_PICO_TEMAC) || defined(CONFIG_XILINX_OLD_TEMAC)
+    u8     phy_type;
+    u8     nic_type;
+#endif
+};
+
+/* Possible DMA modes supported by XTEMAC */
+#define XTEMAC_DMA_NONE        1
+#define XTEMAC_DMA_SIMPLE    2    /* simple 2 channel DMA */
+#define XTEMAC_DMA_SGDMA    3    /* scatter gather DMA */
+
+/*- SPI -*/
+
+struct xspi_platform_data {
+    u32 device_flags;
+    u8 num_slave_bits;
+};
+
+/* Flags related to XSPI device features */
+#define XSPI_HAS_FIFOS        0x00000001
+#define XSPI_SLAVE_ONLY        0x00000002
+
+/*- GPIO -*/
+
+/* Flags related to XGPIO device features */
+#define XGPIO_IS_DUAL        0x00000001
+
+#endif /* _XILINX_DEVICE_H_ */
+#endif /* __KERNEL__ */






-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
