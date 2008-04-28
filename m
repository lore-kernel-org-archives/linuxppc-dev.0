Return-Path: <kay.sievers@vrfy.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 1961FDDFE6
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 02:17:32 +1000 (EST)
Subject: Re: [PATCH 1/2] i2c: Add support for device alias names
From: Kay Sievers <kay.sievers@vrfy.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20080428174010.5a40c2c0@hyperion.delvare>
References: <20080428113052.6d024bda@hyperion.delvare>
	<20080428113901.2772e9d9@hyperion.delvare>
	<1209395245.3666.9.camel@linux.site>
	<20080428174010.5a40c2c0@hyperion.delvare>
Content-Type: text/plain; charset=utf-8
Date: Mon, 28 Apr 2008 18:16:17 +0200
Message-Id: <1209399377.3666.30.camel@linux.site>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Scott Wood <scottwood@freescale.com>,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-04-28 at 17:40 +0200, Jean Delvare wrote:
> On Mon, 28 Apr 2008 17:07:25 +0200, Kay Sievers wrote:
> > On Mon, 2008-04-28 at 11:39 +0200, Jean Delvare wrote:
> > > One thing I am still not happy with is that the aliases created have =
a
> > > trailing "*":
> > >=20
> > > $ /sbin/modinfo lm90
> > > filename:       /lib/modules/2.6.25-git11/kernel/drivers/hwmon/lm90.k=
o
> > > author:         Jean Delvare <khali@linux-fr.org>
> > > description:    LM90/ADM1032 driver
> > > license:        GPL
> > > vermagic:       2.6.25-git11 mod_unload
> > > depends:        hwmon
> > > alias:          i2c:lm90*
> > > alias:          i2c:adm1032*
> > > alias:          i2c:lm99*
> > > alias:          i2c:lm86*
> > > alias:          i2c:max6657*
> > > alias:          i2c:adt7461*
> > > alias:          i2c:max6680*
> > > $
> > >=20
> > > This would cause trouble if one I2C chip name matches the beginning o=
f
> > > another I2C chip name and both chips are supported by different
> > > drivers. This has yet to be seen, but still, I'd like to see this
> > > problem fixed quickly.
> >=20
> > =EF=BB=BFRight, the trailing "*" is not nice.
> >=20
> > We should terminate the string, so the trailing "*" will not match
> > longer strings. The usual thing is to add a ":" to the end, which would
> > then show up as
> >   alias: i2c:max6680:*
> >=20
> > See DMI and ACPI:
> >   alias dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:* apanel
> >   alias acpi*:ASIM0000:* atlas_btns
>=20
> I didn't know about these cases, thanks for the hint.
>=20
> >=20
> > If i2c device modaliases could ever contain multiple strings, it should
> > be:
> >   alias: i2c*:max6680:*
> > =EF=BB=BFto match the module, regardless of the order of the strings in=
 the
> > modalias:
>=20
> Why would i2c device modaliases ever contain multiple strings? A device
> can't have multiple names, can it?

Like ACPI/PNP devices, which can have several compat id's, which means
that a single device can have "multiple names":
  $ cat /sys/bus/pnp/devices/00:09/id
  IBM0057
  PNP0f13

> Adding a ":" at the end of the i2c device names solves the problem I
> was mentioning, sure, but why don't we simply remove the trailing "*",
> instead of trying to work around it? A trailing "*" simply makes no
> sense for aliases which are simple device names.

Sure, if there is only one single string, it's not useful.

> This is not only i2c
> devices, but also platform devices, acpi, dmi, pnp...

ACPI, DMI, PNP (PNP does not do modalias) needs to be able to match only
one string in a given list, so the trailing "*" is needed.

> Looking at the
> various device types handled by file2alias.c, it seems that most of
> them don't need the trailing "*", and many of them have the problem I
> was mentioning.
>=20
> Can't we just stop handle_moddevtable() from adding a tailing "*"
> automatically, and just let the device types which need it, add it on
> their own?

For a lot subsystems it's fine to have it appended, as there is a
defined list of identifiers, which must appear in the same order, and
new identifiers are appended to the end. So the "*" still matches
modules with possibly extended modalias strings.

We would also need to review all buses which export modalias, if they
need the "*" or not, and add them by hand, if needed.

I guess, it's easier to introduce an additional parameter to
file2alias::do_table() and suppress the trailing "*" for i2c?

Thanks,
Kay
