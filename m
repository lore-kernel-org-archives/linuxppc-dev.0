Return-Path: <tnt@246tNt.com>
Message-ID: <4546F46E.5080202@246tNt.com>
Date: Tue, 31 Oct 2006 07:59:58 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support
	for	ARCH=powerpc
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
	<45468775.8040108@246tNt.com>
	<96623161-B847-4F61-94AB-D1F1B1767708@kernel.crashing.org>
In-Reply-To: <96623161-B847-4F61-94AB-D1F1B1767708@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>>> * lets drop all the other struct defn in mpc52xx.h.  This is a hold
>>> over from arch/ppc and we really should only put defn that we
>>> actually need closer to the code that uses them (ie, drivers, etc.)
>>>
>> Most of the struct that were in mpc52xx.h are the ones used in more than
>> one driver.
>> (or don't really belong to a driver)
>> That's why they've been left there and not in the driver header, so I
>> would leave those
>> there.
>>
>> (e.g. the IDE struct is not there, neither is the FEC. But sdma is used
>> at several place
>> for example, so is rtc, xlb and cdm, ...)
>
> I can see that some of these might be used, like SDMA, XLB, and CDM. 
> However, others like RTC should really be done via a single driver. 
> Additionally, I'd have to see code use GPIO, SDRAM, GPT, etc before I
> think we should have them defined here.  I'd rather we add these items
> as they are used rather than having them here wholesale.
I've just rechecked :

* struct mpc52xx_mmap_ctl;
* struct mpc52xx_sdram;

Not really used any where that I can see/remember. Except for
find_end_of_memory ...
It should however be used in several place in the future ... (sleep support
would need sdram iirc, ...).

But can be removed for now if it's annoying to have them there ...


* struct mpc52xx_intr;

Was used before in platform support code to set the IRQ type of external
IRQ (level/irq) ...
but that can be done with set_irq_type. So can be safetly moved to a
local mpc52xx_pic.h


* struct mpc52xx_rtc;

Was used before in some common code. When the bootloader didn't pass the
bus frequency,
we computed it and the rtc was used to do that. Now, with device tree,
no need for
that anymore. So can be safely removed.


* struct mpc52xx_gpio;
* struct mpc52xx_gpio_wkup;

Port config (pin multiplexing) is in those registers so they should stay
there. This is used
by several driver and platform code. Beside custom driver could use gpio
for different
purpose ...

It could be placed in a include/asm-powerpc/mpc52xx_gpio.h but that
would just make
one more file in include/asm-powerpc so it doesn't make much sens imho.
It should
just stay there.


* struct mpc52xx_xlb;
* struct mpc52xx_cdm;
* struct mpc52xx_sdma;

Used at several place and should really stay there.


         Sylvain
