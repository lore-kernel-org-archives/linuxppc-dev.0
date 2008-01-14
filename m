Return-Path: <jonsmirl@gmail.com>
Received: from ro-out-1112.google.com (ro-out-1112.google.com [72.14.202.176])
	by ozlabs.org (Postfix) with ESMTP id 0EE64DDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 01:25:57 +1100 (EST)
Received: by ro-out-1112.google.com with SMTP id p7so2575759roc.1
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 06:25:55 -0800 (PST)
Message-ID: <9e4733910801140625u2503b508kc99e93ff59e31157@mail.gmail.com>
Date: Mon, 14 Jan 2008 09:25:54 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [i2c] [PATCH] update module-init-tools to support the i2c
	subsystem
In-Reply-To: <Pine.LNX.4.64.0801141154420.3058@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910712171839h214e0bc3q179266c86e5987b1@mail.gmail.com>
	<20080113152735.5dca46a1@hyperion.delvare>
	<9e4733910801130714m1be16826jf240171972324d16@mail.gmail.com>
	<20080113163543.16e3d26b@hyperion.delvare>
	<9e4733910801130826l799e4897pe7380ccb973b5fd0@mail.gmail.com>
	<20080113184337.5d4cd546@hyperion.delvare>
	<9e4733910801131004i669276e2pde04b195dd10bd90@mail.gmail.com>
	<Pine.LNX.4.64.0801141154420.3058@vixen.sonytel.be>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/14/08, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> On Sun, 13 Jan 2008, Jon Smirl wrote:
> > On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> > > On Sun, 13 Jan 2008 11:26:07 -0500, Jon Smirl wrote:
> > > > On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> > > > > On Sun, 13 Jan 2008 10:14:14 -0500, Jon Smirl wrote:
> > > > > > On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> > > > > > > On Mon, 17 Dec 2007 21:39:37 -0500, Jon Smirl wrote:
> > > > > > > > Follow on to: "Series to add device tree naming to i2c"
> > > > > > > > Teach module-init-tools about the i2c subsystem.
> > > > > > >
> > > > > > > Can you please explain what this patch does and why it is nee=
ded?
> > > > > >
> > > > > > It generates the entries needed for the user space module tools=
 to
> > > > > > work with the aliases. For example modprobe/depmod. It is a sta=
ndard
> > > > > > part of the kernel module system.
> > > > >
> > > > > What entries, where? What can you do after applying your patch th=
at you
> > > > > couldn't do before?
> > > >
> > > > The drivers you are testing with don't depend on other drivers.
> > >
> > > They do. I'm testing with the lm90 driver, which depends on the hwmon
> > > driver. Both load automatically when the underlying i2c-parport drive=
r
> > > instantiate an "adm1032" i2c device.
> >
> > I don't know exactly what those modules tables are used for. I just
> > copied what the other subsystems do. Maybe they are used when you make
> > an initrd to know which drivers to copy into the image.
>
> Module-init-tools needs those table to create module aliases in the *.ko
> files from the MODULE_DEVICE_TABLE(), so udev can load the modules based
> on the device IDs when the devices appear in sysfs.
>
> That's the generic part. How this applies to i2c devices on platforms
> without Open Firmware device trees is another question. I guess that's
> where Jean gets confused (i2c_device_id got _removed_ last year,
> because it didn't make sense (at the time?)).

Last year i2c modules weren't dynamically loadable so it wasn't needed.

>
> With kind regards,
>
> Geert Uytterhoeven
> Software Architect
>
> Sony Network and Software Technology Center Europe
> The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgi=
um
>
> Phone:    +32 (0)2 700 8453
> Fax:      +32 (0)2 700 8622
> E-mail:   Geert.Uytterhoeven@sonycom.com
> Internet: http://www.sony-europe.com/
>
> Sony Network and Software Technology Center Europe
> A division of Sony Service Centre (Europe) N.V.
> Registered office: Technologielaan 7 =B7 B-1840 Londerzeel =B7 Belgium
> VAT BE 0413.825.160 =B7 RPR Brussels
> Fortis Bank Zaventem =B7 Swift GEBABEBB08A =B7 IBAN BE39001382358619


--=20
Jon Smirl
jonsmirl@gmail.com
