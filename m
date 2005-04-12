Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCEB367B31
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2005 10:05:58 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <425A92B1.6080907@sipsolutions.net>
References: <1113113792.9517.476.camel@gaston>
	<425A92B1.6080907@sipsolutions.net>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 10:04:50 +1000
Message-Id: <1113264290.5388.16.camel@gaston>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] pmac: sound support for latest laptops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-04-11 at 17:07 +0200, Johannes Berg wrote:
> Hi,
> 
> >This patch hacks the current Alsa snd-powermac driver to add support for
> >recent machine models with the tas3004 chip, that is basically new
> >laptop models. The Mac Mini is _NOT_ yet supported by this patch (soon
> >soon ...). The G5s (iMac or Desktop) will need the rewritten sound
> >driver on which I'm working on (I _might_ get a hack for analog only on
> >some G5s on the current driver, but no promise).
> >  
> >
> That's cool. I do have one slight problem with it though: When I turn 
> down the Master mixer and up PCM it sounds badly overmodulated. I can 
> keep PCM at about 75% and turn up master, and all is fine. Would it make 
> sense to limit the PCM mixer to about 75% of its current limits, or how 
> does that actually work in the hardware?

Well, the driver will let you do the setting you want, even if it's
wrong :) You should indeed keep PCM at about 75% and use the master.

There is also an issue with bad quality speakers used by Apple. OS X has
a built-in software DSP that does equalisation & filtering in the kernel
driver, and they have specific settings for it for various machine model
speakers. Obviously, we don't have such thing.

Ben.
