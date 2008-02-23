Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-106-saturday.nerim.net [62.4.16.106])
	by ozlabs.org (Postfix) with ESMTP id 7F117DDDFF
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 23:43:39 +1100 (EST)
Date: Sat, 23 Feb 2008 13:43:35 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv4 2.6.25] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2  controllers
Message-ID: <20080223134335.0f5c7d79@hyperion.delvare>
In-Reply-To: <47BEAF00.50106@scram.de>
References: <47A1C4E9.4000003@scram.de>
	<20080221130520.12b01553@hyperion.delvare>
	<47BEAF00.50106@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	i2c@lm-sensors.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jochen,

On Fri, 22 Feb 2008 12:16:16 +0100, Jochen Friedrich wrote:
> Hi Jean,
> 
> >> +/*
> >> + * Wait for patch from Jon Smirl
> >> + * #include "powerpc-common.h"
> >> + */
> > 
> > It doesn't make sense to merge this comment upstream.
> 
> I know you don't like the patch from Jon Smirl and you also explained your reasons.
> Fortunately, I2c no longer uses numeric device IDs but names. So what are the alternatives?
> 
> 1. modify the I2c subsystem to accept OF names additionally to I2c names (proposed by Jon smirl).

The problem I have with this is that it breaks compatibility. The chip
name is not only used for device/driver matching, it is also exported
to userspace as a sysfs attribute ("name"). Applications might rely on
it. At least libsensors does.

One way to work around the problem would be to use separate fields for
device/driver matching and the "name" attribute. However, this will add
some complexity to the i2c-core code and cost some memory as well, so
it is far from perfect.

> 2. record the I2c name in the dts tree, either as seperate tag (like linux,i2c-name="<i2c-name>")
>    or as additional compatible entry (like compatible="...", "linux,<i2c-name>").

This would work, and it would require almost no change to the current
i2c-core code, but I thought that these dts files were not under our
control?

The problem I see with this approach is that the name translation would
have to be done for each dts file, rather than just once for each device
type. This means more work, but maybe this can be done if at least part
of it is automated. I admit that I never considered this option because
I considered the dts files as read-only. If this assumption was
incorrect, then maybe this is the best solution. Can you please
elaborate on the details of this proposal?

> 3. use a glue layer with a translation map.

This is what we do at the moment (see i2c_devices in
arch/powerpc/sysdev/fsl_soc.c). Jon Smirl is worried that it won't
scale well though, and I can't disagree.

> What is the preferred way to do this?

I still have to think about it. I didn't have much time to work on this
during the last 2 weeks, hopefully I will fine some time to experiment
again soon. As I underlined before, my patch set affects no less than 5
subsystems with different needs and expectations, it's no trivial
change.

-- 
Jean Delvare
