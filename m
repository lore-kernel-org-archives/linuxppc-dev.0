Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 96DA1DDFD7
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 19:58:32 +1000 (EST)
Date: Fri, 18 Jul 2008 10:58:25 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 3/3] ALSA SoC: Add Texas
	Instruments	TLV320AIC26 codec driver
Message-ID: <20080718095823.GA14416@sirena.org.uk>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<1214995713.4882.54.camel@localhost.localdomain>
	<20080712060018.GB23213@secretlab.ca>
	<20080712173609.GA6523@sirena.org.uk>
	<20080717233153.GA8187@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080717233153.GA8187@secretlab.ca>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org,
	timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 17, 2008 at 05:31:53PM -0600, Grant Likely wrote:
> On Sat, Jul 12, 2008 at 06:36:10PM +0100, Mark Brown wrote:

> > /sys/bus/platform/devices/soc-audio/codec_reg

> Yikes.  The AIC26 has registers all over the place and most of them are
> empty.  The codec_reg attribute handling means I need to maintain a
> cache of the entire register file; not just the part that is actually
> used.  Oh well; I can work around it.

Sparse (or sparsely used) register maps are pretty common - in practice
it's not been a problem to just have a cache that covers everything and
only gets read, the amount of data involved is rarely that large in the
context of what you need to store the audio you're working with.
