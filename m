Return-Path: <glikely@secretlab.ca>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.155])
	by ozlabs.org (Postfix) with ESMTP id 552D0DDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 04:53:56 +1100 (EST)
Received: by po-out-1718.google.com with SMTP id c31so4331472poi.4
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 10:53:54 -0700 (PDT)
Message-ID: <fa686aa40810281053u4673dd60sc4e33a1f90f65981@mail.gmail.com>
Date: Tue, 28 Oct 2008 11:53:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/6 RFC] OF-glue devices for I2C/SPI (was: Re: [PATCH 4/7]
	gpiolib: implement dev_gpiochip_{add, remove} calls
In-Reply-To: <20081028174532.GA23834@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081022014243.GA19362@oksana.dev.rtsoft.ru>
	<1224642497.7654.319.camel@pasglop>
	<200810212122.49121.david-b@pacbell.net>
	<20081022103641.GB24757@oksana.dev.rtsoft.ru>
	<20081022104606.GA510@oksana.dev.rtsoft.ru>
	<20081028174532.GA23834@oksana.dev.rtsoft.ru>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
	linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 28, 2008 at 11:45 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Wed, Oct 22, 2008 at 02:46:06PM +0400, Anton Vorontsov wrote:
> [...]
>> > > Like what I suggested:  "chip-aware OF glue drivers".  The relevant
>> > > bus code being the "of_platform_bus_type" infrastructure.
>> > >
>> > > Example:  instead of Anton's patch #6 modifying the existing pca953x
>> > > driver, an of_pca953x driver that knows how to poke around in the OF
>> > > device attributes to (a) create the pca953x_platform_data, (b) call
>> > > i2c_register_board_info() to make that available later, and then
>> > > finally (c) vanish, since it's not needed any longer.
>> >
>> > Heh. You tell me my first approach:
>> >
>> > http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056730.html (mmc_spi)
>> >
>> > The OF people didn't like the patch which was used to support this
>> > approach:
>> > http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056728.html
>>
>> Though, I think I'll able to persuade Grant that two registration paths
>> are inevitable (i.e. for simple devices we should use
>> drivers/of/of_{i2c,spi}.c and for complex cases we'll have to have
>> another method of registration).
>
> Ok, here it is.
>
> I don't like this approach because:
>
> 1. It feels like an overhead to create an of_device for each i2c
>   device that needs platform data.
>
> 2. We have to do ugly of_should_create_pdev() in the i2c code,
>   and duplicate lists of supported devices.
>
> Could anybody convince me that this isn't a big deal? ;-)

I really don't like this approach either.  I think it is a big deal.
It greatly increases the complexity of the probe path for the device.
Adapting the OF data to pdata is entirely driver specific and it
doesn't make sense to break it out into a separate of_device or use
the board_info mechanism to disassociate the adapter code from the
driver.  Each instance of adapter code will never be associated with a
different driver and I think it is entirely reasonable to have a
driver specific hook in the drivers probe path to build pdata from the
device tree.

>
> Otherwise I'll stick with this approach:
> http://lkml.org/lkml/2008/10/22/471

I like this approach.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
