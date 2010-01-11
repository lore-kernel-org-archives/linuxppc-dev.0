Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 6E1101007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 07:20:36 +1100 (EST)
Received: by yxe9 with SMTP id 9so10918065yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 12:20:34 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220810.20622.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220810.20622.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 13:20:14 -0700
Message-ID: <fa686aa41001111220i445e0ddat6ae5e6390475c58f@mail.gmail.com>
Subject: Re: [PATCH 11/13] powerpc/5200: LocalPlus driver: move RAM DMA
	address from request to driver
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

On Tue, Dec 22, 2009 at 12:10 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>

Please merge this change with the patch that adds the dma mapping

g.

> ---
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0 13 +++++++------
> =A02 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/as=
m/mpc52xx.h
> index 043458e..91c65d0 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -347,7 +347,6 @@ struct mpc52xx_lpbfifo_request {
>
> =A0 =A0 =A0 =A0/* Memory address */
> =A0 =A0 =A0 =A0void *data;
> - =A0 =A0 =A0 dma_addr_t data_dma;
>
> =A0 =A0 =A0 =A0/* Details of transfer */
> =A0 =A0 =A0 =A0size_t size;
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> index cd8dc69..b2c92f5 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -41,6 +41,7 @@ struct mpc52xx_lpbfifo {
>
> =A0 =A0 =A0 =A0/* Current state data */
> =A0 =A0 =A0 =A0struct mpc52xx_lpbfifo_request *req;
> + =A0 =A0 =A0 dma_addr_t data_dma;
> =A0 =A0 =A0 =A0unsigned short irqs_pending;
> =A0 =A0 =A0 =A0int dma_irqs_enabled;
> =A0};
> @@ -49,7 +50,7 @@ struct mpc52xx_lpbfifo {
> =A0static struct mpc52xx_lpbfifo lpbfifo;
>
>
> -/* The order of the raised interrupts of SCLPC and BCOM cann not be
> +/* The order of the raised interrupts of SCLPC and BCOM cannot be
> =A0* predicted, because it depends on the individual BCOM and CPU
> =A0* loads. So in DMA mode we just wait for both until we finish the
> =A0* transaction. */
> @@ -160,7 +161,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->fi=
fo_alarm, MPC52xx_SCLPC_FIFO_SIZE - 28);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->fi=
fo_control, MPC52xx_SLPC_FIFO_CONTROL_GR(7));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lpbfifo.bcom_cur_task =3D =
lpbfifo.bcom_tx_task;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->data_dma =3D dma_map_s=
ingle(lpbfifo.dev, req->data, req->size, DMA_TO_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo.data_dma =3D dma_ma=
p_single(lpbfifo.dev, req->data, req->size, DMA_TO_DEVICE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->fi=
fo_alarm, MPC52xx_SCLPC_FIFO_SIZE - 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->fi=
fo_control, MPC52xx_SLPC_FIFO_CONTROL_GR(0));
> @@ -177,7 +178,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0lpbfifo.dma_irqs_enabled =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->data_dma =3D dma_map_s=
ingle(lpbfifo.dev, req->data, req->size, DMA_FROM_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lpbfifo.data_dma =3D dma_ma=
p_single(lpbfifo.dev, req->data, req->size, DMA_FROM_DEVICE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* error irq & master enabled bit */
> @@ -187,7 +188,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd =3D bcom_prepare_next_buffer(lpbfifo.bc=
om_cur_task);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->status =3D tc;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->data[0] =3D req->data_dma + req->pos;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->data[0] =3D lpbfifo.data_dma + req->pos=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_submit_next_buffer(lpbfifo.bcom_cur_t=
ask, NULL);
> =A0 =A0 =A0 =A0}
>
> @@ -378,9 +379,9 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, =
void *dev_id)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (req) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mpc52xx_lpbfifo_is_wri=
te(lpbfifo->req->flags))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_s=
ingle(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req->size, DMA_TO_DEVI=
CE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_s=
ingle(lpbfifo->dev, lpbfifo->data_dma, lpbfifo->req->size, DMA_TO_DEVICE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_s=
ingle(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req->size, DMA_FROM_DE=
VICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_s=
ingle(lpbfifo->dev, lpbfifo->data_dma, lpbfifo->req->size, DMA_FROM_DEVICE)=
;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lpbfifo->req =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo->regs->e=
nable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLPC_ENABLE_RF);
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
