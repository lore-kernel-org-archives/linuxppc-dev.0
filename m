Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id 858EAB6F0E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 08:22:15 +1100 (EST)
Received: by ywh11 with SMTP id 11so1672125ywh.9
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Dec 2009 13:22:14 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091208204854.GE4291@infomag.iguana.be>
References: <fa686aa40911101159y7bef3f9bte74e9aeb5c6e864b@mail.gmail.com>
	<1257884778.14374.5@antares> <20091112213630.GE19336@infomag.iguana.be>
	<fa686aa40911122221s24efdcc9k1daf63b600e7b429@mail.gmail.com>
	<20091208204854.GE4291@infomag.iguana.be>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 8 Dec 2009 14:21:54 -0700
Message-ID: <fa686aa40912081321hc9b1ed3o3e7820f16b960ec6@mail.gmail.com>
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

On Tue, Dec 8, 2009 at 1:48 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Grant,
>
> Sorry for the delay, I need to deliver a project in a weeks time...

understood.

>> In actual fact, it is a single device with multiple functions, some of
>> which can be used at the same time. =A0The driver for the device
>> determines what the device instance supports and registers the
>> appropriate interfaces. =A0There is a GPIO controller, a PWM controller,
>> a general purpose timer, and the watchdog. =A0Because of the
>> multifunction nature of the device, there are subtle interactions
>> between the functions that the driver needs to maintain. =A0I don't want
>> to export functions from the driver which will only be used by a
>> watchdog instance. =A0I also don't want the added code and complexity of
>> a secondary probe path. =A0It is simpler and less code to roll all the
>> behaviour up into the one driver single driver that gets probed once.
>>
>> >From the maintenance perspective, having the main driver in
>> arch/powerpc and the watchdog bit in drivers/watchdog doesn't really
>> help much anyway because anything that changes the internal driver API
>> (between the core and watchdog bits) will require cross-maintainer
>> changes. =A0ie. do changes go through my tree because they touch
>> arch/powerpc, or do they go through yours because they touch
>> drivers/watchdog? =A0I'd much rather all the internal details be
>> contained within a single driver.
>
> Your argument about maintenance is the same one as I have: If all watchdo=
g
> driver pieces are under drivers/watchdog then it's easier for me to maint=
ain
> them. (Definitely if we are doing clean-up work and API changes).

:-)

>> Besides, there is already precedence for very arch-specific drivers
>> living under arch/*/. =A0find ./arch -name *gpio*
>
> But in this case: I know where to find them and I will keep a mental note
> about this one. And yes indeed some very arch specific drivers can reside
> under arch/*/* .
>
> So please go ahead with pulling this one in a single driver.

Great, Thanks Wim.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
