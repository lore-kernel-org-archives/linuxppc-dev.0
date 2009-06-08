Return-Path: <lorenz@missinglinkelectronics.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3870CB70BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 01:58:13 +1000 (EST)
Received: from smtp.esic-solutions.com (h1371364.stratoserver.net
	[85.214.87.145]) by ozlabs.org (Postfix) with ESMTP id B70FBDDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 01:58:12 +1000 (EST)
Message-ID: <4A2D2AE5.2040509@missinglinkelectronics.com>
Date: Mon, 08 Jun 2009 17:14:45 +0200
From: Lorenz Kolb <lorenz@missinglinkelectronics.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: SD card over (xilinx_)SPI, timeout error while CID
References: <1244216069.21470.12.camel@localhost>
	<87bpp1xulr.fsf@macbook.be.48ers.dk>
In-Reply-To: <87bpp1xulr.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: joachim@missinglinkelectronics.com, dbrownell@users.sourceforge.net,
	Joachim Foerster <JOFT@gmx.de>,
	lorenz@missinglinkelectronics.com, linuxppc-dev@ozlabs.org,
	john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:
>>>>>> "Joachim" == Joachim Foerster <JOFT@gmx.de> writes:
>>>>>>             
>
> Hi,
>
>  Joachim> Any hints? Does anybody use SD card support with
>  Joachim> mmc_spi+xilinx_spi ?
>
> I don't, but have you compared the spi signals on a scope in the 2
> setups? Is timing significantly different?
>
>   
Hi,

we just tried to find differences for the timing with the oszi:

Here are to screenshots taken from the initial first few data bytes that are
communicated. At least at that time there does not seem to be any timing 
issue.

2.6.26 using arch ppc and virtex-devices:

http://img145.imageshack.us/img145/9662/2626virtexdevices.jpg

2.6.29.4 using arch powerpc:

http://img145.imageshack.us/img145/9847/2629devtree.jpg

For explanation:

yellow = chan 1 = MOSI = trigger
green = chan 2 = chipselect not
blue = chan 3 = clock
red = chan 4 = MOSI

Looks like we're gonna have to switch to a logic analyzer
(with spi-mode sdcard analyzing support) as we cannot see any differences
in the short timeframe our oszi does measure, though checking the timing
does not look too promising.

We even configured the Xilinx-SPI core to go down to ~780 kHz just to be 
safe,
did not help either.

Regards,

Lorenz
