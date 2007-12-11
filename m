Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by ozlabs.org (Postfix) with ESMTP id 84D69DDEB6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 09:44:52 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so2048273rvf
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 14:44:51 -0800 (PST)
Message-ID: <9e4733910712111444v7d6852e7wbf2ff6b0198bcb83@mail.gmail.com>
Date: Tue, 11 Dec 2007 17:44:51 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 0/5] Series to add device tree naming to i2c
In-Reply-To: <Pine.LNX.4.62.0712112236480.21672@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071210183323.12584.88127.stgit@terra.home>
	<Pine.LNX.4.62.0712112236480.21672@pademelon.sonytel.be>
Cc: Jean Delvare <khali@linux-fr.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/11/07, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> On Mon, 10 Dec 2007, Jon Smirl wrote:
> > Respin to split error return fixups out of mpc-i2c to of_platform chang=
e
> >
> > The following series implements standard linux module aliasing for i2c =
modules
> > It then converts the mpc i2c driver from being a platform driver to an =
open
> > firmware one. I2C device names are picked up from the device tree. Modu=
le
> > aliasing is used to translate from device tree names into to linux kern=
el
> > names. Several i2c drivers are updated to use the new aliasing.
>
> Is there any relationship of these patches with commit
> cee37ae4071740cb190d1ac4ddb7aa77484aa7b3?

That commit appears to be removing an entry for i2c in
mod_devicetable.h. But there was never any code in place to use that
struct which is why it was removed.

I have added the struct back with a name field instead of an id. My
patches also include the code necessary to make it all work.

>
> Author: Jean Delvare <khali@linux-fr.org>
> Date:   Sat Oct 13 23:56:29 2007 +0200
>
>     i2c: Kill struct i2c_device_id
>
>     I2C devices do not have any form of ID as PCI or USB devices have.
>     No driver uses "MODULE_DEVICE_TABLE(i2c, ...)" because it doesn't
>     make sense. So we can get rid of struct i2c_device_id and the
>     associated support code.
>
>     Signed-off-by: Jean Delvare <khali@linux-fr.org>
>     Cc: Greg KH <greg@kroah.com>
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
