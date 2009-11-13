Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 8CEE5B7B99
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 17:21:36 +1100 (EST)
Received: by yxe8 with SMTP id 8so2963773yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 22:21:35 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091112213630.GE19336@infomag.iguana.be>
References: <fa686aa40911101159y7bef3f9bte74e9aeb5c6e864b@mail.gmail.com>
	<1257884778.14374.5@antares> <20091112213630.GE19336@infomag.iguana.be>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Nov 2009 23:21:15 -0700
Message-ID: <fa686aa40911122221s24efdcc9k1daf63b600e7b429@mail.gmail.com>
Subject: Re: [PATCH 3/3] mpc52xx/wdt: WDT uses GPT api
To: Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
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

On Thu, Nov 12, 2009 at 2:36 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi All,
>
>>> Can the WDT functionality just be merged entirely into
>>> arch/powerpc/platforms/52xx/mpc52xx_gpt.c, eliminating the need for
>>> this file entirely? =A0I think I'd rather have all the GPT "built in"
>>> behaviour handled by a single driver.
>>
>> I also thought about it, as it has IMHO the cleaner code, and it would h=
ave the extra benefit that the gpt-wdt api doesn't need to be public.
>>
>> However, the reasons I hesitated to do so are:
>> - I don't want to remove a file someone else wrote (even it doesn't work=
);
>> - WDT code is shifted from drivers/watchdog to arch/powerpc/platforms/52=
xx which might not be the "logical" place from the directory layout's pov;
>> - a file living in arch/powerpc/platforms/52xx depends upon config optio=
ns set from drivers/watchdog/Kconfig which may be confusing.
>>
>> You see these are more political/cosmetical questions, so I would prefer=
 to leave the decision to the maintainers (i.e. you and Wim). =A0Preparing =
a fully merged driver is actually a matter of minutes!
>
> My opinion: it is harder to maintain the watchdog code if it is being mov=
ed away from drivers/watchdog.
> I need to check the code before I comment any further on this, but my fir=
st thought is: why don't you do it with platform resources like other devic=
es are doing? This way you can keep the platform code under arch and the wa=
tchdog itself under drivers/watchdog/. You can look at the following driver=
s as an example: adx_wdt.c ar7_wdt.c at32ap700x_wdt.c coh901327_wdt.c davin=
ci_wdt.c mpcore_wdt.c mv64x60_wdt.c nuc900_wdt.c omap_wdt.c pnx4008_wdt.c r=
c32434_wdt.c s3c2410_wdt.c txx9wdt.c .

In actual fact, it is a single device with multiple functions, some of
which can be used at the same time.  The driver for the device
determines what the device instance supports and registers the
appropriate interfaces.  There is a GPIO controller, a PWM controller,
a general purpose timer, and the watchdog.  Because of the
multifunction nature of the device, there are subtle interactions
between the functions that the driver needs to maintain.  I don't want
to export functions from the driver which will only be used by a
watchdog instance.  I also don't want the added code and complexity of
a secondary probe path.  It is simpler and less code to roll all the
behaviour up into the one driver single driver that gets probed once.

>From the maintenance perspective, having the main driver in
arch/powerpc and the watchdog bit in drivers/watchdog doesn't really
help much anyway because anything that changes the internal driver API
(between the core and watchdog bits) will require cross-maintainer
changes.  ie. do changes go through my tree because they touch
arch/powerpc, or do they go through yours because they touch
drivers/watchdog?  I'd much rather all the internal details be
contained within a single driver.

Besides, there is already precedence for very arch-specific drivers
living under arch/*/.  find ./arch -name *gpio*

Cheers,
g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
