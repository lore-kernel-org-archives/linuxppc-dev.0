Return-Path: <lists@petig-baender.de>
Received: from e.frontend.um.mediaways.net (e.frontend.um.mediaways.net
	[62.53.231.247]) by ozlabs.org (Postfix) with SMTP id B4BA52BDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2004 04:17:39 +1100 (EST)
Message-ID: <41AB5995.9080009@petig-baender.de>
Date: Mon, 29 Nov 2004 18:17:09 +0100
From: Christof Petig <lists@petig-baender.de>
MIME-Version: 1.0
To: Frank Murphy <murphyf+xfree86@f-m.fm>
References: <200411232008.16854.murphyf+xfree86@f-m.fm>
	<200411270948.08054.murphyf+xfree86@f-m.fm>
	<1101607094.5176.0.camel@gaston>
	<200411282114.48141.murphyf+xfree86@f-m.fm>
	<1101674379.4653.9.camel@gaston>
	<1101721355.31317.209633721@webmail.messagingengine.com>
In-Reply-To: <1101721355.31317.209633721@webmail.messagingengine.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: debian-x@lists.debian.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: G3 iBook LCD brightness in X under kernel 2.4.25 and 2.6.8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Frank Murphy schrieb:
>>Well, the backlight control is done by writing to one of the LCD
>>register, you can try to track down the values in there and eventually
>>compare with 2.4
> 
> 
> I'll try to look at this, but I don't know very much about it.

is it possible that using acceleration in the X server puts the chip in 
a state which makes it hard for the kernel framebuffer to set brightness.

>>>I find it interesting that in the console the dimming works. I thought that on 
>>>PPC the console used the framebuffer. Another notable thing is that while in 
>>>X, the dimming doesn't work, but when I switch to one of the VTs, the screen 
>>>brightness is adjusted to what it should have been in X.
>>
>>Ah ? What do you mean by "dimming" ? blanking ? or backlight control ?
> 
> 
> OK, the F1 and F2 keys on my keyboard have little "brighter"/"dimmer"
> icons on them. When I press them when running X on 2.4.25, the screen
> brightness changes. So for me, that's "dimming." I believe that it's the
> "backlight control" that does this. When I press the "dimmer" button
> enough (8 times, I think), then the backlight turns totally off, and I
> can't see anything on the screen. For me that's "blanking" in this
> context. It's true that something else (X, I think) will kind of blank
> the screen, but the backlight stays lit. I noticed this when I closed
> the lid to make the iBook sleep, but the backlight stayed on, warming
> the keyboard. I then noticed the same problem with the dimmer keys.
> 
> 
>>Could be some crap done by the X driver ... It's notoriously allergic to
>>fbdev's ... I'll have to double check.
> 
> It probably is. But it's strange because I use all the same software
> except the kernel to get this behavior. So there's something with the
> kernel / X interface that has changed, either for 2.6 or the way Debian
> builds 2.6. I have a hard time with this because there are so many
> interactions:  is it the PMU? The APM emulation? X driver? Kernel
> driver? I don't have a good idea about how these things interact.

I don't think that this problem is debian related (I use a stock kernel 
for my tests). It _might_ theoretically be a strange result of the 
debian X server patches, but I don't think so.

If I enter snooze in _2.4_ my screen gets strangely garbaged (blue 
patterns which are somewhat related to the X11 screen but with wrong 
line offset, perhaps displayed at 640x480x8bpp?), then the hard disc 
parks, then backlight is turned off. If I press a key, the cdrom spins 
up, the backlight is turned on (screen garbaged) and the screen is 
restored. I would say that this is the correct behaviour.

My last experiment with 2.6.9 gave me (IIRC): The console is switched to 
a text console, some power management transition messages appear, the 
hard disc parks, the text remains readable ... Pressing a screen gives 
CD spinup, more messages and the computer switches back to the X console.

I will retry with Linus latest tree.

    Christof
