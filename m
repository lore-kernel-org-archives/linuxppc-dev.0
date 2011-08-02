Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7843B70C7
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Aug 2011 11:57:10 +1000 (EST)
Date: Tue, 2 Aug 2011 10:50:53 +0900
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] drivers/misc: introduce Freescale Data Collection
	Manager driver
Message-ID: <20110802015050.GA17286@opensource.wolfsonmicro.com>
References: <1312235334-15036-1-git-send-email-timur@freescale.com>
	<20110801234645.GA15792@sirena.org.uk>
	<4E373D88.80006@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E373D88.80006@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 01, 2011 at 11:58:00PM +0000, Tabi Timur-B04825 wrote:
> Mark Brown wrote:
> > On Mon, Aug 01, 2011 at 04:48:54PM -0500, Timur Tabi wrote:

> >> PowerPC reference boards that can read temperature, current, and voltage
> >> settings from the sensors on those boards.  This driver exposes the DCM via a
> >> sysfs interface (/sys/devices/platform/fsl-ocm.0).

> > This sounds like it should be a hwmon driver.

> I didn't see any way to interface the hardware to the hwmon layer in a 
> manner that provides the information that our customers went using this 
> hardware.

Even if that's the case I can't see that it is a good reason for adding
a driver out of any subsystem with a completely non-standard interface.

> > Though this is a bit odd for the subsystem I don't think it's too far
> > out of what other hwmon chips can do, some of them do have longer term
> > stats than just instantaneous readings.

> Can you show an example or some documentation?  I couldn't find anything 
> remotely like that.  I don't even see anything that lets me start/stop 
> monitoring of sensors.

I'd expect that things like the _lowest, _highest and _average
attributes which a number of drivers have are what you're looking for.
At the very least it seems obvious how you might extend the interface if
some features you need are missing.  The subsystem has fairly extensive
documentation in Documentation/hwmon.
