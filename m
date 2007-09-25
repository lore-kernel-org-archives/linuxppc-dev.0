Return-Path: <dgibson@ozlabs.org>
Date: Tue, 25 Sep 2007 12:13:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Message-ID: <20070925021340.GG30338@localhost.localdomain>
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
	<878x6wpq3t.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878x6wpq3t.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2007 at 07:52:22AM +0200, Peter Korsgaard wrote:
> >>>>> "David" == David Gibson <david@gibson.dropbear.id.au> writes:
> 
> Hi
> 
>  >> compatible = "fsl-i2c";
>  >> reg = <3100 100>;
>  >> interrupts = <f 8>;
>  >> interrupt-parent = < &ipic >;
>  >> dfsrr;
>  >> +
>  >> +			rtc@68 {
>  >> +				device_type = "rtc";
>  >> +				compatible = "dallas,ds1339";
>  >> +				reg = <68>;
>  >> +			};
> 
>  David> I think we want to think a bit more carefully about how to do bindings
>  David> for RTC devices.  No "rtc" device_type is defined, but again we might
>  David> want to.
> 
> Could be. I've simply done it like kuroboxHD.dts already does and
> fsl_soc.c expects.
> 
>  David> I did find one real OF binding for a different Dallas RTC (and NVRAM),
>  David> see:
> 
>  David> http://playground.sun.com/1275/proposals/Closed/Remanded/Accepted/346-it.txt
> 
>  David> It's a little different from the example above.
> 
>  David> The fact that NVRAM+RTC chips are so common is a bit of an issue from
>  David> the point of view of defining a device class binding - a device can't
>  David> have type "rtc" and "nvram".
> 
> True. I think we should primarily focus on the RTC part rather than
> NVRAM as that's the "main" functionality and leave a NVRAM class for
> I2C EEPROMs.
> 
> The Linux driver for the chip (rtc-1307.c) doesn't expose the NVRAM
> bytes either.

Incidentally how are you planning on instantiating the driver?  AFAIK
all the rtc-* drivers are platform drivers rather than of_platform
drivers.  I had been thinking of an rtc helper function that would go
through the tree instantiating platform devices for any RTCs based on
a compatible -> platform device name table.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
