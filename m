Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 18C8DDDE28
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 20:53:43 +1000 (EST)
Date: Wed, 23 Jul 2008 11:53:37 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/2] Allow a custom ASOC machine driver with
	soc-of-simple
Message-ID: <20080723105334.GC8377@sirena.org.uk>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080722235351.11648.56387.stgit@terra>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 07:53:51PM -0400, Jon Smirl wrote:

> Allow a custom ASOC machine driver with soc-of-simple

As with the clocking configuration: this looks fine from an ASoC point
of view but please fix the checkpatch warnings.  However...

>  	/* Only register the device if both the codec and platform have
>  	 * been registered */
> -	if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
> +	if ((!of_soc->device.codec_data) || (!of_soc->platform_node) || !machine_name)
>  		return;

...this doesn't just allow a custom machine driver, it requires that
something configures at least the machine name.  That's not a problem
from the ASoC point of view but possibly from the PowerPC side?
