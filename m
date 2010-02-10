Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f181.google.com (mail-yx0-f181.google.com
	[209.85.210.181]) by ozlabs.org (Postfix) with ESMTP id D20F2B7D77
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 13:43:06 +1100 (EST)
Received: by yxe11 with SMTP id 11so784355yxe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 18:43:04 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265377377-29327-5-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-5-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 19:42:43 -0700
Message-ID: <fa686aa41002091842g6795bf68lb8b410d433cd7f31@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] mtd: Add MPC5121 NAND Flash Controller driver
To: Anatolij Gustschin <agust@denx.de>, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 6:42 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Adds NAND Flash Controller driver for MPC5121 Revision 2.
> All device features, except hardware ECC and power management,
> are supported.
>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: <linux-mtd@lists.infradead.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>

On *very* brief review...

Acked-by: Grant Likely <grant.likely@secretlab.ca>

David, there are ordering issues on this patch with arch-specific
code.  If the patch looks okay to you, then can I pick it up into my
tree?

Thanks,
g.

> ---
> Changes since v2:
> =A0- move the arch bits into separate patch
> =A0 (it is the next patch in this series now)
> =A0- use __devinit/__devexit/__devexit_p and __devinitdata
>
> Changes since v1:
> =A0- add logfile with changes since previous version
>
> Changes since the patch version submitted in May 2009:
>
> =A0- move mpc5121_nfc.h to the driver .c as there is only one user
> =A0- remove DRV_VERSION macro
> =A0- replace printk() by dev_*()
> =A0- drop unnecessary .suspend and .resume initializations
> =A0- remove duplicate .name/.owner settings
> =A0- fix mpc5121_nfc_init() to "return of_register_platform_driver(&mpc51=
21_nfc_driver);"
> =A0- move module_init() to just below the init function
> =A0- remove MODULE_VERSION
> =A0- use "mtd: Add MPC5121 NAND Flash Controller driver" as the subject,
> =A0 previously it was "mpc5121: Added NAND Flash Controller driver."
>
> =A0drivers/mtd/nand/Kconfig =A0 =A0 =A0 | =A0 =A07 +
> =A0drivers/mtd/nand/Makefile =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/mtd/nand/mpc5121_nfc.c | =A0916 ++++++++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 924 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/mtd/nand/mpc5121_nfc.c
>
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 677cd53..099f002 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -442,6 +442,13 @@ config MTD_NAND_FSL_UPM
> =A0 =A0 =A0 =A0 =A0Enables support for NAND Flash chips wired onto Freesc=
ale PowerPC
> =A0 =A0 =A0 =A0 =A0processor localbus with User-Programmable Machine supp=
ort.
>
> +config MTD_NAND_MPC5121_NFC
> + =A0 =A0 =A0 tristate "MPC5121 built-in NAND Flash Controller support"
> + =A0 =A0 =A0 depends on PPC_MPC512x
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This enables the driver for the NAND flash controller o=
n the
> + =A0 =A0 =A0 =A0 MPC5121 SoC.
> +
> =A0config MTD_NAND_MXC
> =A0 =A0 =A0 =A0tristate "MXC NAND support"
> =A0 =A0 =A0 =A0depends on ARCH_MX2 || ARCH_MX3
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 1407bd1..d4ddf05 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -42,5 +42,6 @@ obj-$(CONFIG_MTD_NAND_TXX9NDFMC) =A0 =A0 =A0+=3D txx9nd=
fmc.o
> =A0obj-$(CONFIG_MTD_NAND_W90P910) =A0 =A0 =A0 =A0 +=3D w90p910_nand.o
> =A0obj-$(CONFIG_MTD_NAND_NOMADIK) =A0 =A0 =A0 =A0 +=3D nomadik_nand.o
> =A0obj-$(CONFIG_MTD_NAND_BCM_UMI) =A0 =A0 =A0 =A0 +=3D bcm_umi_nand.o nan=
d_bcm_umi.o
> +obj-$(CONFIG_MTD_NAND_MPC5121_NFC) =A0 =A0 +=3D mpc5121_nfc.o
>
> =A0nand-objs :=3D nand_base.o nand_bbt.o
> diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nf=
c.c
> new file mode 100644
> index 0000000..191bf99
> --- /dev/null
> +++ b/drivers/mtd/nand/mpc5121_nfc.c
> @@ -0,0 +1,916 @@
> +/*
> + * Copyright 2004-2008 Freescale Semiconductor, Inc.
> + * Copyright 2009 Semihalf.
> + *
> + * Approved as OSADL project by a majority of OSADL members and funded
> + * by OSADL membership fees in 2009; =A0for details see www.osadl.org.
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
> +#include <asm/mpc5xxx.h>
> +
> +/* Addresses for NFC MAIN RAM BUFFER areas */
> +#define NFC_MAIN_AREA(n) =A0 =A0 =A0 ((n) * =A00x200)
> +
> +/* Addresses for NFC SPARE BUFFER areas */
> +#define NFC_SPARE_BUFFERS =A0 =A0 =A08
> +#define NFC_SPARE_LEN =A0 =A0 =A0 =A0 =A00x40
> +#define NFC_SPARE_AREA(n) =A0 =A0 =A0(0x1000 + ((n) * NFC_SPARE_LEN))
> +
> +/* MPC5121 NFC registers */
> +#define NFC_BUF_ADDR =A0 =A0 =A0 =A0 =A0 0x1E04
> +#define NFC_FLASH_ADDR =A0 =A0 =A0 =A0 0x1E06
> +#define NFC_FLASH_CMD =A0 =A0 =A0 =A0 =A00x1E08
> +#define NFC_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 0x1E0A
> +#define NFC_ECC_STATUS1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1E0C
> +#define NFC_ECC_STATUS2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1E0E
> +#define NFC_SPAS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1E10
> +#define NFC_WRPROT =A0 =A0 =A0 =A0 =A0 =A0 0x1E12
> +#define NFC_NF_WRPRST =A0 =A0 =A0 =A0 =A00x1E18
> +#define NFC_CONFIG1 =A0 =A0 =A0 =A0 =A0 =A00x1E1A
> +#define NFC_CONFIG2 =A0 =A0 =A0 =A0 =A0 =A00x1E1C
> +#define NFC_UNLOCKSTART_BLK0 =A0 0x1E20
> +#define NFC_UNLOCKEND_BLK0 =A0 =A0 0x1E22
> +#define NFC_UNLOCKSTART_BLK1 =A0 0x1E24
> +#define NFC_UNLOCKEND_BLK1 =A0 =A0 0x1E26
> +#define NFC_UNLOCKSTART_BLK2 =A0 0x1E28
> +#define NFC_UNLOCKEND_BLK2 =A0 =A0 0x1E2A
> +#define NFC_UNLOCKSTART_BLK3 =A0 0x1E2C
> +#define NFC_UNLOCKEND_BLK3 =A0 =A0 0x1E2E
> +
> +/* Bit Definitions: NFC_BUF_ADDR */
> +#define NFC_RBA_MASK =A0 =A0 =A0 =A0 =A0 (7 << 0)
> +#define NFC_ACTIVE_CS_SHIFT =A0 =A05
> +#define NFC_ACTIVE_CS_MASK =A0 =A0 (3 << NFC_ACTIVE_CS_SHIFT)
> +
> +/* Bit Definitions: NFC_CONFIG */
> +#define NFC_BLS_UNLOCKED =A0 =A0 =A0 (1 << 1)
> +
> +/* Bit Definitions: NFC_CONFIG1 */
> +#define NFC_ECC_4BIT =A0 =A0 =A0 =A0 =A0 (1 << 0)
> +#define NFC_FULL_PAGE_DMA =A0 =A0 =A0(1 << 1)
> +#define NFC_SPARE_ONLY =A0 =A0 =A0 =A0 (1 << 2)
> +#define NFC_ECC_ENABLE =A0 =A0 =A0 =A0 (1 << 3)
> +#define NFC_INT_MASK =A0 =A0 =A0 =A0 =A0 (1 << 4)
> +#define NFC_BIG_ENDIAN =A0 =A0 =A0 =A0 (1 << 5)
> +#define NFC_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 6)
> +#define NFC_CE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 7)
> +#define NFC_ONE_CYCLE =A0 =A0 =A0 =A0 =A0(1 << 8)
> +#define NFC_PPB_32 =A0 =A0 =A0 =A0 =A0 =A0 (0 << 9)
> +#define NFC_PPB_64 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 9)
> +#define NFC_PPB_128 =A0 =A0 =A0 =A0 =A0 =A0(2 << 9)
> +#define NFC_PPB_256 =A0 =A0 =A0 =A0 =A0 =A0(3 << 9)
> +#define NFC_PPB_MASK =A0 =A0 =A0 =A0 =A0 (3 << 9)
> +#define NFC_FULL_PAGE_INT =A0 =A0 =A0(1 << 11)
> +
> +/* Bit Definitions: NFC_CONFIG2 */
> +#define NFC_COMMAND =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> +#define NFC_ADDRESS =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
> +#define NFC_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> +#define NFC_OUTPUT =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3)
> +#define NFC_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
> +#define NFC_STATUS =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5)
> +#define NFC_CMD_FAIL =A0 =A0 =A0 =A0 =A0 (1 << 15)
> +#define NFC_INT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 15)
> +
> +/* Bit Definitions: NFC_WRPROT */
> +#define NFC_WPC_LOCK_TIGHT =A0 =A0 (1 << 0)
> +#define NFC_WPC_LOCK =A0 =A0 =A0 =A0 =A0 (1 << 1)
> +#define NFC_WPC_UNLOCK =A0 =A0 =A0 =A0 (1 << 2)
> +
> +#define =A0 =A0 =A0 =A0DRV_NAME =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mpc5121_=
nfc"
> +
> +/* Timeouts */
> +#define NFC_RESET_TIMEOUT =A0 =A0 =A01000 =A0 =A0 =A0 =A0 =A0 =A0/* 1 ms=
 */
> +#define NFC_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0(HZ / 10) =A0 =A0 =A0 /* 1/10=
 s */
> +
> +struct mpc5121_nfc_prv {
> + =A0 =A0 =A0 struct mtd_info =A0 =A0 =A0 =A0 mtd;
> + =A0 =A0 =A0 struct nand_chip =A0 =A0 =A0 =A0chip;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*regs;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> + =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 irq_waitq;
> + =A0 =A0 =A0 uint =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0column;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spareonly;
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*csreg;
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
> +};
> +
> +static void mpc5121_nfc_done(struct mtd_info *mtd);
> +
> +#ifdef CONFIG_MTD_PARTITIONS
> +static const char *mpc5121_nfc_pprobes[] =3D { "cmdlinepart", NULL };
> +#endif
> +
> +/* Read NFC register */
> +static inline u16 nfc_read(struct mtd_info *mtd, uint reg)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> +
> + =A0 =A0 =A0 return in_be16(prv->regs + reg);
> +}
> +
> +/* Write NFC register */
> +static inline void nfc_write(struct mtd_info *mtd, uint reg, u16 val)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> +
> + =A0 =A0 =A0 out_be16(prv->regs + reg, val);
> +}
> +
> +/* Set bits in NFC register */
> +static inline void nfc_set(struct mtd_info *mtd, uint reg, u16 bits)
> +{
> + =A0 =A0 =A0 nfc_write(mtd, reg, nfc_read(mtd, reg) | bits);
> +}
> +
> +/* Clear bits in NFC register */
> +static inline void nfc_clear(struct mtd_info *mtd, uint reg, u16 bits)
> +{
> + =A0 =A0 =A0 nfc_write(mtd, reg, nfc_read(mtd, reg) & ~bits);
> +}
> +
> +/* Invoke address cycle */
> +static inline void mpc5121_nfc_send_addr(struct mtd_info *mtd, u16 addr)
> +{
> + =A0 =A0 =A0 nfc_write(mtd, NFC_FLASH_ADDR, addr);
> + =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_ADDRESS);
> + =A0 =A0 =A0 mpc5121_nfc_done(mtd);
> +}
> +
> +/* Invoke command cycle */
> +static inline void mpc5121_nfc_send_cmd(struct mtd_info *mtd, u16 cmd)
> +{
> + =A0 =A0 =A0 nfc_write(mtd, NFC_FLASH_CMD, cmd);
> + =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_COMMAND);
> + =A0 =A0 =A0 mpc5121_nfc_done(mtd);
> +}
> +
> +/* Send data from NFC buffers to NAND flash */
> +static inline void mpc5121_nfc_send_prog_page(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);
> + =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_INPUT);
> + =A0 =A0 =A0 mpc5121_nfc_done(mtd);
> +}
> +
> +/* Receive data from NAND flash */
> +static inline void mpc5121_nfc_send_read_page(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);
> + =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_OUTPUT);
> + =A0 =A0 =A0 mpc5121_nfc_done(mtd);
> +}
> +
> +/* Receive ID from NAND flash */
> +static inline void mpc5121_nfc_send_read_id(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);
> + =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_ID);
> + =A0 =A0 =A0 mpc5121_nfc_done(mtd);
> +}
> +
> +/* Receive status from NAND flash */
> +static inline void mpc5121_nfc_send_read_status(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 nfc_clear(mtd, NFC_BUF_ADDR, NFC_RBA_MASK);
> + =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG2, NFC_STATUS);
> + =A0 =A0 =A0 mpc5121_nfc_done(mtd);
> +}
> +
> +/* NFC interrupt handler */
> +static irqreturn_t mpc5121_nfc_irq(int irq, void *data)
> +{
> + =A0 =A0 =A0 struct mtd_info *mtd =3D data;
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> +
> + =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_INT_MASK);
> + =A0 =A0 =A0 wake_up(&prv->irq_waitq);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +/* Wait for operation complete */
> +static void mpc5121_nfc_done(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> + =A0 =A0 =A0 int rv;
> +
> + =A0 =A0 =A0 if ((nfc_read(mtd, NFC_CONFIG2) & NFC_INT) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_clear(mtd, NFC_CONFIG1, NFC_INT_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rv =3D wait_event_timeout(prv->irq_waitq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (nfc_read(mtd, NFC_CONFIG2)=
 & NFC_INT), NFC_TIMEOUT);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(prv->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Timeout wh=
ile waiting for interrupt.\n");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 nfc_clear(mtd, NFC_CONFIG2, NFC_INT);
> +}
> +
> +/* Do address cycle(s) */
> +static void mpc5121_nfc_addr_cycle(struct mtd_info *mtd, int column, int=
 page)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 u32 pagemask =3D chip->pagemask;
> +
> + =A0 =A0 =A0 if (column !=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_addr(mtd, column);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mtd->writesize > 512)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_addr(mtd, =
column >> 8);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (page !=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_addr(mtd, =
page & 0xFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 page >>=3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pagemask >>=3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (pagemask);
> + =A0 =A0 =A0 }
> +}
> +
> +/* Control chip select signals */
> +static void mpc5121_nfc_select_chip(struct mtd_info *mtd, int chip)
> +{
> + =A0 =A0 =A0 if (chip < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_clear(mtd, NFC_CONFIG1, NFC_CE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 nfc_clear(mtd, NFC_BUF_ADDR, NFC_ACTIVE_CS_MASK);
> + =A0 =A0 =A0 nfc_set(mtd, NFC_BUF_ADDR, (chip << NFC_ACTIVE_CS_SHIFT) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NFC_ACTIVE_CS_MASK);
> + =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_CE);
> +}
> +
> +/* Init external chip select logic on ADS5121 board */
> +static int ads5121_chipselect_init(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> + =A0 =A0 =A0 struct device_node *dn;
> +
> + =A0 =A0 =A0 dn =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121ads-=
cpld");
> + =A0 =A0 =A0 if (dn) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv->csreg =3D of_iomap(dn, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(dn);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!prv->csreg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* CPLD Register 9 controls NAND /CE Lines =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv->csreg +=3D 9;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +/* Control chips select signal on ADS5121 board */
> +static void ads5121_select_chip(struct mtd_info *mtd, int chip)
> +{
> + =A0 =A0 =A0 struct nand_chip *nand =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D nand->priv;
> + =A0 =A0 =A0 u8 v;
> +
> + =A0 =A0 =A0 v =3D in_8(prv->csreg);
> + =A0 =A0 =A0 v |=3D 0x0F;
> +
> + =A0 =A0 =A0 if (chip >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_select_chip(mtd, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v &=3D ~(1 << chip);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_select_chip(mtd, -1);
> +
> + =A0 =A0 =A0 out_8(prv->csreg, v);
> +}
> +
> +/* Read NAND Ready/Busy signal */
> +static int mpc5121_nfc_dev_ready(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* NFC handles ready/busy signal internally. Therefore, t=
his function
> + =A0 =A0 =A0 =A0* always returns status as ready.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/* Write command to NAND flash */
> +static void mpc5121_nfc_command(struct mtd_info *mtd, unsigned command,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int column, int page)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> +
> + =A0 =A0 =A0 prv->column =3D (column >=3D 0) ? column : 0;
> + =A0 =A0 =A0 prv->spareonly =3D 0;
> +
> + =A0 =A0 =A0 switch (command) {
> + =A0 =A0 =A0 case NAND_CMD_PAGEPROG:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_prog_page(mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* NFC does not support sub-page reads and writes,
> + =A0 =A0 =A0 =A0* so emulate them using full page transfers.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 case NAND_CMD_READ0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 column =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case NAND_CMD_READ1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv->column +=3D 256;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 command =3D NAND_CMD_READ0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 column =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case NAND_CMD_READOOB:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv->spareonly =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 command =3D NAND_CMD_READ0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 column =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case NAND_CMD_SEQIN:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_command(mtd, NAND_CMD_READ0, co=
lumn, page);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 column =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case NAND_CMD_ERASE1:
> + =A0 =A0 =A0 case NAND_CMD_ERASE2:
> + =A0 =A0 =A0 case NAND_CMD_READID:
> + =A0 =A0 =A0 case NAND_CMD_STATUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mpc5121_nfc_send_cmd(mtd, command);
> + =A0 =A0 =A0 mpc5121_nfc_addr_cycle(mtd, column, page);
> +
> + =A0 =A0 =A0 switch (command) {
> + =A0 =A0 =A0 case NAND_CMD_READ0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mtd->writesize > 512)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_cmd(mtd, N=
AND_CMD_READSTART);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_read_page(mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case NAND_CMD_READID:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_read_id(mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case NAND_CMD_STATUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_send_read_status(mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chip->options & NAND_BUSWIDTH_16)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv->column =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv->column =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +}
> +
> +/* Copy data from/to NFC spare buffers. */
> +static void mpc5121_nfc_copy_spare(struct mtd_info *mtd, uint offset,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 u8 *buffer, uint size, int wr)
> +{
> + =A0 =A0 =A0 struct nand_chip *nand =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D nand->priv;
> + =A0 =A0 =A0 uint o, s, sbsize, blksize;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* NAND spare area is available through NFC spare buffers=
.
> + =A0 =A0 =A0 =A0* The NFC divides spare area into (page_size / 512) chun=
ks.
> + =A0 =A0 =A0 =A0* Each chunk is placed into separate spare memory area, =
using
> + =A0 =A0 =A0 =A0* first (spare_size / num_of_chunks) bytes of the buffer=
.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* For NAND device in which the spare area is not divided=
 fully
> + =A0 =A0 =A0 =A0* by the number of chunks, number of used bytes in each =
spare
> + =A0 =A0 =A0 =A0* buffer is rounded down to the nearest even number of b=
ytes,
> + =A0 =A0 =A0 =A0* and all remaining bytes are added to the last used spa=
re area.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* For more information read section 26.6.10 of MPC5121e
> + =A0 =A0 =A0 =A0* Microcontroller Reference Manual, Rev. 3.
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 /* Calculate number of valid bytes in each spare buffer */
> + =A0 =A0 =A0 sbsize =3D (mtd->oobsize / (mtd->writesize / 512)) & ~1;
> +
> + =A0 =A0 =A0 while (size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Calculate spare buffer number */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D offset / sbsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s > NFC_SPARE_BUFFERS - 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s =3D NFC_SPARE_BUFFERS - 1=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Calculate offset to requested data blo=
ck in selected spare
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* buffer and its size.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 o =3D offset - (s * sbsize);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blksize =3D min(sbsize - o, size);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy_toio(prv->regs + NFC=
_SPARE_AREA(s) + o,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buffer, blksize);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy_fromio(buffer,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv->regs +=
 NFC_SPARE_AREA(s) + o, blksize);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buffer +=3D blksize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset +=3D blksize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size -=3D blksize;
> + =A0 =A0 =A0 };
> +}
> +
> +/* Copy data from/to NFC main and spare buffers */
> +static void mpc5121_nfc_buf_copy(struct mtd_info *mtd, u_char *buf, int =
len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int wr=
)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> + =A0 =A0 =A0 uint c =3D prv->column;
> + =A0 =A0 =A0 uint l;
> +
> + =A0 =A0 =A0 /* Handle spare area access */
> + =A0 =A0 =A0 if (prv->spareonly || c >=3D mtd->writesize) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Calculate offset from beginning of spare=
 area */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (c >=3D mtd->writesize)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c -=3D mtd->writesize;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prv->column +=3D len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_copy_spare(mtd, c, buf, len, wr=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Handle main area access - limit copy length to prevent
> + =A0 =A0 =A0 =A0* crossing main/spare boundary.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 l =3D min((uint)len, mtd->writesize - c);
> + =A0 =A0 =A0 prv->column +=3D l;
> +
> + =A0 =A0 =A0 if (wr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy_toio(prv->regs + NFC_MAIN_AREA(0) + =
c, buf, l);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy_fromio(buf, prv->regs + NFC_MAIN_ARE=
A(0) + c, l);
> +
> + =A0 =A0 =A0 /* Handle crossing main/spare boundary */
> + =A0 =A0 =A0 if (l !=3D len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf +=3D l;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D l;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_buf_copy(mtd, buf, len, wr);
> + =A0 =A0 =A0 }
> +}
> +
> +/* Read data from NFC buffers */
> +static void mpc5121_nfc_read_buf(struct mtd_info *mtd, u_char *buf, int =
len)
> +{
> + =A0 =A0 =A0 mpc5121_nfc_buf_copy(mtd, buf, len, 0);
> +}
> +
> +/* Write data to NFC buffers */
> +static void mpc5121_nfc_write_buf(struct mtd_info *mtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 const u_char *buf, int len)
> +{
> + =A0 =A0 =A0 mpc5121_nfc_buf_copy(mtd, (u_char *)buf, len, 1);
> +}
> +
> +/* Compare buffer with NAND flash */
> +static int mpc5121_nfc_verify_buf(struct mtd_info *mtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 const u_char *buf, int len)
> +{
> + =A0 =A0 =A0 u_char tmp[256];
> + =A0 =A0 =A0 uint bsize;
> +
> + =A0 =A0 =A0 while (len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bsize =3D min(len, 256);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc5121_nfc_read_buf(mtd, tmp, bsize);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memcmp(buf, tmp, bsize))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf +=3D bsize;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D bsize;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* Read byte from NFC buffers */
> +static u8 mpc5121_nfc_read_byte(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 u8 tmp;
> +
> + =A0 =A0 =A0 mpc5121_nfc_read_buf(mtd, &tmp, sizeof(tmp));
> +
> + =A0 =A0 =A0 return tmp;
> +}
> +
> +/* Read word from NFC buffers */
> +static u16 mpc5121_nfc_read_word(struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 u16 tmp;
> +
> + =A0 =A0 =A0 mpc5121_nfc_read_buf(mtd, (u_char *)&tmp, sizeof(tmp));
> +
> + =A0 =A0 =A0 return tmp;
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
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> + =A0 =A0 =A0 struct mpc512x_reset_module *rm;
> + =A0 =A0 =A0 struct device_node *rmnode;
> + =A0 =A0 =A0 uint rcw_pagesize =3D 0;
> + =A0 =A0 =A0 uint rcw_sparesize =3D 0;
> + =A0 =A0 =A0 uint rcw_width;
> + =A0 =A0 =A0 uint rcwh;
> + =A0 =A0 =A0 uint romloc, ps;
> +
> + =A0 =A0 =A0 rmnode =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121=
-reset");
> + =A0 =A0 =A0 if (!rmnode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(prv->dev, "Missing 'fsl,mpc5121-res=
et' "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "node in device tree!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rm =3D of_iomap(rmnode, 0);
> + =A0 =A0 =A0 if (!rm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(prv->dev, "Error mapping reset modu=
le node!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rcwh =3D in_be32(&rm->rcwhr);
> +
> + =A0 =A0 =A0 /* Bit 6: NFC bus width */
> + =A0 =A0 =A0 rcw_width =3D ((rcwh >> 6) & 0x1) ? 2 : 1;
> +
> + =A0 =A0 =A0 /* Bit 7: NFC Page/Spare size */
> + =A0 =A0 =A0 ps =3D (rcwh >> 7) & 0x1;
> +
> + =A0 =A0 =A0 /* Bits [22:21]: ROM Location */
> + =A0 =A0 =A0 romloc =3D (rcwh >> 21) & 0x3;
> +
> + =A0 =A0 =A0 /* Decode RCW bits */
> + =A0 =A0 =A0 switch ((ps << 2) | romloc) {
> + =A0 =A0 =A0 case 0x00:
> + =A0 =A0 =A0 case 0x01:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_pagesize =3D 512;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_sparesize =3D 16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 0x02:
> + =A0 =A0 =A0 case 0x03:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_pagesize =3D 4096;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_sparesize =3D 128;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 0x04:
> + =A0 =A0 =A0 case 0x05:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_pagesize =3D 2048;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_sparesize =3D 64;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 0x06:
> + =A0 =A0 =A0 case 0x07:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_pagesize =3D 4096;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_sparesize =3D 218;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mtd->writesize =3D rcw_pagesize;
> + =A0 =A0 =A0 mtd->oobsize =3D rcw_sparesize;
> + =A0 =A0 =A0 if (rcw_width =3D=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->options |=3D NAND_BUSWIDTH_16;
> +
> + =A0 =A0 =A0 dev_notice(prv->dev, "Configured for "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%u-bit NAN=
D, page size %u "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "with %u sp=
are.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_width *=
 8, rcw_pagesize,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcw_sparesi=
ze);
> + =A0 =A0 =A0 iounmap(rm);
> + =A0 =A0 =A0 of_node_put(rmnode);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* Free driver resources */
> +static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
> +{
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> +
> + =A0 =A0 =A0 if (prv->clk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(prv->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(prv->clk);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (prv->csreg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(prv->csreg);
> +}
> +
> +static int __devinit mpc5121_nfc_probe(struct of_device *op,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct of_device_id *match)
> +{
> + =A0 =A0 =A0 struct device_node *rootnode, *dn =3D op->node;
> + =A0 =A0 =A0 struct device *dev =3D &op->dev;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv;
> + =A0 =A0 =A0 struct resource res;
> + =A0 =A0 =A0 struct mtd_info *mtd;
> +#ifdef CONFIG_MTD_PARTITIONS
> + =A0 =A0 =A0 struct mtd_partition *parts;
> +#endif
> + =A0 =A0 =A0 struct nand_chip *chip;
> + =A0 =A0 =A0 unsigned long regs_paddr, regs_size;
> + =A0 =A0 =A0 const uint *chips_no;
> + =A0 =A0 =A0 int resettime =3D 0;
> + =A0 =A0 =A0 int retval =3D 0;
> + =A0 =A0 =A0 int rev, len;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Check SoC revision. This driver supports only NFC
> + =A0 =A0 =A0 =A0* in MPC5121 revision 2.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 rev =3D (mfspr(SPRN_SVR) >> 4) & 0xF;
> + =A0 =A0 =A0 if (rev !=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "SoC revision %u is not suppor=
ted!\n", rev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 prv =3D devm_kzalloc(dev, sizeof(*prv), GFP_KERNEL);
> + =A0 =A0 =A0 if (!prv) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Memory exhausted!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mtd =3D &prv->mtd;
> + =A0 =A0 =A0 chip =3D &prv->chip;
> +
> + =A0 =A0 =A0 mtd->priv =3D chip;
> + =A0 =A0 =A0 chip->priv =3D prv;
> + =A0 =A0 =A0 prv->dev =3D dev;
> +
> + =A0 =A0 =A0 /* Read NFC configuration from Reset Config Word */
> + =A0 =A0 =A0 retval =3D mpc5121_nfc_read_hw_config(mtd);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Unable to read NFC config!\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 prv->irq =3D irq_of_parse_and_map(dn, 0);
> + =A0 =A0 =A0 if (prv->irq =3D=3D NO_IRQ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error mapping IRQ!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D of_address_to_resource(dn, 0, &res);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error parsing memory region!\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 chips_no =3D of_get_property(dn, "chips", &len);
> + =A0 =A0 =A0 if (!chips_no || len !=3D sizeof(*chips_no)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Invalid/missing 'chips' prope=
rty!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 regs_paddr =3D res.start;
> + =A0 =A0 =A0 regs_size =3D res.end - res.start + 1;
> +
> + =A0 =A0 =A0 if (!devm_request_mem_region(dev, regs_paddr, regs_size, DR=
V_NAME)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error requesting memory regio=
n!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 prv->regs =3D devm_ioremap(dev, regs_paddr, regs_size);
> + =A0 =A0 =A0 if (!prv->regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error mapping memory region!\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mtd->name =3D "MPC5121 NAND";
> + =A0 =A0 =A0 chip->dev_ready =3D mpc5121_nfc_dev_ready;
> + =A0 =A0 =A0 chip->cmdfunc =3D mpc5121_nfc_command;
> + =A0 =A0 =A0 chip->read_byte =3D mpc5121_nfc_read_byte;
> + =A0 =A0 =A0 chip->read_word =3D mpc5121_nfc_read_word;
> + =A0 =A0 =A0 chip->read_buf =3D mpc5121_nfc_read_buf;
> + =A0 =A0 =A0 chip->write_buf =3D mpc5121_nfc_write_buf;
> + =A0 =A0 =A0 chip->verify_buf =3D mpc5121_nfc_verify_buf;
> + =A0 =A0 =A0 chip->select_chip =3D mpc5121_nfc_select_chip;
> + =A0 =A0 =A0 chip->options =3D NAND_NO_AUTOINCR | NAND_USE_FLASH_BBT;
> + =A0 =A0 =A0 chip->ecc.mode =3D NAND_ECC_SOFT;
> +
> + =A0 =A0 =A0 /* Support external chip-select logic on ADS5121 board */
> + =A0 =A0 =A0 rootnode =3D of_find_node_by_path("/");
> + =A0 =A0 =A0 if (of_device_is_compatible(rootnode, "fsl,mpc5121ads")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D ads5121_chipselect_init(mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Chipselect in=
it error!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(rootnode);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->select_chip =3D ads5121_select_chip;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 of_node_put(rootnode);
> +
> + =A0 =A0 =A0 /* Enable NFC clock */
> + =A0 =A0 =A0 prv->clk =3D clk_get(dev, "nfc_clk");
> + =A0 =A0 =A0 if (!prv->clk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Unable to acquire NFC clock!\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk_enable(prv->clk);
> +
> + =A0 =A0 =A0 /* Reset NAND Flash controller */
> + =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_RESET);
> + =A0 =A0 =A0 while (nfc_read(mtd, NFC_CONFIG1) & NFC_RESET) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (resettime++ >=3D NFC_RESET_TIMEOUT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Timeout while=
 resetting NFC!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Enable write to NFC memory */
> + =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG, NFC_BLS_UNLOCKED);
> +
> + =A0 =A0 =A0 /* Enable write to all NAND pages */
> + =A0 =A0 =A0 nfc_write(mtd, NFC_UNLOCKSTART_BLK0, 0x0000);
> + =A0 =A0 =A0 nfc_write(mtd, NFC_UNLOCKEND_BLK0, 0xFFFF);
> + =A0 =A0 =A0 nfc_write(mtd, NFC_WRPROT, NFC_WPC_UNLOCK);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Setup NFC:
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0- Big Endian transfers,
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0- Interrupt after full page read/write.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 nfc_write(mtd, NFC_CONFIG1, NFC_BIG_ENDIAN | NFC_INT_MASK |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NFC_FULL_PAGE_INT);
> +
> + =A0 =A0 =A0 /* Set spare area size */
> + =A0 =A0 =A0 nfc_write(mtd, NFC_SPAS, mtd->oobsize >> 1);
> +
> + =A0 =A0 =A0 init_waitqueue_head(&prv->irq_waitq);
> + =A0 =A0 =A0 retval =3D devm_request_irq(dev, prv->irq, &mpc5121_nfc_irq=
, 0, DRV_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mtd);
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error requesting IRQ!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Detect NAND chips */
> + =A0 =A0 =A0 if (nand_scan(mtd, *chips_no)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "NAND Flash not found !\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_free_irq(dev, prv->irq, mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set erase block size */
> + =A0 =A0 =A0 switch (mtd->erasesize / mtd->writesize) {
> + =A0 =A0 =A0 case 32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_PPB_32);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case 64:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_PPB_64);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case 128:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_PPB_128);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case 256:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nfc_set(mtd, NFC_CONFIG1, NFC_PPB_256);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Unsupported NAND flash!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_free_irq(dev, prv->irq, mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_set_drvdata(dev, mtd);
> +
> + =A0 =A0 =A0 /* Register device in MTD */
> +#ifdef CONFIG_MTD_PARTITIONS
> + =A0 =A0 =A0 retval =3D parse_mtd_partitions(mtd, mpc5121_nfc_pprobes, &=
parts, 0);
> +#ifdef CONFIG_MTD_OF_PARTS
> + =A0 =A0 =A0 if (retval =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D of_mtd_parse_partitions(dev, dn,=
 &parts);
> +#endif
> + =A0 =A0 =A0 if (retval < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error parsing MTD partitions!=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_free_irq(dev, prv->irq, mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (retval > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D add_mtd_partitions(mtd, parts, r=
etval);
> + =A0 =A0 =A0 else
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D add_mtd_device(mtd);
> +
> + =A0 =A0 =A0 if (retval) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error adding MTD device!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_free_irq(dev, prv->irq, mtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +error:
> + =A0 =A0 =A0 mpc5121_nfc_free(dev, mtd);
> + =A0 =A0 =A0 return retval;
> +}
> +
> +static int __devexit mpc5121_nfc_remove(struct of_device *op)
> +{
> + =A0 =A0 =A0 struct device *dev =3D &op->dev;
> + =A0 =A0 =A0 struct mtd_info *mtd =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct nand_chip *chip =3D mtd->priv;
> + =A0 =A0 =A0 struct mpc5121_nfc_prv *prv =3D chip->priv;
> +
> + =A0 =A0 =A0 nand_release(mtd);
> + =A0 =A0 =A0 devm_free_irq(dev, prv->irq, mtd);
> + =A0 =A0 =A0 mpc5121_nfc_free(dev, mtd);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct of_device_id mpc5121_nfc_match[] __devinitdata =3D {
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-nfc", },
> + =A0 =A0 =A0 {},
> +};
> +
> +static struct of_platform_driver mpc5121_nfc_driver =3D {
> + =A0 =A0 =A0 .match_table =A0 =A0=3D mpc5121_nfc_match,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D mpc5121_nfc_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(mpc5121_nfc_remove)=
,
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRV_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init mpc5121_nfc_init(void)
> +{
> + =A0 =A0 =A0 return of_register_platform_driver(&mpc5121_nfc_driver);
> +}
> +
> +module_init(mpc5121_nfc_init);
> +
> +static void __exit mpc5121_nfc_cleanup(void)
> +{
> + =A0 =A0 =A0 of_unregister_platform_driver(&mpc5121_nfc_driver);
> +}
> +
> +module_exit(mpc5121_nfc_cleanup);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_DESCRIPTION("MPC5121 NAND MTD driver");
> +MODULE_LICENSE("GPL");
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
