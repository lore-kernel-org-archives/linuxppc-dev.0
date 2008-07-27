Return-Path: <jonsmirl@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.226])
	by ozlabs.org (Postfix) with ESMTP id 552DEDDF69
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 15:05:05 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so3689881wxd.15
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 22:05:02 -0700 (PDT)
Message-ID: <9e4733910807262205l2db8d662u9dd2e517282686f8@mail.gmail.com>
Date: Sun, 27 Jul 2008 01:05:01 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
In-Reply-To: <20080727001119.GB12191@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>
	<20080727001119.GB12191@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/26/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jul 14, 2008 at 09:54:37PM +0400, Anton Vorontsov wrote:
>  > Currently of_i2c will select first compatible property as a last resort
>  > option. This isn't best choice though, because generic compatible entries
>  > are listed last, not first. For example, two compatible entries given for
>  > the MCU node:
>  >
>  > "fsl,mc9s08qg8-mpc837xrdb", "fsl,mcu-mpc8349emitx";
>  >
>  > Since no sane driver will ever match specific devices, what we want is
>  > to select most generic option (last). Then driver may call
>  > of_device_is_compatible() if it is really interested in details.
>
>
> I highly suspect that this will actually be a rare condition and that
>  most of the time the driver you want will bind against the first entry
>  in the list (I'm basing this on what discussion I've seen on the list
>  and it seems to me that Jiri does want i2c devices to list the exact set
>  of chips that each driver binds against).

Can we put a loop on request_module() and have it try each one down
the list until something matches? request_module() returns errors, but
I can't tell from the source if one of those errors is "no matching
module found" since it invokes a user space helper.

That would work for this compatible string:
compatible = "atmel,24c32wp", "24c32", "eeprom";

request_module will always fail for the first entry. If you have at24
in your system the second one will succeed. If you have eeprom the
third one works. All of those names are valid in a device tree.

If all three fail, create a device with the last entry since someone
may modprobe the driver in later.

>  I'm inclined to leave it as is for now and instead handle the mpc837x
>  case with the fixup table in this file.  (Actually, this function has
>  been moved to of/base.c; so handle it in that function)
>
>  For the longer term, I think that this whole match method is a stop gap
>  solution until we figure out a tidy way to bind and provide device tree
>  data to i2c, SPI and platform devices.
>
>
>  g.
>
>  >
>  > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>  > ---
>  >
>  > Other options are: start filling the exceptions list, or add  "linux,..."
>  > compatible entry to the device tree.
>  >
>  >  drivers/of/of_i2c.c |   17 +++++++++++------
>  >  1 files changed, 11 insertions(+), 6 deletions(-)
>  >
>  > diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
>  > index b2ccdcb..0d35a0a 100644
>  > --- a/drivers/of/of_i2c.c
>  > +++ b/drivers/of/of_i2c.c
>  > @@ -29,6 +29,7 @@ static int of_find_i2c_driver(struct device_node *node,
>  >       int i, cplen;
>  >       const char *compatible;
>  >       const char *p;
>  > +     const char *last_wcomma = NULL;
>  >
>  >       /* 1. search for exception list entry */
>  >       for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
>  > @@ -45,7 +46,7 @@ static int of_find_i2c_driver(struct device_node *node,
>  >       if (!compatible)
>  >               return -ENODEV;
>  >
>  > -     /* 2. search for linux,<i2c-type> entry */
>  > +     /* 2. search for linux,<i2c-type> entry, or remember last w/ comma */
>  >       p = compatible;
>  >       while (cplen > 0) {
>  >               if (!strncmp(p, "linux,", 6)) {
>  > @@ -54,6 +55,12 @@ static int of_find_i2c_driver(struct device_node *node,
>  >                                   I2C_NAME_SIZE) >= I2C_NAME_SIZE)
>  >                               return -ENOMEM;
>  >                       return 0;
>  > +             } else {
>  > +                     const char *comma;
>  > +
>  > +                     comma = strchr(p, ',');
>  > +                     if (comma)
>  > +                             last_wcomma = comma + 1;
>  >               }
>  >
>  >               i = strlen(p) + 1;
>  > @@ -61,12 +68,10 @@ static int of_find_i2c_driver(struct device_node *node,
>  >               cplen -= i;
>  >       }
>  >
>  > -     /* 3. take fist compatible entry and strip manufacturer */
>  > -     p = strchr(compatible, ',');
>  > -     if (!p)
>  > +     /* 3. take last compatible entry w/ comma, manufacturer stripped */
>  > +     if (!last_wcomma)
>  >               return -ENODEV;
>  > -     p++;
>  > -     if (strlcpy(info->type, p, I2C_NAME_SIZE) >= I2C_NAME_SIZE)
>  > +     if (strlcpy(info->type, last_wcomma, I2C_NAME_SIZE) >= I2C_NAME_SIZE)
>  >               return -ENOMEM;
>  >       return 0;
>  >  }
>  > --
>  > 1.5.5.4
>


-- 
Jon Smirl
jonsmirl@gmail.com
