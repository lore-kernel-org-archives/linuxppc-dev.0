Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id 5D424B7C0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 06:45:04 +1100 (EST)
Received: by ywh39 with SMTP id 39so20265935ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 11:45:02 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220801.53720.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220801.53720.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 12:44:40 -0700
Message-ID: <fa686aa41001111144r7b71d83wf4feed263ac0af91@mail.gmail.com>
Subject: Re: [PATCH 04/13] mpc52xx: LocalPlus driver: rewrite interrupt
	routines, fix errors
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

On Tue, Dec 22, 2009 at 12:01 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>
> Use SCLPC bit definitions from mpc52xx.h for better readability.

The changes of is_write etc. are intermingled with the functional
changes being made.  The functional behaviour of this thing is subtle,
and I'd prefer the stylistic stuff handled in a separate patch.

> Rewrite IRQ handlers, make them work for DMA.

Details please.  As far as my testing goes, dma irqs are working fine.

> Fix module unload error.

ditto here.

>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0306 ++++++++++++---=
----------
> =A01 files changed, 149 insertions(+), 157 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> index 2763d5e..2fd1f3f 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -46,6 +46,34 @@ struct mpc52xx_lpbfifo {
> =A0/* The MPC5200 has only one fifo, so only need one instance structure =
*/
> =A0static struct mpc52xx_lpbfifo lpbfifo;
>
> +
> +/**
> + * mpc52xx_lpbfifo_is_write - return true if it's a WRITE request
> + */
> +static inline int mpc52xx_lpbfifo_is_write(int flags)
> +{
> + =A0 =A0 =A0 return flags & MPC52XX_LPBFIFO_FLAG_WRITE;
> +}
> +
> +
> +/**
> + * mpc52xx_lpbfifo_is_dma - return true if it's a DMA request
> + */
> +static inline int mpc52xx_lpbfifo_is_dma(int flags)
> +{
> + =A0 =A0 =A0 return !(flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
> +}
> +
> +
> +/**
> + * mpc52xx_lpbfifo_is_poll_dma - return true if it's a polled DMA reques=
t
> + */
> +static inline int mpc52xx_lpbfifo_is_poll_dma(int flags)
> +{
> + =A0 =A0 =A0 return flags & MPC52XX_LPBFIFO_FLAG_POLL_DMA;
> +}
> +
> +

I'm not (yet) convinced that adding these is a benefit.

> =A0/**
> =A0* mpc52xx_lpbfifo_kick - Trigger the next block of data to be transfer=
ed
> =A0*/
> @@ -57,16 +85,23 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0u32 *data;
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0int bit_fields;
> - =A0 =A0 =A0 int dma =3D !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
> - =A0 =A0 =A0 int write =3D req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
> - =A0 =A0 =A0 int poll_dma =3D req->flags & MPC52XX_LPBFIFO_FLAG_POLL_DMA=
;
> + =A0 =A0 =A0 int rflags =3D req->flags;
>
> =A0 =A0 =A0 =A0/* Set and clear the reset bits; is good practice in User =
Manual */
> - =A0 =A0 =A0 out_be32(&lpbfifo.regs->enable, 0x01010000);
> + =A0 =A0 =A0 out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC | M=
PC52xx_SCLPC_ENABLE_RF);
> +
> + =A0 =A0 =A0 /* Set width, chip select and READ mode */
> + =A0 =A0 =A0 out_be32(&lpbfifo.regs->start_address, req->offset + req->p=
os);
> +
> + =A0 =A0 =A0 /* Set CS and BPT */
> + =A0 =A0 =A0 bit_fields =3D MPC52xx_SCLPC_CONTROL_CS(req->cs) | 0x8;
> + =A0 =A0 =A0 if (!(mpc52xx_lpbfifo_is_write(rflags))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D MPC52xx_SCLPC_CONTROL_RWB_R=
ECEIVE; =A0 =A0 =A0 =A0/* read mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D MPC52xx_SCLPC_CONTROL_FLUSH=
;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 out_be32(&lpbfifo.regs->control, bit_fields);
>
> - =A0 =A0 =A0 /* set master enable bit */
> - =A0 =A0 =A0 out_be32(&lpbfifo.regs->enable, 0x00000001);

My experimenting has found that clearing the reset bits and setting
the master enable bit is needed before programming the FIFO.  It looks
to me like this patch drops the above line which does so.

> - =A0 =A0 =A0 if (!dma) {
> + =A0 =A0 =A0 if (!mpc52xx_lpbfifo_is_dma(rflags)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* While the FIFO can be setup for transfe=
r sizes as large as
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * 16M-1, the FIFO itself is only 512 byte=
s deep and it does
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * not generate interrupts for FIFO full e=
vents (only transfer
> @@ -80,7 +115,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfif=
o_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0transfer_size =3D 512;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Load the FIFO with data */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc52xx_lpbfifo_is_write(rflags)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D &lpbfifo.regs->fif=
o_data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data =3D req->data + req->=
pos;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < transfer=
_size; i +=3D 4)
> @@ -88,7 +123,9 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfif=
o_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Unmask both error and completion irqs *=
/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->enable, 0x00000301)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->enable, (MPC52xx_SC=
LPC_ENABLE_AIE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0MPC52xx_SCLPC_ENABLE_NIE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0MPC52xx_SCLPC_ENABLE_ME));
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Choose the correct direction
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
> @@ -97,16 +134,16 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbf=
ifo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * there is a performance impacit. =A0Howe=
ver, if it is wrong there
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * is a risk of DMA not transferring the l=
ast chunk of data
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (write) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->fif=
o_alarm, 0x1e4);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&lpbfifo.regs->fifo_c=
ontrol, 7);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc52xx_lpbfifo_is_write(rflags)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->fif=
o_alarm, MPC52xx_SCLPC_FIFO_SIZE - 28);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->fif=
o_control, MPC52xx_SLPC_FIFO_CONTROL_GR(7));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lpbfifo.bcom_cur_task =3D =
lpbfifo.bcom_tx_task;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->fif=
o_alarm, 0x1ff);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&lpbfifo.regs->fifo_c=
ontrol, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->fif=
o_alarm, MPC52xx_SCLPC_FIFO_SIZE - 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->fif=
o_control, MPC52xx_SLPC_FIFO_CONTROL_GR(0));

More stylistic changes in a patch that also changes functional
behaviour.  Please split into separate patches.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lpbfifo.bcom_cur_task =3D =
lpbfifo.bcom_rx_task;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (poll_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc52xx_lpbfifo_is_poll=
_dma(rflags)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (lpbfif=
o.dma_irqs_enabled) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0disable_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0lpbfifo.dma_irqs_enabled =3D 0;
> @@ -119,63 +156,34 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpb=
fifo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* error irq & master enabled bit */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&lpbfifo.regs->enable, MPC52xx_SCL=
PC_ENABLE_AIE | MPC52xx_SCLPC_ENABLE_NIE | MPC52xx_SCLPC_ENABLE_ME);
> +

You'll need to explain this change it greater detail.  The old code
only enabled the NIE irq when in non-polled DMA mode.  You're changing
it and you need to explain why.  Not just for me but for future
readers.

I'm stopping here on this particular patch.  A number of comments have
been removed that describe the behaviour of the driver without being
replaced with comments describing the new behaviour.  There are also
several whitespace and style only change that should be done in a
separate patch.  Keeping them separate means I can merge
uncontroversial stuff while still debating the other points.

Please respin and describe not just what you've change, but how you
changed it, why the change is needed, and it should be clear what the
new behaviour model is.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
