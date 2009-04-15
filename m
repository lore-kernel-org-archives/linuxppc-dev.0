Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB22DDDFAE
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 23:52:54 +1000 (EST)
Date: Wed, 15 Apr 2009 15:52:36 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
Message-ID: <20090415155236.379479b7@hyperion.delvare>
In-Reply-To: <1239801490.9071.11.camel@johannes.local>
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
	<20090415141530.0d5e47fc@hyperion.delvare>
	<1239799934.9071.4.camel@johannes.local>
	<20090415150632.0b2fe6bb@hyperion.delvare>
	<1239801490.9071.11.camel@johannes.local>
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

On Wed, 15 Apr 2009 15:18:10 +0200, Johannes Berg wrote:
> On Wed, 2009-04-15 at 15:06 +0200, Jean Delvare wrote:
> > Yes, i2c core or even driver core. I'll see if I can reproduce it.
> 
> Alright.

Hmm, couldn't reproduce it. Maybe it is fixed in rc2. I don't have too
much time to spend on this, so if we don't hit it again I consider it
solved.

> > (...)
> > What I had in mind was not so complex. Simply, we could move the
> > i2c_new_device() calls into layout_found_codec(). That way we can
> > decide to instantiate the I2C device if and only if check_codec() is
> > successful. This is more efficient that creating the device, letting
> > the driver attach to it, with probing eventually failing, and then
> > removing the device if it wasn't the right one.
> > 
> > That is, the i2c client would be a mere helper on top of struct
> > aoa_codec, rather than the other way around.
> 
> Ah. That would probably work, but right now I have little motivation to
> work on it -- I hardly use the G5 desktop machine any more.

OK, no problem. I don't want to force anyone to spend time on this. But
if anyone ever does and need my help for the i2c part, just drop me a
line!

> > Wow. One I2C device which can be reached through 2 different I2C buses?
> > First time I hear about something like this. Very odd. I can't see the
> > point of doing this.
> 
> Hmm. How do you know it's on different buses?

2-0046 fails and 3-0046 succeeds. The second number is the hexadecimal
I2C address, the first number is the I2C bus number. So, unless
i2c-powermac was told to register the same I2C bus twice (which would
be dangerous), the device can be accessed through 2 different buses.

> I don't really know
> anything -- all I know is that the DT is buggered and lists the codec
> twice. Since we can talk to both, then I'm sure it's just one chip, they
> wouldn't put the chip in twice when you can use only one of them :)

There's probably little point in trying to guess anything further, the
only thing that would help are the detailed schematics of that part of
the board.

-- 
Jean Delvare
