Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 30AFDDDE30
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 05:01:07 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3258109wag.13
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jan 2008 10:01:06 -0800 (PST)
Message-ID: <9e4733910801131001o604c1474vc2fd021d32b8c2a3@mail.gmail.com>
Date: Sun, 13 Jan 2008 13:01:06 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH 1/5] Implement module aliasing for i2c to translate from
	device tree names
In-Reply-To: <20080113184017.7e3b409f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071220044136.20091.70984.stgit@terra.home>
	<20071220044138.20091.31417.stgit@terra.home>
	<20080111202015.65c3c160@hyperion.delvare>
	<20080112094658.197acb08@hyperion.delvare>
	<9e4733910801120826haa8905dk863ed1c8e9f420c9@mail.gmail.com>
	<20080113154114.4a1c5166@hyperion.delvare>
	<9e4733910801130824i547b65a9n64e415f9626d6ab5@mail.gmail.com>
	<20080113184017.7e3b409f@hyperion.delvare>
Cc: Greg KH <greg@kroah.com>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> On Sun, 13 Jan 2008 11:24:29 -0500, Jon Smirl wrote:
> > On 1/13/08, Jean Delvare wrote:
> > > On Sat, 12 Jan 2008 11:26:34 -0500, Jon Smirl wrote:
> > > > IMHO, driver_name/type should be removed in new style drivers and
> > > > replaced with aliases on all platforms since aliases are the standard
> > > > kernel mechanism.
> > >
> > > I agree. But we can take your aliasing code now (once you have
> > > addressed the issues I raised) and convert the users of driver_name
> > > later; it doesn't have to be done all at once.
> >
> > GregKH, adding a new dynamically loadable subsystem is not something
> > that happens every day, can you check to make sure all of the standard
> > kernels mechanisms are being used? I'm not totally sure how the
> > modalias naming code is supposed to be done. The subsystem core code
> > in these patches needs review.
> >
> > Jean, could you take over the i2c core portion of the patch? That will
> > let you decide exactly how you want the driver_name/name fields to be
> > dealt with. After you get standard naming support into i2c core I'll
> > rework the rest of the patch to use your new code.
>
> Yes, that could be done, and I agree that it will probably be faster
> than iterative review/rework cycles between you and me. I'll free some
> cycles next week for that.
>
> > I don't think driver_name/name fields should be stored in an i2c
> > structure at all. They are redundant with the standard mechanism.
> >
> > The kernel automatically exposes modalias as a sysfs attribute so the
> > string must be recorded further down in the driver support layers. No
> > need to keep a copy in the i2c structure.
>
> Really? I didn't know that. So that's another thing that the i2c
> subsystem is not doing like the rest of the kernel? Can you please
> point me to the code that does this?

I never noticed it before either. Just do find | grep modalias in /sys
and see that every driver has a modalias attribute. It is probably
implement in drivers/base.

>
> > Standard devices don't export a 'name' attribute. To see the driver
> > name for a device in sysfs look at the 'driver' link.
>
> The driver name and the device name are different things! The "name"
> attribute that i2c devices have tells user-space the device name, not
> the driver name.

For this system my i2c device names are:
0-0050  0-0051  0-0052  0-0053
How does the name=eeprom attribute interact with this? All four of my
devices have name=eeprom. What is the name field used for in user
space?

jonsmirl@terra:/sys/bus/i2c/devices/0-0052$ ls
driver  eeprom  modalias  name  power  subsystem  uevent
jonsmirl@terra:/sys/bus/i2c/devices/0-0052$ cat name
eeprom
jonsmirl@terra:/sys/bus/i2c/devices/0-0052$ ls driver -l
lrwxrwxrwx 1 root root 0 2008-01-13 12:46 driver ->
../../../../../../bus/i2c/drivers/eeprom
jonsmirl@terra:/sys/bus/i2c/devices/0-0052$

jonsmirl@terra:/sys/bus/i2c/drivers$ ls
eeprom
jonsmirl@terra:/sys/bus/i2c/drivers$ ls eeprom
0-0050  0-0051  0-0052  0-0053  bind  module  uevent  unbind

>
> You may not like what the i2c subsystem does but you can't ignore its
> history. The name attribute of i2c devices has been there pretty much
> forever and user-space relies on it, thus we can't remove it.
>
> --
> Jean Delvare
>


-- 
Jon Smirl
jonsmirl@gmail.com
