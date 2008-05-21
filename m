Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87002DE172
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:10:17 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4LFACVS003627
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:10:12 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m4LFA3SI006233
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 10:10:08 -0500 (CDT)
Date: Wed, 21 May 2008 10:10:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [POWERPC] Add i2c pins to dts and board setup
Message-ID: <20080521151003.GA13858@ld0162-tx32.am.freescale.net>
References: <4833FA0C.5090800@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4833FA0C.5090800@scram.de>
Cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Linux I2C <i2c@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 12:31:40PM +0200, Jochen Friedrich wrote:
> +   - linux,i2c-index : Can be used to hard code an i2c bus nummer.

s/nummer/number/

Why do we need this?

> +   - linux,i2c-class : Can be used to override the i2c class. The class is used
> +     by old style i2c device drivers to find a bus in a specific context like
> +     system management, video or sound. By default, I2C_CLASS_HWMON (1) is
> +     being used. The definition of the classes can be found in
> +     include/i2c/i2c.h

It'd be better to just convert any needed old-style drivers than add this
to the device tree.

> +   - bus-frequency : Can be used to set the i2c bus frequency. If unspecified,
> +     a default frequency of 60kHz is being used.

clock-frequency is the standard name for such things.

-Scott
