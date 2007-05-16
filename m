Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87F53DDEF4
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 05:59:08 +1000 (EST)
In-Reply-To: <1179338347.8132.200.camel@rhino>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
	<1179338347.8132.200.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fcd8f2b3d13e3ff675886f06843d2038@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
Date: Wed, 16 May 2007 21:59:02 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Is "rtc" a standard OF device, or are we making up a
>> new thing that should be documented in booting-with-OF.txt ?
>> And is the plan to somehow use this entry in the future?
>
> It is my understanding that "rtc" is a standard OF device.  Can anybody
> confirm this?

It is.

> This could be used in the platform-specific RTC code to get the ports
> from the device tree.  Currently, however, I simply use RTC_PORT(x) 
> from
> asm/mc146818rtc.h.  Is it preferable to use the device tree here?

If you instantiate the RTC device from platform code,
and the device sits at the same address on all boards
you support, the only good thing you get from using
the device tree is that you don't have to hardcode a
number in the Linux code.  Using the device tree however
the RTC device could be detected and instantiated from
more generic code, a much better situation.


Segher
