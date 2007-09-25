Return-Path: <dgibson@ozlabs.org>
Date: Tue, 25 Sep 2007 15:47:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Message-ID: <20070925054716.GE2525@localhost.localdomain>
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
	<878x6wpq3t.fsf@macbook.be.48ers.dk>
	<20070925021340.GG30338@localhost.localdomain>
	<87myvbnwbo.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87myvbnwbo.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2007 at 07:33:15AM +0200, Peter Korsgaard wrote:
> >>>>> "David" == David Gibson <david@gibson.dropbear.id.au> writes:
> 
> Hi,
> 
>  >> The Linux driver for the chip (rtc-1307.c) doesn't expose the NVRAM
>  >> bytes either.
> 
>  David> Incidentally how are you planning on instantiating the driver?  AFAIK
>  David> all the rtc-* drivers are platform drivers rather than of_platform
>  David> drivers.  I had been thinking of an rtc helper function that would go
>  David> through the tree instantiating platform devices for any RTCs based on
>  David> a compatible -> platform device name table.
> 
> Please see patch #2 in the series:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042896.html
> 
> That helper function more or less already exists in fsl_soc.c.

Ah, I see.  Well... it exists for i2c devices (possibly including
RTCs).  Whereas I was thinking of a version for RTCs (possibly
including i2c devices).  Actually that won't quite work - looks like
the i2c RTC class drivers are probed differently from the RTC drivers
I was looking at which are pure platform devices.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
