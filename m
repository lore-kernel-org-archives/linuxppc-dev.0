Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFCEC679F6
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 08:03:54 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h7j4m40kf.wl%tiwai@suse.de>
References: <1147780945.29795.110.camel@johannes>
	<s5h7j4m40kf.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Wed, 17 May 2006 08:03:43 +1000
Message-Id: <1147817023.6753.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	ALSA development <alsa-devel@alsa-project.org>,
	Benjamin Berg <benjamin@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-16 at 14:27 +0200, Takashi Iwai wrote:
> At Tue, 16 May 2006 14:02:20 +0200,
> Johannes Berg wrote:
> > 
> > Apparently all alsa userspace programs including alsamixer suck. Hence,
> > this patch is required to make them work properly. Why is it so hard to
> > do these additions/subtractions in the program or maybe even in the alsa
> > library? The alsa libraries already think they know better and mess up
> > all kinds of things.
> 
> It's a pretty stupid question to ask why you are stupid :)
> 
> I don't think it's alsa-lib that prevents the negative or non-zero
> integer range.  The fact amixer works implies that it's an
> app-specific bug.  But I'm not 100% sure and need more
> inside-looking.

Well, the problem I think is that pretty much all apps but amixer (and
alsamixer whch works too for me at least) are bogus. It would have been
good if Alsa had a more explicit specification that those values are not
to be interpreted in the old OSS range :) In fact, best would have been
to have the control structure carry a "unit" which a set of known units,
one being dB, since the natural way of specifying an attenuation on any
serious audio HW is dB and is negative... 

> > What are your opinions on this? Should this be required? And if so, why
> > do we even have the value.integer.min when we can't use it anyway? 
> 
> Right now, the range 0-max would make your life easier, I guess.
> 
> The min value is an API definition, and implemented and worked once.
> But no drivers used yet.  So, there might be a breakage.  It's of
> course to be fixed.

There is a lack of serious/professional audio drivers in the linux world
unfortunately... 

Ben.
