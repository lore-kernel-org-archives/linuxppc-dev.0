Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f218.google.com (mail-gx0-f218.google.com
	[209.85.217.218]) by ozlabs.org (Postfix) with ESMTP id D4468B7BB3
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 05:16:48 +1100 (EST)
Received: by gxk10 with SMTP id 10so4088305gxk.3
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Oct 2009 11:16:46 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1254764467.5503.1@antares>
References: <1254764467.5503.1@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 5 Oct 2009 12:16:26 -0600
Message-ID: <fa686aa40910051116l6439eef7xc9f75c6ac4368094@mail.gmail.com>
Subject: Re: [PATCH/v2] powerpc/5200: make BestComm gen_bd microcode
	exchangeable
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 5, 2009 at 11:41 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> This patch adds a method for defining different microcodes than the pe-de=
fined ones for the MPC52xx's BestComm General Buffer Descriptor (gen_db) ta=
sks. =A0The default microcode is still the one from bcom_gen_bd_[rt]x_task,=
 but it can be replaced by calling bcom_gen_bd_set_microcode() which is mor=
e efficient than explicitly loading it via bcom_load_image() after each bco=
m_gen_bd_[rt]x_reset().
>
> Except for a fixed tab vs. space formatting and the transfer format, ther=
e are no diffierences to the initial attempt.

Hmmm.  I've not been comfortable with this change, but it took me a
while to put my finger on exactly why.  In principle, I think it is a
good idea.  However, I don't want to merge it without any in-tree
users.

The other concern is that I don't like that the patch is only
applicable to gen_bd tasks.  I've been thinking about this for a
while, and I'm not exactly thrilled with the bestcomm layout which
keeps the bestcomm firmware separate from the only driver that
actually uses it (ie FEC firmware & support code is separate from the
FEC driver.  Same for ATA).  I don't like the fact that code which is
only ever used by the ATA driver is maintained completely separate
from it.  But I may be splitting hairs here and maybe I shouldn't be
too concerned about it.  Regardless, I'd think I'd rather see
something that isn't totally gen_bd specific.  Perhaps *microcode
should be part of the bcom_task structure?

Thoughts?

g.

>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
>
>
> ---
>
>
> diff -uprN -X linux-2.6.32-rc3/Documentation/dontdiff linux-2.6.32-rc3-or=
ig/arch/powerpc/sysdev/bestcomm/gen_bd.c linux-2.6.32-rc3/arch/powerpc/sysd=
ev/bestcomm/gen_bd.c
> --- linux-2.6.32-rc3-orig/arch/powerpc/sysdev/bestcomm/gen_bd.c 2009-10-0=
5 02:12:30.000000000 +0200
> +++ linux-2.6.32-rc3/arch/powerpc/sysdev/bestcomm/gen_bd.c =A0 =A0 =A0200=
9-10-05 14:52:31.000000000 +0200
> @@ -78,6 +78,7 @@ struct bcom_gen_bd_priv {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 initiator;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 ipr;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 maxbufsize;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 *microcode;
> =A0};
>
>
> @@ -104,6 +105,7 @@ bcom_gen_bd_rx_init(int queue_len, phys_
> =A0 =A0 =A0 =A0priv->initiator =3D initiator;
> =A0 =A0 =A0 =A0priv->ipr =A0 =A0 =A0 =3D ipr;
> =A0 =A0 =A0 =A0priv->maxbufsize =3D maxbufsize;
> + =A0 =A0 =A0 priv->microcode =3D bcom_gen_bd_rx_task;
>
> =A0 =A0 =A0 =A0if (bcom_gen_bd_rx_reset(tsk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_task_free(tsk);
> @@ -128,7 +130,7 @@ bcom_gen_bd_rx_reset(struct bcom_task *t
> =A0 =A0 =A0 =A0var =3D (struct bcom_gen_bd_rx_var *) bcom_task_var(tsk->t=
asknum);
> =A0 =A0 =A0 =A0inc =3D (struct bcom_gen_bd_rx_inc *) bcom_task_inc(tsk->t=
asknum);
>
> - =A0 =A0 =A0 if (bcom_load_image(tsk->tasknum, bcom_gen_bd_rx_task))
> + =A0 =A0 =A0 if (bcom_load_image(tsk->tasknum, priv->microcode))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> =A0 =A0 =A0 =A0var->enable =A0 =A0 =3D bcom_eng->regs_base +
> @@ -188,6 +190,7 @@ bcom_gen_bd_tx_init(int queue_len, phys_
> =A0 =A0 =A0 =A0priv->fifo =A0 =A0 =A0=3D fifo;
> =A0 =A0 =A0 =A0priv->initiator =3D initiator;
> =A0 =A0 =A0 =A0priv->ipr =A0 =A0 =A0 =3D ipr;
> + =A0 =A0 =A0 priv->microcode =3D bcom_gen_bd_tx_task;
>
> =A0 =A0 =A0 =A0if (bcom_gen_bd_tx_reset(tsk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_task_free(tsk);
> @@ -212,7 +215,7 @@ bcom_gen_bd_tx_reset(struct bcom_task *t
> =A0 =A0 =A0 =A0var =3D (struct bcom_gen_bd_tx_var *) bcom_task_var(tsk->t=
asknum);
> =A0 =A0 =A0 =A0inc =3D (struct bcom_gen_bd_tx_inc *) bcom_task_inc(tsk->t=
asknum);
>
> - =A0 =A0 =A0 if (bcom_load_image(tsk->tasknum, bcom_gen_bd_tx_task))
> + =A0 =A0 =A0 if (bcom_load_image(tsk->tasknum, priv->microcode))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> =A0 =A0 =A0 =A0var->enable =A0 =A0 =3D bcom_eng->regs_base +
> @@ -253,6 +256,15 @@ bcom_gen_bd_tx_release(struct bcom_task
> =A0}
> =A0EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_release);
>
> +void
> +bcom_gen_bd_set_microcode(struct bcom_task *tsk, u32 *microcode)
> +{
> + =A0 =A0 =A0 struct bcom_gen_bd_priv *priv =3D tsk->priv;
> +
> + =A0 =A0 =A0 priv->microcode =3D microcode;
> +}
> +EXPORT_SYMBOL_GPL(bcom_gen_bd_set_microcode);
> +
> =A0/* -------------------------------------------------------------------=
--
> =A0* PSC support code
> =A0*/
> diff -uprN -X linux-2.6.32-rc3/Documentation/dontdiff linux-2.6.32-rc3-or=
ig/arch/powerpc/sysdev/bestcomm/gen_bd.h linux-2.6.32-rc3/arch/powerpc/sysd=
ev/bestcomm/gen_bd.h
> --- linux-2.6.32-rc3-orig/arch/powerpc/sysdev/bestcomm/gen_bd.h 2009-10-0=
5 02:12:30.000000000 +0200
> +++ linux-2.6.32-rc3/arch/powerpc/sysdev/bestcomm/gen_bd.h =A0 =A0 =A0200=
9-10-05 14:52:31.000000000 +0200
> @@ -43,6 +43,9 @@ bcom_gen_bd_tx_reset(struct bcom_task *t
> =A0extern void
> =A0bcom_gen_bd_tx_release(struct bcom_task *tsk);
>
> +extern void
> +bcom_gen_bd_set_microcode(struct bcom_task *tsk, u32 *microcode);
> +
>
> =A0/* PSC support utility wrappers */
> =A0struct bcom_task * bcom_psc_gen_bd_rx_init(unsigned psc_num, int queue=
_len,
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
