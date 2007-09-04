Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0D353DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 20:45:51 +1000 (EST)
Date: Tue, 4 Sep 2007 14:47:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in
	QE, register mmc_spi stub
Message-ID: <20070904104750.GA32451@localhost.localdomain>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<20070903151319.GA24840@localhost.localdomain>
	<fdaf530168b099fcb5a3fbbe45e38271@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fdaf530168b099fcb5a3fbbe45e38271@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2007 at 01:17:51AM +0200, Segher Boessenkool wrote:
>> I expect very few things from the bootloader: setup memory controller,
>
> Setup CPUs, clocks and voltages, system busses, system controllers,
> memory controllers, memory itself,

Yup-yup, these little things. ;-) But clocks and voltages are set
up by the firmware to initially boot the kernel. After kernel
booted, it can, and should, and do manage this stuff. Power
management (includingturning on/off clocks, voltages), cpu freq
(this leads into whole other management issues, like changing
prescalers for companion chips and/or on-board CPLDs, if they're
getting clocks from the CPU-dependant source).

That's for clocks and voltages. Ok, let's back to GPIOs.

> _and system GPIOs_ :-)

Yup, firmware should set up gpios, to make initial kernel boot.
After that, kernel can and should manage GPIOs. Few examples.

Say units (like USB or SPI) can work in very different modes. And
it's okay if user want to change device mode in the runtime. Often
that means that we must also change GPIOs' dedicated functions or
even directions. Say, SPI slave or master, USB host/device/otg,
and so on.

Yes, probably there is no single powerpc driver actually doing this
today, because of many reasons. Some features unneeded today, some
are hard to implement. And maybe there is no single PowerPC device
yet that needs this, I don't know, but it's easy to imagine. ;-)

Another example, power management - if some unit temporarily unused,
to save power GPIOs should be set up differently. Say if SPI unit
turned off (unused just now), it's wise to bring their dedicated
GPIOs to "power saving" state (be it output0/1 or input, it
depends).

"Unneeded" GPIO pin drains less than 1 mA, but if there are bunch of
such GPIOs, this could be a real issue, especially on battery
powered devices.

And yet another GPIOs use from the kernel side I can bring, and it's
real use case: software-managed chip-selects, just like I have to
use for MMC-over-SPI.

To sum up: kernel anyway must be aware of GPIOs, and I'd prefer
smart kernel wrt GPIOs, instead of dumb kernel blindly relying on
the firmware setup.


At the same time I agree: doing gpio setup in the board file isn't a
great solution, just like doing it in the device tree. But hard-code
gpio setup in the firmware is much worse and short-sighted approach.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
