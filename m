Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DED54DE0C3
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 05:53:26 +1100 (EST)
Message-ID: <47262CA9.3070500@genesi-usa.com>
Date: Mon, 29 Oct 2007 18:55:37 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<4725FA58.4030505@genesi-usa.com>
	<20071029161140.GA4358@loki.buserror.net>
In-Reply-To: <20071029161140.GA4358@loki.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Mon, Oct 29, 2007 at 03:20:56PM +0000, Matt Sealey wrote:
>> I think device_type, compatible and model properties fulfil
>> this already, they simply aren't being used correctly.
> 
> device_type has a few drawbacks, though:
> 
> 1. You can only specify one type, whereas with a new property we could
> define it as a list (similar to compatible). 

This is the whole point; device_type and compatible are companion
properties. You specify the exact thing in device_type and give
it a list of compatible device_types in compatible.

> 2. We want to avoid any confusion with OF bindings and abused device_type
> entries that have been allowed to become existing practice.

Creating whole new device type bindings that are not OF standards,
which puts OF vendors at a sort of impass; do they comply to the
Open Firmware standard or use the Linux Standard?

Flat device trees are already somewhat of a strange beast, it is
probably best not to make them much stranger.

> 3. It's the only standard property (AFAIK) with an underscore in it. :-)

Petty :D

>> For readability, the name of the device needn't match device_type;
>> for instance on the 5121E it may be that the 'diu' unit be
>> called diu, but be of device_type 'display'
> 
> I don't think that's more readable than setting the name to display.
> Something containing "diu" will be in the compatible list.

It at least makes the device tree far more human readable.

"Name" and "Device Type" are not required to be the same thing. A
name is just a human readable marker, device_type is what drivers
need to match on.

While name is derived from device_type on creation of a device (after
all a display is a display), giving it a human readable name is
sometimes a boon.

Remember that Open Firmware is not just a text file you compile
with U-Boot - the console you get on boot needs to be useful to
users too. In that sense, 8 USB controllers with names usb@f10001000,
usb@f10002000 going upwards to infinity is not the greatest thing
in the world.

>> Selecting the "model" would be no different to, for example,
>> having a list of PCI IDs that will work with a driver.
> 
> It's what we currently do with compatible.  Why break it into two
> properties?

Because encoding human-readable descriptions of devices in the
compatible property is ridiculously long-winded.

Currently it's being terribly misused, in my opinion (USB especially,
there is no need to tell that it is "compatible" with mpc5200b-usb,
USB is a well-defined standard with 3 possible host controllers,
encoding the specific SoC into it is going way overboard)

> No, you should use compatible for that.
> 
> No, that goes in name/compatible according to the OF PCI binding.

This is absolutely contrary to your own request for comments; you want
to implement a new class property, but.. you can use device_type
and compatible for it, as is evident everywhere and in two already
existing bus bindings.

If you need more information in the device tree for each device,
I simply recommend we take a hint from the PCI and USB bindings
and add properties of the same names and descriptions (why create
new standards when old ones work fine).

>> Perhaps it is a solution though; mark each device with a
>> class property, for instance on the 5200B give it a unique
>> chip ID (fsl5200 or soc5200?)
> 
> No.  That's precisely the sort of device_type abuse we want to get away from
> with class.

It is not an abuse to give a device_type by some very easily matchable
device type.

> Personally, I'm fine with just using name and compatible, but others such as
> Stuart have expressed a desire for something to formally indicate compliance
> with a standard binding.  I don't think we should expand the use of
> device_type in any case.

You can formally indicate compliance with a standard binding by using
the standard bindings.. be they the USB or PCI standard, be your device
not on USB or PCI, they already exist, and already do what Stuart asks.

For devices which do not have a standard binding you run into a problem;
who arbitrates what class goes where?

Reusing vendor codes from PCI and USB, class codes from PCI and USB,
and implementing a few 'non-standard others' is far more efficient
as there is plenty of code in the Linux tree for parsing and collecting
this data. It is not so far a leap to go from parsing "pci" or "usb"
device_types to collecting "fsl" or "soc" data and a selection of appended
codes.

Therefore, if there is not a standard binding that gives it a neat name
(i2c would be a good example), I suggest following the route of PCI and
USB, and encoding that specific device as a set of matchable codes,
rather than a list of strings.

"soc5121,0c0320" matches a device exactly where "usb" particularly
does not. As with the specification for PCI where such a device may
not have a particular device_type name (not a good example with USB)
simply prefix with the bus type, then vendor code, device code,
class code etc. gives you an identical match.

Why not;

chickenlittle {
	device_type = "usb"
	model = "soc1057,5121,0c0320"
	compatible = "usb-ehci", "soc1057,8349,*"
}

bluesky {
	device_type = "i2c"
	model = "i2c1057,5121,030000"
	compatible = "whatever"
}

ata {
	device_type = "ide"
	model = "soc1057,5121,01801f"
	compatible = "soc1057,5200,01801f"
}

Maybe that is an incredibly bad idea, now I look at it.

If not, simply whacking in the PCI class-code, vendor-id, device-id
and suchlike properties is both easy to add to current firmware
implementations and easy to differentiate a device (far beyond a
simple "class name"). 99% of names, and device_types already exist
and have well-known bindings. i2c being our example of where no
example binding exists, it is easy to report it's existance and
it's programming interface via these values.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
