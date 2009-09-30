Return-Path: <khali@linux-fr.org>
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124])
	by ozlabs.org (Postfix) with ESMTP id 7D1D5B7BBE
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2009 01:00:09 +1000 (EST)
Date: Wed, 30 Sep 2009 17:00:06 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] sound: Don't assume i2c device probing always succeeds
Message-ID: <20090930170006.76e145ca@hyperion.delvare>
In-Reply-To: <s5hbpksy0yq.wl%tiwai@suse.de>
References: <20090930152542.3ef753ee@hyperion.delvare>
	<s5hbpksy0yq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	Tim Shepard <shep@alum.mit.edu>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Takashi,

Thanks for the swift reply.

On Wed, 30 Sep 2009 16:13:49 +0200, Takashi Iwai wrote:
> At Wed, 30 Sep 2009 15:25:42 +0200,
> Jean Delvare wrote:
> > 
> > If i2c device probing fails, then there is no driver to dereference
> > after calling i2c_new_device(). Stop assuming that probing will always
> > succeed, to avoid NULL pointer dereferences. We have an easier access
> > to the driver anyway.
> > 
> > Reported-by: Tim Shepard <shep@alum.mit.edu>
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > ---
> > The code is similar to the one in therm_adt746x, for which Tim reported
> > a real-world oops, so it should be fixed ASAP.
> 
> Jean, thanks for the patch.
> 
> I'm just wondering whether the additional NULL check of client->driver
> would be enough?  If yes, sound/aoa/onyx.c has it, at least, and we
> can add the similar checks to the rest, too.

The NULL check of client->driver, if followed by a call to
i2c_unregister_device(), would indeed be enough. But unlike the onyx
driver which we know we sometimes load erroneously, the other drivers
should never fail. I am reluctant to add code to handle error cases
which are not supposed to happen, which is why I prefer my proposed
fix: it does not add code.

That being said, I will be happy with any solution that fixes the
problem, so if you prefer client->driver NULL checks, I can send a
patch doing this.

Thanks,
-- 
Jean Delvare
