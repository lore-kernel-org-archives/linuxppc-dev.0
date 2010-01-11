Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id 4E45D1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 07:16:13 +1100 (EST)
Received: by ywh39 with SMTP id 39so20298854ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 12:16:11 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220808.14759.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220808.14759.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 13:15:46 -0700
Message-ID: <fa686aa41001111215j249a761bn80786de2de43ee63@mail.gmail.com>
Subject: Re: [PATCH 09/13] powerpc/5200: LocalPlus driver: smarter calculation
	of BPT, bytes per transfer
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

On Tue, Dec 22, 2009 at 12:08 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0 33 +++++++++++++++=
----------
> =A01 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> index 48f2b4f..21b2a40 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -80,11 +80,11 @@ static inline int mpc52xx_lpbfifo_is_poll_dma(int fla=
gs)
> =A0*/
> =A0static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo_request *req)
> =A0{
> - =A0 =A0 =A0 size_t transfer_size =3D req->size - req->pos;
> + =A0 =A0 =A0 size_t tc =3D req->size - req->pos;
> =A0 =A0 =A0 =A0struct bcom_bd *bd;
> =A0 =A0 =A0 =A0void __iomem *reg;
> =A0 =A0 =A0 =A0u32 *data;
> - =A0 =A0 =A0 u32 bit_fields;
> + =A0 =A0 =A0 u32 control;

Changing the name of these two variables makes it hard to review the
functional change.  A lot of unrelated housekeeping gets interwoven.

> =A0 =A0 =A0 =A0int rflags =3D req->flags;
>
> =A0 =A0 =A0 =A0/* Set and clear the reset bits; is good practice in User =
Manual */
> @@ -93,10 +93,10 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0/* Set width, chip select and READ mode */
> =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->start_address, req->offset + req->=
pos);
>
> - =A0 =A0 =A0 /* Set CS and BPT */
> - =A0 =A0 =A0 bit_fields =3D MPC52xx_SCLPC_CONTROL_CS(req->cs) | 0x8;
> + =A0 =A0 =A0 /* Setup CS */
> + =A0 =A0 =A0 control =3D MPC52xx_SCLPC_CONTROL_CS(req->cs);
> =A0 =A0 =A0 =A0if (!(mpc52xx_lpbfifo_is_write(rflags)))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D MPC52xx_SCLPC_CONTROL_RWB_R=
ECEIVE; =A0 =A0 =A0 =A0/* read mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 control |=3D MPC52xx_SCLPC_CONTROL_RWB_RECE=
IVE; =A0 /* read mode */
>
> =A0 =A0 =A0 =A0if (!mpc52xx_lpbfifo_is_dma(rflags)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* While the FIFO can be setup for transfe=
r sizes as
> @@ -112,10 +112,10 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpb=
fifo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * The last block of data will be received=
 with the
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * flush bit set. This avoids stale read d=
ata.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (transfer_size > 512)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 transfer_size =3D 512;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tc > 512)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tc =3D 512;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (!(mpc52xx_lpbfifo_is_write(rflags=
)))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D MPC52xx_SCL=
PC_CONTROL_FLUSH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 control |=3D MPC52xx_SCLPC_=
CONTROL_FLUSH;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Load the FIFO with data */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mpc52xx_lpbfifo_is_write(rflags)) {
> @@ -123,7 +123,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D &lpbfifo.regs->fif=
o_data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data =3D req->data + req->=
pos;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < transfer_=
size; i +=3D 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < tc; i +=
=3D 4)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(r=
eg, *data++);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> @@ -136,7 +136,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* In DMA mode we can always set the flush=
 bit to avoid
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * stale read data. */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(mpc52xx_lpbfifo_is_write(rflags)))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D MPC52xx_SCL=
PC_CONTROL_FLUSH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 control |=3D MPC52xx_SCLPC_=
CONTROL_FLUSH;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Choose the correct direction
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
> @@ -173,15 +173,17 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpb=
fifo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->enable, MPC52xx_SC=
LPC_ENABLE_AIE | MPC52xx_SCLPC_ENABLE_NIE | MPC52xx_SCLPC_ENABLE_ME);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd =3D bcom_prepare_next_buffer(lpbfifo.bc=
om_cur_task);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->status =3D transfer_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->status =3D tc;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->data[0] =3D req->data_dma + req->pos;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_submit_next_buffer(lpbfifo.bcom_cur_t=
ask, NULL);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 out_be32(&lpbfifo.regs->control, bit_fields);
> + =A0 =A0 =A0 /* Setup BPT. tc is already screened and a multiple of 4 */
> + =A0 =A0 =A0 control |=3D tc & 7 ? 4 : 8;
> + =A0 =A0 =A0 out_be32(&lpbfifo.regs->control, control);

The calculation looks correct.  However, why isn't the transfer size
calculated up by the /* Setup CS and BPT */ comment?  I don't think it
needs to be down here.

>
> =A0 =A0 =A0 =A0/* Set packet size and kick it off */
> - =A0 =A0 =A0 out_be32(&lpbfifo.regs->packet_size.packet_size, MPC52xx_SC=
LPC_PACKET_SIZE_RESTART | transfer_size);
> + =A0 =A0 =A0 out_be32(&lpbfifo.regs->packet_size.packet_size, MPC52xx_SC=
LPC_PACKET_SIZE_RESTART | tc);
> =A0 =A0 =A0 =A0if (mpc52xx_lpbfifo_is_dma(rflags))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_enable(lpbfifo.bcom_cur_task);
> =A0}
> @@ -395,6 +397,11 @@ int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_re=
quest *req)
> =A0 =A0 =A0 =A0if (!lpbfifo.regs)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> + =A0 =A0 =A0 /* The gen bd BestComm task currently only allows an increm=
ent
> + =A0 =A0 =A0 =A0* of 4 */
> + =A0 =A0 =A0 if (!req->size || req->size & 0x03)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> =A0 =A0 =A0 =A0spin_lock_irqsave(&lpbfifo.lock, flags);
>
> =A0 =A0 =A0 =A0/* If the req pointer is already set, then a transfer is i=
n progress */
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
