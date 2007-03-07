Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA476DDF26
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 06:49:59 +1100 (EST)
In-Reply-To: <20070307193438.GA30721@ld0162-tx32.am.freescale.net>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<20070307193438.GA30721@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Wed, 7 Mar 2007 13:48:58 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 7, 2007, at 1:34 PM, Scott Wood wrote:

> On Wed, Mar 07, 2007 at 01:19:29PM -0600, Kumar Gala wrote:
>> On Mar 7, 2007, at 12:49 PM, Jon Loeliger wrote:
>>> From: Zhang Wei <wei.zhang@freescale.com>
>>>
>>> Give more IRQ numbers for MPIC IPIs and TIMERs use.
>>> Added generic RTC support for MPC8641HPCN.
>>>
>>> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
>>> Signed-off-by: Jon Loeliger <jdl@freescale.com>
>>
>> Nack.
>>
>> You can't call the generic set_rtc_time from the
>> ppc_md.set_rtc_time.  Take a look at:
>>
>> http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030440.html
>
> set_rtc_time != rtc_set_time.  The latter is the one that goes through
> the drivers/rtc stuff and needs a workqueue; the former (which this  
> patch
> uses) is in asm-generic/rtc.h, and appears to be interrupt-safe.

I ah, didn't notice.. Well I don't think set_rtc_time/get_rtc_time do  
anything useful for most ppc's, since it seems they use CMOS_READ/ 
CMOS_WRITE which is only defined in asm/mc146818rtc.h

- k
