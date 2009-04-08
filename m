Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4B21DDFBE
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 06:49:12 +1000 (EST)
Date: Wed, 8 Apr 2009 22:48:58 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
Message-ID: <20090408224858.04cb6dc4@hyperion.delvare>
In-Reply-To: <1239205899.16477.32.camel@johannes.local>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
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

Hi Johannes,

Thanks for the fast answer.

On Wed, 08 Apr 2009 17:51:39 +0200, Johannes Berg wrote:
> > Basically the idea is to move the I2C device instantiation from the
> > codec drivers (onyx, tas) to the I2C adapter driver (i2c-powermac.)
> > This follows the Linux device driver model, requires slightly less
> > code, runs faster and and lets the required chip drivers be loaded by
> > udev or similar automatically.
> 
> Sounds weird -- how do you handle codecs that could be on different
> buses? This seems to imply that any probing may potentially need to be
> duplicated across any bus driver they could possibly connected to. But
> that's not really relevant to this patch.

Yes, "probing" would be duplicated if we had to support more than one
bus. But as far as I can see, the onyx and tas devices can only be
found on i2c-powermac buses, so this shouldn't be an issue. And there
isn't really any probing going on, it's really only a matter of walking
a small subset of the device tree (the children of the I2C bus) and
instantiating I2C devices.

Out of curiosity, are there systems with more than one system I2C buses
(supported by i2c-powermac)?

If there were a significant amount of duplicated code, it could
certainly be addressed one way or another, but it wasn't my top
priority, and actually didn't seem that necessary. As a matter of fact,
my patch removes (slightly) more code than it adds.

> > The last driver to convert, keywest, is a mystery to me. I have a hard
> > time understanding how it interacts with tumbler and daca. I have the
> > feeling that it is essentially a glue module to workaround the legacy
> > i2c model limitations, so probably it could go away entirely now, but
> > I'm not sure how to do that in practice. Maybe tumbler and daca would
> > be made separate i2c drivers, I'm not sure.
> 
> Sorry, I'm not familiar with this code.
> 
> > One thing in particular which I find strange is that tumbler has
> > references to the TAS3004 device, much like the tas codec driver. It is
> > unclear to me whether tas is a replacement for tumbler, or if both
> > drivers work together, or if they are for separate hardware. I would
> > appreciate clarifications about this.
> 
> Well... tumbler also drives the very similar tas3001 codec.
> 
> However, I need to start with a little more background.
> 
> Apple machines can contain various codecs, for example the tas3004,
> which has various outputs. Due to the way Apple wires up the codec, you
> need platform fabric to identify which outputs are connected where, cf.
> sound/aoa/fabrics/layout.c. Note all machines have line-in for instance.
> 
> The aoa driver, which I wrote, currently supports only i2s buses for
> actually transferring data, but I think there are some other ways to get
> data to the codec -- I'm not too familiar with the old machines.
> 
> Now, aoa will currently automatically load from the layout fabric
> module, and then pull in the modules for the codecs it _knows_ to be
> present on the bus. Therefore, it seems that your patch makes things
> less efficient because you probe for all those codecs, and there's no
> machine that has all of them. The aoa fabric only loads the modules for
> those it knows to be present, and they then probe (and in reality the
> probing never fails because they really are there).

Can you please point me to the layout fabric / aoa fabric? I'd like to
understand how it works. Then I may be able to rewrite my patch
completely differently.

There are basically two ways to instantiate I2C devices in the new
model. The first method is to declare the I2C devices as platform data
and let i2c-core instantiate them. The second method is to have the i2c
bus driver instantiate the clients. My patch uses the second method
because I didn't know how to use the first method. However using the
first method would solve the issues you raised. But I need some help
from someone more familiar with the powermac platform initialization
code to get it right.

> Now, since aoa needs information on how the entire system is glued
> together (the fabric I was talking about with the line-in example), it
> has to infer that from platform data, in this case the device tree.
> Because I do not have any older machines, am lazy and snd-powermac works
> for the old machines, snd-powermac with its "tumbler" is a driver for
> the same tas3004 codec, but on a different, older, fabric.

I think I've found that one by now (snd_pmac_detect in
sound/ppc/pmac.c, right?), thanks for the clarification.

BTW, that code doesn't seem significantly different from what my patch
is adding to i2c-powermac.

> Once upon a time the plan was to get rid of snd-powermac entirely and
> port all its functionality into subdrivers of aoa, but that clearly
> never happened. No fairy-tale happy ending here, quite obviously.
> 
> Now, looking at your patch, I think it will break snd-powermac. See, if
> snd_aoa_codec_tas is automatically loaded on a system with an _old_
> fabric that aoa knows nothing about, snd-powermac can no longer be
> loaded. (Incidentally, snd-powermac cannot be auto-loaded at all
> currently, while aoa can via the fabric driver's device-tree binding)

Hmm, OK, I expected the code I moved from the aoa drivers to
i2c-powermac to only match the subset of machines actually supported by
aoa. If that's not the case then indeed it is incorrect.

> Therefore, probing the codecs in i2c-powermac and automatically loading
> the corresponding aoa module will break sound on old machines.

Does this mean that manually loading snd_aoa_codec_tas today on an old
system with a TAS would break sound too?

> I would think that if you removed the MODULE_DEVICE_TABLE from your
> patch, it may continue to work because the aoa fabric driver loads the
> modules as before, and on old machines nothing loads automatically and
> snd-powermac can be loaded manually.
> 
> However, it will still be less efficient because you will be probing
> _all_ those codecs, notably the tas family, even on machines that are
> known to not have it (machines that have onyx). Putting that mutual
> exclusion information into i2c-powermac would be misplaced, imho.
> 
> Note also that there's one more codec (topaz) which isn't currently
> supported.
> 
> In conclusion, I think that the old/existing/legacy i2c binding model
> was much better suited to platform knowledge about the way machines are
> put together, and the new code is, as far as I can tell, less efficient
> -- contrary to your assertion.

My comment about efficiency was related to the fact that the sound chip
detection code would run only on the i2c-power mac bus, rather than all
I2C buses on the system. Admittedly I had missed the larger picture of
all detections running on all powermac systems, which wasn't the case
so far.

Anyway, the key point of my patch is to get rid of the legacy i2c
binding model, not efficiency.

> Since I'm away from all machines I could test this with I have no data
> on any that or the module device table thing I pointed out for now.
> 
> Anyway, some more technical comments on your patch:
>  * I realise you just copied things around but it would be nice to clean
>    up the coding style, especially comment style, a little while at it.
>    (yeah, it's my fault)

I can fix anything you like, just tell me what :)

>  * aoa_codec_* is the module name, I see no reason to use that as the
>    i2c name, that should be the codec's name instead (aka pcm3052 etc)

The names are totally arbitrary and we can change them if you like.
Keep in mind though that we should avoid using mere chip names for
non-generic drivers. The aoa drivers are powermac-specific, we don't
want the names we pick to collide with another driver, that's why I
chose to keep the aoa prefix.

-- 
Jean Delvare
