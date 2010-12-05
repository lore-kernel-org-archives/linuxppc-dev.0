Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1AA7B70CD
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Dec 2010 02:34:48 +1100 (EST)
Subject: Re: PowerMac G4 (Digital Audio)
From: Johannes Berg <johannes@sipsolutions.net>
To: Risto Suominen <risto.suominen@gmail.com>
In-Reply-To: <AANLkTinaCDvnOCy1e1Ca92hZO5UuB-9HKe4rvLg7TUEx@mail.gmail.com>
References: <AANLkTinaCDvnOCy1e1Ca92hZO5UuB-9HKe4rvLg7TUEx@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 05 Dec 2010 16:16:18 +0100
Message-ID: <1291562178.3495.6.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Your snd-aoa seems to support PowerMac3,4. Is it really tested?

I used to add only IDs that some people tested, until most things worked
and I wholesale added all of the ones found in Darwin.

> The reason I'm asking: people are having problems with sound on that
> machine. Even snd-powermac didn't function, but I believe these
> patches have helped:
> 
> http://ristosu.wippiespace.com/pub/alsa-tumbler-1.0.22.1-p15.diff
> http://ristosu.wippiespace.com/pub/alsa-tumbler-1.0.22.1-p16.diff

These patches are odd -- the first one adds something the second
removes? Am I supposed to look at the combination?

> The problem is that active state is inverted (i.e. 1) compared to
> other machines on inputs that detect a plug (and there is no
> audio-gpio-active-state in the device tree in gpio 15 and gpio16).
> Snd-powermac guessed wrong.
> 
> How do you handle these in your code?

Well, there is gpio-feature and gpio-pmf right now. I suspect you can
get things working by adding some overrides to ftr_gpio_init(). I guess
you want something like

get_gpio("keywest-gpio1", NULL,
         &lineout_mute_gpio,
         &lineout_mute_gpio_activestate);

on the PowerMac4,3, and something else for the headphone ...

But frankly, it's been so long that it's not all making perfect sense to
me right now. If you send me a tarball of /proc/device-tree/ maybe I can
take a look -- just looked at my collection and I don't have that one.

johannes
