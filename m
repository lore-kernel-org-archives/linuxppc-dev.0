Return-Path: <david.c.hubbard@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id E1B19DEAAF
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 03:55:03 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2633477pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 10:55:02 -0700 (PDT)
Message-ID: <4dfa50520807141055l532caaaai700255936600e5ae@mail.gmail.com>
Date: Mon, 14 Jul 2008 11:55:01 -0600
From: "David Hubbard" <david.c.hubbard@gmail.com>
To: "Hans de Goede" <j.w.r.degoede@hhs.nl>
Subject: Re: [lm-sensors] [RFC] (almost) booting allyesconfig -- please don't
	poke super-io without request_region
In-Reply-To: <487B8D2C.1090208@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <for-27-patch1-0@bga.com> <48770B5E.7000308@hhs.nl>
	<20080711093650.4b98e3b7@hyperion.delvare> <4879A144.8060203@hhs.nl>
	<4dfa50520807131411ied883cgcb20eb6bd94f761@mail.gmail.com>
	<487A7211.7030309@hhs.nl>
	<4dfa50520807131426t4013142cp1fcd49e078a79c1f@mail.gmail.com>
	<20080714095914.0644ac5d@hyperion.delvare>
	<88f5162604470179b3c6ebfe729a46f5@bga.com> <487B8D2C.1090208@hhs.nl>
Cc: linuxppc-dev@ozlabs.org, Samuel Ortiz <samuel@sortiz.org>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Hans,

On Mon, Jul 14, 2008 at 11:30 AM, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> Milton Miller wrote:
>> I haven't done the research, but it might be keep superio as
>> a platform driver, and keep the clients as platform drivers.  Only
>> have the superio driver probe and discover the subcomponent
>> addresses and then create the platform devices as children
>> instead of having each driver create its own platform device.
>> (This all assumes they are all platform devices in sysfs, I have
>> not looked).
>>
>> This is all because in the platform bus the bus driver does not
>> discover the addresses but relies on drivers or platform setup code.
>>
>
> This sounds like a good plan, rather then add a new bus type add a superio
> platform driver which does superio probing and registering of platform devices
> for discovered logical devices.
>
> This superio platform driver then needs to also export some functions of those
> few logical devices which need access to the superio registers for more then
> just finding out their own base address.
>
> I guess that it then would be best to load this superio driver by default on
> most systems.
>
> How does this all mix and match with isapnp, it feels to me we're doing
> somewhat the same as isapnp here.

Is there any way to use lspci and start at the LPC bridge, then find
the SuperIO chip's IO address? What about ACPI tables? Perhaps probing
logic could look for an LPC bridge before probing certain IO addresses
even if the addresses are not in the LPC bridge config.

A superio platform driver is a good way to go -- it fits with the way
the platform bus does things. Also, Jim's patches are almost there
already.

Thanks,
David
