Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f173.google.com (mail-iw0-f173.google.com
	[209.85.223.173]) by ozlabs.org (Postfix) with ESMTP id EBD0CB7BE3
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 12:25:31 +1000 (EST)
Received: by iwn3 with SMTP id 3so336142iwn.17
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Sep 2009 19:25:29 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090929204248.16225.22818.stgit@riker>
References: <20090929204248.16225.22818.stgit@riker>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 29 Sep 2009 20:25:09 -0600
Message-ID: <fa686aa40909291925r2ffc4e09o49efebfc5e702402@mail.gmail.com>
Subject: Re: [PATCH] powerpc/5200: add LocalPlus bus FIFO device driver
To: John Bonesio <bones@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 29, 2009 at 2:43 PM, John Bonesio <bones@secretlab.ca> wrote:
> This is a driver for the FIFO device on the LocalPlus bus on an mpc5200 s=
ystem.
> The driver supports programmed I/O through the FIFO as well as setting up=
 DMA
> via the BestComm engine through the FIFO.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: John Bonesio <bones@secretlab.ca>

Let me know if anyone has comments on this.  Since it is a new driver,
I'll probably try to merge it for 2.6.32 in the next week or so even
though the merge window has closed.

Cheers,
g.

> ---
> This driver was originally written by Grant Likely. I have updated it so =
that
> transmitting data (as opposed to receiving data) works better. The driver=
 has
> been tested for all 6 transfer modes:
> =A0 =A0 =A0 =A0PIO mode (rx and tx)
> =A0 =A0 =A0 =A0DMA polled mode (rx and tx)
> =A0 =A0 =A0 =A0DMA interrupt mode (rx and tx)
>
> - John
>
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 39 ++
> =A0arch/powerpc/platforms/52xx/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A05
> =A0arch/powerpc/platforms/52xx/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0560 +++++++++++++++=
++++++++++
> =A04 files changed, 605 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
>
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/as=
m/mpc52xx.h
> index 8273357..819a0be 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -282,6 +282,45 @@ extern int mpc52xx_gpt_start_timer(struct mpc52xx_gp=
t_priv *gpt, int period,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int continuous);
> =A0extern void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
>
> +/* mpc52xx_lpbfifo.c */
> +#define MPC52XX_LPBFIFO_FLAG_READ =A0 =A0 =A0 =A0 =A0 =A0 =A0(0)
> +#define MPC52XX_LPBFIFO_FLAG_WRITE =A0 =A0 =A0 =A0 =A0 =A0 (1<<0)
> +#define MPC52XX_LPBFIFO_FLAG_NO_INCREMENT =A0 =A0 =A0(1<<1)
> +#define MPC52XX_LPBFIFO_FLAG_NO_DMA =A0 =A0 =A0 =A0 =A0 =A0(1<<2)
> +#define MPC52XX_LPBFIFO_FLAG_POLL_DMA =A0 =A0 =A0 =A0 =A0(1<<3)
> +
> +struct mpc52xx_lpbfifo_request {
> + =A0 =A0 =A0 struct list_head list;
> +
> + =A0 =A0 =A0 /* localplus bus address */
> + =A0 =A0 =A0 unsigned int cs;
> + =A0 =A0 =A0 size_t offset;
> +
> + =A0 =A0 =A0 /* Memory address */
> + =A0 =A0 =A0 void *data;
> + =A0 =A0 =A0 phys_addr_t data_phys;
> +
> + =A0 =A0 =A0 /* Details of transfer */
> + =A0 =A0 =A0 size_t size;
> + =A0 =A0 =A0 size_t pos; =A0 =A0 /* current position of transfer */
> + =A0 =A0 =A0 int flags;
> +
> + =A0 =A0 =A0 /* What to do when finished */
> + =A0 =A0 =A0 void (*callback)(struct mpc52xx_lpbfifo_request *);
> +
> + =A0 =A0 =A0 void *priv; =A0 =A0 =A0 =A0 =A0 =A0 /* Driver private data =
*/
> +
> + =A0 =A0 =A0 /* statistics */
> + =A0 =A0 =A0 int irq_count;
> + =A0 =A0 =A0 int irq_ticks;
> + =A0 =A0 =A0 u8 last_byte;
> + =A0 =A0 =A0 int buffer_not_done_cnt;
> +};
> +
> +extern int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req);
> +extern void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req);
> +extern void mpc52xx_lpbfifo_poll(void);
> +
> =A0/* mpc52xx_pic.c */
> =A0extern void mpc52xx_init_irq(void);
> =A0extern unsigned int mpc52xx_get_irq(void);
> diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms=
/52xx/Kconfig
> index 696a5ee..ea00b3d 100644
> --- a/arch/powerpc/platforms/52xx/Kconfig
> +++ b/arch/powerpc/platforms/52xx/Kconfig
> @@ -51,3 +51,8 @@ config PPC_MPC5200_GPIO
> =A0 =A0 =A0 =A0select GENERIC_GPIO
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Enable gpiolib support for mpc5200 based boards
> +
> +config PPC_MPC5200_LPBFIFO
> + =A0 =A0 =A0 tristate "MPC5200 LocalPlus bus FIFO driver"
> + =A0 =A0 =A0 depends on PPC_MPC52xx
> + =A0 =A0 =A0 select PPC_BESTCOMM_GEN_BD
> diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platform=
s/52xx/Makefile
> index d6ade3d..8df23af 100644
> --- a/arch/powerpc/platforms/52xx/Makefile
> +++ b/arch/powerpc/platforms/52xx/Makefile
> @@ -14,3 +14,4 @@ ifeq ($(CONFIG_PPC_LITE5200),y)
> =A0endif
>
> =A0obj-$(CONFIG_PPC_MPC5200_GPIO) +=3D mpc52xx_gpio.o
> +obj-$(CONFIG_PPC_MPC5200_LPBFIFO) =A0 =A0 =A0+=3D mpc52xx_lpbfifo.o
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> new file mode 100644
> index 0000000..929d017
> --- /dev/null
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -0,0 +1,560 @@
> +/*
> + * LocalPlus Bus FIFO driver for the Freescale MPC52xx.
> + *
> + * Copyright (C) 2009 Secret Lab Technologies Ltd.
> + *
> + * This file is released under the GPLv2
> + *
> + * Todo:
> + * - Add support for multiple requests to be queued.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/spinlock.h>
> +#include <asm/io.h>
> +#include <asm/prom.h>
> +#include <asm/mpc52xx.h>
> +#include <asm/time.h>
> +
> +#include <sysdev/bestcomm/bestcomm.h>
> +#include <sysdev/bestcomm/bestcomm_priv.h>
> +#include <sysdev/bestcomm/gen_bd.h>
> +
> +MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
> +MODULE_DESCRIPTION("MPC5200 LocalPlus FIFO device driver");
> +MODULE_LICENSE("GPL");
> +
> +#define LPBFIFO_REG_PACKET_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x00)
> +#define LPBFIFO_REG_START_ADDRESS =A0 =A0 =A0(0x04)
> +#define LPBFIFO_REG_CONTROL =A0 =A0 =A0 =A0 =A0 =A0(0x08)
> +#define LPBFIFO_REG_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 (0x0C)
> +#define LPBFIFO_REG_BYTES_DONE_STATUS =A0(0x14)
> +#define LPBFIFO_REG_FIFO_DATA =A0 =A0 =A0 =A0 =A0(0x40)
> +#define LPBFIFO_REG_FIFO_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x44)
> +#define LPBFIFO_REG_FIFO_CONTROL =A0 =A0 =A0 (0x48)
> +#define LPBFIFO_REG_FIFO_ALARM =A0 =A0 =A0 =A0 (0x4C)
> +
> +struct mpc52xx_lpbfifo {
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 phys_addr_t regs_phys;
> + =A0 =A0 =A0 void __iomem *regs;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 spinlock_t lock;
> +
> + =A0 =A0 =A0 struct bcom_task *bcom_tx_task;
> + =A0 =A0 =A0 struct bcom_task *bcom_rx_task;
> + =A0 =A0 =A0 struct bcom_task *bcom_cur_task;
> +
> + =A0 =A0 =A0 /* Current state data */
> + =A0 =A0 =A0 struct mpc52xx_lpbfifo_request *req;
> + =A0 =A0 =A0 int dma_irqs_enabled;
> +};
> +
> +/* The MPC5200 has only one fifo, so only need one instance structure */
> +static struct mpc52xx_lpbfifo lpbfifo;
> +
> +/**
> + * mpc52xx_lpbfifo_kick - Trigger the next block of data to be transfere=
d
> + */
> +static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo_request *req)
> +{
> + =A0 =A0 =A0 size_t transfer_size =3D req->size - req->pos;
> + =A0 =A0 =A0 struct bcom_bd *bd;
> + =A0 =A0 =A0 void __iomem *reg;
> + =A0 =A0 =A0 u32 *data;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int bit_fields;
> + =A0 =A0 =A0 int dma =3D !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
> + =A0 =A0 =A0 int write =3D req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
> + =A0 =A0 =A0 int poll_dma =3D req->flags & MPC52XX_LPBFIFO_FLAG_POLL_DMA=
;
> +
> + =A0 =A0 =A0 /* Set and clear the reset bits; is good practice in User M=
anual */
> + =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
> +
> + =A0 =A0 =A0 /* set master enable bit */
> + =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x00000001);
> + =A0 =A0 =A0 if (!dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* While the FIFO can be setup for transfer=
 sizes as large as
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 16M-1, the FIFO itself is only 512 byt=
es deep and it does
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* not generate interrupts for FIFO full =
events (only transfer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* complete will raise an IRQ). =A0Theref=
ore when not using
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Bestcomm to drive the FIFO it needs to=
 either be polled, or
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* transfers need to constrained to the s=
ize of the fifo.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This driver restricts the size of the =
transfer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (transfer_size > 512)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 transfer_size =3D 512;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Load the FIFO with data */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D lpbfifo.regs + LPBF=
IFO_REG_FIFO_DATA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D req->data + req->p=
os;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < transfer_=
size; i +=3D 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(re=
g, *data++);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Unmask both error and completion irqs */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE,=
 0x00000301);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Choose the correct direction
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Configure the watermarks so DMA will a=
lways complete correctly.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* It may be worth experimenting with the=
 ALARM value to see if
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* there is a performance impacit. =A0How=
ever, if it is wrong there
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is a risk of DMA not transferring the =
last chunk of data
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(lpbfifo.regs + LPB=
FIFO_REG_FIFO_ALARM, 0x1e4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(lpbfifo.regs + LPBFIF=
O_REG_FIFO_CONTROL, 7);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo.bcom_cur_task =3D l=
pbfifo.bcom_tx_task;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(lpbfifo.regs + LPB=
FIFO_REG_FIFO_ALARM, 0x1ff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(lpbfifo.regs + LPBFIF=
O_REG_FIFO_CONTROL, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo.bcom_cur_task =3D l=
pbfifo.bcom_rx_task;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (poll_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lpbfifo=
.dma_irqs_enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 disable_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 lpbfifo.dma_irqs_enabled =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!lpbfif=
o.dma_irqs_enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 enable_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 lpbfifo.dma_irqs_enabled =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd =3D bcom_prepare_next_buffer(lpbfifo.bco=
m_cur_task);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->status =3D transfer_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!write) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In the DMA read case, =
the DMA doesn't complete,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* possibly due to incorr=
ect watermarks in the ALARM
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and CONTROL regs. For =
now instead of trying to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* determine the right wa=
termarks that will make this
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* work, just increase th=
e number of bytes the FIFO is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* expecting.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* When submitting anothe=
r operation, the FIFO will get
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* reset, so the conditio=
n of the FIFO waiting for a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* non-existent 4 bytes w=
ill get cleared.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 transfer_size +=3D 4; /* BL=
ECH! */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->data[0] =3D req->data_phys + req->pos;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_submit_next_buffer(lpbfifo.bcom_cur_ta=
sk, NULL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* error irq & master enabled bit */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields =3D 0x00000201;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Unmask irqs */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write && (!poll_dma))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D 0x00000100;=
 /* completion irq too */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE,=
 bit_fields);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set transfer size, width, chip select and READ mode */
> + =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_START_ADDRESS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0req->offset + req->pos);
> + =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, transfer_s=
ize);
> +
> + =A0 =A0 =A0 bit_fields =3D req->cs << 24 | 0x000008;
> + =A0 =A0 =A0 if (!write)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D 0x010000; /* read mode */
> + =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_CONTROL, bit_fields);
> +
> + =A0 =A0 =A0 /* Kick it off */
> + =A0 =A0 =A0 out_8(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, 0x01);
> + =A0 =A0 =A0 if (dma)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_enable(lpbfifo.bcom_cur_task);
> +}
> +
> +/**
> + * mpc52xx_lpbfifo_irq - IRQ handler for LPB FIFO
> + *
> + * On transmit, the dma completion irq triggers before the fifo completi=
on
> + * triggers. =A0Handle the dma completion here instead of the LPB FIFO B=
estcomm
> + * task completion irq becuase everyting is not really done until the LP=
B FIFO
> + * completion irq triggers.
> + *
> + * In other words:
> + * For DMA, on receive, the "Fat Lady" is the bestcom completion irq. on
> + * transmit, the fifo completion irq is the "Fat Lady". The opera (or in=
 this
> + * case the DMA/FIFO operation) is not finished until the "Fat Lady" sin=
gs.
> + *
> + * Reasons for entering this routine:
> + * 1) PIO mode rx and tx completion irq
> + * 2) DMA interrupt mode tx completion irq
> + * 3) DMA polled mode tx
> + *
> + * Exit conditions:
> + * 1) Transfer aborted
> + * 2) FIFO complete without DMA; more data to do
> + * 3) FIFO complete without DMA; all data transfered
> + * 4) FIFO complete using DMA
> + *
> + * Condition 1 can occur regardless of whether or not DMA is used.
> + * It requires executing the callback to report the error and exiting
> + * immediately.
> + *
> + * Condition 2 requires programming the FIFO with the next block of data
> + *
> + * Condition 3 requires executing the callback to report completion
> + *
> + * Condition 4 means the same as 3, except that we also retrieve the bco=
m
> + * buffer so DMA doesn't get clogged up.
> + *
> + * To make things trickier, the spinlock must be dropped before
> + * executing the callback, otherwise we could end up with a deadlock
> + * or nested spinlock condition. =A0The out path is non-trivial, so
> + * extra fiddling is done to make sure all paths lead to the same
> + * outbound code.
> + */
> +static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct mpc52xx_lpbfifo_request *req;
> + =A0 =A0 =A0 u32 status =3D in_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_S=
TATUS);
> + =A0 =A0 =A0 void __iomem *reg;
> + =A0 =A0 =A0 u32 *data;
> + =A0 =A0 =A0 int count, i;
> + =A0 =A0 =A0 int do_callback =3D 0;
> + =A0 =A0 =A0 u32 ts;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int dma, write, poll_dma;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&lpbfifo.lock, flags);
> + =A0 =A0 =A0 ts =3D get_tbl();
> +
> + =A0 =A0 =A0 req =3D lpbfifo.req;
> + =A0 =A0 =A0 if (!req) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("bogus LPBFIFO IRQ\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dma =3D !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
> + =A0 =A0 =A0 write =3D req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
> + =A0 =A0 =A0 poll_dma =3D req->flags & MPC52XX_LPBFIFO_FLAG_POLL_DMA;
> +
> + =A0 =A0 =A0 if (dma && !write) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("bogus LPBFIFO IRQ (dma and not writ=
ting)\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if ((status & 0x01) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* check abort bit */
> + =A0 =A0 =A0 if (status & 0x10) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE,=
 0x01010000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_callback =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Read result from hardware */
> + =A0 =A0 =A0 count =3D in_be32(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STA=
TUS);
> + =A0 =A0 =A0 count &=3D 0x00ffffff;
> +
> + =A0 =A0 =A0 if (!dma && !write) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* copy the data out of the FIFO */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D lpbfifo.regs + LPBFIFO_REG_FIFO_DAT=
A;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D req->data + req->pos;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < count; i +=3D 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *data++ =3D in_be32(reg);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Update transfer position and count */
> + =A0 =A0 =A0 req->pos +=3D count;
> +
> + =A0 =A0 =A0 /* Decide what to do next */
> + =A0 =A0 =A0 if (req->size - req->pos)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_lpbfifo_kick(req); /* more work to =
do */
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_callback =3D 1;
> +
> + out:
> + =A0 =A0 =A0 /* Clear the IRQ */
> + =A0 =A0 =A0 out_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS, 0x01);
> +
> + =A0 =A0 =A0 if (dma && (status & 0x11)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Count the DMA as complete only when th=
e FIFO completion
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* status or abort bits are set.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (status & 0x01) should always be the c=
ase except sometimes
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* when using polled DMA.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (status & 0x10) {transfer aborted}: Th=
is case needs more
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* testing.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_retrieve_buffer(lpbfifo.bcom_cur_task,=
 &status, NULL);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 req->last_byte =3D ((u8 *)req->data)[req->size - 1];
> +
> + =A0 =A0 =A0 /* When the do_callback flag is set; it means the transfer =
is finished
> + =A0 =A0 =A0 =A0* so set the FIFO as idle */
> + =A0 =A0 =A0 if (do_callback)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo.req =3D NULL;
> +
> + =A0 =A0 =A0 if (irq !=3D 0) /* don't increment on polled case */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->irq_count++;
> +
> + =A0 =A0 =A0 req->irq_ticks +=3D get_tbl() - ts;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +
> + =A0 =A0 =A0 /* Spinlock is released; it is now safe to call the callbac=
k */
> + =A0 =A0 =A0 if (do_callback && req->callback)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->callback(req);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +/**
> + * mpc52xx_lpbfifo_bcom_irq - IRQ handler for LPB FIFO Bestcomm task
> + *
> + * Only used when receiving data.
> + */
> +static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct mpc52xx_lpbfifo_request *req;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 u32 status;
> + =A0 =A0 =A0 u32 ts;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&lpbfifo.lock, flags);
> + =A0 =A0 =A0 ts =3D get_tbl();
> +
> + =A0 =A0 =A0 req =3D lpbfifo.req;
> + =A0 =A0 =A0 if (!req || (req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (irq !=3D 0) /* don't increment on polled case */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->irq_count++;
> +
> + =A0 =A0 =A0 if (!bcom_buffer_done(lpbfifo.bcom_cur_task)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->buffer_not_done_cnt++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((req->buffer_not_done_cnt % 1000) =3D=
=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("transfer stalled\n"=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bcom_retrieve_buffer(lpbfifo.bcom_cur_task, &status, NULL);
> +
> + =A0 =A0 =A0 req->last_byte =3D ((u8 *)req->data)[req->size - 1];
> +
> + =A0 =A0 =A0 req->pos =3D status & 0x00ffffff;
> +
> + =A0 =A0 =A0 /* Mark the FIFO as idle */
> + =A0 =A0 =A0 lpbfifo.req =3D NULL;
> +
> + =A0 =A0 =A0 /* Release the lock before calling out to the callback. */
> + =A0 =A0 =A0 req->irq_ticks +=3D get_tbl() - ts;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +
> + =A0 =A0 =A0 if (req->callback)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->callback(req);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +/**
> + * mpc52xx_lpbfifo_bcom_poll - Poll for DMA completion
> + */
> +void mpc52xx_lpbfifo_poll(void)
> +{
> + =A0 =A0 =A0 struct mpc52xx_lpbfifo_request *req =3D lpbfifo.req;
> + =A0 =A0 =A0 int dma =3D !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
> + =A0 =A0 =A0 int write =3D req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* For more information, see comments on the "Fat Lady"
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (dma && write)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_lpbfifo_irq(0, NULL);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_lpbfifo_bcom_irq(0, NULL);
> +}
> +EXPORT_SYMBOL(mpc52xx_lpbfifo_poll);
> +
> +/**
> + * mpc52xx_lpbfifo_submit - Submit an LPB FIFO transfer request.
> + * @req: Pointer to request structure
> + */
> +int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (!lpbfifo.regs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&lpbfifo.lock, flags);
> +
> + =A0 =A0 =A0 /* If the req pointer is already set, then a transfer is in=
 progress */
> + =A0 =A0 =A0 if (lpbfifo.req) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Setup the transfer */
> + =A0 =A0 =A0 lpbfifo.req =3D req;
> + =A0 =A0 =A0 req->irq_count =3D 0;
> + =A0 =A0 =A0 req->irq_ticks =3D 0;
> + =A0 =A0 =A0 req->buffer_not_done_cnt =3D 0;
> + =A0 =A0 =A0 req->pos =3D 0;
> +
> + =A0 =A0 =A0 mpc52xx_lpbfifo_kick(req);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags);
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(mpc52xx_lpbfifo_submit);
> +
> +void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&lpbfifo.lock, flags);
> + =A0 =A0 =A0 if (lpbfifo.req =3D=3D req) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Put it into reset and clear the state */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_rx_reset(lpbfifo.bcom_rx_task);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_tx_reset(lpbfifo.bcom_tx_task);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE,=
 0x01010000);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo.req =3D NULL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags);
> +}
> +EXPORT_SYMBOL(mpc52xx_lpbfifo_abort);
> +
> +static int __devinit
> +mpc52xx_lpbfifo_probe(struct of_device *op, const struct of_device_id *m=
atch)
> +{
> + =A0 =A0 =A0 struct resource res;
> + =A0 =A0 =A0 int rc =3D -ENOMEM;
> +
> + =A0 =A0 =A0 if (lpbfifo.dev !=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOSPC;
> +
> + =A0 =A0 =A0 lpbfifo.irq =3D irq_of_parse_and_map(op->node, 0);
> + =A0 =A0 =A0 if (!lpbfifo.irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 if (of_address_to_resource(op->node, 0, &res))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 lpbfifo.regs_phys =3D res.start;
> + =A0 =A0 =A0 lpbfifo.regs =3D of_iomap(op->node, 0);
> + =A0 =A0 =A0 if (!lpbfifo.regs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 spin_lock_init(&lpbfifo.lock);
> +
> + =A0 =A0 =A0 /* Put FIFO into reset */
> + =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
> +
> + =A0 =A0 =A0 /* Register the interrupt handler */
> + =A0 =A0 =A0 rc =3D request_irq(lpbfifo.irq, mpc52xx_lpbfifo_irq, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mpc52xx-lpbfifo", &lpbf=
ifo);
> + =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
> +
> + =A0 =A0 =A0 /* Request the Bestcomm receive (fifo --> memory) task and =
IRQ */
> + =A0 =A0 =A0 lpbfifo.bcom_rx_task =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_rx_init(2, res.start + LPBFIFO_=
REG_FIFO_DATA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BCO=
M_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16*=
1024*1024);
> + =A0 =A0 =A0 if (!lpbfifo.bcom_rx_task)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_bcom_rx;
> +
> + =A0 =A0 =A0 rc =3D request_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc52xx_lpbfifo_bcom_irq=
, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mpc52xx-lpbfifo-rx", &l=
pbfifo);
> + =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_bcom_rx_irq;
> +
> + =A0 =A0 =A0 /* Request the Bestcomm transmit (memory --> fifo) task and=
 IRQ */
> + =A0 =A0 =A0 lpbfifo.bcom_tx_task =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_gen_bd_tx_init(2, res.start + LPBFIFO_=
REG_FIFO_DATA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BCO=
M_INITIATOR_SCLPC, BCOM_IPR_SCLPC);
> + =A0 =A0 =A0 if (!lpbfifo.bcom_tx_task)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_bcom_tx;
> +
> + =A0 =A0 =A0 lpbfifo.dev =3D &op->dev;
> + =A0 =A0 =A0 return 0;
> +
> + err_bcom_tx:
> + =A0 =A0 =A0 free_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task), &lpbfifo)=
;
> + err_bcom_rx_irq:
> + =A0 =A0 =A0 bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
> + err_bcom_rx:
> + err_irq:
> + =A0 =A0 =A0 iounmap(lpbfifo.regs);
> + =A0 =A0 =A0 lpbfifo.regs =3D NULL;
> +
> + =A0 =A0 =A0 dev_err(&op->dev, "mpc52xx_lpbfifo_probe() failed\n");
> + =A0 =A0 =A0 return -ENODEV;
> +}
> +
> +
> +static int __devexit mpc52xx_lpbfifo_remove(struct of_device *op)
> +{
> + =A0 =A0 =A0 if (lpbfifo.dev !=3D &op->dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 /* Put FIFO in reset */
> + =A0 =A0 =A0 out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
> +
> + =A0 =A0 =A0 /* Release the bestcomm transmit task */
> + =A0 =A0 =A0 free_irq(bcom_get_task_irq(lpbfifo.bcom_tx_task), &lpbfifo)=
;
> + =A0 =A0 =A0 bcom_gen_bd_tx_release(lpbfifo.bcom_tx_task);
> +
> + =A0 =A0 =A0 /* Release the bestcomm receive task */
> + =A0 =A0 =A0 free_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task), &lpbfifo)=
;
> + =A0 =A0 =A0 bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
> +
> + =A0 =A0 =A0 free_irq(lpbfifo.irq, &lpbfifo);
> + =A0 =A0 =A0 iounmap(lpbfifo.regs);
> + =A0 =A0 =A0 lpbfifo.regs =3D NULL;
> + =A0 =A0 =A0 lpbfifo.dev =3D NULL;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct of_device_id mpc52xx_lpbfifo_match[] __devinitconst =3D {
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5200-lpbfifo", },
> + =A0 =A0 =A0 {},
> +};
> +
> +static struct of_platform_driver mpc52xx_lpbfifo_driver =3D {
> + =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 .name =3D "mpc52xx-lpbfifo",
> + =A0 =A0 =A0 .match_table =3D mpc52xx_lpbfifo_match,
> + =A0 =A0 =A0 .probe =3D mpc52xx_lpbfifo_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(mpc52xx_lpbfifo_remove),
> +};
> +
> +/***********************************************************************
> + * Module init/exit
> + */
> +static int __init mpc52xx_lpbfifo_init(void)
> +{
> + =A0 =A0 =A0 pr_debug("Registering LocalPlus bus FIFO driver\n");
> + =A0 =A0 =A0 return of_register_platform_driver(&mpc52xx_lpbfifo_driver)=
;
> +}
> +module_init(mpc52xx_lpbfifo_init);
> +
> +static void __exit mpc52xx_lpbfifo_exit(void)
> +{
> + =A0 =A0 =A0 pr_debug("Unregistering LocalPlus bus FIFO driver\n");
> + =A0 =A0 =A0 of_unregister_platform_driver(&mpc52xx_lpbfifo_driver);
> +}
> +module_exit(mpc52xx_lpbfifo_exit);
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
