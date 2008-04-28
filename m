Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DDB1EDE060
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:42:43 +1000 (EST)
Date: Mon, 28 Apr 2008 17:42:20 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/2] i2c: Add support for device alias names
Message-ID: <20080428174220.0860ab25@hyperion.delvare>
In-Reply-To: <9e4733910804280743q2de1da62m120c607b200cafa0@mail.gmail.com>
References: <20080428113052.6d024bda@hyperion.delvare>
	<20080428113901.2772e9d9@hyperion.delvare>
	<9e4733910804280743q2de1da62m120c607b200cafa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Jon,

On Mon, 28 Apr 2008 10:43:35 -0400, Jon Smirl wrote:
> On 4/28/08, Jean Delvare <khali@linux-fr.org> wrote:
> >  One thing I am still not happy with is that the aliases created have a
> >  trailing "*":
> >
> >  $ /sbin/modinfo lm90
> >  filename:       /lib/modules/2.6.25-git11/kernel/drivers/hwmon/lm90.ko
> >  author:         Jean Delvare <khali@linux-fr.org>
> >  description:    LM90/ADM1032 driver
> >  license:        GPL
> >  vermagic:       2.6.25-git11 mod_unload
> >  depends:        hwmon
> >  alias:          i2c:lm90*
> >  alias:          i2c:adm1032*
> >  alias:          i2c:lm99*
> >  alias:          i2c:lm86*
> >  alias:          i2c:max6657*
> >  alias:          i2c:adt7461*
> >  alias:          i2c:max6680*
> >  $
> >
> >  This would cause trouble if one I2C chip name matches the beginning of
> >  another I2C chip name and both chips are supported by different
> >  drivers. This has yet to be seen, but still, I'd like to see this
> >  problem fixed quickly.
> 
> 
> Trailing wildcard is always added by file2alias.c:
> 
>                 if (do_entry(mod->name, symval+i, alias)) {
>                         /* Always end in a wildcard, for future extension */
>                         if (alias[strlen(alias)-1] != '*')
>                                 strcat(alias, "*");
> 
> 
> Can't the match order be controlled in the makefile? For example if
> you had lm905* and lm90*, put lm905* into into the makefile first
> which will cause it to appear in the alias file first. But that would
> still cause problems if only lm90 was built and you had a lm905
> device.

That's too trickly and fragile - I'd rather make sure that wrong
matches just can't happen.

> 
> Alternatively you could change the code to append something like a
> period to the name string.
> 
> sprintf(alias, I2C_MODULE_PREFIX "%s.", id->name);

Similar to what Kay proposed. It works and we'll do that if we have to,
but if we can just get rid of the "*" I'd rather do that.

> 
> I was using macros to alter the name strings to move the PowerPC names
> into their own namespace.
> 


-- 
Jean Delvare
