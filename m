Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 85EAFDDED3
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 03:19:29 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1271630wag.13
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 08:19:28 -0800 (PST)
Message-ID: <9e4733910802240819w70b1846ftea776495016567fc@mail.gmail.com>
Date: Sun, 24 Feb 2008 11:19:28 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCHv4 2.6.25] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
In-Reply-To: <47BEAF00.50106@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47A1C4E9.4000003@scram.de>
	<20080221130520.12b01553@hyperion.delvare> <47BEAF00.50106@scram.de>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/22/08, Jochen Friedrich <jochen@scram.de> wrote:
> Hi Jean,
>
>
>  >> +/*
>  >> + * Wait for patch from Jon Smirl
>  >> + * #include "powerpc-common.h"
>  >> + */
>  >
>  > It doesn't make sense to merge this comment upstream.
>
>
> I know you don't like the patch from Jon Smirl and you also explained your reasons.
>  Fortunately, I2c no longer uses numeric device IDs but names. So what are the alternatives?
>
>  1. modify the I2c subsystem to accept OF names additionally to I2c names (proposed by Jon smirl).

The correct statement is: modify the i2c subsystem to support the
standard kernel driver aliasing mechanism. Leaving powerpc and OF out
of the argument for the moment, i2c has a custom aliasing scheme on
the x86 too.

So as a first step, can we remove the custom i2c aliasing scheme and
change i2c to use standard module aliases on the x86? Patches for this
already exist.

On 2/23/08, Jean Delvare <khali@linux-fr.org> wrote:
> The problem I have with this is that it breaks compatibility. The chip
>  name is not only used for device/driver matching, it is also exported
>  to userspace as a sysfs attribute ("name"). Applications might rely on
>  it. At least libsensors does.

I think there is some confusion here. The OF aliases are only used by
the kernel to load the correct driver. Would doing something like this
help?

static struct i2c_device_id pcf8563_id[] = {
	{"pcf8563", 0, "sysfs_legacy_name"},
	{"rtc8564", 0, "sysfs_legacy_name"},
	OF_ID("phillips,pcf8563", &pcf8563_id[0], 0)
	OF_ID("epson,rtc8564", &pcf8563_id[1], 0)
	{},
};
MODULE_DEVICE_TABLE(i2c, pcf8563_id);

Then in the probe function you can use the pointer to find the base id
entry and i2c never has to be aware that the OF alias exists.

>  2. record the I2c name in the dts tree, either as separate tag (like linux,i2c-name="<i2c-name>")

Not really practical for the millions of machines (all PowerPC Macs)
already shipped.

>    or as additional compatible entry (like compatible="...", "linux,<i2c-name>").
>  3. use a glue layer with a translation map.

Audio codecs have exactly the same problem. There are probably other
devices that also need mapping.

This mapping table will need to contain a map from the OF names to the
kernel driver names.  It will need to stored permanently in RAM and
contain all possible mappings. This table will only grow in size.

The kernel has a widely used mechanism for mapping -- aliases in the
device drivers. Why do we want to build a new, parallel one?

What we are doing now is option 4.

4. Use kconfig to build custom kernels for each target system. Don't
load drivers automatically based on what the BIOS tells us.

-- 
Jon Smirl
jonsmirl@gmail.com
