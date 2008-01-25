Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 389EADDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 11:48:44 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so711305wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 16:48:44 -0800 (PST)
Message-ID: <9e4733910801241648h68fb460ftfae25cae9282e2e5@mail.gmail.com>
Date: Thu, 24 Jan 2008 19:48:43 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [i2c] [PATCH 3/3] Add device tree compatible aliases to i2c
	drivers
In-Reply-To: <47992E4D.7010500@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123020916.31675.98481.stgit@terra.home>
	<20080125003249.GA30794@lixom.net> <47992E4D.7010500@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/24/08, Scott Wood <scottwood@freescale.com> wrote:
> Olof Johansson wrote:
> > For example, for an eeprom I might have: "MCHP,24lc128est",
> > "MCHP,24xx128", "24c128". The at24 driver (not in mainline yet :) would
> > likely match with "24c128", and it would normally not make sense to have
> > to list all specific vendors and models of the device type in question
> > in the driver.
>
> It's not really about the vendors of the device, but the namespace it
> goes into.  If there's really no canonical vendor name, then a plain old
> "24c148" might make sense, but that seems like it'd be fairly rare.
>
> > I can't register a board_info for each of the compatible fields without
> > changing the way the i2c drivers are registered, since the creation of
> > the duplicate entries will start reporting errors.
>
> Even with the current i2c changes that have been flying around the
> lists?  If so, it should be fixed...

How to fix this needs some thought....

Devices can register before their drivers are loaded. What name are
you going to use to register the device in this case?

Probably the right way to fix this is in drivers/base not in the i2c
code. PowerPC devices would register with their entire compatible
string. Then later when drivers are loaded they would be compared
against the device's compatible string.   When you register a device
the existing drivers will need to be looked for in the order of the
compatible string.

Another wrinkle is exhibited by the USB HID driver. The generic USB
HID driver will bind to every HID device it sees. Later if you want to
load a specific driver for the USB device you have to go into sysfs
and unbind the device from the generic HID driver and then rebind it
to the specific driver. Matching on the compatible list will have the
same problem.

>
> > So it seems that the solution would be to make i2c_board_info take a
> > list of names for the device, and each of them has to be matched with
> > all drivers, taking the first match.
>
> Agreed.
>
> -Scott
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
