Return-Path: <j.w.r.degoede@hhs.nl>
Received: from smtp2.versatel.nl (smtp2.versatel.nl [62.58.50.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 441D4DDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 07:15:05 +1000 (EST)
Message-ID: <487A7211.7030309@hhs.nl>
Date: Sun, 13 Jul 2008 23:22:25 +0200
From: Hans de Goede <j.w.r.degoede@hhs.nl>
MIME-Version: 1.0
To: David Hubbard <david.c.hubbard@gmail.com>
Subject: Re: [lm-sensors] [RFC] (almost) booting allyesconfig -- please don't
	poke super-io without request_region
References: <for-27-patch1-0@bga.com> <48768018.2070704@hhs.nl>	
	<acca8e14e769b2feadee19f1f7448438@bga.com>	
	<20080711085246.1ead773b@hyperion.delvare>
	<48770B5E.7000308@hhs.nl>	
	<20080711093650.4b98e3b7@hyperion.delvare>
	<4879A144.8060203@hhs.nl>
	<4dfa50520807131411ied883cgcb20eb6bd94f761@mail.gmail.com>
In-Reply-To: <4dfa50520807131411ied883cgcb20eb6bd94f761@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Samuel Ortiz <samuel@sortiz.org>, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Hubbard wrote:
> Hi Hans, Milton, Jean,
> 
> On Sun, Jul 13, 2008 at 12:31 AM, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
>> Jean Delvare wrote:
>>> On Fri, 11 Jul 2008 09:27:26 +0200, Hans de Goede wrote:
>>>> Jean Delvare wrote:
>>>>> Hi Hans, hi Milton,
>>>>>
>>>> <snip>
>>>>
>>>>>> One could make a superio driver, and create sub-devices for the IR,
>>>>>> I2C, floppy, parallel, etc
>>>>>> nodes.
>>>>> There have been proposals to do this, and this would indeed be a very
>>>>> good idea, but unfortunately nobody took the time to implement this
>>>>> properly, push it upstream and volunteer to maintain it. The problem is
>>>>> that you don't need just a "driver", but a new subsystem, that needs to
>>>>> be designed and maintained.
>>>> Well, I believe there have been some lightweight superio locking coordinator
>>>> patches been floating around on the lm_sensors list, and I have reviewed them
>>>> and then a new version was done with my issues fixed.
>>>>
>>>> I kinda liked the proposed solution there, it was quite simple, moved all the
>>>> generic superio stuff into generic superio code, and added locking for super io
>>>> access from multiple drivers, what ever happened to those patches?
>>> As far as I know, nothing, and this is the problem. Somebody needs to
>>> step up and call him/herself the maintainer of the new code, and push
>>> it upstream and convert all the drivers (hwmon, watchdog, parallel
>>> port...) to make use of it. And I am not the one to do this, I am busy
>>> enough as is with i2c and hwmon.
>>>
>> Ok, I've mailed Jim Cromie, the author of the superio access patches
>> from end 2007 and told him we're still interested in this and asked him
>> if he is willing to drive this forward.
> 
> I propose writing a subsystem driver. (Is that properly called "The
> SuperIO Bus Driver"?) If no one thinks it's a really bad idea I will
> put together some code and submit it for review, and maintain it.
> 
> Some hwmon chips have odd / unique probe sequences. IMHO this is where
> the design needs to be inspected. One of those is the w83627ehf, which
> Jean and Hans are familiar enough with to check my work.
> 
> Thoughts?

I'm afraid that making this a "bus" will be a bit overkill. Jim's patches are 
quite simple and seem todo the job.

Also keep in mind that most users will be platform devices which just want to 
use the superio registers to find out the baseaddress of their logical device, 
a whole bus seems overkill for this, would the hwmon driver then need to be a 
superio_driver (as well as an platform_driver) or can the bus be queried / used
without having to be a bustype-driver?

Regards,

Hans
