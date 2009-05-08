Return-Path: <jcrigby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 15ED6DDE07
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 13:30:16 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so925977rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 07 May 2009 20:30:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241640919-4650-7-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-7-git-send-email-wd@denx.de>
Date: Thu, 7 May 2009 21:30:15 -0600
Message-ID: <4b73d43f0905072030n1b014dafmea840387ab0f3a6d@mail.gmail.com>
Subject: Re: [PATCH 06/12] mpc5121: Added NAND Flash Controller driver.
From: John Rigby <jcrigby@gmail.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: multipart/alternative; boundary=000e0cd1748839687704695e3f99
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd1748839687704695e3f99
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Did you choose to not support hardware ECC so you could use the spare area?
The original driver only supported hardware ECC but unfortuneatly the
hardware ECC includes the spare area so the spare area cannot be written
separately.

On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:

> From: Piotr Ziecik <kosmo@semihalf.com>
>
> This patch adds NAND Flash Controller driver for MPC5121
> revision 2. All device features, except hardware ECC and
> power management, are supported.
>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: <linux-mtd@lists.infradead.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
>  arch/powerpc/include/asm/mpc5121_nfc.h       |  100 +++
>  arch/powerpc/platforms/512x/mpc512x_shared.c |    1 +
>  drivers/mtd/nand/Kconfig                     |    7 +
>  drivers/mtd/nand/Makefile                    |    1 +
>  drivers/mtd/nand/mpc5121_nfc.c               |  855
> ++++++++++++++++++++++++++
>  5 files changed, 964 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/mpc5121_nfc.h
>  create mode 100644 drivers/mtd/nand/mpc5121_nfc.c
>
> diff --git a/arch/powerpc/include/asm/mpc5121_nfc.h
> b/arch/powerpc/include/asm/mpc5121_nfc.h
> new file mode 100644
> index 0000000..b96a5b9
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpc5121_nfc.h
> @@ -0,0 +1,100 @@
> +/*
> + * Copyright 2004-2008 Freescale Semiconductor, Inc.
> + * Copyright 2009 Semihalf.
> + *
> + * Approved as OSADL project by a majority of OSADL members and funded
> + * by OSADL membership fees in 2009;  for details see www.osadl.org.
> + *
> + * Based on original driver from Freescale Semiconductor
> + * written by John Rigby <jrigby@freescale.com> on basis
> + * of drivers/mtd/nand/mxc_nand.c. Reworked and extended by
> + * Piotr Ziecik <kosmo@semihalf.com>.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +
> +#ifndef MPC5121_NFC_H
> +#define MPC5121_NFC_H
> +
> +/* Addresses for NFC MAIN RAM BUFFER areas */
> +#define NFC_MAIN_AREA(n)       ((n) *  0x200)
> +
> +/* Addresses for NFC SPARE BUFFER areas */
> +#define NFC_SPARE_BUFFERS      8
> +#define NFC_SPARE_LEN          0x40
> +#define NFC_SPARE_AREA(n)      (0x1000 + ((n) * NFC_SPARE_LEN))
> +
> +/* MPC5121 NFC registers */
> +#define NFC_BUF_ADDR           0x1E04
> +#define NFC_FLASH_ADDR         0x1E06
> +#define NFC_FLASH_CMD          0x1E08
> +#define NFC_CONFIG             0x1E0A
> +#define NFC_ECC_STATUS1                0x1E0C
> +#define NFC_ECC_STATUS2                0x1E0E
> +#define NFC_SPAS               0x1E10
> +#define NFC_WRPROT             0x1E12
> +#define NFC_NF_WRPRST          0x1E18
> +#define NFC_CONFIG1            0x1E1A
> +#define NFC_CONFIG2            0x1E1C
> +#define NFC_UNLOCKSTART_BLK0   0x1E20
> +#define NFC_UNLOCKEND_BLK0     0x1E22
> +#define NFC_UNLOCKSTART_BLK1   0x1E24
> +#define NFC_UNLOCKEND_BLK1     0x1E26
> +#define NFC_UNLOCKSTART_BLK2   0x1E28
> +#define NFC_UNLOCKEND_BLK2     0x1E2A
> +#define NFC_UNLOCKSTART_BLK3   0x1E2C
> +#define NFC_UNLOCKEND_BLK3     0x1E2E
> +
> +/* Bit Definitions: NFC_BUF_ADDR */
> +#define NFC_RBA_MASK           (7 << 0)
> +#define NFC_ACTIVE_CS_SHIFT    5
> +#define NFC_ACTIVE_CS_MASK     (3 << NFC_ACTIVE_CS_SHIFT)
> +
> +/* Bit Definitions: NFC_CONFIG */
> +#define NFC_BLS_UNLOCKED       (1 << 1)
> +
> +/* Bit Definitions: NFC_CONFIG1 */
> +#define NFC_ECC_4BIT           (1 << 0)
> +#define NFC_FULL_PAGE_DMA      (1 << 1)
> +#define NFC_SPARE_ONLY         (1 << 2)
> +#define NFC_ECC_ENABLE         (1 << 3)
> +#define NFC_INT_MASK           (1 << 4)
> +#define NFC_BIG_ENDIAN         (1 << 5)
> +#define NFC_RESET              (1 << 6)
> +#define NFC_CE                 (1 << 7)
> +#define NFC_ONE_CYCLE          (1 << 8)
> +#define NFC_PPB_32             (0 << 9)
> +#define NFC_PPB_64             (1 << 9)
> +#define NFC_PPB_128            (2 << 9)
> +#define NFC_PPB_256            (3 << 9)
> +#define NFC_PPB_MASK           (3 << 9)
> +#define NFC_FULL_PAGE_INT      (1 << 11)
> +
> +/* Bit Definitions: NFC_CONFIG2 */
> +#define NFC_COMMAND            (1 << 0)
> +#define NFC_ADDRESS            (1 << 1)
> +#define NFC_INPUT              (1 << 2)
> +#define NFC_OUTPUT             (1 << 3)
> +#define NFC_ID                 (1 << 4)
> +#define NFC_STATUS             (1 << 5)
> +#define NFC_CMD_FAIL           (1 << 15)
> +#define NFC_INT                        (1 << 15)
> +
> +/* Bit Definitions: NFC_WRPROT */
> +#define NFC_WPC_LOCK_TIGHT     (1 << 0)
> +#define NFC_WPC_LOCK           (1 << 1)
> +#define NFC_WPC_UNLOCK         (1 << 2)
> +
> +#endif /* MPC5121_NFC_H */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c
> b/arch/powerpc/platforms/512x/mpc512x_shared.c
> index d8cd579..7135d89 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -71,6 +71,7 @@ void __init mpc512x_init_IRQ(void)
>  static struct of_device_id __initdata of_bus_ids[] = {
>        { .compatible = "fsl,mpc5121-immr", },
>        { .compatible = "fsl,mpc5121-localbus", },
> +       { .compatible = "fsl,mpc5121-nfc", },
>        {},
>  };
>
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 890936d..fb0d1c4 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -413,6 +413,13 @@ config MTD_NAND_FSL_UPM
>          Enables support for NAND Flash chips wired onto Freescale PowerPC
>          processor localbus with User-Programmable Machine support.
>
> +config MTD_NAND_MPC5121_NFC
> +       tristate "MPC5121 built-in NAND Flash Controller support"
> +       depends on PPC_MPC512x
> +       help
> +         This enables the driver for the NAND flash controller on the
> +         MPC5121 SoC.
> +
>  config MTD_NAND_MXC
>        tristate "MXC NAND support"
>        depends on ARCH_MX2 || ARCH_MX3
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index d33860a..563e812 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -39,5 +39,6 @@ obj-$(CONFIG_MTD_NAND_SH_FLCTL)               +=
> sh_flctl.o
>  obj-$(CONFIG_MTD_NAND_MXC)             += mxc_nand.o
>  obj-$(CONFIG_MTD_NAND_SOCRATES)                += socrates_nand.o
>  obj-$(CONFIG_MTD_NAND_TXX9NDFMC)       += txx9ndfmc.o
> +obj-$(CONFIG_MTD_NAND_MPC5121_NFC)     += mpc5121_nfc.o
>
>  nand-objs := nand_base.o nand_bbt.o
> diff --git a/drivers/mtd/nand/mpc5121_nfc.c
> b/drivers/mtd/nand/mpc5121_nfc.c
> new file mode 100644
> index 0000000..a8da4db
> --- /dev/null
> +++ b/drivers/mtd/nand/mpc5121_nfc.c
> @@ -0,0 +1,855 @@
> +/*
> + * Copyright 2004-2008 Freescale Semiconductor, Inc.
> + * Copyright 2009 Semihalf.
> + *
> + * Based on original driver from Freescale Semiconductor
> + * written by John Rigby <jrigby@freescale.com> on basis
> + * of drivers/mtd/nand/mxc_nand.c. Reworked and extended
> + * Piotr Ziecik <kosmo@semihalf.com>.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/mpc512x.h>
> +#include <asm/mpc5121_nfc.h>
> +
> +#define        DRV_NAME                "mpc5121_nfc"
> +#define        DRV_VERSION             "0.5"
> +
> +/* Timeouts */
> +#define NFC_RESET_TIMEOUT      1000            /* 1 ms */
> +#define NFC_TIMEOUT            (HZ / 10)       /* 1/10 s */
> +
> +struct mpc5121_nfc_prv {
> +       struct mtd_info         mtd;
> +       struct nand_chip        chip;
> +       int                     irq;
> +       void __iomem            *regs;
> +       struct clk              *clk;
> +       wait_queue_head_t       irq_waitq;
> +       uint                    column;
> +       int                     spareonly;
> +       void __iomem            *csreg;
> +};
> +
> +static void mpc5121_nfc_done(struct mtd_info *mtd);
> +
> +#ifdef CONFIG_MTD_PARTITIONS
> +static const char *mpc5121_nfc_pprobes[] = { "cmdlinepart", NULL };
> +#endif
> +
> +/* Read NFC register */
> +static inline u16 nfc_read(struct mtd_info *mtd, uint reg)
> +{
> +       struct nand_chip *chip = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = chip->priv;
> +
> +       return in_be16(prv->regs + reg);
> +}
> +
> +/* Write NFC register */
> +static inline void nfc_write(struct mtd_info *mtd, uint reg, u16 val)
> +{
> +       struct nand_chip *chip = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = chip->priv;
> +
> +       out_be16(prv->regs + reg, val);
> +}
> +
> +/* Set bits in NFC register */
> +static inline void nfc_set(struct mtd_info *mtd, uint reg, u16 bits)
> +{
> +       nfc_write(mtd, reg, nfc_read(mtd, reg) | bits);
> +}
> +
> +/* Clear bits in NFC register */
> +static inline void nfc_clear(struct mtd_info *mtd, uint reg, u16 bits)
> +{
> +       nfc_write(mtd, reg, nfc_read(mtd, reg) & ~bits);
> +}
> +
> +/* Invoke address cycle */
> +static inline void mpc5121_nfc_send_addr(struct mtd_info *mtd, u16 addr)
> +{
> +       nfc_write(mtd, NFC_FLASH_ADDR, addr);
> +       nfc_write(mtd, NFC_CONFIG2, NFC_ADDRESS);
> +       mpc5121_nfc_done(mtd);
> +}
> +
> +/* Invoke command cycle */
> +static inline void mpc5121_nfc_send_cmd(struct mtd_info *mtd, u16 cmd)
> +{
> +       nfc_write(mtd, NFC_FLASH_CMD, cmd);
> +       nfc_write(mtd, NFC_CONFIG2, NFC_COMMAND);
> +       mpc5121_nfc_done(mtd);
> +}
> +
> +/* Send data from NFC buffers to NAND flash */
> +static inline void mpc5121_nfc_send_prog_page(struct mtd_info *mtd)
> +{
> +       nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);
> +       nfc_write(mtd, NFC_CONFIG2, NFC_INPUT);
> +       mpc5121_nfc_done(mtd);
> +}
> +
> +/* Receive data from NAND flash */
> +static inline void mpc5121_nfc_send_read_page(struct mtd_info *mtd)
> +{
> +       nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);
> +       nfc_write(mtd, NFC_CONFIG2, NFC_OUTPUT);
> +       mpc5121_nfc_done(mtd);
> +}
> +
> +/* Receive ID from NAND flash */
> +static inline void mpc5121_nfc_send_read_id(struct mtd_info *mtd)
> +{
> +       nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);
> +       nfc_write(mtd, NFC_CONFIG2, NFC_ID);
> +       mpc5121_nfc_done(mtd);
> +}
> +
> +/* Receive status from NAND flash */
> +static inline void mpc5121_nfc_send_read_status(struct mtd_info *mtd)
> +{
> +       nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);
> +       nfc_write(mtd, NFC_CONFIG2, NFC_STATUS);
> +       mpc5121_nfc_done(mtd);
> +}
> +
> +/* NFC interrupt handler */
> +static irqreturn_t mpc5121_nfc_irq(int irq, void *data)
> +{
> +       struct mtd_info *mtd = data;
> +       struct nand_chip *chip = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = chip->priv;
> +
> +       nfc_set(mtd, NFC_CONFIG1, NFC_INT_MASK);
> +       wake_up(&prv->irq_waitq);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* Wait for operation complete */
> +static void mpc5121_nfc_done(struct mtd_info *mtd)
> +{
> +       struct nand_chip *chip = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = chip->priv;
> +       int rv;
> +
> +       if ((nfc_read(mtd, NFC_CONFIG2) & NFC_INT) == 0) {
> +               nfc_clear(mtd, NFC_CONFIG1, NFC_INT_MASK);
> +               rv = wait_event_timeout(prv->irq_waitq,
> +                       (nfc_read(mtd, NFC_CONFIG2) & NFC_INT),
> NFC_TIMEOUT);
> +
> +               if (!rv)
> +                       printk(KERN_WARNING DRV_NAME
> +                               ": Timeout while waiting for
> interrupt.\n");
> +       }
> +
> +       nfc_clear(mtd, NFC_CONFIG2, NFC_INT);
> +}
> +
> +/* Do address cycle(s) */
> +static void mpc5121_nfc_addr_cycle(struct mtd_info *mtd, int column, int
> page)
> +{
> +       struct nand_chip *chip = mtd->priv;
> +       u32 pagemask = chip->pagemask;
> +
> +       if (column != -1) {
> +               mpc5121_nfc_send_addr(mtd, column);
> +               if (mtd->writesize > 512)
> +                       mpc5121_nfc_send_addr(mtd, column >> 8);
> +       }
> +
> +       if (page != -1) {
> +               do {
> +                       mpc5121_nfc_send_addr(mtd, page & 0xFF);
> +                       page >>= 8;
> +                       pagemask >>= 8;
> +               } while (pagemask);
> +       }
> +}
> +
> +/* Control chip select signals */
> +static void mpc5121_nfc_select_chip(struct mtd_info *mtd, int chip)
> +{
> +       if (chip < 0) {
> +               nfc_clear(mtd, NFC_CONFIG1, NFC_CE);
> +               return;
> +       }
> +
> +       nfc_clear(mtd, NFC_BUF_ADDR, NFC_ACTIVE_CS_MASK);
> +       nfc_set(mtd, NFC_BUF_ADDR, (chip << NFC_ACTIVE_CS_SHIFT) &
> +
> NFC_ACTIVE_CS_MASK);
> +       nfc_set(mtd, NFC_CONFIG1, NFC_CE);
> +}
> +
> +/* Init external chip select logic on ADS5121 board */
> +static int ads5121_chipselect_init(struct mtd_info *mtd)
> +{
> +       struct nand_chip *chip = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = chip->priv;
> +       struct device_node *dn;
> +
> +       dn = of_find_compatible_node(NULL, NULL, "fsl,mpc5121ads-cpld");
> +       if (dn) {
> +               prv->csreg = of_iomap(dn, 0);
> +               of_node_put(dn);
> +               if (!prv->csreg)
> +                       return -ENOMEM;
> +
> +               /* CPLD Register 9 controls NAND /CE Lines */
> +               prv->csreg += 9;
> +               return 0;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +/* Control chips select signal on ADS5121 board */
> +static void ads5121_select_chip(struct mtd_info *mtd, int chip)
> +{
> +       struct nand_chip *nand = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = nand->priv;
> +       u8 v;
> +
> +       v = in_8(prv->csreg);
> +       v |= 0x0F;
> +
> +       if (chip >= 0) {
> +               mpc5121_nfc_select_chip(mtd, 0);
> +               v &= ~(1 << chip);
> +       } else
> +               mpc5121_nfc_select_chip(mtd, -1);
> +
> +       out_8(prv->csreg, v);
> +}
> +
> +/* Read NAND Ready/Busy signal */
> +static int mpc5121_nfc_dev_ready(struct mtd_info *mtd)
> +{
> +       /*
> +        * NFC handles ready/busy signal internally. Therefore, this
> function
> +        * always returns status as ready.
> +        */
> +       return 1;
> +}
> +
> +/* Write command to NAND flash */
> +static void mpc5121_nfc_command(struct mtd_info *mtd, unsigned command,
> +                                                       int column, int
> page)
> +{
> +       struct nand_chip *chip = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = chip->priv;
> +
> +       prv->column = (column >= 0) ? column : 0;
> +       prv->spareonly = 0;
> +
> +       switch (command) {
> +       case NAND_CMD_PAGEPROG:
> +               mpc5121_nfc_send_prog_page(mtd);
> +               break;
> +       /*
> +        * NFC does not support sub-page reads and writes,
> +        * so emulate them using full page transfers.
> +        */
> +       case NAND_CMD_READ0:
> +               column = 0;
> +               break;
> +
> +       case NAND_CMD_READ1:
> +               prv->column += 256;
> +               command = NAND_CMD_READ0;
> +               column = 0;
> +               break;
> +
> +       case NAND_CMD_READOOB:
> +               prv->spareonly = 1;
> +               command = NAND_CMD_READ0;
> +               column = 0;
> +               break;
> +
> +       case NAND_CMD_SEQIN:
> +               mpc5121_nfc_command(mtd, NAND_CMD_READ0, column, page);
> +               column = 0;
> +               break;
> +
> +       case NAND_CMD_ERASE1:
> +       case NAND_CMD_ERASE2:
> +       case NAND_CMD_READID:
> +       case NAND_CMD_STATUS:
> +               break;
> +
> +       default:
> +               return;
> +       }
> +
> +       mpc5121_nfc_send_cmd(mtd, command);
> +       mpc5121_nfc_addr_cycle(mtd, column, page);
> +
> +       switch (command) {
> +       case NAND_CMD_READ0:
> +               if (mtd->writesize > 512)
> +                       mpc5121_nfc_send_cmd(mtd, NAND_CMD_READSTART);
> +               mpc5121_nfc_send_read_page(mtd);
> +               break;
> +
> +       case NAND_CMD_READID:
> +               mpc5121_nfc_send_read_id(mtd);
> +               break;
> +
> +       case NAND_CMD_STATUS:
> +               mpc5121_nfc_send_read_status(mtd);
> +               if (chip->options & NAND_BUSWIDTH_16)
> +                       prv->column = 1;
> +               else
> +                       prv->column = 0;
> +               break;
> +       }
> +}
> +
> +/* Copy data from/to NFC spare buffers. */
> +static void mpc5121_nfc_copy_spare(struct mtd_info *mtd, uint offset,
> +                                               u8 *buffer, uint size, int
> wr)
> +{
> +       struct nand_chip *nand = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = nand->priv;
> +       uint o, s, sbsize, blksize;
> +
> +       /*
> +        * NAND spare area is available through NFC spare buffers.
> +        * The NFC divides spare area into (page_size / 512) chunks.
> +        * Each chunk is placed into separate spare memory area, using
> +        * first (spare_size / num_of_chunks) bytes of the buffer.
> +        *
> +        * For NAND device in which the spare area is not divided fully
> +        * by the number of chunks, number of used bytes in each spare
> +        * buffer is rounded down to the nearest even number of bytes,
> +        * and all remaining bytes are added to the last used spare area.
> +        *
> +        * For more information read section 26.6.10 of MPC5121e
> +        * Microcontroller Reference Manual, Rev. 3.
> +        */
> +
> +       /* Calculate number of valid bytes in each spare buffer */
> +       sbsize = (mtd->oobsize / (mtd->writesize / 512)) & ~1;
> +
> +       while (size) {
> +               /* Calculate spare buffer number */
> +               s = offset / sbsize;
> +               if (s > NFC_SPARE_BUFFERS - 1)
> +                       s = NFC_SPARE_BUFFERS - 1;
> +
> +               /*
> +                * Calculate offset to requested data block in selected
> spare
> +                * buffer and its size.
> +                */
> +               o = offset - (s * sbsize);
> +               blksize = min(sbsize - o, size);
> +
> +               if (wr)
> +                       memcpy_toio(prv->regs + NFC_SPARE_AREA(s) + o,
> +                                                       buffer, blksize);
> +               else
> +                       memcpy_fromio(buffer,
> +                               prv->regs + NFC_SPARE_AREA(s) + o,
> blksize);
> +
> +               buffer += blksize;
> +               offset += blksize;
> +               size -= blksize;
> +       };
> +}
> +
> +/* Copy data from/to NFC main and spare buffers */
> +static void mpc5121_nfc_buf_copy(struct mtd_info *mtd, u_char *buf, int
> len,
> +                                                                       int
> wr)
> +{
> +       struct nand_chip *chip = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = chip->priv;
> +       uint c = prv->column;
> +       uint l;
> +
> +       /* Handle spare area access */
> +       if (prv->spareonly || c >= mtd->writesize) {
> +               /* Calculate offset from beginning of spare area */
> +               if (c >= mtd->writesize)
> +                       c -= mtd->writesize;
> +
> +               prv->column += len;
> +               mpc5121_nfc_copy_spare(mtd, c, buf, len, wr);
> +               return;
> +       }
> +
> +       /*
> +        * Handle main area access - limit copy length to prevent
> +        * crossing main/spare boundary.
> +        */
> +       l = min((uint)len, mtd->writesize - c);
> +       prv->column += l;
> +
> +       if (wr)
> +               memcpy_toio(prv->regs + NFC_MAIN_AREA(0) + c, buf, l);
> +       else
> +               memcpy_fromio(buf, prv->regs + NFC_MAIN_AREA(0) + c, l);
> +
> +       /* Handle crossing main/spare boundary */
> +       if (l != len) {
> +               buf += l;
> +               len -= l;
> +               mpc5121_nfc_buf_copy(mtd, buf, len, wr);
> +       }
> +}
> +
> +/* Read data from NFC buffers */
> +static void mpc5121_nfc_read_buf(struct mtd_info *mtd, u_char *buf, int
> len)
> +{
> +       mpc5121_nfc_buf_copy(mtd, buf, len, 0);
> +}
> +
> +/* Write data to NFC buffers */
> +static void mpc5121_nfc_write_buf(struct mtd_info *mtd,
> +                                               const u_char *buf, int len)
> +{
> +       mpc5121_nfc_buf_copy(mtd, (u_char *)buf, len, 1);
> +}
> +
> +/* Compare buffer with NAND flash */
> +static int mpc5121_nfc_verify_buf(struct mtd_info *mtd,
> +                                               const u_char *buf, int len)
> +{
> +       u_char tmp[256];
> +       uint bsize;
> +
> +       while (len) {
> +               bsize = min(len, 256);
> +               mpc5121_nfc_read_buf(mtd, tmp, bsize);
> +
> +               if (memcmp(buf, tmp, bsize))
> +                       return 1;
> +
> +               buf += bsize;
> +               len -= bsize;
> +       }
> +
> +       return 0;
> +}
> +
> +/* Read byte from NFC buffers */
> +static u8 mpc5121_nfc_read_byte(struct mtd_info *mtd)
> +{
> +       u8 tmp;
> +
> +       mpc5121_nfc_read_buf(mtd, &tmp, sizeof(tmp));
> +
> +       return tmp;
> +}
> +
> +/* Read word from NFC buffers */
> +static u16 mpc5121_nfc_read_word(struct mtd_info *mtd)
> +{
> +       u16 tmp;
> +
> +       mpc5121_nfc_read_buf(mtd, (u_char *)&tmp, sizeof(tmp));
> +
> +       return tmp;
> +}
> +
> +/*
> + * Read NFC configuration from Reset Config Word
> + *
> + * NFC is configured during reset in basis of information stored
> + * in Reset Config Word. There is no other way to set NAND block
> + * size, spare size and bus width.
> + */
> +static int mpc5121_nfc_read_hw_config(struct mtd_info *mtd)
> +{
> +       struct nand_chip *chip = mtd->priv;
> +       struct mpc512x_reset_module *rm;
> +       struct device_node *rmnode;
> +       uint rcw_pagesize = 0;
> +       uint rcw_sparesize = 0;
> +       uint rcw_width;
> +       uint rcwh;
> +       uint romloc, ps;
> +
> +       rmnode = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-reset");
> +       if (!rmnode) {
> +               printk(KERN_ERR DRV_NAME ": Missing 'fsl,mpc5121-reset' "
> +                                               "node in device tree!\n");
> +               return -ENODEV;
> +       }
> +
> +       rm = of_iomap(rmnode, 0);
> +       if (!rm) {
> +               printk(KERN_ERR DRV_NAME
> +                                       ": Error mapping reset module
> node!\n");
> +               return -EBUSY;
> +       }
> +
> +       rcwh = in_be32(&rm->rcwhr);
> +
> +       /* Bit 6: NFC bus width */
> +       rcw_width = ((rcwh >> 6) & 0x1) ? 2 : 1;
> +
> +       /* Bit 7: NFC Page/Spare size */
> +       ps = (rcwh >> 7) & 0x1;
> +
> +       /* Bits [22:21]: ROM Location */
> +       romloc = (rcwh >> 21) & 0x3;
> +
> +       /* Decode RCW bits */
> +       switch ((ps << 2) | romloc) {
> +       case 0x00:
> +       case 0x01:
> +               rcw_pagesize = 512;
> +               rcw_sparesize = 16;
> +               break;
> +       case 0x02:
> +       case 0x03:
> +               rcw_pagesize = 4096;
> +               rcw_sparesize = 128;
> +               break;
> +       case 0x04:
> +       case 0x05:
> +               rcw_pagesize = 2048;
> +               rcw_sparesize = 64;
> +               break;
> +       case 0x06:
> +       case 0x07:
> +               rcw_pagesize = 4096;
> +               rcw_sparesize = 218;
> +               break;
> +       }
> +
> +       mtd->writesize = rcw_pagesize;
> +       mtd->oobsize = rcw_sparesize;
> +       if (rcw_width == 2)
> +               chip->options |= NAND_BUSWIDTH_16;
> +
> +       printk(KERN_NOTICE DRV_NAME ": Configured for "
> +                                               "%u-bit NAND, page size %u
> "
> +                                               "with %u spare.\n",
> +                                               rcw_width * 8,
> rcw_pagesize,
> +                                               rcw_sparesize);
> +       iounmap(rm);
> +       of_node_put(rmnode);
> +       return 0;
> +}
> +
> +/* Free driver resources */
> +static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
> +{
> +       struct nand_chip *chip = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = chip->priv;
> +
> +       if (prv->clk) {
> +               clk_disable(prv->clk);
> +               clk_put(prv->clk);
> +       }
> +
> +       if (prv->csreg)
> +               iounmap(prv->csreg);
> +}
> +
> +static int __init mpc5121_nfc_probe(struct of_device *op,
> +                                       const struct of_device_id *match)
> +{
> +       struct device_node *rootnode, *dn = op->node;
> +       struct device *dev = &op->dev;
> +       struct mpc5121_nfc_prv *prv;
> +       struct resource res;
> +       struct mtd_info *mtd;
> +#ifdef CONFIG_MTD_PARTITIONS
> +       struct mtd_partition *parts;
> +#endif
> +       struct nand_chip *chip;
> +       unsigned long regs_paddr, regs_size;
> +       const uint *chips_no;
> +       int resettime = 0;
> +       int retval = 0;
> +       int rev, len;
> +
> +       /*
> +        * Check SoC revision. This driver supports only NFC
> +        * in MPC5121 revision 2.
> +        */
> +       rev = (mfspr(SPRN_SVR) >> 4) & 0xF;
> +       if (rev != 2) {
> +               printk(KERN_ERR DRV_NAME
> +                               ": SoC revision %u is not supported!\n",
> rev);
> +               return -ENXIO;
> +       }
> +
> +       prv = devm_kzalloc(dev, sizeof(*prv), GFP_KERNEL);
> +       if (!prv) {
> +               printk(KERN_ERR DRV_NAME ": Memory exhausted!\n");
> +               return -ENOMEM;
> +       }
> +
> +       mtd = &prv->mtd;
> +       chip = &prv->chip;
> +
> +       mtd->priv = chip;
> +       chip->priv = prv;
> +
> +       /* Read NFC configuration from Reset Config Word */
> +       retval = mpc5121_nfc_read_hw_config(mtd);
> +       if (retval) {
> +               printk(KERN_ERR DRV_NAME ": Unable to read NFC config!\n");
> +               return retval;
> +       }
> +
> +       prv->irq = irq_of_parse_and_map(dn, 0);
> +       if (prv->irq == NO_IRQ) {
> +               printk(KERN_ERR DRV_NAME ": Error mapping IRQ!\n");
> +               return -EINVAL;
> +       }
> +
> +       retval = of_address_to_resource(dn, 0, &res);
> +       if (retval) {
> +               printk(KERN_ERR DRV_NAME ": Error parsing memory
> region!\n");
> +               return retval;
> +       }
> +
> +       chips_no = of_get_property(dn, "chips", &len);
> +       if (!chips_no || len != sizeof(*chips_no)) {
> +               printk(KERN_ERR DRV_NAME ": Invalid/missing 'chips' "
> +
> "property!\n");
> +               return -EINVAL;
> +       }
> +
> +       regs_paddr = res.start;
> +       regs_size = res.end - res.start + 1;
> +
> +       if (!devm_request_mem_region(dev, regs_paddr, regs_size, DRV_NAME))
> {
> +               printk(KERN_ERR DRV_NAME ": Error requesting memory
> region!\n");
> +               return -EBUSY;
> +       }
> +
> +       prv->regs = devm_ioremap(dev, regs_paddr, regs_size);
> +       if (!prv->regs) {
> +               printk(KERN_ERR DRV_NAME ": Error mapping memory
> region!\n");
> +               return -ENOMEM;
> +       }
> +
> +       mtd->name = "MPC5121 NAND";
> +       chip->dev_ready = mpc5121_nfc_dev_ready;
> +       chip->cmdfunc = mpc5121_nfc_command;
> +       chip->read_byte = mpc5121_nfc_read_byte;
> +       chip->read_word = mpc5121_nfc_read_word;
> +       chip->read_buf = mpc5121_nfc_read_buf;
> +       chip->write_buf = mpc5121_nfc_write_buf;
> +       chip->verify_buf = mpc5121_nfc_verify_buf;
> +       chip->select_chip = mpc5121_nfc_select_chip;
> +       chip->options = NAND_NO_AUTOINCR | NAND_USE_FLASH_BBT;
> +       chip->ecc.mode = NAND_ECC_SOFT;
> +
> +       /* Support external chip-select logic on ADS5121 board */
> +       rootnode = of_find_node_by_path("/");
> +       if (of_device_is_compatible(rootnode, "fsl,mpc5121ads")) {
> +               retval = ads5121_chipselect_init(mtd);
> +               if (retval) {
> +                       printk(KERN_ERR DRV_NAME ": Chipselect init
> error!\n");
> +                       of_node_put(rootnode);
> +                       return retval;
> +               }
> +
> +               chip->select_chip = ads5121_select_chip;
> +       }
> +       of_node_put(rootnode);
> +
> +       /* Enable NFC clock */
> +       prv->clk = clk_get(dev, "nfc_clk");
> +       if (!prv->clk) {
> +               printk(KERN_ERR DRV_NAME ": Unable to acquire NFC
> clock!\n");
> +               retval = -ENODEV;
> +               goto error;
> +       }
> +
> +       clk_enable(prv->clk);
> +
> +       /* Reset NAND Flash controller */
> +       nfc_set(mtd, NFC_CONFIG1, NFC_RESET);
> +       while (nfc_read(mtd, NFC_CONFIG1) & NFC_RESET) {
> +               if (resettime++ >= NFC_RESET_TIMEOUT) {
> +                       printk(KERN_ERR DRV_NAME
> +                                       ": Timeout while resetting
> NFC!\n");
> +                       retval = -EINVAL;
> +                       goto error;
> +               }
> +
> +               udelay(1);
> +       }
> +
> +       /* Enable write to NFC memory */
> +       nfc_write(mtd, NFC_CONFIG, NFC_BLS_UNLOCKED);
> +
> +       /* Enable write to all NAND pages */
> +       nfc_write(mtd, NFC_UNLOCKSTART_BLK0, 0x0000);
> +       nfc_write(mtd, NFC_UNLOCKEND_BLK0, 0xFFFF);
> +       nfc_write(mtd, NFC_WRPROT, NFC_WPC_UNLOCK);
> +
> +       /*
> +        * Setup NFC:
> +        *      - Big Endian transfers,
> +        *      - Interrupt after full page read/write.
> +        */
> +       nfc_write(mtd, NFC_CONFIG1, NFC_BIG_ENDIAN | NFC_INT_MASK |
> +                                                       NFC_FULL_PAGE_INT);
> +
> +       /* Set spare area size */
> +       nfc_write(mtd, NFC_SPAS, mtd->oobsize >> 1);
> +
> +       init_waitqueue_head(&prv->irq_waitq);
> +       retval = devm_request_irq(dev, prv->irq, &mpc5121_nfc_irq, 0,
> DRV_NAME,
> +
> mtd);
> +       if (retval) {
> +               printk(KERN_ERR DRV_NAME ": Error requesting IRQ!\n");
> +               goto error;
> +       }
> +
> +       /* Detect NAND chips */
> +       if (nand_scan(mtd, *chips_no)) {
> +               printk(KERN_ERR DRV_NAME ": NAND Flash not found !\n");
> +               devm_free_irq(dev, prv->irq, mtd);
> +               retval = -ENXIO;
> +               goto error;
> +       }
> +
> +       /* Set erase block size */
> +       switch (mtd->erasesize / mtd->writesize) {
> +       case 32:
> +               nfc_set(mtd, NFC_CONFIG1, NFC_PPB_32);
> +               break;
> +
> +       case 64:
> +               nfc_set(mtd, NFC_CONFIG1, NFC_PPB_64);
> +               break;
> +
> +       case 128:
> +               nfc_set(mtd, NFC_CONFIG1, NFC_PPB_128);
> +               break;
> +
> +       case 256:
> +               nfc_set(mtd, NFC_CONFIG1, NFC_PPB_256);
> +               break;
> +
> +       default:
> +               printk(KERN_ERR DRV_NAME ": Unsupported NAND flash!\n");
> +               devm_free_irq(dev, prv->irq, mtd);
> +               retval = -ENXIO;
> +               goto error;
> +       }
> +
> +       dev_set_drvdata(dev, mtd);
> +
> +       /* Register device in MTD */
> +#ifdef CONFIG_MTD_PARTITIONS
> +       retval = parse_mtd_partitions(mtd, mpc5121_nfc_pprobes, &parts, 0);
> +#ifdef CONFIG_MTD_OF_PARTS
> +       if (retval == 0)
> +               retval = of_mtd_parse_partitions(dev, dn, &parts);
> +#endif
> +       if (retval < 0) {
> +               printk(KERN_ERR DRV_NAME ": Error parsing MTD
> partitions!\n");
> +               devm_free_irq(dev, prv->irq, mtd);
> +               retval = -EINVAL;
> +               goto error;
> +       }
> +
> +       if (retval > 0)
> +               retval = add_mtd_partitions(mtd, parts, retval);
> +       else
> +#endif
> +               retval = add_mtd_device(mtd);
> +
> +       if (retval) {
> +               printk(KERN_ERR DRV_NAME ": Error adding MTD device!\n");
> +               devm_free_irq(dev, prv->irq, mtd);
> +               goto error;
> +       }
> +
> +       return 0;
> +error:
> +       mpc5121_nfc_free(dev, mtd);
> +       return retval;
> +}
> +
> +static int __exit mpc5121_nfc_remove(struct of_device *op)
> +{
> +       struct device *dev = &op->dev;
> +       struct mtd_info *mtd = dev_get_drvdata(dev);
> +       struct nand_chip *chip = mtd->priv;
> +       struct mpc5121_nfc_prv *prv = chip->priv;
> +
> +       nand_release(mtd);
> +       devm_free_irq(dev, prv->irq, mtd);
> +       mpc5121_nfc_free(dev, mtd);
> +
> +       return 0;
> +}
> +
> +static struct of_device_id mpc5121_nfc_match[] = {
> +       { .compatible = "fsl,mpc5121-nfc", },
> +       {},
> +};
> +
> +static struct of_platform_driver mpc5121_nfc_driver = {
> +       .owner          = THIS_MODULE,
> +       .name           = DRV_NAME,
> +       .match_table    = mpc5121_nfc_match,
> +       .probe          = mpc5121_nfc_probe,
> +       .remove         = __exit_p(mpc5121_nfc_remove),
> +       .suspend        = NULL,
> +       .resume         = NULL,
> +       .driver         = {
> +               .name   = DRV_NAME,
> +               .owner  = THIS_MODULE,
> +       },
> +};
> +
> +static int __init mpc5121_nfc_init(void)
> +{
> +       if (of_register_platform_driver(&mpc5121_nfc_driver) != 0) {
> +               printk(KERN_ERR DRV_NAME ": Driver register failed!\n");
> +               return -ENODEV;
> +       }
> +       return 0;
> +}
> +
> +static void __exit mpc5121_nfc_cleanup(void)
> +{
> +       of_unregister_platform_driver(&mpc5121_nfc_driver);
> +}
> +
> +module_init(mpc5121_nfc_init);
> +module_exit(mpc5121_nfc_cleanup);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_DESCRIPTION("MPC5121 NAND MTD driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> --
> 1.6.0.6
>
>

--000e0cd1748839687704695e3f99
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Did you choose to not support hardware ECC so you could use the spare area?=
=A0 The original driver only supported hardware ECC but unfortuneatly the h=
ardware ECC includes the spare area so the spare area cannot be written sep=
arately.<br>
<br><div class=3D"gmail_quote">On Wed, May 6, 2009 at 2:15 PM, Wolfgang Den=
k <span dir=3D"ltr">&lt;<a href=3D"mailto:wd@denx.de">wd@denx.de</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px =
solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
From: Piotr Ziecik &lt;<a href=3D"mailto:kosmo@semihalf.com">kosmo@semihalf=
.com</a>&gt;<br>
<br>
This patch adds NAND Flash Controller driver for MPC5121<br>
revision 2. All device features, except hardware ECC and<br>
power management, are supported.<br>
<br>
Signed-off-by: Piotr Ziecik &lt;<a href=3D"mailto:kosmo@semihalf.com">kosmo=
@semihalf.com</a>&gt;<br>
Signed-off-by: Wolfgang Denk &lt;<a href=3D"mailto:wd@denx.de">wd@denx.de</=
a>&gt;<br>
Cc: &lt;<a href=3D"mailto:linux-mtd@lists.infradead.org">linux-mtd@lists.in=
fradead.org</a>&gt;<br>
Cc: Grant Likely &lt;<a href=3D"mailto:grant.likely@secretlab.ca">grant.lik=
ely@secretlab.ca</a>&gt;<br>
Cc: John Rigby &lt;<a href=3D"mailto:jcrigby@gmail.com">jcrigby@gmail.com</=
a>&gt;<br>
---<br>
=A0arch/powerpc/include/asm/mpc5121_nfc.h =A0 =A0 =A0 | =A0100 +++<br>
=A0arch/powerpc/platforms/512x/mpc512x_shared.c | =A0 =A01 +<br>
=A0drivers/mtd/nand/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A07 +<br>
=A0drivers/mtd/nand/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +<br>
=A0drivers/mtd/nand/mpc5121_nfc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0855 ++++=
++++++++++++++++++++++<br>
=A05 files changed, 964 insertions(+), 0 deletions(-)<br>
=A0create mode 100644 arch/powerpc/include/asm/mpc5121_nfc.h<br>
=A0create mode 100644 drivers/mtd/nand/mpc5121_nfc.c<br>
<br>
diff --git a/arch/powerpc/include/asm/mpc5121_nfc.h b/arch/powerpc/include/=
asm/mpc5121_nfc.h<br>
new file mode 100644<br>
index 0000000..b96a5b9<br>
--- /dev/null<br>
+++ b/arch/powerpc/include/asm/mpc5121_nfc.h<br>
@@ -0,0 +1,100 @@<br>
+/*<br>
+ * Copyright 2004-2008 Freescale Semiconductor, Inc.<br>
+ * Copyright 2009 Semihalf.<br>
+ *<br>
+ * Approved as OSADL project by a majority of OSADL members and funded<br>
+ * by OSADL membership fees in 2009; =A0for details see <a href=3D"http://=
www.osadl.org" target=3D"_blank">www.osadl.org</a>.<br>
+ *<br>
+ * Based on original driver from Freescale Semiconductor<br>
+ * written by John Rigby &lt;<a href=3D"mailto:jrigby@freescale.com">jrigb=
y@freescale.com</a>&gt; on basis<br>
+ * of drivers/mtd/nand/mxc_nand.c. Reworked and extended by<br>
+ * Piotr Ziecik &lt;<a href=3D"mailto:kosmo@semihalf.com">kosmo@semihalf.c=
om</a>&gt;.<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU General Public License<br>
+ * as published by the Free Software Foundation; either version 2<br>
+ * of the License, or (at your option) any later version.<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program; if not, write to the Free Software<br>
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,<br>
+ * MA 02110-1301, USA.<br>
+ */<br>
+<br>
+#ifndef MPC5121_NFC_H<br>
+#define MPC5121_NFC_H<br>
+<br>
+/* Addresses for NFC MAIN RAM BUFFER areas */<br>
+#define NFC_MAIN_AREA(n) =A0 =A0 =A0 ((n) * =A00x200)<br>
+<br>
+/* Addresses for NFC SPARE BUFFER areas */<br>
+#define NFC_SPARE_BUFFERS =A0 =A0 =A08<br>
+#define NFC_SPARE_LEN =A0 =A0 =A0 =A0 =A00x40<br>
+#define NFC_SPARE_AREA(n) =A0 =A0 =A0(0x1000 + ((n) * NFC_SPARE_LEN))<br>
+<br>
+/* MPC5121 NFC registers */<br>
+#define NFC_BUF_ADDR =A0 =A0 =A0 =A0 =A0 0x1E04<br>
+#define NFC_FLASH_ADDR =A0 =A0 =A0 =A0 0x1E06<br>
+#define NFC_FLASH_CMD =A0 =A0 =A0 =A0 =A00x1E08<br>
+#define NFC_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 0x1E0A<br>
+#define NFC_ECC_STATUS1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1E0C<br>
+#define NFC_ECC_STATUS2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1E0E<br>
+#define NFC_SPAS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1E10<br>
+#define NFC_WRPROT =A0 =A0 =A0 =A0 =A0 =A0 0x1E12<br>
+#define NFC_NF_WRPRST =A0 =A0 =A0 =A0 =A00x1E18<br>
+#define NFC_CONFIG1 =A0 =A0 =A0 =A0 =A0 =A00x1E1A<br>
+#define NFC_CONFIG2 =A0 =A0 =A0 =A0 =A0 =A00x1E1C<br>
+#define NFC_UNLOCKSTART_BLK0 =A0 0x1E20<br>
+#define NFC_UNLOCKEND_BLK0 =A0 =A0 0x1E22<br>
+#define NFC_UNLOCKSTART_BLK1 =A0 0x1E24<br>
+#define NFC_UNLOCKEND_BLK1 =A0 =A0 0x1E26<br>
+#define NFC_UNLOCKSTART_BLK2 =A0 0x1E28<br>
+#define NFC_UNLOCKEND_BLK2 =A0 =A0 0x1E2A<br>
+#define NFC_UNLOCKSTART_BLK3 =A0 0x1E2C<br>
+#define NFC_UNLOCKEND_BLK3 =A0 =A0 0x1E2E<br>
+<br>
+/* Bit Definitions: NFC_BUF_ADDR */<br>
+#define NFC_RBA_MASK =A0 =A0 =A0 =A0 =A0 (7 &lt;&lt; 0)<br>
+#define NFC_ACTIVE_CS_SHIFT =A0 =A05<br>
+#define NFC_ACTIVE_CS_MASK =A0 =A0 (3 &lt;&lt; NFC_ACTIVE_CS_SHIFT)<br>
+<br>
+/* Bit Definitions: NFC_CONFIG */<br>
+#define NFC_BLS_UNLOCKED =A0 =A0 =A0 (1 &lt;&lt; 1)<br>
+<br>
+/* Bit Definitions: NFC_CONFIG1 */<br>
+#define NFC_ECC_4BIT =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; 0)<br>
+#define NFC_FULL_PAGE_DMA =A0 =A0 =A0(1 &lt;&lt; 1)<br>
+#define NFC_SPARE_ONLY =A0 =A0 =A0 =A0 (1 &lt;&lt; 2)<br>
+#define NFC_ECC_ENABLE =A0 =A0 =A0 =A0 (1 &lt;&lt; 3)<br>
+#define NFC_INT_MASK =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; 4)<br>
+#define NFC_BIG_ENDIAN =A0 =A0 =A0 =A0 (1 &lt;&lt; 5)<br>
+#define NFC_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 &lt;&lt; 6)<br>
+#define NFC_CE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; 7)<br>
+#define NFC_ONE_CYCLE =A0 =A0 =A0 =A0 =A0(1 &lt;&lt; 8)<br>
+#define NFC_PPB_32 =A0 =A0 =A0 =A0 =A0 =A0 (0 &lt;&lt; 9)<br>
+#define NFC_PPB_64 =A0 =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; 9)<br>
+#define NFC_PPB_128 =A0 =A0 =A0 =A0 =A0 =A0(2 &lt;&lt; 9)<br>
+#define NFC_PPB_256 =A0 =A0 =A0 =A0 =A0 =A0(3 &lt;&lt; 9)<br>
+#define NFC_PPB_MASK =A0 =A0 =A0 =A0 =A0 (3 &lt;&lt; 9)<br>
+#define NFC_FULL_PAGE_INT =A0 =A0 =A0(1 &lt;&lt; 11)<br>
+<br>
+/* Bit Definitions: NFC_CONFIG2 */<br>
+#define NFC_COMMAND =A0 =A0 =A0 =A0 =A0 =A0(1 &lt;&lt; 0)<br>
+#define NFC_ADDRESS =A0 =A0 =A0 =A0 =A0 =A0(1 &lt;&lt; 1)<br>
+#define NFC_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 &lt;&lt; 2)<br>
+#define NFC_OUTPUT =A0 =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; 3)<br>
+#define NFC_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; 4)<br>
+#define NFC_STATUS =A0 =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; 5)<br>
+#define NFC_CMD_FAIL =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; 15)<br>
+#define NFC_INT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 &lt;&lt;=
 15)<br>
+<br>
+/* Bit Definitions: NFC_WRPROT */<br>
+#define NFC_WPC_LOCK_TIGHT =A0 =A0 (1 &lt;&lt; 0)<br>
+#define NFC_WPC_LOCK =A0 =A0 =A0 =A0 =A0 (1 &lt;&lt; 1)<br>
+#define NFC_WPC_UNLOCK =A0 =A0 =A0 =A0 (1 &lt;&lt; 2)<br>
+<br>
+#endif /* MPC5121_NFC_H */<br>
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/pl=
atforms/512x/mpc512x_shared.c<br>
index d8cd579..7135d89 100644<br>
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c<br>
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c<br>
@@ -71,6 +71,7 @@ void __init mpc512x_init_IRQ(void)<br>
=A0static struct of_device_id __initdata of_bus_ids[] =3D {<br>
 =A0 =A0 =A0 =A0{ .compatible =3D &quot;fsl,mpc5121-immr&quot;, },<br>
 =A0 =A0 =A0 =A0{ .compatible =3D &quot;fsl,mpc5121-localbus&quot;, },<br>
+ =A0 =A0 =A0 { .compatible =3D &quot;fsl,mpc5121-nfc&quot;, },<br>
 =A0 =A0 =A0 =A0{},<br>
=A0};<br>
<br>
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig<br>
index 890936d..fb0d1c4 100644<br>
--- a/drivers/mtd/nand/Kconfig<br>
+++ b/drivers/mtd/nand/Kconfig<br>
@@ -413,6 +413,13 @@ config MTD_NAND_FSL_UPM<br>
 =A0 =A0 =A0 =A0 =A0Enables support for NAND Flash chips wired onto Freesca=
le PowerPC<br>
 =A0 =A0 =A0 =A0 =A0processor localbus with User-Programmable Machine suppo=
rt.<br>
<br>
+config MTD_NAND_MPC5121_NFC<br>
+ =A0 =A0 =A0 tristate &quot;MPC5121 built-in NAND Flash Controller support=
&quot;<br>
+ =A0 =A0 =A0 depends on PPC_MPC512x<br>
+ =A0 =A0 =A0 help<br>
+ =A0 =A0 =A0 =A0 This enables the driver for the NAND flash controller on =
the<br>
+ =A0 =A0 =A0 =A0 MPC5121 SoC.<br>
+<br>
=A0config MTD_NAND_MXC<br>
 =A0 =A0 =A0 =A0tristate &quot;MXC NAND support&quot;<br>
 =A0 =A0 =A0 =A0depends on ARCH_MX2 || ARCH_MX3<br>
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile<br>
index d33860a..563e812 100644<br>
--- a/drivers/mtd/nand/Makefile<br>
+++ b/drivers/mtd/nand/Makefile<br>
@@ -39,5 +39,6 @@ obj-$(CONFIG_MTD_NAND_SH_FLCTL) =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 +=3D sh_flctl.o<br>
=A0obj-$(CONFIG_MTD_NAND_MXC) =A0 =A0 =A0 =A0 =A0 =A0 +=3D mxc_nand.o<br>
=A0obj-$(CONFIG_MTD_NAND_SOCRATES) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D socr=
ates_nand.o<br>
=A0obj-$(CONFIG_MTD_NAND_TXX9NDFMC) =A0 =A0 =A0 +=3D txx9ndfmc.o<br>
+obj-$(CONFIG_MTD_NAND_MPC5121_NFC) =A0 =A0 +=3D mpc5121_nfc.o<br>
<br>
=A0nand-objs :=3D nand_base.o nand_bbt.o<br>
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.=
c<br>
new file mode 100644<br>
index 0000000..a8da4db<br>
--- /dev/null<br>
+++ b/drivers/mtd/nand/mpc5121_nfc.c<br>
@@ -0,0 +1,855 @@<br>
+/*<br>
+ * Copyright 2004-2008 Freescale Semiconductor, Inc.<br>
+ * Copyright 2009 Semihalf.<br>
+ *<br>
+ * Based on original driver from Freescale Semiconductor<br>
+ * written by John Rigby &lt;<a href=3D"mailto:jrigby@freescale.com">jrigb=
y@freescale.com</a>&gt; on basis<br>
+ * of drivers/mtd/nand/mxc_nand.c. Reworked and extended<br>
+ * Piotr Ziecik &lt;<a href=3D"mailto:kosmo@semihalf.com">kosmo@semihalf.c=
om</a>&gt;.<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU General Public License<br>
+ * as published by the Free Software Foundation; either version 2<br>
+ * of the License, or (at your option) any later version.<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program; if not, write to the Free Software<br>
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,<br>
+ * MA 02110-1301, USA.<br>
+ */<br>
+<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/clk.h&gt;<br>
+#include &lt;linux/delay.h&gt;<br>
+#include &lt;linux/init.h&gt;<br>
+#include &lt;linux/interrupt.h&gt;<br>
+#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/mtd/mtd.h&gt;<br>
+#include &lt;linux/mtd/nand.h&gt;<br>
+#include &lt;linux/mtd/partitions.h&gt;<br>
+#include &lt;linux/of_device.h&gt;<br>
+#include &lt;linux/of_platform.h&gt;<br>
+<br>
+#include &lt;asm/mpc512x.h&gt;<br>
+#include &lt;asm/mpc5121_nfc.h&gt;<br>
+<br>
+#define =A0 =A0 =A0 =A0DRV_NAME =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;mpc51=
21_nfc&quot;<br>
+#define =A0 =A0 =A0 =A0DRV_VERSION =A0 =A0 =A0 =A0 =A0 =A0 &quot;0.5&quot;=
<br>
+<br>
+/* Timeouts */<br>
+#define NFC_RESET_TIMEOUT =A0 =A0 =A01000 =A0 =A0 =A0 =A0 =A0 =A0/* 1 ms *=
/<br>
+#define NFC_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0(HZ / 10) =A0 =A0 =A0 /* 1/10 s=
 */<br>
+<br>
+struct mpc5121_nfc_prv {<br>
+ =A0 =A0 =A0 struct mtd_info =A0 =A0 =A0 =A0 mtd;<br>
+ =A0 =A0 =A0 struct nand_chip =A0 =A0 =A0 =A0chip;<br>
+ =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;<br>
+ =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*regs;<br>
+ =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;<br>
+ =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 irq_waitq;<br>
+ =A0 =A0 =A0 uint =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0column;<br>
+ =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spareonly;<br>
+ =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*csreg;<br>
+};<br>
+<br>
+static void mpc5121_nfc_done(struct mtd_info *mtd);<br>
+<br>
+#ifdef CONFIG_MTD_PARTITIONS<br>
+static const char *mpc5121_nfc_pprobes[] =3D { &quot;cmdlinepart&quot;, NU=
LL };<br>
+#endif<br>
+<br>
+/* Read NFC register */<br>
+static inline u16 nfc_read(struct mtd_info *mtd, uint reg)<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip-&gt;priv;<br>
+<br>
+ =A0 =A0 =A0 return in_be16(prv-&gt;regs + reg);<br>
+}<br>
+<br>
+/* Write NFC register */<br>
+static inline void nfc_write(struct mtd_info *mtd, uint reg, u16 val)<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip-&gt;priv;<br>
+<br>
+ =A0 =A0 =A0 out_be16(prv-&gt;regs + reg, val);<br>
+}<br>
+<br>
+/* Set bits in NFC register */<br>
+static inline void nfc_set(struct mtd_info *mtd, uint reg, u16 bits)<br>
+{<br>
+ =A0 =A0 =A0 nfc_write(mtd, reg, nfc_read(mtd, reg) | bits);<br>
+}<br>
+<br>
+/* Clear bits in NFC register */<br>
+static inline void nfc_clear(struct mtd_info *mtd, uint reg, u16 bits)<br>
+{<br>
+ =A0 =A0 =A0 nfc_write(mtd, reg, nfc_read(mtd, reg) &amp; ~bits);<br>
+}<br>
+<br>
+/* Invoke address cycle */<br>
+static inline void mpc5121_nfc_send_addr(struct mtd_info *mtd, u16 addr)<b=
r>
+{<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_FLASH_ADDR, addr);<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_ADDRESS);<br>
+ =A0 =A0 =A0 mpc5121_nfc_done(mtd);<br>
+}<br>
+<br>
+/* Invoke command cycle */<br>
+static inline void mpc5121_nfc_send_cmd(struct mtd_info *mtd, u16 cmd)<br>
+{<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_FLASH_CMD, cmd);<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_COMMAND);<br>
+ =A0 =A0 =A0 mpc5121_nfc_done(mtd);<br>
+}<br>
+<br>
+/* Send data from NFC buffers to NAND flash */<br>
+static inline void mpc5121_nfc_send_prog_page(struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_INPUT);<br>
+ =A0 =A0 =A0 mpc5121_nfc_done(mtd);<br>
+}<br>
+<br>
+/* Receive data from NAND flash */<br>
+static inline void mpc5121_nfc_send_read_page(struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_OUTPUT);<br>
+ =A0 =A0 =A0 mpc5121_nfc_done(mtd);<br>
+}<br>
+<br>
+/* Receive ID from NAND flash */<br>
+static inline void mpc5121_nfc_send_read_id(struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_ID);<br>
+ =A0 =A0 =A0 mpc5121_nfc_done(mtd);<br>
+}<br>
+<br>
+/* Receive status from NAND flash */<br>
+static inline void mpc5121_nfc_send_read_status(struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_STATUS);<br>
+ =A0 =A0 =A0 mpc5121_nfc_done(mtd);<br>
+}<br>
+<br>
+/* NFC interrupt handler */<br>
+static irqreturn_t mpc5121_nfc_irq(int irq, void *data)<br>
+{<br>
+ =A0 =A0 =A0 struct mtd_info *mtd =3D data;<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip-&gt;priv;<br>
+<br>
+ =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_INT_MASK);<br>
+ =A0 =A0 =A0 wake_up(&amp;prv-&gt;irq_waitq);<br>
+<br>
+ =A0 =A0 =A0 return IRQ_HANDLED;<br>
+}<br>
+<br>
+/* Wait for operation complete */<br>
+static void mpc5121_nfc_done(struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip-&gt;priv;<br>
+ =A0 =A0 =A0 int rv;<br>
+<br>
+ =A0 =A0 =A0 if ((nfc_read(mtd, NFC_CONFIG2) &amp; NFC_INT) =3D=3D 0) {<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_clear(mtd, NFC_CONFIG1, NFC_INT_MASK);<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rv =3D wait_event_timeout(prv-&gt;irq_waitq,<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (nfc_read(mtd, NFC_CONFIG2) &=
amp; NFC_INT), NFC_TIMEOUT);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rv)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING DRV_NAME<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;: Timeo=
ut while waiting for interrupt.\n&quot;);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 nfc_clear(mtd, NFC_CONFIG2, NFC_INT);<br>
+}<br>
+<br>
+/* Do address cycle(s) */<br>
+static void mpc5121_nfc_addr_cycle(struct mtd_info *mtd, int column, int p=
age)<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 u32 pagemask =3D chip-&gt;pagemask;<br>
+<br>
+ =A0 =A0 =A0 if (column !=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_addr(mtd, column);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mtd-&gt;writesize &gt; 512)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_addr(mtd, co=
lumn &gt;&gt; 8);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (page !=3D -1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_addr(mtd, pa=
ge &amp; 0xFF);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page &gt;&gt;=3D 8;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pagemask &gt;&gt;=3D 8;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (pagemask);<br>
+ =A0 =A0 =A0 }<br>
+}<br>
+<br>
+/* Control chip select signals */<br>
+static void mpc5121_nfc_select_chip(struct mtd_info *mtd, int chip)<br>
+{<br>
+ =A0 =A0 =A0 if (chip &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_clear(mtd, NFC_CONFIG1, NFC_CE);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 nfc_clear(mtd, NFC_BUF_ADDR, NFC_ACTIVE_CS_MASK);<br>
+ =A0 =A0 =A0 nfc_set(mtd, NFC_BUF_ADDR, (chip &lt;&lt; NFC_ACTIVE_CS_SHIFT=
) &amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NFC_ACTIVE_CS_MASK);<br>
+ =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_CE);<br>
+}<br>
+<br>
+/* Init external chip select logic on ADS5121 board */<br>
+static int ads5121_chipselect_init(struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip-&gt;priv;<br>
+ =A0 =A0 =A0 struct device_node *dn;<br>
+<br>
+ =A0 =A0 =A0 dn =3D of_find_compatible_node(NULL, NULL, &quot;fsl,mpc5121a=
ds-cpld&quot;);<br>
+ =A0 =A0 =A0 if (dn) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv-&gt;csreg =3D of_iomap(dn, 0);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(dn);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!prv-&gt;csreg)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* CPLD Register 9 controls NAND /CE Lines */=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv-&gt;csreg +=3D 9;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return -EINVAL;<br>
+}<br>
+<br>
+/* Control chips select signal on ADS5121 board */<br>
+static void ads5121_select_chip(struct mtd_info *mtd, int chip)<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *nand =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D nand-&gt;priv;<br>
+ =A0 =A0 =A0 u8 v;<br>
+<br>
+ =A0 =A0 =A0 v =3D in_8(prv-&gt;csreg);<br>
+ =A0 =A0 =A0 v |=3D 0x0F;<br>
+<br>
+ =A0 =A0 =A0 if (chip &gt;=3D 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_select_chip(mtd, 0);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 v &amp;=3D ~(1 &lt;&lt; chip);<br>
+ =A0 =A0 =A0 } else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_select_chip(mtd, -1);<br>
+<br>
+ =A0 =A0 =A0 out_8(prv-&gt;csreg, v);<br>
+}<br>
+<br>
+/* Read NAND Ready/Busy signal */<br>
+static int mpc5121_nfc_dev_ready(struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* NFC handles ready/busy signal internally. Therefore, thi=
s function<br>
+ =A0 =A0 =A0 =A0* always returns status as ready.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 return 1;<br>
+}<br>
+<br>
+/* Write command to NAND flash */<br>
+static void mpc5121_nfc_command(struct mtd_info *mtd, unsigned command,<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int column, int page)<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip-&gt;priv;<br>
+<br>
+ =A0 =A0 =A0 prv-&gt;column =3D (column &gt;=3D 0) ? column : 0;<br>
+ =A0 =A0 =A0 prv-&gt;spareonly =3D 0;<br>
+<br>
+ =A0 =A0 =A0 switch (command) {<br>
+ =A0 =A0 =A0 case NAND_CMD_PAGEPROG:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_prog_page(mtd);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* NFC does not support sub-page reads and writes,<br>
+ =A0 =A0 =A0 =A0* so emulate them using full page transfers.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 case NAND_CMD_READ0:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 column =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 case NAND_CMD_READ1:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv-&gt;column +=3D 256;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 command =3D NAND_CMD_READ0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 column =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 case NAND_CMD_READOOB:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv-&gt;spareonly =3D 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 command =3D NAND_CMD_READ0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 column =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 case NAND_CMD_SEQIN:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_command(mtd, NAND_CMD_READ0, colu=
mn, page);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 column =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 case NAND_CMD_ERASE1:<br>
+ =A0 =A0 =A0 case NAND_CMD_ERASE2:<br>
+ =A0 =A0 =A0 case NAND_CMD_READID:<br>
+ =A0 =A0 =A0 case NAND_CMD_STATUS:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 mpc5121_nfc_send_cmd(mtd, command);<br>
+ =A0 =A0 =A0 mpc5121_nfc_addr_cycle(mtd, column, page);<br>
+<br>
+ =A0 =A0 =A0 switch (command) {<br>
+ =A0 =A0 =A0 case NAND_CMD_READ0:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mtd-&gt;writesize &gt; 512)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_cmd(mtd, NAN=
D_CMD_READSTART);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_read_page(mtd);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 case NAND_CMD_READID:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_read_id(mtd);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 case NAND_CMD_STATUS:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_read_status(mtd);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chip-&gt;options &amp; NAND_BUSWIDTH_16)<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv-&gt;column =3D 1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv-&gt;column =3D 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+}<br>
+<br>
+/* Copy data from/to NFC spare buffers. */<br>
+static void mpc5121_nfc_copy_spare(struct mtd_info *mtd, uint offset,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 u8 *buffer, uint size, int wr)<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *nand =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D nand-&gt;priv;<br>
+ =A0 =A0 =A0 uint o, s, sbsize, blksize;<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* NAND spare area is available through NFC spare buffers.<=
br>
+ =A0 =A0 =A0 =A0* The NFC divides spare area into (page_size / 512) chunks=
.<br>
+ =A0 =A0 =A0 =A0* Each chunk is placed into separate spare memory area, us=
ing<br>
+ =A0 =A0 =A0 =A0* first (spare_size / num_of_chunks) bytes of the buffer.<=
br>
+ =A0 =A0 =A0 =A0*<br>
+ =A0 =A0 =A0 =A0* For NAND device in which the spare area is not divided f=
ully<br>
+ =A0 =A0 =A0 =A0* by the number of chunks, number of used bytes in each sp=
are<br>
+ =A0 =A0 =A0 =A0* buffer is rounded down to the nearest even number of byt=
es,<br>
+ =A0 =A0 =A0 =A0* and all remaining bytes are added to the last used spare=
 area.<br>
+ =A0 =A0 =A0 =A0*<br>
+ =A0 =A0 =A0 =A0* For more information read section 26.6.10 of MPC5121e<br=
>
+ =A0 =A0 =A0 =A0* Microcontroller Reference Manual, Rev. 3.<br>
+ =A0 =A0 =A0 =A0*/<br>
+<br>
+ =A0 =A0 =A0 /* Calculate number of valid bytes in each spare buffer */<br=
>
+ =A0 =A0 =A0 sbsize =3D (mtd-&gt;oobsize / (mtd-&gt;writesize / 512)) &amp=
; ~1;<br>
+<br>
+ =A0 =A0 =A0 while (size) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Calculate spare buffer number */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D offset / sbsize;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s &gt; NFC_SPARE_BUFFERS - 1)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D NFC_SPARE_BUFFERS - 1;<=
br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Calculate offset to requested data block=
 in selected spare<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* buffer and its size.<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 o =3D offset - (s * sbsize);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 blksize =3D min(sbsize - o, size);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wr)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy_toio(prv-&gt;regs + NF=
C_SPARE_AREA(s) + o,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buffer, blksize);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy_fromio(buffer,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv-&gt;regs =
+ NFC_SPARE_AREA(s) + o, blksize);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 buffer +=3D blksize;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset +=3D blksize;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 size -=3D blksize;<br>
+ =A0 =A0 =A0 };<br>
+}<br>
+<br>
+/* Copy data from/to NFC main and spare buffers */<br>
+static void mpc5121_nfc_buf_copy(struct mtd_info *mtd, u_char *buf, int le=
n,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int wr)=
<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip-&gt;priv;<br>
+ =A0 =A0 =A0 uint c =3D prv-&gt;column;<br>
+ =A0 =A0 =A0 uint l;<br>
+<br>
+ =A0 =A0 =A0 /* Handle spare area access */<br>
+ =A0 =A0 =A0 if (prv-&gt;spareonly || c &gt;=3D mtd-&gt;writesize) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Calculate offset from beginning of spare a=
rea */<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c &gt;=3D mtd-&gt;writesize)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c -=3D mtd-&gt;writesize;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv-&gt;column +=3D len;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_copy_spare(mtd, c, buf, len, wr);=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* Handle main area access - limit copy length to prevent<b=
r>
+ =A0 =A0 =A0 =A0* crossing main/spare boundary.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 l =3D min((uint)len, mtd-&gt;writesize - c);<br>
+ =A0 =A0 =A0 prv-&gt;column +=3D l;<br>
+<br>
+ =A0 =A0 =A0 if (wr)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy_toio(prv-&gt;regs + NFC_MAIN_AREA(0) +=
 c, buf, l);<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy_fromio(buf, prv-&gt;regs + NFC_MAIN_AR=
EA(0) + c, l);<br>
+<br>
+ =A0 =A0 =A0 /* Handle crossing main/spare boundary */<br>
+ =A0 =A0 =A0 if (l !=3D len) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf +=3D l;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D l;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_buf_copy(mtd, buf, len, wr);<br>
+ =A0 =A0 =A0 }<br>
+}<br>
+<br>
+/* Read data from NFC buffers */<br>
+static void mpc5121_nfc_read_buf(struct mtd_info *mtd, u_char *buf, int le=
n)<br>
+{<br>
+ =A0 =A0 =A0 mpc5121_nfc_buf_copy(mtd, buf, len, 0);<br>
+}<br>
+<br>
+/* Write data to NFC buffers */<br>
+static void mpc5121_nfc_write_buf(struct mtd_info *mtd,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 const u_char *buf, int len)<br>
+{<br>
+ =A0 =A0 =A0 mpc5121_nfc_buf_copy(mtd, (u_char *)buf, len, 1);<br>
+}<br>
+<br>
+/* Compare buffer with NAND flash */<br>
+static int mpc5121_nfc_verify_buf(struct mtd_info *mtd,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 const u_char *buf, int len)<br>
+{<br>
+ =A0 =A0 =A0 u_char tmp[256];<br>
+ =A0 =A0 =A0 uint bsize;<br>
+<br>
+ =A0 =A0 =A0 while (len) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 bsize =3D min(len, 256);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_read_buf(mtd, tmp, bsize);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memcmp(buf, tmp, bsize))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf +=3D bsize;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D bsize;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+/* Read byte from NFC buffers */<br>
+static u8 mpc5121_nfc_read_byte(struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 u8 tmp;<br>
+<br>
+ =A0 =A0 =A0 mpc5121_nfc_read_buf(mtd, &amp;tmp, sizeof(tmp));<br>
+<br>
+ =A0 =A0 =A0 return tmp;<br>
+}<br>
+<br>
+/* Read word from NFC buffers */<br>
+static u16 mpc5121_nfc_read_word(struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 u16 tmp;<br>
+<br>
+ =A0 =A0 =A0 mpc5121_nfc_read_buf(mtd, (u_char *)&amp;tmp, sizeof(tmp));<b=
r>
+<br>
+ =A0 =A0 =A0 return tmp;<br>
+}<br>
+<br>
+/*<br>
+ * Read NFC configuration from Reset Config Word<br>
+ *<br>
+ * NFC is configured during reset in basis of information stored<br>
+ * in Reset Config Word. There is no other way to set NAND block<br>
+ * size, spare size and bus width.<br>
+ */<br>
+static int mpc5121_nfc_read_hw_config(struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc512x_reset_module *rm;<br>
+ =A0 =A0 =A0 struct device_node *rmnode;<br>
+ =A0 =A0 =A0 uint rcw_pagesize =3D 0;<br>
+ =A0 =A0 =A0 uint rcw_sparesize =3D 0;<br>
+ =A0 =A0 =A0 uint rcw_width;<br>
+ =A0 =A0 =A0 uint rcwh;<br>
+ =A0 =A0 =A0 uint romloc, ps;<br>
+<br>
+ =A0 =A0 =A0 rmnode =3D of_find_compatible_node(NULL, NULL, &quot;fsl,mpc5=
121-reset&quot;);<br>
+ =A0 =A0 =A0 if (!rmnode) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Missing &#39=
;fsl,mpc5121-reset&#39; &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &quot;node in device tree!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 rm =3D of_iomap(rmnode, 0);<br>
+ =A0 =A0 =A0 if (!rm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &quot;: Error mapping reset module node!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 rcwh =3D in_be32(&amp;rm-&gt;rcwhr);<br>
+<br>
+ =A0 =A0 =A0 /* Bit 6: NFC bus width */<br>
+ =A0 =A0 =A0 rcw_width =3D ((rcwh &gt;&gt; 6) &amp; 0x1) ? 2 : 1;<br>
+<br>
+ =A0 =A0 =A0 /* Bit 7: NFC Page/Spare size */<br>
+ =A0 =A0 =A0 ps =3D (rcwh &gt;&gt; 7) &amp; 0x1;<br>
+<br>
+ =A0 =A0 =A0 /* Bits [22:21]: ROM Location */<br>
+ =A0 =A0 =A0 romloc =3D (rcwh &gt;&gt; 21) &amp; 0x3;<br>
+<br>
+ =A0 =A0 =A0 /* Decode RCW bits */<br>
+ =A0 =A0 =A0 switch ((ps &lt;&lt; 2) | romloc) {<br>
+ =A0 =A0 =A0 case 0x00:<br>
+ =A0 =A0 =A0 case 0x01:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_pagesize =3D 512;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_sparesize =3D 16;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case 0x02:<br>
+ =A0 =A0 =A0 case 0x03:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_pagesize =3D 4096;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_sparesize =3D 128;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case 0x04:<br>
+ =A0 =A0 =A0 case 0x05:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_pagesize =3D 2048;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_sparesize =3D 64;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case 0x06:<br>
+ =A0 =A0 =A0 case 0x07:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_pagesize =3D 4096;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_sparesize =3D 218;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 mtd-&gt;writesize =3D rcw_pagesize;<br>
+ =A0 =A0 =A0 mtd-&gt;oobsize =3D rcw_sparesize;<br>
+ =A0 =A0 =A0 if (rcw_width =3D=3D 2)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip-&gt;options |=3D NAND_BUSWIDTH_16;<br>
+<br>
+ =A0 =A0 =A0 printk(KERN_NOTICE DRV_NAME &quot;: Configured for &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &quot;%u-bit NAND, page size %u &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &quot;with %u spare.\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 rcw_width * 8, rcw_pagesize,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 rcw_sparesize);<br>
+ =A0 =A0 =A0 iounmap(rm);<br>
+ =A0 =A0 =A0 of_node_put(rmnode);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+/* Free driver resources */<br>
+static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)<br>
+{<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip-&gt;priv;<br>
+<br>
+ =A0 =A0 =A0 if (prv-&gt;clk) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(prv-&gt;clk);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(prv-&gt;clk);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (prv-&gt;csreg)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(prv-&gt;csreg);<br>
+}<br>
+<br>
+static int __init mpc5121_nfc_probe(struct of_device *op,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 const struct of_device_id *match)<br>
+{<br>
+ =A0 =A0 =A0 struct device_node *rootnode, *dn =3D op-&gt;node;<br>
+ =A0 =A0 =A0 struct device *dev =3D &amp;op-&gt;dev;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv;<br>
+ =A0 =A0 =A0 struct resource res;<br>
+ =A0 =A0 =A0 struct mtd_info *mtd;<br>
+#ifdef CONFIG_MTD_PARTITIONS<br>
+ =A0 =A0 =A0 struct mtd_partition *parts;<br>
+#endif<br>
+ =A0 =A0 =A0 struct nand_chip *chip;<br>
+ =A0 =A0 =A0 unsigned long regs_paddr, regs_size;<br>
+ =A0 =A0 =A0 const uint *chips_no;<br>
+ =A0 =A0 =A0 int resettime =3D 0;<br>
+ =A0 =A0 =A0 int retval =3D 0;<br>
+ =A0 =A0 =A0 int rev, len;<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* Check SoC revision. This driver supports only NFC<br>
+ =A0 =A0 =A0 =A0* in MPC5121 revision 2.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 rev =3D (mfspr(SPRN_SVR) &gt;&gt; 4) &amp; 0xF;<br>
+ =A0 =A0 =A0 if (rev !=3D 2) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;: SoC r=
evision %u is not supported!\n&quot;, rev);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 prv =3D devm_kzalloc(dev, sizeof(*prv), GFP_KERNEL);<br>
+ =A0 =A0 =A0 if (!prv) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Memory exhau=
sted!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 mtd =3D &amp;prv-&gt;mtd;<br>
+ =A0 =A0 =A0 chip =3D &amp;prv-&gt;chip;<br>
+<br>
+ =A0 =A0 =A0 mtd-&gt;priv =3D chip;<br>
+ =A0 =A0 =A0 chip-&gt;priv =3D prv;<br>
+<br>
+ =A0 =A0 =A0 /* Read NFC configuration from Reset Config Word */<br>
+ =A0 =A0 =A0 retval =3D mpc5121_nfc_read_hw_config(mtd);<br>
+ =A0 =A0 =A0 if (retval) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Unable to re=
ad NFC config!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 prv-&gt;irq =3D irq_of_parse_and_map(dn, 0);<br>
+ =A0 =A0 =A0 if (prv-&gt;irq =3D=3D NO_IRQ) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Error mappin=
g IRQ!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 retval =3D of_address_to_resource(dn, 0, &amp;res);<br>
+ =A0 =A0 =A0 if (retval) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Error parsin=
g memory region!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 chips_no =3D of_get_property(dn, &quot;chips&quot;, &amp;len)=
;<br>
+ =A0 =A0 =A0 if (!chips_no || len !=3D sizeof(*chips_no)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Invalid/miss=
ing &#39;chips&#39; &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;property!\n&quot;=
);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 regs_paddr =3D res.start;<br>
+ =A0 =A0 =A0 regs_size =3D res.end - res.start + 1;<br>
+<br>
+ =A0 =A0 =A0 if (!devm_request_mem_region(dev, regs_paddr, regs_size, DRV_=
NAME)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Error reques=
ting memory region!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 prv-&gt;regs =3D devm_ioremap(dev, regs_paddr, regs_size);<br=
>
+ =A0 =A0 =A0 if (!prv-&gt;regs) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Error mappin=
g memory region!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 mtd-&gt;name =3D &quot;MPC5121 NAND&quot;;<br>
+ =A0 =A0 =A0 chip-&gt;dev_ready =3D mpc5121_nfc_dev_ready;<br>
+ =A0 =A0 =A0 chip-&gt;cmdfunc =3D mpc5121_nfc_command;<br>
+ =A0 =A0 =A0 chip-&gt;read_byte =3D mpc5121_nfc_read_byte;<br>
+ =A0 =A0 =A0 chip-&gt;read_word =3D mpc5121_nfc_read_word;<br>
+ =A0 =A0 =A0 chip-&gt;read_buf =3D mpc5121_nfc_read_buf;<br>
+ =A0 =A0 =A0 chip-&gt;write_buf =3D mpc5121_nfc_write_buf;<br>
+ =A0 =A0 =A0 chip-&gt;verify_buf =3D mpc5121_nfc_verify_buf;<br>
+ =A0 =A0 =A0 chip-&gt;select_chip =3D mpc5121_nfc_select_chip;<br>
+ =A0 =A0 =A0 chip-&gt;options =3D NAND_NO_AUTOINCR | NAND_USE_FLASH_BBT;<b=
r>
+ =A0 =A0 =A0 chip-&gt;ecc.mode =3D NAND_ECC_SOFT;<br>
+<br>
+ =A0 =A0 =A0 /* Support external chip-select logic on ADS5121 board */<br>
+ =A0 =A0 =A0 rootnode =3D of_find_node_by_path(&quot;/&quot;);<br>
+ =A0 =A0 =A0 if (of_device_is_compatible(rootnode, &quot;fsl,mpc5121ads&qu=
ot;)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D ads5121_chipselect_init(mtd);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quo=
t;: Chipselect init error!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(rootnode);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip-&gt;select_chip =3D ads5121_select_chip;=
<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 of_node_put(rootnode);<br>
+<br>
+ =A0 =A0 =A0 /* Enable NFC clock */<br>
+ =A0 =A0 =A0 prv-&gt;clk =3D clk_get(dev, &quot;nfc_clk&quot;);<br>
+ =A0 =A0 =A0 if (!prv-&gt;clk) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Unable to ac=
quire NFC clock!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENODEV;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 clk_enable(prv-&gt;clk);<br>
+<br>
+ =A0 =A0 =A0 /* Reset NAND Flash controller */<br>
+ =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_RESET);<br>
+ =A0 =A0 =A0 while (nfc_read(mtd, NFC_CONFIG1) &amp; NFC_RESET) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (resettime++ &gt;=3D NFC_RESET_TIMEOUT) {<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &quot;: Timeout while resetting NFC!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* Enable write to NFC memory */<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG, NFC_BLS_UNLOCKED);<br>
+<br>
+ =A0 =A0 =A0 /* Enable write to all NAND pages */<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_UNLOCKSTART_BLK0, 0x0000);<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_UNLOCKEND_BLK0, 0xFFFF);<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_WRPROT, NFC_WPC_UNLOCK);<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* Setup NFC:<br>
+ =A0 =A0 =A0 =A0* =A0 =A0 =A0- Big Endian transfers,<br>
+ =A0 =A0 =A0 =A0* =A0 =A0 =A0- Interrupt after full page read/write.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG1, NFC_BIG_ENDIAN | NFC_INT_MASK |<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NFC_FULL_PAGE_INT);<br>
+<br>
+ =A0 =A0 =A0 /* Set spare area size */<br>
+ =A0 =A0 =A0 nfc_write(mtd, NFC_SPAS, mtd-&gt;oobsize &gt;&gt; 1);<br>
+<br>
+ =A0 =A0 =A0 init_waitqueue_head(&amp;prv-&gt;irq_waitq);<br>
+ =A0 =A0 =A0 retval =3D devm_request_irq(dev, prv-&gt;irq, &amp;mpc5121_nf=
c_irq, 0, DRV_NAME,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtd);<b=
r>
+ =A0 =A0 =A0 if (retval) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Error reques=
ting IRQ!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* Detect NAND chips */<br>
+ =A0 =A0 =A0 if (nand_scan(mtd, *chips_no)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: NAND Flash n=
ot found !\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_free_irq(dev, prv-&gt;irq, mtd);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENXIO;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* Set erase block size */<br>
+ =A0 =A0 =A0 switch (mtd-&gt;erasesize / mtd-&gt;writesize) {<br>
+ =A0 =A0 =A0 case 32:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_PPB_32);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 case 64:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_PPB_64);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 case 128:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_PPB_128);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 case 256:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_PPB_256);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+<br>
+ =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Unsupported =
NAND flash!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_free_irq(dev, prv-&gt;irq, mtd);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENXIO;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 dev_set_drvdata(dev, mtd);<br>
+<br>
+ =A0 =A0 =A0 /* Register device in MTD */<br>
+#ifdef CONFIG_MTD_PARTITIONS<br>
+ =A0 =A0 =A0 retval =3D parse_mtd_partitions(mtd, mpc5121_nfc_pprobes, &am=
p;parts, 0);<br>
+#ifdef CONFIG_MTD_OF_PARTS<br>
+ =A0 =A0 =A0 if (retval =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D of_mtd_parse_partitions(dev, dn, &=
amp;parts);<br>
+#endif<br>
+ =A0 =A0 =A0 if (retval &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Error parsin=
g MTD partitions!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_free_irq(dev, prv-&gt;irq, mtd);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (retval &gt; 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D add_mtd_partitions(mtd, parts, ret=
val);<br>
+ =A0 =A0 =A0 else<br>
+#endif<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D add_mtd_device(mtd);<br>
+<br>
+ =A0 =A0 =A0 if (retval) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Error adding=
 MTD device!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_free_irq(dev, prv-&gt;irq, mtd);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+error:<br>
+ =A0 =A0 =A0 mpc5121_nfc_free(dev, mtd);<br>
+ =A0 =A0 =A0 return retval;<br>
+}<br>
+<br>
+static int __exit mpc5121_nfc_remove(struct of_device *op)<br>
+{<br>
+ =A0 =A0 =A0 struct device *dev =3D &amp;op-&gt;dev;<br>
+ =A0 =A0 =A0 struct mtd_info *mtd =3D dev_get_drvdata(dev);<br>
+ =A0 =A0 =A0 struct nand_chip *chip =3D mtd-&gt;priv;<br>
+ =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip-&gt;priv;<br>
+<br>
+ =A0 =A0 =A0 nand_release(mtd);<br>
+ =A0 =A0 =A0 devm_free_irq(dev, prv-&gt;irq, mtd);<br>
+ =A0 =A0 =A0 mpc5121_nfc_free(dev, mtd);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static struct of_device_id mpc5121_nfc_match[] =3D {<br>
+ =A0 =A0 =A0 { .compatible =3D &quot;fsl,mpc5121-nfc&quot;, },<br>
+ =A0 =A0 =A0 {},<br>
+};<br>
+<br>
+static struct of_platform_driver mpc5121_nfc_driver =3D {<br>
+ =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,<br>
+ =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D DRV_NAME,<br>
+ =A0 =A0 =A0 .match_table =A0 =A0=3D mpc5121_nfc_match,<br>
+ =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D mpc5121_nfc_probe,<br>
+ =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(mpc5121_nfc_remove),<br>
+ =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D NULL,<br>
+ =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D NULL,<br>
+ =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRV_NAME,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,<br>
+ =A0 =A0 =A0 },<br>
+};<br>
+<br>
+static int __init mpc5121_nfc_init(void)<br>
+{<br>
+ =A0 =A0 =A0 if (of_register_platform_driver(&amp;mpc5121_nfc_driver) !=3D=
 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRV_NAME &quot;: Driver regis=
ter failed!\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static void __exit mpc5121_nfc_cleanup(void)<br>
+{<br>
+ =A0 =A0 =A0 of_unregister_platform_driver(&amp;mpc5121_nfc_driver);<br>
+}<br>
+<br>
+module_init(mpc5121_nfc_init);<br>
+module_exit(mpc5121_nfc_cleanup);<br>
+<br>
+MODULE_AUTHOR(&quot;Freescale Semiconductor, Inc.&quot;);<br>
+MODULE_DESCRIPTION(&quot;MPC5121 NAND MTD driver&quot;);<br>
+MODULE_LICENSE(&quot;GPL&quot;);<br>
+MODULE_VERSION(DRV_VERSION);<br>
<font color=3D"#888888">--<br>
1.6.0.6<br>
<br>
</font></blockquote></div><br>

--000e0cd1748839687704695e3f99--
