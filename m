Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id C8FB0DDF04
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 22:11:00 +1000 (EST)
Date: Mon, 14 Jul 2008 13:10:54 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH v2 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Message-ID: <20080714121054.GB25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083934.15025.86862.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080712083934.15025.86862.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 12, 2008 at 02:39:34AM -0600, Grant Likely wrote:

> This is an I2S bus driver for the MPC5200 PSC device.  It is probably
> will not be merged as-is because it uses v1 of the ASoC API, but I want
> to get it out there for comments.

Looks basically good.  A few things below, plus you probably want to run
checkpatch over it.

> +/* Bestcomm DMA irq handler */
> +static irqreturn_t psc_i2s_bcom_irq(int irq, void *_psc_i2s_stream)
> +{
> +	struct psc_i2s_stream *s = _psc_i2s_stream;
> +
> +	//spin_lock(&s->psc_i2s->lock);

Either the lock is needed or it isn't :) .

> + * If this is the first stream open, then grab the IRQ and program most of
> + * the PSC registers.

> +static int psc_i2s_startup(struct snd_pcm_substream *substream)
> +{

The comment here doesn't seem to reflect what the function does - it
looks to just unconditionally reinitialise the controller with things
like this:

> +	/* Disable all interrupts and reset the PSC */
> +	out_be16(&regs->mpc52xx_psc_imr, 0);
> +	out_8(&regs->command, 3 << 4); /* reset transmitter */
> +	out_8(&regs->command, 2 << 4); /* reset receiver */
> +	out_8(&regs->command, 1 << 4); /* reset mode */
> +	out_8(&regs->command, 4 << 4); /* reset error */

which I'd imagine might upset running streams?

> +static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
> +{

> +       case SNDRV_PCM_TRIGGER_STOP:

> +       case SNDRV_PCM_TRIGGER_STOP:

> +	default:
> +		dev_dbg(psc_i2s->dev, "invalid command\n");
> +		return -EINVAL;
> +	}

This doesn't handle the pause, suspend, resume or pause_release
triggers.  If there's really nothing to do for those it should ignore
them, especially given the default: behaviour.
