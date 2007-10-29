Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 973CCDE0C6
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 06:21:48 +1100 (EST)
Message-ID: <472632C6.9040705@freescale.com>
Date: Mon, 29 Oct 2007 14:21:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: RFC:  replace device_type with new "class" property?
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<4725FA58.4030505@genesi-usa.com>
	<20071029161140.GA4358@loki.buserror.net>
	<47262CA9.3070500@genesi-usa.com>
In-Reply-To: <47262CA9.3070500@genesi-usa.com>
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

Matt Sealey wrote:
> Scott Wood wrote:
>> On Mon, Oct 29, 2007 at 03:20:56PM +0000, Matt Sealey wrote:
>>> I think device_type, compatible and model properties fulfil this
>>> already, they simply aren't being used correctly.
>> 
>> device_type has a few drawbacks, though:
>> 
>> 1. You can only specify one type, whereas with a new property we
>> could define it as a list (similar to compatible).
> 
> This is the whole point; device_type and compatible are companion 
> properties. You specify the exact thing in device_type and give it a
> list of compatible device_types in compatible.

That sounds more like a description of "model", or the original use of
"name", than device_type.

>> 2. We want to avoid any confusion with OF bindings and abused
>> device_type entries that have been allowed to become existing
>> practice.
> 
> Creating whole new device type bindings that are not OF standards, 
> which puts OF vendors at a sort of impass; do they comply to the Open
> Firmware standard or use the Linux Standard?

We try to stay compatible with OF when practical; however, we have no
choice if an OF device_type implies a method interface that we cannot
provide.

>>> For readability, the name of the device needn't match
>>> device_type; for instance on the 5121E it may be that the 'diu'
>>> unit be called diu, but be of device_type 'display'
>> 
>> I don't think that's more readable than setting the name to
>> display. Something containing "diu" will be in the compatible list.
>> 
> 
> It at least makes the device tree far more human readable.

Unless you're familiar with the hardware, "diu" is likely to be a
meaningless acronym.  "display" is obvious, and much more human-friendly.

> While name is derived from device_type on creation of a device (after
>  all a display is a display), giving it a human readable name is 
> sometimes a boon.

name generally comes from the generic names document, not device_type.

> Remember that Open Firmware is not just a text file you compile with
> U-Boot - the console you get on boot needs to be useful to users too.
> In that sense, 8 USB controllers with names usb@f10001000, 
> usb@f10002000 going upwards to infinity is not the greatest thing in
> the world.

And the alternative is?

>>> Selecting the "model" would be no different to, for example, 
>>> having a list of PCI IDs that will work with a driver.
>> 
>> It's what we currently do with compatible.  Why break it into two 
>> properties?
> 
> Because encoding human-readable descriptions of devices in the 
> compatible property is ridiculously long-winded.

Putting something human readable in model is fine.  It's not a reason to
  force drivers to care about it by failing to include a highly specific
entry in the compatible list.

> Currently it's being terribly misused, in my opinion (USB especially,
>  there is no need to tell that it is "compatible" with mpc5200b-usb, 
> USB is a well-defined standard with 3 possible host controllers, 
> encoding the specific SoC into it is going way overboard)

Well, there are various non-standard registers also present on many
embedded USB controllers.

>> No, you should use compatible for that.
>> 
>> No, that goes in name/compatible according to the OF PCI binding.
> 
> This is absolutely contrary to your own request for comments; you
> want to implement a new class property, but.. you can use device_type
>  and compatible for it, as is evident everywhere and in two already 
> existing bus bindings.

It was Stuart's RFC, not mine.  :-)

What I originally proposed was deprecating device_type, and using name
and compatible.  Stuart wanted something to indicate formal adherence to
a standard binding, so I suggested "class" if such a thing is really needed.

You seem to be confusing name and device_type, BTW.

>>> Perhaps it is a solution though; mark each device with a class
>>> property, for instance on the 5200B give it a unique chip ID
>>> (fsl5200 or soc5200?)
>> 
>> No.  That's precisely the sort of device_type abuse we want to get
>>  away from with class.
> 
> It is not an abuse to give a device_type by some very easily
> matchable device type.

That's not a device type, it's a device.

> For devices which do not have a standard binding you run into a
> problem; who arbitrates what class goes where?

The issue that brought all this up was new bindings for device classes 
that OF doesn't have bindings for.

> Reusing vendor codes from PCI and USB,

OF already specifies OUI numbers for this, why be different?

We use things like "ibm" and "fsl" for common, unambiguous vendors for 
readability sake.

> class codes from PCI and USB, 

What do we need the class codes for?

> and implementing a few 'non-standard others' is far more efficient as
> there is plenty of code in the Linux tree for parsing and collecting 
> this data.

I highly doubt there's any code in Linux that wants a PCI or USB class 
ID for something that isn't a PCI or USB device.

> It is not so far a leap to go from parsing "pci" or "usb" 
> device_types

name/compatible, not device_type.  Please actually read the PCI binding.

And you shouldn't parse them, that's what the vendor-id and device-id 
properties are for.  The encoded form is for matching against a 
similarly encoded string.

> "soc5121,0c0320" matches a device exactly where "usb" particularly 
> does not.

Why are you comparing it to "usb" and not "fsl,mpc5121-usb"?

> Why not;
> 
> chickenlittle { device_type = "usb" model = "soc1057,5121,0c0320" 
> compatible = "usb-ehci", "soc1057,8349,*" }

Is chickenlittle really a useful description of a USB bus on your 
hardware? :-)

And I thought you wanted human readable descriptions in model?

What's wrong with:

usb {
	compatible = "fsl,mpc8349-usb", "usb-ehci";
	reg = <whatever>;
};

?
