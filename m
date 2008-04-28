Return-Path: <kay.sievers@vrfy.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 2A157DDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:09:13 +1000 (EST)
Subject: Re: [PATCH 1/2] i2c: Add support for device alias names
From: Kay Sievers <kay.sievers@vrfy.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20080428113901.2772e9d9@hyperion.delvare>
References: <20080428113052.6d024bda@hyperion.delvare>
	<20080428113901.2772e9d9@hyperion.delvare>
Content-Type: text/plain; charset=utf-8
Date: Mon, 28 Apr 2008 17:07:25 +0200
Message-Id: <1209395245.3666.9.camel@linux.site>
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

On Mon, 2008-04-28 at 11:39 +0200, Jean Delvare wrote:
> Based on earlier work by Jon Smirl and Jochen Friedrich.
>=20
> This patch allows new-style i2c chip drivers to have alias names using
> the official kernel aliasing system and MODULE_DEVICE_TABLE(). At this
> point, the old i2c driver binding scheme (driver_name/type) is still
> supported.
>=20
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Jochen Friedrich <jochen@scram.de>
> Cc: Jon Smirl <jonsmirl@gmail.com>
> Cc: Kay Sievers <kay.sievers@vrfy.org>
> ---
> One thing I am still not happy with is that the aliases created have a
> trailing "*":
>=20
> $ /sbin/modinfo lm90
> filename:       /lib/modules/2.6.25-git11/kernel/drivers/hwmon/lm90.ko
> author:         Jean Delvare <khali@linux-fr.org>
> description:    LM90/ADM1032 driver
> license:        GPL
> vermagic:       2.6.25-git11 mod_unload
> depends:        hwmon
> alias:          i2c:lm90*
> alias:          i2c:adm1032*
> alias:          i2c:lm99*
> alias:          i2c:lm86*
> alias:          i2c:max6657*
> alias:          i2c:adt7461*
> alias:          i2c:max6680*
> $
>=20
> This would cause trouble if one I2C chip name matches the beginning of
> another I2C chip name and both chips are supported by different
> drivers. This has yet to be seen, but still, I'd like to see this
> problem fixed quickly.

=EF=BB=BFRight, the trailing "*" is not nice.

We should terminate the string, so the trailing "*" will not match
longer strings. The usual thing is to add a ":" to the end, which would
then show up as
  alias: i2c:max6680:*

See DMI and ACPI:
  alias dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:* apanel
  alias acpi*:ASIM0000:* atlas_btns

If i2c device modaliases could ever contain multiple strings, it should
be:
  alias: i2c*:max6680:*
=EF=BB=BFto match the module, regardless of the order of the strings in the
modalias:

Thanks,
Kay
