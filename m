Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id AA24E1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 07:06:33 +1100 (EST)
Received: by gxk28 with SMTP id 28so14833707gxk.9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 12:06:32 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220806.33304.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220806.33304.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 13:06:12 -0700
Message-ID: <fa686aa41001111206x60789087p59060450485df1df@mail.gmail.com>
Subject: Re: [PATCH 08/13] powerpc/5200: LocalPlus driver: smart flush of
	receive FIFO
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

On Tue, Dec 22, 2009 at 12:06 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>

Need patch description

> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0 40 +++++++++++++++=
+---------
> =A01 files changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> index a7cd585..48f2b4f 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -84,8 +84,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
> =A0 =A0 =A0 =A0struct bcom_bd *bd;
> =A0 =A0 =A0 =A0void __iomem *reg;
> =A0 =A0 =A0 =A0u32 *data;
> - =A0 =A0 =A0 int i;
> - =A0 =A0 =A0 int bit_fields;
> + =A0 =A0 =A0 u32 bit_fields;
> =A0 =A0 =A0 =A0int rflags =3D req->flags;
>
> =A0 =A0 =A0 =A0/* Set and clear the reset bits; is good practice in User =
Manual */
> @@ -96,27 +95,32 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
>
> =A0 =A0 =A0 =A0/* Set CS and BPT */
> =A0 =A0 =A0 =A0bit_fields =3D MPC52xx_SCLPC_CONTROL_CS(req->cs) | 0x8;
> - =A0 =A0 =A0 if (!(mpc52xx_lpbfifo_is_write(rflags))) {
> + =A0 =A0 =A0 if (!(mpc52xx_lpbfifo_is_write(rflags)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bit_fields |=3D MPC52xx_SCLPC_CONTROL_RWB_=
RECEIVE; =A0 =A0 =A0 =A0/* read mode */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D MPC52xx_SCLPC_CONTROL_FLUSH=
;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 out_be32(&lpbfifo.regs->control, bit_fields);

Writing the control register is being deferred to later.  I'm not
convinced this is correct (see comment on previous patch).

>
> =A0 =A0 =A0 =A0if (!mpc52xx_lpbfifo_is_dma(rflags)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* While the FIFO can be setup for transfer=
 sizes as large as
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 16M-1, the FIFO itself is only 512 byt=
es deep and it does
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* not generate interrupts for FIFO full =
events (only transfer
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* complete will raise an IRQ). =A0Theref=
ore when not using
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Bestcomm to drive the FIFO it needs to=
 either be polled, or
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* transfers need to constrained to the s=
ize of the fifo.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* While the FIFO can be setup for transfer=
 sizes as
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* large as 16M-1, the FIFO itself is onl=
y 512 bytes
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* deep and it does not generate interrup=
ts for FIFO
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* full events (only transfer complete wi=
ll raise an
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* IRQ). Therefore when not using Bestcom=
m to drive the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* FIFO it needs to either be polled, or =
transfers need
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to constrained to the size of the fifo=
.

Drop formatting changes or spilt to separate patch.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * This driver restricts the size of the t=
ransfer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The last block of data will be receive=
d with the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* flush bit set. This avoids stale read =
data.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (transfer_size > 512)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0transfer_size =3D 512;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (!(mpc52xx_lpbfifo_is_write(rflags)=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D MPC52xx_SCL=
PC_CONTROL_FLUSH;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Load the FIFO with data */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mpc52xx_lpbfifo_is_write(rflags)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t i;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D &lpbfifo.regs->fif=
o_data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data =3D req->data + req->=
pos;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < transfer=
_size; i +=3D 4)
> @@ -128,6 +132,12 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbf=
ifo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 MPC52xx_SCLPC_ENABLE_NIE |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 MPC52xx_SCLPC_ENABLE_ME));
> =A0 =A0 =A0 =A0} else {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* In DMA mode we can always set the flush =
bit to avoid
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* stale read data. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(mpc52xx_lpbfifo_is_write(rflags)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit_fields |=3D MPC52xx_SCL=
PC_CONTROL_FLUSH;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Choose the correct direction
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Configure the watermarks so DMA will al=
ways complete correctly.
> @@ -168,6 +178,8 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_submit_next_buffer(lpbfifo.bcom_cur_t=
ask, NULL);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 out_be32(&lpbfifo.regs->control, bit_fields);
> +
> =A0 =A0 =A0 =A0/* Set packet size and kick it off */
> =A0 =A0 =A0 =A0out_be32(&lpbfifo.regs->packet_size.packet_size, MPC52xx_S=
CLPC_PACKET_SIZE_RESTART | transfer_size);
> =A0 =A0 =A0 =A0if (mpc52xx_lpbfifo_is_dma(rflags))
> @@ -455,7 +467,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_irq;
>
> =A0 =A0 =A0 =A0/* Request the Bestcomm receive (fifo --> memory) task and=
 IRQ */
> - =A0 =A0 =A0 lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(4,
> + =A0 =A0 =A0 lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(2,

unrelated change (and this line was also changed in an earlier patch)

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 res.start + offsetof(struct mpc52xx_sclpc, fifo=
_data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 16 * 1024 * 1024);
> @@ -469,7 +481,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_bcom_rx_irq;
>
> =A0 =A0 =A0 =A0/* Request the Bestcomm transmit (memory --> fifo) task an=
d IRQ */
> - =A0 =A0 =A0 lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(4,
> + =A0 =A0 =A0 lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(2,

ditto

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 res.start + offsetof(struct mpc52xx_sclpc, fifo=
_data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 BCOM_INITIATOR_SCLPC,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 BCOM_IPR_SCLPC);
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
