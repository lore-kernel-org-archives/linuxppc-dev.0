Return-Path: <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 12:10:59 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] Support for DS75 thermal sensor
Message-ID: <20080716121059.2dbbfebe@hyperion.delvare>
In-Reply-To: <487DC457.6000103@grandegger.com>
References: <487331DC.2020601@grandegger.com>
	<20080708115319.111226e6@hyperion.delvare>
	<4873670C.6080204@grandegger.com>
	<20080708152935.7457bc90@hyperion.delvare>
	<487754DA.1060207@grandegger.com>
	<20080711145613.14380360@hyperion.delvare>
	<487DBB92.1070100@grandegger.com>
	<20080716113311.384d211e@hyperion.delvare>
	<487DC457.6000103@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Alan Clucas <alanc@pipstechnology.co.uk>,
	Detlev Zundel <dzu@denx.de>, lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Jul 2008 11:50:15 +0200, Wolfgang Grandegger wrote:
> Jean Delvare wrote:
> > The problem is that at this point in time, only a couple hwmon drivers
> > have been converted to new-style i2c. So, dropping the I2C_CLASS_HWMON
> > would break most systems.
> > 
> > I have a set of patches converting most hwmon drivers to new-style i2c.
> > I plan to send it to Linus later today. Once all drivers are converted,
> > everyone can start adding device definitions to platform code. And only
> > once this is done for all platforms, you may remove I2C_CLASS_HWMON
> > from the i2c-mpc driver.
> 
> Of course.
> 
> > But even then, you can't exclude the possibility that some people want
> > to keep relying on the auto-detection mode. In that case, the setting
> 
> I understood that this is only true for the HWMON devices. Why the 
> special treatment?

Not really. There are other I2C_CLASS_* flags, just check <linux/i2c.h>.

What makes hwmon a bit different is the historical context. Originally,
the hwmon drivers were written for PCs, which have no per-system
platform code, so declaring the devices was simply not an option.
Additionally, i2c was maintained as part of the lm-sensors project
itself. This determined the probe-everything approach that has ruled
the i2c subsystem until recently. I've spent (with a few other
developers) the past few years drawing a clear separation between i2c
and hwmon, and now making it possible to declare i2c devices where
possible. This is a lot of work if you want to do this without breaking
any system out there (which is my case.)

> > of the I2C_CLASS_HWMON flag should become an attribute of each i2c-mpc
> > device.
> 
> Yep, as probing might not be acceptable in some cases, I makes sense to 
> add a property to suppress probing:

It'd rather make no-probing the default if possible. My understanding
is that all systems using i2c-mpc should have proper platform data.

But then again, that's not really my business. The decision is left to
the actual users of this i2c bus driver.

-- 
Jean Delvare
