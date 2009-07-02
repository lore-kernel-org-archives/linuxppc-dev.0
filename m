Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D8EC1B710E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 05:14:14 +1000 (EST)
Received: from mail-gx0-f216.google.com (mail-gx0-f216.google.com
	[209.85.217.216]) by ozlabs.org (Postfix) with ESMTP id CC262DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 05:14:13 +1000 (EST)
Received: by gxk12 with SMTP id 12so2843114gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Jul 2009 12:14:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090702175725.15773.37291.stgit@localhost.localdomain>
References: <20090702175719.15773.58956.stgit@localhost.localdomain>
	<20090702175725.15773.37291.stgit@localhost.localdomain>
Date: Thu, 2 Jul 2009 15:06:37 -0400
Message-ID: <9e4733910907021206s5bb9f7e8xfba1eee7e9d02398@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: add locking to mpc5200-psc-ac97 driver
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 2, 2009 at 1:57 PM, Grant Likely<grant.likely@secretlab.ca> wro=
te:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> AC97 bus register read/write hooks need to provide locking, but the
> mpc5200-psc-ac97 driver does not. =A0This patch adds a mutex around
> the register access routines.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Jon Smirl <jonsmirl@gmail.com>

> ---
>
> =A0sound/soc/fsl/mpc5200_dma.c =A0 =A0 =A0| =A0 =A01 +
> =A0sound/soc/fsl/mpc5200_dma.h =A0 =A0 =A0| =A0 =A01 +
> =A0sound/soc/fsl/mpc5200_psc_ac97.c | =A0 13 ++++++++++++-
> =A03 files changed, 14 insertions(+), 1 deletions(-)
>
>
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index efec33a..f0a2d40 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -456,6 +456,7 @@ int mpc5200_audio_dma_create(struct of_device *op)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> =A0 =A0 =A0 =A0spin_lock_init(&psc_dma->lock);
> + =A0 =A0 =A0 mutex_init(&psc_dma->mutex);
> =A0 =A0 =A0 =A0psc_dma->id =3D be32_to_cpu(*prop);
> =A0 =A0 =A0 =A0psc_dma->irq =3D irq;
> =A0 =A0 =A0 =A0psc_dma->psc_regs =3D regs;
> diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
> index 2000803..8d396bb 100644
> --- a/sound/soc/fsl/mpc5200_dma.h
> +++ b/sound/soc/fsl/mpc5200_dma.h
> @@ -55,6 +55,7 @@ struct psc_dma {
> =A0 =A0 =A0 =A0unsigned int irq;
> =A0 =A0 =A0 =A0struct device *dev;
> =A0 =A0 =A0 =A0spinlock_t lock;
> + =A0 =A0 =A0 struct mutex mutex;
> =A0 =A0 =A0 =A0u32 sicr;
> =A0 =A0 =A0 =A0uint sysclk;
> =A0 =A0 =A0 =A0int imr;
> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc=
_ac97.c
> index 9b8503f..7eb5499 100644
> --- a/sound/soc/fsl/mpc5200_psc_ac97.c
> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
> @@ -34,11 +34,14 @@ static unsigned short psc_ac97_read(struct snd_ac97 *=
ac97, unsigned short reg)
> =A0 =A0 =A0 =A0int status;
> =A0 =A0 =A0 =A0unsigned int val;
>
> + =A0 =A0 =A0 mutex_lock(&psc_dma->mutex);
> +
> =A0 =A0 =A0 =A0/* Wait for command send status zero =3D ready */
> =A0 =A0 =A0 =A0status =3D spin_event_timeout(!(in_be16(&psc_dma->psc_regs=
->sr_csr.status) &
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MPC52xx_PS=
C_SR_CMDSEND), 100, 0);
> =A0 =A0 =A0 =A0if (status =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("timeout on ac97 bus (rdy)\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&psc_dma->mutex);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
>
> @@ -54,16 +57,19 @@ static unsigned short psc_ac97_read(struct snd_ac97 *=
ac97, unsigned short reg)
> =A0 =A0 =A0 =A0if (status =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("timeout on ac97 read (val) %x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in_be16(&p=
sc_dma->psc_regs->sr_csr.status));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&psc_dma->mutex);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/* Get the data */
> =A0 =A0 =A0 =A0val =3D in_be32(&psc_dma->psc_regs->ac97_data);
> =A0 =A0 =A0 =A0if (((val >> 24) & 0x7f) !=3D reg) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("reg echo error on ac97 read\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&psc_dma->mutex);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0val =3D (val >> 8) & 0xffff;
>
> + =A0 =A0 =A0 mutex_unlock(&psc_dma->mutex);
> =A0 =A0 =A0 =A0return (unsigned short) val;
> =A0}
>
> @@ -72,16 +78,21 @@ static void psc_ac97_write(struct snd_ac97 *ac97,
> =A0{
> =A0 =A0 =A0 =A0int status;
>
> + =A0 =A0 =A0 mutex_lock(&psc_dma->mutex);
> +
> =A0 =A0 =A0 =A0/* Wait for command status zero =3D ready */
> =A0 =A0 =A0 =A0status =3D spin_event_timeout(!(in_be16(&psc_dma->psc_regs=
->sr_csr.status) &
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MPC52xx_PS=
C_SR_CMDSEND), 100, 0);
> =A0 =A0 =A0 =A0if (status =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("timeout on ac97 bus (write)\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/* Write data */
> =A0 =A0 =A0 =A0out_be32(&psc_dma->psc_regs->ac97_cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((reg & 0x7f) << 24) | (va=
l << 8));
> +
> + out:
> + =A0 =A0 =A0 mutex_unlock(&psc_dma->mutex);
> =A0}
>
> =A0static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
