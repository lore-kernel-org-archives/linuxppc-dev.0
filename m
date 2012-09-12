Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by ozlabs.org (Postfix) with ESMTP id B9FB82C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 13:11:36 +1000 (EST)
Date: Wed, 12 Sep 2012 11:11:22 +0800
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 3/5] ASoC: fsl: mpc5200-soc-audio driver
Message-ID: <20120912031121.GG9162@opensource.wolfsonmicro.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-4-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347416089-23393-4-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2012 at 10:14:47PM -0400, Eric Millbrandt wrote:
> Add a generic mpc5200 driver that allows asoc cards to be defined in the
> device tree.

ASoC - you've misspelt this throughout.

This changelog should discuss the subset of devices supported by your
binding, it's only possible to define bindings like this for a subset of
possible cards.  Looking at the code it seems like this driver can only
work for CODECs which require no runtime configuration (which is a very
small subset of CODEC drivers).

> --- a/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt

Audio bindings generally go under sound.

> +Multiple DAI nodes may be attached to a sound node
> +- stream-name         - The asoc name of the platform DAI stream
> +- codec-name          - The name of codec to bind to
> +- codec-dai-name      - The codec DAI to bind to
> +- cpu-dai-name        - The cpu DAI to bind to

What are the allowable values for these strings?

> +config SND_MPC52xx_SOC_AUDIO
> +	tristate "SoC Generic Audio support for MPC5200"
> +	depends on (SND_SOC_MPC5200_AC97 || SND_SOC_MPC5200_I2S)

It seems wrong that this depends on both AC'97 and I2S - users should be
able to use one or the other.  Given how AC'97 works we really should be
defining it as a bus in the device tree anyway, and ideally trying to
enumerate the CODECs at runtime, so it should probably be a separate
binding.

> +#define DEBUG

Remove this for mainline.

> +	card = kzalloc(sizeof(struct snd_soc_card), GFP_KERNEL);

devm_kzalloc()
