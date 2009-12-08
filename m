Return-Path: <wim@iguana.be>
Received: from mailrelay011.isp.belgacom.be (mailrelay011.isp.belgacom.be
	[195.238.6.178]) by ozlabs.org (Postfix) with ESMTP id C0130B6F10
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 07:48:56 +1100 (EST)
Date: Tue, 8 Dec 2009 21:48:54 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] mpc52xx/wdt: WDT uses GPT api
Message-ID: <20091208204854.GE4291@infomag.iguana.be>
References: <fa686aa40911101159y7bef3f9bte74e9aeb5c6e864b@mail.gmail.com>
	<1257884778.14374.5@antares>
	<20091112213630.GE19336@infomag.iguana.be>
	<fa686aa40911122221s24efdcc9k1daf63b600e7b429@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40911122221s24efdcc9k1daf63b600e7b429@mail.gmail.com>
Cc: Albrecht =?iso-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>,
	devicetree-discuss@lists.ozlabs.org,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

Sorry for the delay, I need to deliver a project in a weeks time...

> In actual fact, it is a single device with multiple functions, some of
> which can be used at the same time.  The driver for the device
> determines what the device instance supports and registers the
> appropriate interfaces.  There is a GPIO controller, a PWM controller,
> a general purpose timer, and the watchdog.  Because of the
> multifunction nature of the device, there are subtle interactions
> between the functions that the driver needs to maintain.  I don't want
> to export functions from the driver which will only be used by a
> watchdog instance.  I also don't want the added code and complexity of
> a secondary probe path.  It is simpler and less code to roll all the
> behaviour up into the one driver single driver that gets probed once.
> 
> >From the maintenance perspective, having the main driver in
> arch/powerpc and the watchdog bit in drivers/watchdog doesn't really
> help much anyway because anything that changes the internal driver API
> (between the core and watchdog bits) will require cross-maintainer
> changes.  ie. do changes go through my tree because they touch
> arch/powerpc, or do they go through yours because they touch
> drivers/watchdog?  I'd much rather all the internal details be
> contained within a single driver.

Your argument about maintenance is the same one as I have: If all watchdog
driver pieces are under drivers/watchdog then it's easier for me to maintain
them. (Definitely if we are doing clean-up work and API changes).

> Besides, there is already precedence for very arch-specific drivers
> living under arch/*/.  find ./arch -name *gpio*

But in this case: I know where to find them and I will keep a mental note
about this one. And yes indeed some very arch specific drivers can reside
under arch/*/* .

So please go ahead with pulling this one in a single driver.

Kind regards,
Wim.
