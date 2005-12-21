Return-Path: <azummo-lists@towertech.it>
Received: from mail.towertech.it (jack.kinetikon.it [62.152.125.81])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.towertech.it",
	Issuer "mail.towertech.it" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3DB0068936
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Dec 2005 04:40:26 +1100 (EST)
Date: Wed, 21 Dec 2005 18:41:22 +0100
From: Alessandro Zummo <azummo-lists@towertech.it>
To: Simon Richter <Simon.Richter@hogyros.de>
Message-ID: <20051221184122.5253df01@inspiron>
In-Reply-To: <43A97CAF.50301@hogyros.de>
References: <20051220220022.4e9ff931@inspiron> <43A94811.4010704@hogyros.de>
	<20051221160712.2d322f42@inspiron> <43A97CAF.50301@hogyros.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] RTC subsystem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Dec 2005 17:02:55 +0100
Simon Richter <Simon.Richter@hogyros.de> wrote:

> >   the proposal actually had a fully-working patch attached :)
> 
> Ah, didn't see that, as I just skimmed over the web archive page you 
> linked to, which has no link to the actual patch (or I'm too stupid to 
> find it).

 right.. the link was to 0/6 of the patchset, which is
 actually only the introduction. real patch was in subsequent
 messages.

> >  In my code, the first rtc that register is bound
> >  to /proc/driver/rtc and /dev/rtc (if those interfaces
> >  are compiled in, as they are all selectable).
> 
> It would be good to have a way to change which clock is the "primary" 
> one from userspace later (userspace because this is clearly site policy).

 If I'm not wrong, the RTC is usually queried at bootup
 and written to on shutdown. If NTP mode is active, 
 it is also written every 11 minutes.

 So my intention was to emulate that interface as a starting
 point. Then we can update the userspace utilities (hwclock)
 to let the user choose which clock he want to use.

 I guess /proc/driver/rtc will be deprecated sooner or
 later. The /dev/rtc interface only supports one clock.
 It can either be extended to have /dev/rtcX or we
 can extend the sysfs one to allow clock updating.

 NTP mode could then be adjusted to update one or more
 of the rtcs. Maybe each RTC could have an attribute
 (let's say /sys/class/rtc/rtcX/ntp) which tells the
 kernel whether to update it or not.
  
 This way we will not have a primary clock anymore.

> >  You have full control of which functions you will provide
> >  to the upper layer. Obivously if you try to set the
> >  time on a read-only rtc, you will get an error.
> 
> Sure. I was thinking of the question which error that should be.

 -EPERM ? -EACCESS? :)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it
