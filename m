Return-Path: <jonsmirl@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by ozlabs.org (Postfix) with ESMTP id 62AA6DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 00:43:37 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id e13so2125982rng.16
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 07:43:36 -0700 (PDT)
Message-ID: <9e4733910804280743q2de1da62m120c607b200cafa0@mail.gmail.com>
Date: Mon, 28 Apr 2008 10:43:35 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH 1/2] i2c: Add support for device alias names
In-Reply-To: <20080428113901.2772e9d9@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080428113052.6d024bda@hyperion.delvare>
	<20080428113901.2772e9d9@hyperion.delvare>
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Linux I2C <i2c@lm-sensors.org>,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 4/28/08, Jean Delvare <khali@linux-fr.org> wrote:
> Based on earlier work by Jon Smirl and Jochen Friedrich.
>
>  This patch allows new-style i2c chip drivers to have alias names using
>  the official kernel aliasing system and MODULE_DEVICE_TABLE(). At this
>  point, the old i2c driver binding scheme (driver_name/type) is still
>  supported.
>
>  Signed-off-by: Jean Delvare <khali@linux-fr.org>
>  Cc: Jochen Friedrich <jochen@scram.de>
>  Cc: Jon Smirl <jonsmirl@gmail.com>
>  Cc: Kay Sievers <kay.sievers@vrfy.org>
>  ---
>  One thing I am still not happy with is that the aliases created have a
>  trailing "*":
>
>  $ /sbin/modinfo lm90
>  filename:       /lib/modules/2.6.25-git11/kernel/drivers/hwmon/lm90.ko
>  author:         Jean Delvare <khali@linux-fr.org>
>  description:    LM90/ADM1032 driver
>  license:        GPL
>  vermagic:       2.6.25-git11 mod_unload
>  depends:        hwmon
>  alias:          i2c:lm90*
>  alias:          i2c:adm1032*
>  alias:          i2c:lm99*
>  alias:          i2c:lm86*
>  alias:          i2c:max6657*
>  alias:          i2c:adt7461*
>  alias:          i2c:max6680*
>  $
>
>  This would cause trouble if one I2C chip name matches the beginning of
>  another I2C chip name and both chips are supported by different
>  drivers. This has yet to be seen, but still, I'd like to see this
>  problem fixed quickly.


Trailing wildcard is always added by file2alias.c:

                if (do_entry(mod->name, symval+i, alias)) {
                        /* Always end in a wildcard, for future extension */
                        if (alias[strlen(alias)-1] != '*')
                                strcat(alias, "*");


Can't the match order be controlled in the makefile? For example if
you had lm905* and lm90*, put lm905* into into the makefile first
which will cause it to appear in the alias file first. But that would
still cause problems if only lm90 was built and you had a lm905
device.

Alternatively you could change the code to append something like a
period to the name string.

sprintf(alias, I2C_MODULE_PREFIX "%s.", id->name);

I was using macros to alter the name strings to move the PowerPC names
into their own namespace.

-- 
Jon Smirl
jonsmirl@gmail.com
