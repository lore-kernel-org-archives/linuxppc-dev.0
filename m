Return-Path: <michael@evidence.eu.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0F8A5B710B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 05:36:19 +1000 (EST)
Received: from panicking.kicks-ass.org (unknown [77.224.194.88])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1D08DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 05:36:17 +1000 (EST)
Message-ID: <4A4D05AB.1090306@evidence.eu.com>
Date: Thu, 02 Jul 2009 21:08:27 +0200
From: michael <michael@evidence.eu.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] ASoC: add locking to mpc5200-psc-ac97 driver
References: <20090702175719.15773.58956.stgit@localhost.localdomain>
	<20090702175725.15773.37291.stgit@localhost.localdomain>
In-Reply-To: <20090702175725.15773.37291.stgit@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> AC97 bus register read/write hooks need to provide locking, but the
> mpc5200-psc-ac97 driver does not.  This patch adds a mutex around
> the register access routines.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  sound/soc/fsl/mpc5200_dma.c      |    1 +
>  sound/soc/fsl/mpc5200_dma.h      |    1 +
>  sound/soc/fsl/mpc5200_psc_ac97.c |   13 ++++++++++++-
>  3 files changed, 14 insertions(+), 1 deletions(-)
>
>
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index efec33a..f0a2d40 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -456,6 +456,7 @@ int mpc5200_audio_dma_create(struct of_device *op)
>  		return -ENODEV;
>  
>  	spin_lock_init(&psc_dma->lock);
> +	mutex_init(&psc_dma->mutex);
>  	psc_dma->id = be32_to_cpu(*prop);
>  	psc_dma->irq = irq;
>  	psc_dma->psc_regs = regs;
> diff --git a/sound/soc/fsl/mpc5200_dma.h b/sound/soc/fsl/mpc5200_dma.h
> index 2000803..8d396bb 100644
> --- a/sound/soc/fsl/mpc5200_dma.h
> +++ b/sound/soc/fsl/mpc5200_dma.h
> @@ -55,6 +55,7 @@ struct psc_dma {
>  	unsigned int irq;
>  	struct device *dev;
>  	spinlock_t lock;
> +	struct mutex mutex;
>  	u32 sicr;
>  	uint sysclk;
>  	int imr;
> diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
> index 9b8503f..7eb5499 100644
> --- a/sound/soc/fsl/mpc5200_psc_ac97.c
> +++ b/sound/soc/fsl/mpc5200_psc_ac97.c
> @@ -34,11 +34,14 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
>  	int status;
>  	unsigned int val;
>  
> +	mutex_lock(&psc_dma->mutex);
> +
>  	/* Wait for command send status zero = ready */
>  	status = spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
>  				MPC52xx_PSC_SR_CMDSEND), 100, 0);
>  	if (status == 0) {
>  		pr_err("timeout on ac97 bus (rdy)\n");
> +		mutex_unlock(&psc_dma->mutex);
>  		return -ENODEV;
>   
maybe define an err variable and and a goto out.

Michael
