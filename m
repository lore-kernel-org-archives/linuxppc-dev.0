Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 63A9CDDE39
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 15:52:29 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so1197648nfd
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Sep 2007 22:52:27 -0700 (PDT)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 24 Sep 2007 07:52:22 +0200
In-Reply-To: <20070924050709.GM8058@localhost.localdomain> (David Gibson's
	message of "Mon\, 24 Sep 2007 15\:07\:09 +1000")
Message-ID: <878x6wpq3t.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David Gibson <david@gibson.dropbear.id.au> writes:

Hi

 >> compatible = "fsl-i2c";
 >> reg = <3100 100>;
 >> interrupts = <f 8>;
 >> interrupt-parent = < &ipic >;
 >> dfsrr;
 >> +
 >> +			rtc@68 {
 >> +				device_type = "rtc";
 >> +				compatible = "dallas,ds1339";
 >> +				reg = <68>;
 >> +			};

 David> I think we want to think a bit more carefully about how to do bindings
 David> for RTC devices.  No "rtc" device_type is defined, but again we might
 David> want to.

Could be. I've simply done it like kuroboxHD.dts already does and
fsl_soc.c expects.

 David> I did find one real OF binding for a different Dallas RTC (and NVRAM),
 David> see:

 David> http://playground.sun.com/1275/proposals/Closed/Remanded/Accepted/346-it.txt

 David> It's a little different from the example above.

 David> The fact that NVRAM+RTC chips are so common is a bit of an issue from
 David> the point of view of defining a device class binding - a device can't
 David> have type "rtc" and "nvram".

True. I think we should primarily focus on the RTC part rather than
NVRAM as that's the "main" functionality and leave a NVRAM class for
I2C EEPROMs.

The Linux driver for the chip (rtc-1307.c) doesn't expose the NVRAM
bytes either.

But I'm open for suggestions.

-- 
Bye, Peter Korsgaard
