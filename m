Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DA56DE147
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 22:15:45 +1000 (EST)
Date: Wed, 15 Apr 2009 14:15:30 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c    
	drivers
Message-ID: <20090415141530.0d5e47fc@hyperion.delvare>
In-Reply-To: <1239746399.4205.21.camel@johannes.local>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239723613.24771.8.camel@johannes.local>
	<1239724227.24771.9.camel@johannes.local>
	<1239730915.24771.12.camel@johannes.local>
	<20090414214949.736597d9@hyperion.delvare>
	<1239746399.4205.21.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 14 Apr 2009 23:59:59 +0200, Johannes Berg wrote:
> Hi Jean,
> 
> > Thanks for the quick test and sorry that it didn't work. I'll take a
> > look at the trace below and try to figure out what went wrong.
> 
> No worries, seems some error path is going wrong but I can't see what it
> is right now.
> 
> > Did you remove the 2 MODULE_DEVICE_TABLE from my patch? If you didn't,
> > please pick the latest version of my patch which doesn't have them:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/sound-aoa-codecs-convert-to-new-style.patch
> > I don't think they are the reason of the crash, but who knows...
> 
> No, I didn't, but I was loading the modules manually so that didn't kick
> in.
> 
> > Are you using a machine with onyx or tas? I guess onyx but I want to be
> > sure.
> 
> onyx only.
> 
> > > [   10.267137] snd-aoa-codec-onyx: found pcm3052
> > > [   10.267238] PM: Adding info for i2c:2-0046
> > > [   10.267926] snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match!
> > 
> > Does this error also happen without my patch? It would help to see the
> > logs without my patch to see where it starts diverging.
> 
> Yes -- this happens normally.

OK. I couldn't see how my patch would cause this error, so if it was
already there before, it's good news.

> > > [   10.267930] snd-aoa: fabric didn't like codec onyx
> > > [   10.268041] aoa_codec_onyx: probe of 2-0046 failed with error -22
> > 
> > Apparently aoa_codec_register failed in onyx_i2c_probe(), I have to
> > understand why.
> 
> Because the device-tree is broken -- there are two nodes for the same
> device, and only one of them can be used. Then the fabric rejects the
> first instantiation from the broken node. Here's how it looks normally:
> 
> ...
> [   10.398296] snd-aoa-codec-onyx: found pcm3052
> [   10.398472] PM: Adding info for i2c:2-0046
> [   10.412189] snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match!
> [   10.462593] snd-aoa: fabric didn't like codec onyx
> [   10.468030] PM: Removing info for i2c:2-0046
> [   10.473892] snd-aoa-codec-onyx: found pcm3052
> [   10.479317] PM: Adding info for i2c:3-0046
> [   10.485631] snd-aoa-fabric-layout: can use this codec
> ...

OK, I understand better what is going on now. I do not understand the
crash at the end though, but I suspect it isn't a bug in my code but
simply a faulty error path which had never been taken before.

Now, the fact that there are two nodes, one right and one wrong, is
quite a problem. My code expected the device tree to be trustworthy.
The new i2c binding model cleanly separates the instantiation of
devices and their binding to a driver. The codec check which fails,
will cause the i2c device to not bind to its driver, but it will still
be present, while there is no underlying physical I2C device if I
understand properly. In the new i2c model, you have to ensure that an
i2c device exists _before_ you instantiate it.

Well, there is a dirty workaround, which I will apply for now, but...
ideally the layout factory should be revisited so that the codec check
happens earlier. Is this something you could help with?

That's something which isn't too clear to me: is there a physical
device at 2-0046 and 3-0046? The onyx codec is accepted for the latter,
however it seems that the test of a device presence at 2-0046 succeeds
as well...

-- 
Jean Delvare
