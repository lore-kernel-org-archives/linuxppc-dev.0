Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 97913DDFBC
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 23:49:38 +1000 (EST)
Date: Mon, 14 Jul 2008 14:49:32 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and	codec drivers
Message-ID: <20080714134930.GC25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
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

On Sat, Jul 12, 2008 at 02:39:29AM -0600, Grant Likely wrote:

> Simple utility layer for creating ASoC machine instances based on data
> in the OpenFirmware device tree.  OF aware platform drivers and codec
> drivers register themselves with this framework and the framework
> automatically instantiates a machine driver.

Ideally someone from the PowerPC community would sign off on this -
given the nature and volume of discussion people obviously have very
strong opinions about how machine drivers should be done so I'd really
like to see some community buy in for something like this.  From an ASoC
point of view if this works it's fine.

> This is most likely temporary glue code to work around limitations in
> the ASoC v1 framework.  I expect ASoC v2 won't need this.

It will need some way of providing a machine driver, generic (like this
one) or otherwise.

> +static void of_snd_soc_register_device(struct of_snd_soc_device *of_soc)
> +{
> +	struct platform_device *pdev;
> +	int rc;
> +
> +	/* Only register the device if both the codec and platform have
> +	 * been registered */
> +	if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
> +		return;
> +
> +	pr_info("platform<-->codec match achieved; registering machine\n");

So what this does is add an extremely simple machine driver which
matches up the first DAI on a single codec and platform with no facility
for setting up any configurable clocking or anything?  This is fine in
so far as it goes but it's going to work for very few systems as it is -
most codecs will need some additional configuration.  This could be
added later, though.

Given this it might be worth renaming it to something less generic and
perhaps pushing it down into an of directory below the main ASoC
directory to parallel existing machine drivers.  I'm happy with the code
from an ASoC point of view.
