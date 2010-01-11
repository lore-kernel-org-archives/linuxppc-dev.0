Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 75B55B7C1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 07:19:35 +1100 (EST)
Received: by yxe9 with SMTP id 9so10917172yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 12:19:34 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220809.09578.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220809.09578.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 13:19:14 -0700
Message-ID: <fa686aa41001111219r23e0adc4gd6daf70096771f91@mail.gmail.com>
Subject: Re: [PATCH 10/13] powerpc/5200: LocalPlus driver: fix problem caused
	by unpredictable IRQ order
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

On Tue, Dec 22, 2009 at 12:09 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>
> The order of the raised interrupts of SCLPC and BCOM cannot be
> predicted, because it depends on the individual BCOM and CPU loads. So
> in DMA mode we just wait for both until we finish the transaction.

I'm really not convinced.  It is true that the IRQ ordering may be
different, but by definition the BCOM *must* be finished before the
FIFO finishes on the TX path, and the FIFO definitely completes before
the BCOM completes on the RX path, regardless of the order IRQs are
actually processed.

g.

>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0 94 +++++++++++++++=
++--------
> =A01 files changed, 64 insertions(+), 30 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> index 21b2a40..cd8dc69 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -32,7 +32,7 @@ struct mpc52xx_lpbfifo {
> =A0 =A0 =A0 =A0struct device *dev;
> =A0 =A0 =A0 =A0phys_addr_t regs_phys;
> =A0 =A0 =A0 =A0struct mpc52xx_sclpc __iomem *regs;
> - =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 int sclpc_irq;
> =A0 =A0 =A0 =A0spinlock_t lock;
>
> =A0 =A0 =A0 =A0struct bcom_task *bcom_tx_task;
> @@ -41,6 +41,7 @@ struct mpc52xx_lpbfifo {
>
> =A0 =A0 =A0 =A0/* Current state data */
> =A0 =A0 =A0 =A0struct mpc52xx_lpbfifo_request *req;
> + =A0 =A0 =A0 unsigned short irqs_pending;
> =A0 =A0 =A0 =A0int dma_irqs_enabled;
> =A0};
>
> @@ -48,6 +49,14 @@ struct mpc52xx_lpbfifo {
> =A0static struct mpc52xx_lpbfifo lpbfifo;
>
>
> +/* The order of the raised interrupts of SCLPC and BCOM cann not be
> + * predicted, because it depends on the individual BCOM and CPU
> + * loads. So in DMA mode we just wait for both until we finish the
> + * transaction. */
> +#define MPC52XX_LPBFIFO_PENDING_SCLPC =A0BIT(0)
> +#define MPC52XX_LPBFIFO_PENDING_BCOM =A0 BIT(1)
> +
> +
> =A0/**
> =A0* mpc52xx_lpbfifo_is_write - return true if it's a WRITE request
> =A0*/
> @@ -127,6 +136,8 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(r=
eg, *data++);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo.irqs_pending =3D MPC52XX_LPBFIFO_PE=
NDING_SCLPC;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Unmask both error and completion irqs *=
/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->enable, (MPC52xx_S=
CLPC_ENABLE_AIE |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 MPC52xx_SCLPC_ENABLE_NIE |
> @@ -172,6 +183,8 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* error irq & master enabled bit */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->enable, MPC52xx_SC=
LPC_ENABLE_AIE | MPC52xx_SCLPC_ENABLE_NIE | MPC52xx_SCLPC_ENABLE_ME);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo.irqs_pending =3D MPC52XX_LPBFIFO_PE=
NDING_BCOM | MPC52XX_LPBFIFO_PENDING_SCLPC;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd =3D bcom_prepare_next_buffer(lpbfifo.bc=
om_cur_task);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->status =3D tc;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->data[0] =3D req->data_dma + req->pos;
> @@ -188,6 +201,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_enable(lpbfifo.bcom_cur_task);
> =A0}
>
> +
> =A0/**
> =A0* mpc52xx_lpbfifo_sclpc_irq - IRQ handler for LPB FIFO
> =A0*
> @@ -232,8 +246,9 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0*/
> =A0static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int irq, void *dev_id)
> =A0{
> + =A0 =A0 =A0 struct mpc52xx_lpbfifo *lpbfifo =3D dev_id;
> =A0 =A0 =A0 =A0struct mpc52xx_lpbfifo_request *req;
> - =A0 =A0 =A0 u32 status_count =3D in_be32(&lpbfifo.regs->bytes_done_stat=
us.bytes_done);
> + =A0 =A0 =A0 u32 status_count =3D in_be32(&lpbfifo->regs->bytes_done_sta=
tus.bytes_done);
> =A0 =A0 =A0 =A0void __iomem *reg;
> =A0 =A0 =A0 =A0u32 *data;
> =A0 =A0 =A0 =A0size_t i;
> @@ -242,18 +257,20 @@ static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int ir=
q, void *dev_id)
> =A0 =A0 =A0 =A0unsigned long flags;
> =A0 =A0 =A0 =A0int rflags;
>
> - =A0 =A0 =A0 spin_lock_irqsave(&lpbfifo.lock, flags);
> + =A0 =A0 =A0 spin_lock_irqsave(&lpbfifo->lock, flags);
> =A0 =A0 =A0 =A0ts =3D get_tbl();
>
> - =A0 =A0 =A0 req =3D lpbfifo.req;
> + =A0 =A0 =A0 req =3D lpbfifo->req;
> =A0 =A0 =A0 =A0if (!req) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo->lock, flag=
s);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("bogus SCLPC IRQ\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 lpbfifo->irqs_pending &=3D ~MPC52XX_LPBFIFO_PENDING_SCLPC;
> +
> =A0 =A0 =A0 =A0rflags =3D req->flags;
> - =A0 =A0 =A0 status_count =3D in_be32(&lpbfifo.regs->bytes_done_status.b=
ytes_done);
> + =A0 =A0 =A0 status_count =3D in_be32(&lpbfifo->regs->bytes_done_status.=
bytes_done);
>
> =A0 =A0 =A0 =A0/* Check normal termination bit */
> =A0 =A0 =A0 =A0if (!(status_count & MPC52xx_SCLPC_STATUS_NT))
> @@ -261,19 +278,23 @@ static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int ir=
q, void *dev_id)
>
> =A0 =A0 =A0 =A0/* Check abort bit */
> =A0 =A0 =A0 =A0if (status_count & MPC52xx_SCLPC_STATUS_AT) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->enable, MPC52xx_SCL=
PC_ENABLE_RC | MPC52xx_SCLPC_ENABLE_RF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo->regs->enable, MPC52xx_SC=
LPC_ENABLE_RC | MPC52xx_SCLPC_ENABLE_RF);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_callback =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (!mpc52xx_lpbfifo_is_dma(rflags)) {
> + =A0 =A0 =A0 if (mpc52xx_lpbfifo_is_dma(rflags)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!lpbfifo->irqs_pending)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_callback =3D 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 else {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Bytes done */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status_count &=3D MPC52xx_SCLPC_STATUS_BYT=
ES_DONE_MASK;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mpc52xx_lpbfifo_is_write(rflags)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* copy the data out of th=
e FIFO */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lpbfifo.regs->fifo=
_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &lpbfifo->regs->fif=
o_data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data =3D req->data + req->=
pos;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < status_c=
ount; i +=3D sizeof(u32))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*data++ =
=3D in_be32(reg);
> @@ -288,13 +309,10 @@ static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int ir=
q, void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_callback =3D 1;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_callback =3D 1;
> - =A0 =A0 =A0 }
>
> =A0out:
> =A0 =A0 =A0 =A0/* Clear the IRQ */
> - =A0 =A0 =A0 out_8(&lpbfifo.regs->bytes_done_status.status, BIT(0));
> + =A0 =A0 =A0 out_8(&lpbfifo->regs->bytes_done_status.status, BIT(0));
>
> =A0 =A0 =A0 =A0req->last_byte =3D ((u8 *)req->data)[req->size - 1];
>
> @@ -304,11 +322,11 @@ out:
> =A0 =A0 =A0 =A0/* When the do_callback flag is set; it means the transfer=
 is finished
> =A0 =A0 =A0 =A0 * so set the FIFO as idle */
> =A0 =A0 =A0 =A0if (do_callback) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo.req =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->enable, MPC52xx_SCL=
PC_ENABLE_RC | MPC52xx_SCLPC_ENABLE_RF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo->req =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo->regs->enable, MPC52xx_SC=
LPC_ENABLE_RC | MPC52xx_SCLPC_ENABLE_RF);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0req->irq_ticks +=3D get_tbl() - ts;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo->lock, flag=
s);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Spinlock is released; it is now safe to=
 call the callback */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (req->callback)
> @@ -318,7 +336,7 @@ out:
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0req->irq_ticks +=3D get_tbl() - ts;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo.lock, flags=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpbfifo->lock, flag=
s);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0 =A0 =A0 =A0}
> @@ -354,14 +372,30 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq=
, void *dev_id)
> =A0 =A0 =A0 =A0bcom_retrieve_buffer(lpbfifo->bcom_cur_task, NULL, NULL);
> =A0 =A0 =A0 =A0// req->irq_ticks +=3D get_tbl() - ts;
>
> - =A0 =A0 =A0 if (lpbfifo->req) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc52xx_lpbfifo_is_write(lpbfifo->req->=
flags))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(lpbfifo->d=
ev, lpbfifo->req->data_dma, lpbfifo->req->size, DMA_TO_DEVICE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(lpbfifo->d=
ev, lpbfifo->req->data_dma, lpbfifo->req->size, DMA_FROM_DEVICE);
> - =A0 =A0 =A0 } else
> - =A0 =A0 =A0 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lpbfifo->dev, "request is NULL\n");
> + =A0 =A0 =A0 lpbfifo->irqs_pending &=3D ~MPC52XX_LPBFIFO_PENDING_BCOM;
> + =A0 =A0 =A0 if (!lpbfifo->irqs_pending) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpc52xx_lpbfifo_request *req =3D lpb=
fifo->req;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc52xx_lpbfifo_is_writ=
e(lpbfifo->req->flags))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_s=
ingle(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req->size, DMA_TO_DEVI=
CE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_s=
ingle(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req->size, DMA_FROM_DE=
VICE);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo->req =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo->regs->en=
able, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLPC_ENABLE_RF);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&lpb=
fifo->lock, flags);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Spinlock is released; it=
 is now safe to call the callback */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req->callback)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->callba=
ck(req);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(lpbfifo->dev, "bogu=
s BCOM IRQ\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&lpbfifo->lock, flags);
> @@ -451,8 +485,8 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
> =A0 =A0 =A0 =A0if (lpbfifo.dev !=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOSPC;
>
> - =A0 =A0 =A0 lpbfifo.irq =3D irq_of_parse_and_map(op->node, 0);
> - =A0 =A0 =A0 if (!lpbfifo.irq)
> + =A0 =A0 =A0 lpbfifo.sclpc_irq =3D irq_of_parse_and_map(op->node, 0);
> + =A0 =A0 =A0 if (!lpbfifo.sclpc_irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> =A0 =A0 =A0 =A0if (of_address_to_resource(op->node, 0, &res))
> @@ -468,7 +502,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
> =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC | =
MPC52xx_SCLPC_ENABLE_RF);
>
> =A0 =A0 =A0 =A0/* register the interrupt handler */
> - =A0 =A0 =A0 rc =3D request_irq(lpbfifo.irq, mpc52xx_lpbfifo_sclpc_irq, =
0,
> + =A0 =A0 =A0 rc =3D request_irq(lpbfifo.sclpc_irq, mpc52xx_lpbfifo_sclpc=
_irq, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "mpc52xx-lpbfifo", &lpbfi=
fo);
> =A0 =A0 =A0 =A0if (rc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_irq;
> @@ -539,7 +573,7 @@ static int __devexit mpc52xx_lpbfifo_remove(struct of=
_device *op)
> =A0 =A0 =A0 =A0free_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task), &lpbfifo=
);
> =A0 =A0 =A0 =A0bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
>
> - =A0 =A0 =A0 free_irq(lpbfifo.irq, &lpbfifo);
> + =A0 =A0 =A0 free_irq(lpbfifo.sclpc_irq, &lpbfifo);
> =A0 =A0 =A0 =A0iounmap(lpbfifo.regs);
> =A0 =A0 =A0 =A0lpbfifo.regs =3D NULL;
> =A0 =A0 =A0 =A0lpbfifo.dev =3D NULL;
> @@ -547,7 +581,7 @@ static int __devexit mpc52xx_lpbfifo_remove(struct of=
_device *op)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static struct of_device_id mpc52xx_lpbfifo_match[] __devinitconst =3D {
> +static const struct of_device_id mpc52xx_lpbfifo_match[] __devinitconst =
=3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5200-lpbfifo", },
> =A0 =A0 =A0 =A0{},
> =A0};
> --
> 1.6.5.5
>
>
>
> --
> Roman Fietze =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Telemotive AG B=FCro M=FChlha=
usen
> Breitwiesen =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A073=
347 M=FChlhausen
> Tel.: +49(0)7335/18493-45 =A0 =A0 =A0 =A0http://www.telemotive.de
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
