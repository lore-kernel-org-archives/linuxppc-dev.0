Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3EB34B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 22:29:40 +1100 (EST)
Date: Thu, 23 Feb 2012 11:29:15 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Grant Likely <grant.likely@secretlab.ca>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: in_be32() etc
Message-ID: <20120223112915.GT22562@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

What's this stuff doing in generic drivers?

See drivers/gpio/gpio-xilinx.c:
static int xgpio_get(struct gpio_chip *gc, unsigned int gpio)
{
        struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);

        return (in_be32(mm_gc->regs + XGPIO_DATA_OFFSET) >> gpio) & 1;
}

include/linux/of_gpio.h:
struct of_mm_gpio_chip {
        struct gpio_chip gc;
        void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
        void __iomem *regs;
};

Why am I being asked to add in_be32() etc to ARMs io.h ?  Why do we need
yet another set of IO accessors?  Is there something wrong with
ioread*()/ioread*be() etc?

My guess is this stems from a lack of proper review:
/*
 * Low level MMIO accessors
 *
 * This provides the non-bus specific accessors to MMIO. Those are PowerPC
 * specific and thus shouldn't be used in generic code. The accessors
 * provided here are:
 *
 *      in_8, in_le16, in_be16, in_le32, in_be32, in_le64, in_be64
 *      out_8, out_le16, out_be16, out_le32, out_be32, out_le64, out_be64
 *      _insb, _insw_ns, _insl_ns, _outsb, _outsw_ns, _outsl_ns

$ grep '\(out\|in\)_be32' drivers/ -rl
drivers/media/video/fsl-viu.c
drivers/macintosh/via-pmu.c
drivers/gpio/gpio-mpc8xxx.c
drivers/gpio/gpio-mpc5200.c
drivers/gpio/gpio-xilinx.c
drivers/edac/mpc85xx_edac.c
drivers/tty/serial/mpc52xx_uart.c
drivers/tty/serial/ucc_uart.c
drivers/tty/serial/cpm_uart/cpm_uart_core.c
drivers/scsi/mvme16x_scsi.c
drivers/char/xilinx_hwicap/buffer_icap.c
drivers/char/xilinx_hwicap/fifo_icap.c
drivers/rtc/rtc-mpc5121.c
drivers/pcmcia/m8xx_pcmcia.c
drivers/ata/pata_scc.c
drivers/ata/pata_mpc52xx.c
drivers/ide/scc_pata.c
drivers/net/ethernet/xilinx/xilinx_emaclite.c
drivers/net/ethernet/xilinx/ll_temac_main.c
drivers/net/ethernet/freescale/ucc_geth.c
drivers/net/ethernet/freescale/fsl_pq_mdio.c
drivers/net/ethernet/freescale/fec_mpc52xx.c
drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
drivers/net/ethernet/freescale/fs_enet/mii-fec.c
drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
drivers/net/ethernet/freescale/fs_enet/mac-fec.c
drivers/net/ethernet/freescale/fs_enet/mac-scc.c
drivers/net/ethernet/freescale/fs_enet/fs_enet.h
drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
drivers/net/ethernet/freescale/gianfar.h
drivers/net/ethernet/freescale/ucc_geth_ethtool.c
drivers/net/ethernet/tundra/tsi108_eth.h
drivers/net/ethernet/ibm/emac/tah.c
drivers/net/ethernet/ibm/emac/zmii.c
drivers/net/ethernet/ibm/emac/rgmii.c
drivers/net/ethernet/ibm/emac/core.c
drivers/net/ethernet/ibm/emac/debug.c
drivers/net/ethernet/toshiba/spider_net.c
drivers/net/can/flexcan.c
drivers/net/can/mscan/mpc5xxx_can.c
drivers/video/xilinxfb.c
drivers/video/fsl-diu-fb.c
drivers/video/platinumfb.c
drivers/spi/spi-fsl-spi.c
drivers/spi/spi-fsl-lib.h
drivers/spi/spi-mpc52xx-psc.c
drivers/spi/spi-mpc512x-psc.c
drivers/watchdog/mpc8xxx_wdt.c
drivers/watchdog/pika_wdt.c
drivers/mmc/host/sdhci-pltfm.h
drivers/mmc/host/sdhci-of-esdhc.c
drivers/crypto/caam/regs.h
drivers/crypto/talitos.c
drivers/usb/gadget/fsl_qe_udc.c
drivers/usb/gadget/fsl_udc_core.c
drivers/usb/host/fhci-hcd.c
drivers/usb/host/ehci-fsl.c
drivers/usb/host/ehci-ppc-of.c
drivers/usb/host/fhci-tds.c
drivers/usb/host/fsl-mph-dr-of.c
drivers/usb/otg/fsl_otg.c
drivers/dma/fsldma.c
drivers/dma/fsldma.h
drivers/dma/mpc512x_dma.c
drivers/i2c/busses/i2c-mpc.c
drivers/i2c/busses/i2c-cpm.c
drivers/input/serio/xilinx_ps2.c
drivers/isdn/hisax/avm_pci.c
drivers/mtd/nand/ppchameleonevb.c
drivers/mtd/nand/fsl_elbc_nand.c
drivers/mtd/nand/mpc5121_nfc.c
drivers/mtd/nand/ndfc.c
drivers/mtd/nand/socrates_nand.c
