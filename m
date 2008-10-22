Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AE3EEDDDF8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 21:36:42 +1100 (EST)
Date: Wed, 22 Oct 2008 14:36:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Message-ID: <20081022103641.GB24757@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081022014243.GA19362@oksana.dev.rtsoft.ru>
	<1224642497.7654.319.camel@pasglop>
	<200810212122.49121.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200810212122.49121.david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 21, 2008 at 09:22:48PM -0700, David Brownell wrote:
> On Tuesday 21 October 2008, Benjamin Herrenschmidt wrote:
> > The notifier can be registered before the devices, though it's a little
> > bit fishy and fragile.
> > 
> > Easier I suppose to just have OF specific hooks in the bus code.
> 
> Like what I suggested:  "chip-aware OF glue drivers".  The relevant
> bus code being the "of_platform_bus_type" infrastructure.
> 
> Example:  instead of Anton's patch #6 modifying the existing pca953x
> driver, an of_pca953x driver that knows how to poke around in the OF
> device attributes to (a) create the pca953x_platform_data, (b) call
> i2c_register_board_info() to make that available later, and then
> finally (c) vanish, since it's not needed any longer.

Heh. You tell me my first approach:

http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056730.html (mmc_spi)

The OF people didn't like the patch which was used to support this
approach:
http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056728.html


The board info has another problem though. We can't remove it, thus
we can't implement module_exit() for the 'OF glue'.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
