Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07A5867B5E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2005 23:16:02 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1113483344.5614.17.camel@localhost>
References: <1113113792.9517.476.camel@gaston>
	<1113483344.5614.17.camel@localhost>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 23:15:14 +1000
Message-Id: <1113484515.5516.100.camel@gaston>
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

On Thu, 2005-04-14 at 14:55 +0200, Johannes Berg wrote:
> Hi,
> 
> > This patch hacks the current Alsa snd-powermac driver to add support for
> > recent machine models with the tas3004 chip, that is basically new
> > laptop models.
> 
> So this works, but is incompatible with gstreamer. I took it with a
> rhythmbox/gstreamer developer and he said that it's a driver issue. A
> gstreamer log is here:
> http://johannes.sipsolutions.net/files/rhythmbox-alsa-debug
> (produced by GST_DEBUG=alsa*:5 rhythmbox 2>&1 | tee logfile)
> 
> He also asked me to try
> $ gst-launch-0.8 sinesrc ! alsasink device=hw:0
> 
> which yields:
> RUNNING pipeline ...
> ERROR: pipeline doesn't want to play.
> 
> So the conclusion was:
> "set_periods_near ioctl does something weird"
> 
> Any ideas?

I don't know, this is definitely not a problem with the platform
specific part of the driver, which is what I've been dealin with lately.
You may find a better answer with the Alsa folks regarding the actual
PCM implementation.
