Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 7707DDDF6A
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 06:20:52 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so92335wag.13
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 13:20:51 -0700 (PDT)
Message-ID: <9e4733910807301320h4e6029a8gbff2875ba9c7ab0b@mail.gmail.com>
Date: Wed, 30 Jul 2008 16:20:50 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
In-Reply-To: <20080730144202.GB21958@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>
	<20080727001119.GB12191@secretlab.ca>
	<9e4733910807262205l2db8d662u9dd2e517282686f8@mail.gmail.com>
	<fa686aa40807262235l47bff0bfi15d86a6e171d6775@mail.gmail.com>
	<9e4733910807270721h5777bb80u9f3d25413a62883c@mail.gmail.com>
	<77a246d166f3eafb4d6a5d899ff86945@kernel.crashing.org>
	<9e4733910807271500l23fd2b12n940197474a5291df@mail.gmail.com>
	<043095cdcd52bb7af5cf4373b249b302@kernel.crashing.org>
	<20080730144202.GB21958@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/30/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jul 28, 2008 at 09:47:21AM +0200, Segher Boessenkool wrote:
>  >>>  A reasonable "compatible" value would be something like
>  >>> "serial-eeprom-24c32".
>  >>>  You can go a little bit more generic than that, if you write up in
>  >>>  your binding how the driver should figure out the device size and
>  >>>  the protocol used.
>  >>
>  >> Matching on "serial-eeprom-24c32" requires me to convince the at24
>  >> authors to add that string as an alias binding for their driver.
>  >
>  > No, it requires the IIC subsystem to get fixed and not use OF
>  > "compatible" values as module alias names.
>
>
> Indeed; the device tree is just a data structure with a well defined
>  usage model.  It is the kernel's job to adapt that data into a form that
>  it can use.

Then we're going to have to work on the i2s subsystem more to get them
to allow arbitrary modalias strings like serial-eeprom-24c32.

The current i2c code has linked the use of modalias strings and the
i2c sysfs attribute  'name'. Currently those two always need to be the
same. Existing user space apps are expecting to get the linux name for
the device from the name field.  That linkage needs to be broken.

Then you need entries like this:

static const struct i2c_device_id at24_ids[] = {
	{ "24c01", "24c01", AT24_DEVICE_MAGIC(1024 / 8, 0) },
	{ "24c02", "24c02", AT24_DEVICE_MAGIC(2048 / 8, 0) },
	OF( "serial-eeprom-24c01", "24c01", AT24_DEVICE_MAGIC(1024 / 8, 0) ),
	OF( "serial-eeprom-24c02", "24c02", AT24_DEVICE_MAGIC(2048 / 8, 0) ),

First column is the modalias, second is the string that is going into
the 'name' attribute. OF() causes the entries to disappear on non-OF
platforms.

We should argue for another macro that makes the non-OF strings
disappear on our platform.

I have submitted a patch like this before and Jean declared that he
doesn't recognize open firmware as a naming authority and NACK'd it.


>
>
>  >> How
>  >> about "serial-eeprom,24c32" or "generic,24x32"?
>  >
>  > Neither "serial-eeprom" nor "generic" is the name of a vendor, so
>  > no.  The comma has a well-defined meaning.  Why would a comma be
>  > easier than a dash for your device matching code, anyway?
>
>
> Just to add my voice; I 100% agree.  If it is not documented, and it
>  doesn't fit with established conventions, then it shouldn't be used in
>  the compatible field.
>
>
>  g.
>


-- 
Jon Smirl
jonsmirl@gmail.com
