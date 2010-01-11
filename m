Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id ABE5EB6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 06:57:35 +1100 (EST)
Received: by gxk28 with SMTP id 28so14823913gxk.9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 11:57:34 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220804.05543.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220804.05543.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 12:57:14 -0700
Message-ID: <fa686aa41001111157t247af48fg6c4e788307eb2173@mail.gmail.com>
Subject: Re: [PATCH 06/13] powerpc/5200: LocalPlus driver: map and unmap DMA
	areas
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 22, 2009 at 12:04 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>

Yes, this is definitely needed.  Please respin this patch and move it
earlier in your series so I can apply it to mainline.

More comments below.

g.

> ---
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +=
-
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0 26 +++++++++++++++=
++++-----
> =A02 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/as=
m/mpc52xx.h
> index c659d1d..043458e 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -347,7 +347,7 @@ struct mpc52xx_lpbfifo_request {
>
> =A0 =A0 =A0 =A0/* Memory address */
> =A0 =A0 =A0 =A0void *data;
> - =A0 =A0 =A0 phys_addr_t data_phys;
> + =A0 =A0 =A0 dma_addr_t data_dma;
>
> =A0 =A0 =A0 =A0/* Details of transfer */
> =A0 =A0 =A0 =A0size_t size;
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> index 1e4f725..8d8a63a 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -14,6 +14,7 @@
> =A0#include <linux/of.h>
> =A0#include <linux/of_platform.h>
> =A0#include <linux/spinlock.h>
> +#include <linux/dma-mapping.h>
> =A0#include <asm/io.h>
> =A0#include <asm/prom.h>
> =A0#include <asm/mpc52xx.h>
> @@ -138,6 +139,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->fi=
fo_alarm, MPC52xx_SCLPC_FIFO_SIZE - 28);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->fi=
fo_control, MPC52xx_SLPC_FIFO_CONTROL_GR(7));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lpbfifo.bcom_cur_task =3D =
lpbfifo.bcom_tx_task;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->data_dma =3D dma_map_s=
ingle(lpbfifo.dev, req->data, req->size, DMA_TO_DEVICE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->fi=
fo_alarm, MPC52xx_SCLPC_FIFO_SIZE - 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->fi=
fo_control, MPC52xx_SLPC_FIFO_CONTROL_GR(0));
> @@ -154,6 +156,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0lpbfifo.dma_irqs_enabled =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->data_dma =3D dma_map_s=
ingle(lpbfifo.dev, req->data, req->size, DMA_FROM_DEVICE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}

Need to ensure the return value !=3D NULL

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* error irq & master enabled bit */
> @@ -161,7 +164,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd =3D bcom_prepare_next_buffer(lpbfifo.bc=
om_cur_task);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->status =3D transfer_size;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->data[0] =3D req->data_phys + req->pos;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->data[0] =3D req->data_dma + req->pos;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_submit_next_buffer(lpbfifo.bcom_cur_t=
ask, NULL);
> =A0 =A0 =A0 =A0}
>
> @@ -236,12 +239,13 @@ static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int ir=
q, void *dev_id)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0rflags =3D req->flags;
> + =A0 =A0 =A0 status_count =3D in_be32(&lpbfifo.regs->bytes_done_status.b=
ytes_done);
>
> - =A0 =A0 =A0 /* check normal termination bit */
> + =A0 =A0 =A0 /* Check normal termination bit */
> =A0 =A0 =A0 =A0if (!(status_count & MPC52xx_SCLPC_STATUS_NT))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> - =A0 =A0 =A0 /* check abort bit */
> + =A0 =A0 =A0 /* Check abort bit */

unrelated changes

> =A0 =A0 =A0 =A0if (status_count & MPC52xx_SCLPC_STATUS_AT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->enable, MPC52xx_SC=
LPC_ENABLE_RC | MPC52xx_SCLPC_ENABLE_RF);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_callback =3D 1;
> @@ -250,7 +254,7 @@ static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int irq,=
 void *dev_id)
>
> =A0 =A0 =A0 =A0if (!mpc52xx_lpbfifo_is_dma(rflags)) {
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* bytes done */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Bytes done */

ditto

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status_count &=3D MPC52xx_SCLPC_STATUS_BYT=
ES_DONE_MASK;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mpc52xx_lpbfifo_is_write(rflags)) {
> @@ -336,6 +340,16 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq,=
 void *dev_id)
> =A0 =A0 =A0 =A0bcom_retrieve_buffer(lpbfifo->bcom_cur_task, NULL, NULL);
> =A0 =A0 =A0 =A0// req->irq_ticks +=3D get_tbl() - ts;
>
> + =A0 =A0 =A0 if (lpbfifo->req) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc52xx_lpbfifo_is_write(lpbfifo->req->=
flags))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(lpbfifo->d=
ev, lpbfifo->req->data_dma, lpbfifo->req->size, DMA_TO_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(lpbfifo->d=
ev, lpbfifo->req->data_dma, lpbfifo->req->size, DMA_FROM_DEVICE);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lpbfifo->dev, "request is NULL\n");
> + =A0 =A0 =A0 }
> +

The ->req pointer was verified earlier in this function.  It will
never be null here.

> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&lpbfifo->lock, flags);
>
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> @@ -439,7 +453,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_irq;
>
> =A0 =A0 =A0 =A0/* Request the Bestcomm receive (fifo --> memory) task and=
 IRQ */
> - =A0 =A0 =A0 lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(16,
> + =A0 =A0 =A0 lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 res.start + offsetof(struct mpc52xx_sclpc, fifo=
_data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 16*1024*1024);

Why?

> @@ -453,7 +467,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_bcom_rx_irq;
>
> =A0 =A0 =A0 =A0/* Request the Bestcomm transmit (memory --> fifo) task an=
d IRQ */
> - =A0 =A0 =A0 lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(16,
> + =A0 =A0 =A0 lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 res.start + offsetof(struct mpc52xx_sclpc, fifo=
_data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 BCOM_INITIATOR_SCLPC,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 BCOM_IPR_SCLPC);

Ditto.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
